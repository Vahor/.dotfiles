---
name: jira-acli
description: "Use Atlassian CLI (`acli`) whenever the user wants Jira information: issues/tickets, projects, boards, sprints, filters, users, statuses, comments, changelogs, or JQL/search results. Prefer retrieving Jira data with `acli` instead of asking the user to paste Jira details or guessing from memory."
---

# Jira ACLI

When a request requires Jira information, use the Atlassian CLI command `acli` from the shell.

## Workflow

1. Prefer `acli` for live Jira data.
2. If the exact `acli` syntax is unclear, inspect the installed CLI help first:
   ```bash
   acli --help
   acli jira --help
   ```
3. If the user provides a Jira issue key or URL, retrieve that item with `acli` before answering. If the user provides only a numeric issue id with no project prefix, assume the `CORE-` project prefix (for example, `4436` means `CORE-4436`).
4. If the user asks for search/list/report style information, use `acli` with JQL or the relevant Jira subcommand when available.
5. If required context is missing (for example project key, issue key, sprint, board, or JQL), ask a concise clarification.
6. If `acli` is not installed or not authenticated, tell the user what failed and ask them to install/authenticate it.

## Work item fields

For general work-item context, fetch and report only these fields unless the user explicitly asks for more:

- `summary`
- `description`
- Design: `customfield_10134`
- Validation: `customfield_10170`
- `subtasks`

Do not fetch, list, or summarize other metadata fields such as status, assignee, reporter, priority, issue type, created, updated, or parent unless explicitly requested.

`description`, Design, and Validation are usually Atlassian Document Format (ADF). Do not show raw JSON unless the user asks for it.

Render work-item JSON with the local Bun transformer. It must always be used as a pipe transform; it does not call `acli` itself.

```bash
acli jira workitem view <ISSUE_KEY> --fields "summary,description,customfield_10134,customfield_10170,subtasks" --json \
  | jira-workitem-field-md
```

For a single field, fetch the raw Jira field id and pass the readable alias to the transformer:

```bash
acli jira workitem view <ISSUE_KEY> --fields "customfield_10134" --json \
  | jira-workitem-field-md

acli jira workitem view <ISSUE_KEY> --fields "customfield_10170" --json \
  | jira-workitem-field-md
```

Transformer aliases: `summary`, `description`, `design`, `validation`, `subtasks`.

## Response guidance

- Return the requested Jira field content as-is from `acli` / `jira-workitem-field-md`. Do not summarize, rephrase, restructure, or otherwise transform the content.
- MUST paste the complete transformer output for the requested fields. Do not omit, condense, reorder, or skip any section, bullet list, paragraph, or subtask, even when the field is long.
- If output is too long for the chat/interface, say that explicitly and offer to write it to a file; never selectively summarize.
- For general issue lookups, include only summary, description, Design, Validation, and subtasks.
- Mention the command used when it helps the user verify or repeat the result.
- Do not invent Jira data when `acli` cannot retrieve it.
