---
description: "When a question is allowed vs forbidden. Read before calling AskUserQuestion or writing a clarifying question."
---

# Ask gate

A question is allowed only if **all** of these are true:

1. The answer changes the work in a way you cannot cheaply undo.
2. You already searched the request, the repo, git, and public docs.
3. Neighboring code does not already pick a pattern.
4. There is no safe default you can state and proceed with.
5. The user is the only person who knows the answer.

If any item is false, do not ask.

## User is source of truth

Ask (after the look):

| Topic | Why it is theirs |
|---|---|
| Product outcome | "Is this for end users or internal ops?" when both exist and the repo is silent |
| Irreversible side effect | production migrate, delete, force-push, email customers, spend money |
| Secret value | API token, password, account they have not put in the environment |
| Taste with no house style | copy, brand, UX when no design system or existing screen exists |
| Scope they never named | "also rewrite the billing service?" when they asked for a typo fix |

Do not ask:

| Topic | Why it is not theirs |
|---|---|
| File location | Grep / Glob |
| How a function works | Read the function |
| Which library the repo uses | package.json, imports, existing modules |
| Test command | package.json, Makefile, CI |
| Public API shape | vendor docs |
| Naming of a new helper | match the folder |
| Whether to read a file | that is your job |
| Whether the plan is OK in plan mode | use plan approval |

## Permission theater

These are not questions. They are stalls. Convert each to an action:

| Stall | Action |
|---|---|
| Want me to check the repo? | Check the repo |
| Should I search the web? | Search if the dependency is third-party |
| Can I run the tests? | Run the relevant tests |
| Should I add a test? | Add one if the folder already tests this layer |
| Do you want me to proceed? | They already asked you to do the task |

## Defaults beat questions

Pick the default that already exists, in this order:

1. Exact pattern in the same package
2. Pattern in the closest sibling feature
3. Documented convention in `CLAUDE.md` / ADRs
4. Language or framework idiomatic default
5. The reversible option (feature flag off, additive API, no data delete)

State it. Move.

## Question shape when allowed

One question, two to four options, one marked recommended.

Bad: "How do you want auth?"
Good: "Auth is not specified and the repo has no auth. Recommended: session cookies like `apps/web` already uses for admin. Or JWT if this is a public API."

If you need two axes (who + where), put both in one turn. Never ask axis 1, wait, then axis 2.
