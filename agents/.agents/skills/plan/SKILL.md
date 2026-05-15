---
name: plan 
description: 'How to plan for a task. Use this skill when asked to implement a task or a feature.'
---


0. Check only obvious/current-directory planning guidance: `AGENTS.md`, `PLAN.md`, and `QUESTIONS.md`. Do not search recursively. If `PLAN.md` or `QUESTIONS.md` is present, ask if it is up to date. If `AGENTS.md` is present or explicitly named, read it as repo guidance.

1. **Non-negotiable first step:** understand the scope before planning. If the user gives a Jira issue key/URL, first fetch the Jira issue details needed to understand the task, following the Jira skill's field/output limits. Then ask clarifying questions based on that ticket. If the user does not give a Jira issue, ask clarifying questions before any task-specific work. Do **not** read repository files, run implementation-oriented shell commands, or gather code context before asking those questions and waiting for the user's answer. The only exceptions before the first questions are reading this skill file itself, reading obvious/current-directory `AGENTS.md` / `PLAN.md` / `QUESTIONS.md`, and fetching the provided Jira issue. Write a `QUESTIONS.md` file with responses to these questions after the user answers.

1.1 If the user does not answer each question, or answers with a vague response, ask clarifying questions until the user provides a clear answer for every question.

2. After the user answers, gather only the additional context needed for the plan. Default context budget: read at most 3 targeted files or 500 lines total. If the relevant files are not obvious from the user's answers or `AGENTS.md`, ask the user which files to inspect instead of searching. Increase this budget only after explicit user approval. Then break down the task into smaller, manageable subtasks. Use the following format:

```
- Subtask 1
- Subtask 2
- Subtask 3
```

Add as much detail as needed.

Each subtask has to be somewhat independent of the others. The goal is for the user to be able to review it and see the results. If the tests don't fully pass, as long as it's planned to be fixed in the future, it's fine.

You can make as many subtasks as you want.

3. For each subtask, define the specific goals and deliverables. Be clear, which files will be impacted, and how the task will be accomplished.

4. Ask for confirmation before writing the plan to a PLAN.md file. Do not create or update PLAN.md until the user explicitly approves the proposed plan. Refer to PLAN.md when doing the task.

5. One a task is done, do not go on the next task unless specifically asked to do so. Ask for confirmation before moving on.

## Information-gathering guardrails


- Once in "plan" phase, inform user on what you are looking for. And base your search on that information. Make a `SEARCH.md` to document your search.
