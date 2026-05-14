---
name: git-worktree
description: Use when starting feature work or creating a feature branch - creates a branch in-place when current branch is main/develop, otherwise creates an isolated git worktree next to the current project. Triggers on worktree, git worktree, isolated workspace, or creating a new branch for feature work.
user-invocable: true
---

# Using Git Worktrees

## Overview

Git worktrees create isolated workspaces sharing the same repository, allowing work on multiple branches simultaneously without switching.

**Core principle:** If the current branch is `main` or `develop`, create the requested feature branch in the current repository. Otherwise, create a sibling worktree for the requested branch and verify a clean baseline.

**Announce at start:** "I'm using the git-worktree skill to set up the feature branch/workspace."

## Worktree Location

When a worktree is needed, always create it in the parent folder of the current project/repository:

```bash
<parent-folder>/<project-name>-worktree-<branchname>
```

`branchname` means: use the JIRA issue key if available, otherwise use the branch name.

Examples:

```bash
# Repo root: ~/dev/myproject
# Worktree:  ~/dev/myproject-worktree-feature-auth

# Repo root: ~/dev/vahor/bidule
# Worktree:  ~/dev/vahor/bidule-worktree-feature-auth
```

Rules:
- Use the parent folder of the git repository root, not a fixed global directory.
- If the repo is nested under `~/dev`, keep the worktree in that same parent folder.
- Do not suggest or use project-local `.worktrees/` or `worktrees/` directories.
- Do not suggest or use `~/.config/superpowers/worktrees/`.
- Do not ask where to create the worktree unless the user explicitly requests a different location.
- The folder suffix is `branchname`: the JIRA issue key if available, otherwise the branch name.
- Sanitize `branchname` for folder names, for example replace `/` and spaces with `-`.
- Do not rely on an environment variable named `BRANCH_NAME` unless it has been explicitly set.

Because this location is outside the repository, no `.gitignore` verification is required.

## Creation Steps

### 1. Detect Project Name, Parent Folder, and Current Branch

```bash
repo_root=$(git rev-parse --show-toplevel)
project=$(basename "$repo_root")
parent=$(dirname "$repo_root")
current_branch=$(git branch --show-current)
```

If `current_branch` is empty (detached HEAD), ask before creating a branch or worktree.

### 2. Determine Target Branch

```bash
branch="<requested-feature-branch-name>"
```

Rules:
- If the branch/feature name is not clear from the user request, ask for it before running commands.
- Do not default to the current branch name unless the user explicitly asks to continue that branch.

### 3. If on main/develop, Create Branch In-Place

If the current branch is `main` or `develop`, do **not** create a worktree. Create the requested feature branch in the current repository and continue there.

```bash
if [ "$current_branch" = "main" ] || [ "$current_branch" = "develop" ]; then
  git switch -c "$branch"
  # Stay in the current repository; no worktree path is needed.
fi
```

If the branch already exists, confirm the user's intent before switching to it:

```bash
git switch "$branch"
```

### 4. Determine Worktree Path

For any current branch other than `main` or `develop`, create a sibling worktree for the requested branch.

```bash
jira_issue=$(printf "%s" "$branch" | grep -Eo '[A-Z][A-Z0-9]+-[0-9]+' | head -n 1 || true)
branchname="${jira_issue:-$branch}"
branchname=$(printf "%s" "$branchname" | sed -E 's#[/[:space:]]+#-#g')
path="$parent/${project}-worktree-${branchname}"
```

Examples:

```bash
# branch=feature/auth       -> branchname=feature-auth
# branch=feature/APP-123-x  -> branchname=APP-123
# branch=APP-123            -> branchname=APP-123
```

### 5. Create Worktree

```bash
git worktree add "$path" -b "$branch" "$current_branch"
cd "$path"
```

If the branch already exists and is not checked out elsewhere, use the existing branch instead:

```bash
git worktree add "$path" "$branch"
cd "$path"
```

If the target branch is already checked out in another worktree, report that path and ask before proceeding.

### 6. Run Project Setup

Auto-detect and run appropriate setup:

```bash
# Node.js
if [ -f package.json ]; then bun install; fi
if [ -f mise.toml ]; then mise trust; fi
```

Files to copy:
- `config/config.local.json` or equivalent.
- `.env` or equivalent.
- `.pi` folder


### 7. Report Location

For worktree flow:

```text
Worktree ready at <full-path>
Tests passing (<N> tests, 0 failures)
Ready to implement <feature-name>
```

Then update `pi` cwd to the worktree.

For main/develop in-place flow:

```text
Branch ready in current repository: <branch>
Ready to implement <feature-name>
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| Current branch is `main` or `develop` | Create requested feature branch in the current repo; no worktree |
| Current branch is anything else | Use `<repo-parent>/<project>-worktree-<branchname>` |
| Repo is `~/dev/vahor/bidule` | Use `~/dev/vahor/bidule-worktree-<branchname>` |
| Branch has `/` | Replace `/` with `-` in folder name |
| Branch has JIRA code | Use JIRA code as `branchname` |
| Tests fail during baseline | Report failures + ask |
| No package.json/Cargo.toml/etc. | Skip dependency install |

**Called by:**
- Any skill needing isolated workspace for feature work
- When user explicitly requests worktree setup
- Before long-running implementation tasks that could pollute current workspace
