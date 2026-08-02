---
name: ansible-pr-workflow
description: "Use for Ansible infrastructure PRs. Validate all playbooks."
version: 1.1.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [ansible, infrastructure, github, pull-request, ci]
---

# Ansible Pull Request Workflow

Use this skill when a user asks to add or change infrastructure managed by Ansible and deliver the change as a GitHub pull request.

## Workflow

1. **Inspect before editing**
   - Locate the repository using the user's normal work directory convention.
   - Read repository-local `AGENTS.md`, `CONTRIBUTING.md`, and relevant documentation.
   - Check `git status --short --branch` and `git remote -v`.
   - Do not overwrite unrelated work.

2. **Start from the correct base**
   - Fetch remotes, fast-forward the base branch, and create a focused feature branch from the latest `origin/main` (or the repository's documented default branch).
   - Preserve the user's existing branches and uncommitted changes.

3. **Translate the request into Ansible changes**
   - Prefer a dedicated role for reusable host setup rather than embedding unrelated tasks in a playbook.
   - Put tunable package versions in role defaults/variables and keep upgrades explicit.
   - Never commit credentials or automate interactive provider authentication unless explicitly requested.
   - For CLI package additions, verify the official package names and current versions before pinning them.
   - Document what is installed and which authentication steps remain manual.

4. **Validate locally**
   - Run `git diff --check`.
   - Use the repository's pinned controller environment, not system Ansible. Respect local instructions such as `mise x --` or `uv run`.
   - Run syntax checks for every playbook covered by CI, not only the edited playbook.
   - Run Ansible linting when the repository provides it; do not hide actual lint failures behind `|| true`.
   - Check `HERMES_WRITE_SAFE_ROOT` before choosing a temporary verification path: `write_file` and `patch` hard-block paths outside the configured roots. Keep file-tool artifacts in the active checkout or approved work root; for terminal-only ephemeral scripts, use Python `tempfile.mkstemp(prefix="hermes-verify-", suffix=".py")`, run it, and unlink it in `finally`. Remove artifacts after execution and confirm the worktree is clean except for intended changes.
   - If the Ansible change deploys Hermes and its tools need `/tmp`, configure the documented multi-root value (Unix: `/opt/data:/tmp`) while retaining `/opt/data`; put it in the shared rendered app environment so all services inherit it. See `references/hermes-safe-write-roots.md`.
   - If remote execution is not requested or credentials are unavailable, do not claim deployment was tested.

### Existing PR follow-up

When an existing PR has the requested change in an uncommitted checkout, inspect and validate that diff instead of recreating it. If the user then says to continue and the task is clearly to finish that PR, make a focused commit, push the existing branch, and verify the PR URL, head/base branches, commit, and any reported checks. Use the dedicated PR checkout; do not move the work into `/tmp`.

5. **Commit and publish**
   - Review `git diff` including untracked files.
   - Use a focused conventional commit.
   - Push the branch and create the PR with a concise summary and validation section.
   - Verify the returned PR URL, state, source branch, and base branch.
   - Check CI status. If checks are reported, wait for them to finish and address failures. If GitHub reports no checks, do not wait for CI; the applicable local validations are the completion gate.
   - After local validation passes, mark the PR ready for review when no checks are reported or all reported checks pass. Keep it draft only when validation is incomplete or a reported check is pending/failing.
   - When follow-up feedback changes the implementation, update the PR body so its summary and validation describe the final diff, not the superseded approach; then re-verify the PR metadata after pushing.

## Generic YAML configuration merges

When persistent YAML configuration should retain user-managed values while receiving defaults, prefer Ansible's built-in `combine` filter over a custom filter plugin:

```yaml
content: "{{ defaults | combine(existing, recursive=true) | to_nice_yaml(indent=2, sort_keys=false) }}"
```

Use the defaults mapping as the left operand and the persistent mapping as the right operand so existing values win. `recursive=true` merges nested mappings; scalar and list values from the persistent mapping replace defaults. This is generic YAML behavior and should not contain application-specific migration branches unless the request explicitly requires a data migration. Remove the custom filter plugin and update the task to use `combine` directly.

For a configuration-only change without a dedicated test suite, supplement all-playbook syntax checks with a deterministic ad-hoc Ansible assertion covering nested-map preservation, overrides, list replacement, and arbitrary keys. Report this as focused ad-hoc verification, not as a full test-suite result. Keep the temporary verification script/playbook OS-safe and clean it up in a `finally` block. The verifier should exercise the actual deployment ordering: preserve an existing destination during the generic template pass, then merge defaults with the existing mapping.

## Existing PR rebases and conflict resolution

When updating an existing PR whose base branch may have moved:

1. Fetch the base ref explicitly before trusting the local remote-tracking ref: `git fetch origin main:refs/remotes/origin/main`.
2. Inspect `gh pr view <number> --json mergeable,mergeStateStatus,headRefOid` so GitHub's actual mergeability is known.
3. Preserve unrelated work before rebasing with a targeted stash.
4. Rebase onto `origin/main`, resolve conflicts by retaining both the upstream behavior and the PR behavior, then reapply the stash and keep unrelated files uncommitted.
5. Validate the rebased HEAD, then update the PR with `git push --force-with-lease`. Verify local and remote HEADs match and re-check the PR's `mergeable`/`mergeStateStatus`.

Do not assume a plain `git fetch origin` refreshed `origin/main` when the remote fetch refspec is narrow; compare it with `git ls-remote origin refs/heads/main` when GitHub reports conflicts unexpectedly.

## Generic template backup and merge ordering

Do not add a per-app `preserve_templates` exception to the generic render loop. The generic role should render templates with Ansible's default `force: true` behavior; an explicit `force: true` is optional. When an app has a persistence-aware pre-deploy hook, set `backup: "{{ app.pre_deploy_role is defined }}"` on the template task and register its results as `_rendered_templates`.

Use this order:

1. Render all app templates; Ansible creates `backup_file` only when an existing destination changes.
2. Run the pre-deploy hook. It selects the relevant `backup_file`, reads the previous remote content with `slurp`, and merges it with `defaults | combine(existing, recursive=true)` so existing values win.
3. If no backup exists, there was no existing changed content to preserve; leave the freshly rendered defaults in place.
4. Remove all registered template backups after the hook succeeds.

When the render loop uses `loop_var: tpl`, registered results expose the template as `tpl`, so select paths with `selectattr('tpl.path', ...)`, not `item.path`. Verify the native `backup_file` behavior with a focused Ansible fixture that overwrites an existing file, merges the backup, asserts retained user values and added defaults, and removes the backup.

Do not replace this post-render backup with `stat` plus `lookup('file', remote_path)`: the `file` lookup reads the controller filesystem, not the managed host. Also, merging and writing before the generic render causes the subsequent template task to overwrite the merge.

Keep authentication/setup in the image entrypoint when it already runs there. A post-deploy command that repeats startup authentication is redundant and should be removed unless it has a distinct, tested purpose.

## Pitfalls

- A syntax check can pass while a new role is missing from the playbook; verify both the role inclusion and role files.
- `git diff` omits untracked role files until they are staged or inspected separately.
- Do not preserve application-specific compatibility logic merely because it exists in a custom merge helper; first check whether the intended behavior is a normal recursive YAML merge.
- Installing a coding CLI does not authenticate it. Keep OAuth/API-key setup out of the playbook and tell the user to sign in as the intended runtime user.
- Mutable `latest` package installs undermine reproducibility in infrastructure repositories; pin versions when the package registry provides them.

## Verification Checklist

- [ ] The diff contains only the requested infrastructure changes.
- [ ] `git diff --check` passes.
- [ ] Every playbook covered by CI passes syntax validation.
- [ ] Any applicable focused or ad-hoc verification passes.
- [ ] If checks are reported, all are complete and passing; if no checks are reported, no CI wait is required.
- [ ] The PR metadata and validation summary match the final diff.
