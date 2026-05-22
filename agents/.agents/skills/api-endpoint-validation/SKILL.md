---
name: api-endpoint-validation
description: Validate API endpoint behavior using live calls through MCP, curl, CLI clients, or SDKs. Use when asked to validate, smoke-test, QA, or prove that an API route works as expected, especially async task/export endpoints, report downloads, filters, pagination, and response-shape checks.
---

# API Endpoint Validation

Use this skill to validate that an API endpoint does what is expected in a real environment.

The goal is not only to call the endpoint. The goal is to produce evidence: what was called, what happened, what was checked, what passed, what failed, and what remains unvalidated.

## Core principles

- Validate against the expected contract: ticket, API docs, OpenAPI spec, product requirement, or user-provided acceptance criteria.
- Prefer live, user-approved tooling for the target environment: MCP tools, official CLIs, SDK clients, or `curl`.
- Keep validation safe: avoid destructive calls unless the user explicitly approves them.
- Use the smallest representative dataset that proves behavior.
- Verify both transport behavior and domain behavior.
- Save artifacts when outputs are downloadable or non-trivial.
- Be explicit about limitations. A good validation report says what was not validated.

## Before calling the endpoint

1. Clarify scope if missing:
   - environment: local, dev, staging, preprod, production
   - endpoint/route and method
   - expected behavior or ticket/key to validate
   - auth/tooling to use: MCP, curl, CLI, SDK
   - whether side effects are allowed
   - whether Jira/status transitions should be updated

2. Gather the contract:
   - Jira issue, acceptance criteria, or product requirement
   - API docs/OpenAPI schema if available
   - MCP tool descriptions if validating through MCP
   - existing source-of-truth endpoint if one can be used for comparison

3. Pick validation data:
   - choose a small but representative resource
   - ensure the resource has enough data to exercise the behavior
   - avoid huge datasets unless scale/performance is explicitly in scope
   - capture identifiers used: IDs, names, counts, filter values

4. Define checks before running calls:
   - expected response status/body/schema
   - required fields and types
   - side effects or created resources
   - downstream status transitions for async endpoints
   - downloadable artifacts or output formats
   - filter/pagination/sorting behavior
   - negative or boundary cases, if safe

## Validation workflow

### 1. Discover callable tools/routes

If using MCP:

- Connect/list the relevant MCP server.
- Describe candidate tools before calling them.
- Record tool names, route URLs, required parameters, and optional parameters.

If using HTTP directly:

- Use documented routes and auth mechanisms.
- Do not read secret files such as `.env`, `.envrc`, `.npmrc`, or credentials files.
- Ask the user for credentials or rely on already configured tooling.

### 2. Establish baseline data

Fetch the resource being tested from a reliable endpoint.

Examples:

- For a universe report, fetch the universe and entities first.
- For a detail endpoint, fetch known IDs from a list/search endpoint.
- For an update endpoint, fetch the current state before updating.
- For a filtered endpoint, fetch unfiltered and filtered versions for comparison.

Record the baseline, for example:

```markdown
| Field | Value |
| --- | --- |
| Resource ID | `...` |
| Resource name | `...` |
| Expected item count | `...` |
```

### 3. Call the endpoint

Record the exact call shape.

For MCP calls, include the tool and args:

```json
{
  "tool": "server_ToolName",
  "args": {
    "resource_id": "..."
  }
}
```

For HTTP calls, include method/path and relevant query/body fields. Avoid pasting secrets or signed URLs if they are sensitive.

Validate:

- call succeeds
- response contains expected fields
- IDs and returned references are usable
- invalid/missing fields are not silently accepted unless expected

### 4. Validate async endpoints

For async endpoints, validate the whole lifecycle:

1. Trigger the endpoint.
2. Capture the returned `task_id`, job ID, execution ID, or equivalent.
3. Poll status until a terminal state.
4. Record observed transitions.
5. On success, fetch the output/download/result.
6. On failure, capture error details without hiding them.

Expected terminal statuses should be documented. Example:

```text
pending -> running -> completed
```

or, if only observed partially:

```text
running -> completed
```

If testing failure behavior requires destructive or artificial input, ask before doing it.

### 5. Validate output artifacts

If the endpoint produces a file/export:

- download the artifact when safe
- save it under a clear local folder such as `validation-artifacts/`
- inspect the file type and compression
- parse the file with an appropriate parser, not string-only checks
- validate row count, headers, field types, duplicate IDs, missing IDs, and unexpected IDs

For CSV:

- use a CSV parser
- verify all rows have the same width as the header
- verify expected columns/blocks
- verify row counts against baseline data
- verify empty/null values are acceptable

For JSON/JSONL:

