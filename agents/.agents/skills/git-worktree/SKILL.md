---
name: git-worktree
description: Use when starting feature work that needs isolation from current workspace - creates isolated git worktrees next to the current project with safety verification. Triggers on worktree, git worktree, isolated workspace, or creating a new branch for feature work.
user-invocable: true
---

# Using Git Worktrees

## Overview

Git worktrees create isolated workspaces sharing the same repository, allowing work on multiple branches simultaneously without switching.

**Core principle:** Create the worktree as a sibling of the current project + verify a clean baseline.

**Announce at start:** "I'm using the git-worktree skill to set up an isolated workspace."

## Worktree Location

Always create worktrees in the parent folder of the current project/repository:

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

### 1. Detect Project Name and Parent Folder

```bash
repo_root=$(git rev-parse --show-toplevel)
project=$(basename "$repo_root")
parent=$(dirname "$repo_root")
```

### 2. Determine Worktree Path

```bash
branch="<actual-git-branch-name>"
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

If current branch is `main` or `develop` or `master` ask user which feature should be implemented. Do not make a worktree based of these branches.

### 3. Create Worktree

```bash
git worktree add "$path" -b "$branch"
cd "$path"
```

If the branch already exists, use the existing branch instead:

```bash
git worktree add "$path" "$branch"
cd "$path"
```

### 4. Run Project Setup

Auto-detect and run appropriate setup:

```bash
# Node.js
if [ -f package.json ]; then bun install; fi
if [ -f mise.toml]; then mise trust; fi
```

Files to copy:
- `config/config.local.json` or equivalent.
- `.env` or equivalent.
- `.pi` folder


### 5. Report Location

```text
Worktree ready at <full-path>
Tests passing (<N> tests, 0 failures)
Ready to implement <feature-name>
```

Then update `pi` cwd.

## Quick Reference

| Situation | Action |
|-----------|--------|
| Any project | Use `<repo-parent>/<project>-worktree-<branchname>` |
| Repo is `~/dev/vahor/bidule` | Use `~/dev/vahor/bidule-worktree-<branchname>` |
| Branch has `/` | Replace `/` with `-` in folder name |
| Branch has JIRA code | Use JIRA code as `branchname` |
| Tests fail during baseline | Report failures + ask |
| No package.json/Cargo.toml/etc. | Skip dependency install |

**Called by:**
- Any skill needing isolated workspace for feature work
- When user explicitly requests worktree setup
- Before long-running implementation tasks that could pollute current workspace
