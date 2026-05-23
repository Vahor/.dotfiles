---
name: commit-format
description: Use when writing, reviewing, or amending git commit messages. Enforces the preferred commit prefix and message style.
---

# Commit format

Commit titles must use this format:

```text
prefix: message
```

Allowed prefixes:

- `feat`
- `fix`
- `refactor`
- `docs`

## Message rules

- The message should explicitly describe the commit content.
- Keep the commit focused on one logical change.
- If the message needs `x and y`, it likely means the work should be split into two commits.
- Do not use vague messages like `fix stuff`, `update code`, or `changes`.

## Description/body

Add a commit description only when it is really needed to explain context, tradeoffs, or non-obvious behavior.

Keep it short. The description is read by Nathan, but not necessarily by everyone, so avoid large paragraphs unless they are genuinely useful.