- parse JSON
- verify required fields and types
- verify pagination/count consistency when relevant

For archives:

- list archive contents
- verify expected file names and count
- inspect each relevant file

### 6. Validate filters and boundary behavior

For filters:

- choose a filter with a predictable effect
- compare filtered vs unfiltered output
- verify the filter affects only the intended parts of the output

Example for report endpoints that should keep all entities while filtering aggregations:

- unfiltered export returns one row per entity with non-zero counts
- future date filter still returns one row per entity
- all event/case-derived counts become zero
- max fields dependent on filtered data become empty/null

Useful safe boundary checks:

- future date range expected to return no matched events/items
- very narrow range expected to reduce counts
- known ID filter expected to return exactly one resource
- pagination `size` expected to limit result size

Avoid unsafe boundary checks, such as triggering huge exports or destructive updates, unless the user approves.

### 7. Compare with source of truth

When possible, compare the endpoint output against another trusted source:

- list endpoint count vs export row count
- detail endpoint value vs report row value
- task status endpoint vs downloaded output availability
- database/datamart recomputation only if explicitly in scope and accessible safely

Do not claim exact data correctness if only shape/lifecycle was validated. Say precisely what level of correctness was checked.

## What to document

Create a validation report when the validation is more than a trivial smoke test.

Recommended filename:

```text
VALIDATION_<ticket-or-endpoint>.md
```

Recommended structure:

```markdown
# <Ticket/Endpoint> Validation Report

Date: <date>
Environment: <environment>
Scope: <what was validated>

## Requirement validated

<Acceptance criteria or API contract>

## Tools used

<MCP tools, curl, CLI, scripts>

## Test data

<resource IDs, baseline counts, why chosen>

## Validation runs

### <Run 1>

- Call made
- Response received
- Status/lifecycle observed
- Output inspected
- Checks performed
- Result

### <Run 2>

...

## Summary matrix

| Requirement | Result | Evidence |
| --- | --- | --- |
| Route is callable | Pass/Fail | ... |
| Response schema is correct | Pass/Fail | ... |
| Side effect occurs | Pass/Fail | ... |

## Limitations

<What was not validated and why>

## Final conclusion

PASS / FAIL / PARTIAL, with concise reasoning.
```

## Evidence checklist

For each endpoint validation, try to capture:

- endpoint/tool name
- method/path or MCP tool description
- parameters/body used
- resource IDs used
- timestamps or date of validation
- response body snippets relevant to the check
- status transitions for async work
- artifact paths for downloaded outputs
- parser/command/script used to inspect outputs
- computed checks: row counts, missing IDs, duplicates, totals, schema matches
- limitations and risks

## Pass/fail guidance

Use clear verdicts:

- **PASS**: Expected behavior was validated with sufficient evidence.
- **PARTIAL**: Core behavior works, but some acceptance criteria were not validated.
- **FAIL**: A required behavior is missing, incorrect, or the endpoint cannot complete.
- **BLOCKED**: Validation could not be performed because tooling/auth/data/environment was unavailable.

Do not overstate results. If only the success path was tested, say so.

## Common validation patterns

### Read/list endpoint

Validate:

- endpoint is callable
- pagination works if present
- filters work if present
- response fields match docs
- count/total/search_after values are coherent
- returned IDs can be used in detail endpoints

### Detail endpoint

Validate:

- known valid ID returns expected object
- object has required fields
- related IDs/nested fields are coherent
- invalid ID behavior is checked if safe and allowed

### Create endpoint

Validate:

- request creates exactly one resource
- response returns an ID/reference
- resource can be fetched afterward
- default values are correct
- cleanup is performed if approved/needed

Only create test data in environments where side effects are allowed.

### Update endpoint

Validate:

- baseline state is captured
- update request succeeds
- updated resource reflects changes
- unchanged fields remain unchanged when expected
- cleanup/restore is performed if approved/needed

### Delete endpoint

Validate only with explicit approval.

Validate:

- target is test data
- delete request succeeds
- resource is absent afterward or marked deleted as expected
- repeated delete behavior if required

### Async export/report endpoint

Validate:

- trigger returns task/job ID
- task status is pollable
- task reaches terminal success state
- download/result endpoint returns output
- output can be parsed
- output row/object count matches source-of-truth baseline
- expected columns/fields are present
- filters affect aggregation/content correctly
- limitations for large datasets and failure path are documented

## Safety rules

- Do not call production write/delete endpoints without explicit user approval.
- Do not trigger large exports unless performance/scale is in scope and the user approves.
- Do not expose tokens, cookies, signed URLs, or secrets in the final report.
- Do not read secret files.
- Do not modify Jira/ticket status unless explicitly requested.
- Do not claim data correctness beyond what was independently checked.
