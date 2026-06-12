---
name: plan 
description: 'How to plan for a task. Use this skill when asked to implement a task or a feature.'
---

## Information-gathering guardrails

- Once in "search"/"plan" phase, inform user on what you are looking for. And base your search on that information. Make a `SEARCH.md` to document your search.

- If a found information does not match what was in `AGENTS.md` or is clearly missing to understand the codebase, add it to `AGENTS.md` and update the plan. When an information is important to understand the structure, create a `docs/` folder in the repo and put the information there. Check [./ADR-FORMAT.md](./ADR-FORMAT.md) for more details.

## Plan

0. Check only obvious/current-directory planning guidance: `README.md`, `CONTRIBUTING.md`, `AGENTS.md`, `PLAN.md`, `SEARCH.md`, and `QUESTIONS.md` and `docs/` folder. When checking an existing `PLAN.md`, or any plan-related file, ask the user if it is up to date.

1. **Non-negotiable first step:** understand the scope before planning. If the user gives a Jira issue key/URL, first fetch the Jira issue details needed to understand the task, following the Jira skill's field/output limits. Then ask clarifying questions based on that ticket. If the user does not give a Jira issue, ask clarifying questions before any task-specific work. 
You can read repository files, `docs` folder, run implementation-oriented shell commands, or gather code context before asking those questions. Do not look for at the whole codebase, ask guidance questions instead. But do not start anything else. If you had a question and answer it yourself, still ask the user if the answer is correct. 
Write a `QUESTIONS.md` file with responses to these questions after the user answers, in there write the full question and full answer.

1.1 If the user does not answer each question, or answers with a vague response, ask clarifying questions until the user provides a clear answer for every question.

1.2 If you have many questions, ask them one by one, as a previous anwser may influence the next question.

2. After the user answers, gather only the additional context needed for the plan. Then break down the task into smaller, manageable subtasks. Use the following format:

```
# Step 1: Task description
- [ ] Subtask 1

implementation details

- [ ] Subtask 2

implementation details

- [ ] Subtask 3

implementation details

# Step 2: Task description
...
```

Add as much detail as needed.

Each subtask has to be somewhat independent of the others. The goal is for the user to be able to review it and see the results. If the tests don't fully pass, as long as it's planned to be fixed in the future, it's fine.

You can make as many subtasks as you want.

2.1 Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

If a question can be answered by exploring the codebase, explore the codebase instead.

Update the plan and questions file with the user's answers.

2.2 If a subtask is complex, ask the user if they want a minimal version first. In that case note to use the `minimal-solution` skill for that part and make an new subtask for the minimal version. The next step is to possibly to implement the full version.

3. For each subtask, define the specific goals and deliverables. Be clear, which files will be impacted, and how the task will be accomplished.

4. Ask for confirmation before writing the plan to a PLAN.md file. Do not create or update PLAN.md until the user explicitly approves the proposed plan. Refer to PLAN.md when doing the task.

5. One a task is done, do not go on the next task unless specifically asked to do so. Ask for confirmation before moving on. Update plan to mark what was done and what was skipped.
