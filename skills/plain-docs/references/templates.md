# Doc skeletons

Fill these from findings. Delete any section you cannot source.

## README

```
# <name>

<one sentence: what it is and who uses it>

## Run locally

<prereqs>
<exact commands>
<how you know it worked>

## Test

<exact command>
<what green looks like>

## Configure

| Name | Default | What it does |
| --- | --- | --- |
|  |  |  |

## Deploy

<who runs it, where, command>

## Known gaps

<things that look supported but are not>
```

## API

```
# <METHOD> <path>

<one sentence>

Auth: <scheme and scope>
Idempotent: yes/no
Rate limit: <number> or "none documented"

## Request

<required fields, types, example from a real call if you have one>

## Response

<success body>
<status codes that actually happen>

## Errors

| Status | When |
| --- | --- |
|  |  |
```

## Runbook

```
# <symptom in the words the pager uses>

## Check

1. <dashboard or log query>
2. <expected vs bad>

## Act

1. <command>
2. <expected result and how long to wait>
3. <who to page if it is still bad>

## After

<root cause notes, ticket to file>
```

## ADR

```
# ADR-<n>: <decision in one line>

Status: accepted | proposed | superseded by ADR-x
Date: <date>

## Context

<what forced a choice. numbers if you have them>

## Decision

<what we do now>

## Consequences

- <good>
- <pain we accepted>

## Rejected

- <option>: <one paragraph why not>
```

## Changelog entry

```
## <version or date>

- <user-facing change>. (<PR or issue>)
- Breaking — <what old clients must do now>
```

## Onboarding

```
# First working day on <repo>

1. Get access to: <list>
2. Clone and run: <commands>
3. You are done when: <observable>
4. Ask: <channel or person> for <specific thing>
```
