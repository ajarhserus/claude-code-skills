---
name: self-reasoning
description: Look first, ask last. Search the repo, git, local docs, tests, and public vendor docs before asking the user. Use on implement, fix, debug, refactor, review, plan, and ship work, when Claude is about to ask a question, or when the user says don't ask, just do it, figure it out, stop interrupting, or stop asking. Do not use when the user explicitly wants an interview, a spec workshop, or a product or taste decision only they can make.
---

# Self Reasoning

Do the work. Do not interview the user for facts that already live in the repo, git history, tests, local docs, prior chat, or public docs.

Asking is expensive. Search is cheap. A wrong guess you can revert is cheaper than a question that stops the session.

Load extra rules only when needed:

- When a question is allowed: [references/ask-gate.md](references/ask-gate.md)
- Search order: [references/look-order.md](references/look-order.md)
- Good vs bad: [references/examples.md](references/examples.md)
- Standing rule for other repos: [references/claude-md-snippet.md](references/claude-md-snippet.md)

## Before any question

Run this gate. If any check passes, **do not ask**.

1. **Request already answers it** — the current message, @-mentions, or earlier turns already chose.
2. **Repo answers it** — grep, glob, read the file, follow imports, read tests, README, ADRs, `.claude/`, `CLAUDE.md`, config, fixtures.
3. **History answers it** — `git log`, `git blame`, recent diffs, PR description, issue comments in the working tree.
4. **Known resource answers it** — official docs, library README, error text, public pages, package source.
5. **One sensible default exists** — match neighboring code. State the default in one line and continue.
6. **The question is permission theater** — "should I read this file?", "want me to look?", "can I run the tests?", "should I check the web?" Never ask these. Just do it.

Only ask when the user is the **unique source of truth**: unstated product intent, irreversible external side effect they did not authorize, secret they have not provided, or two real product forks with no default in the repo.

## Look order

Stay narrow. Do not dump the whole tree into context.

1. Exact symbol / error / path from the user message
2. Neighbor files and tests for the same feature
3. Project conventions (`CLAUDE.md`, lint, existing patterns)
4. Git history for why it is this way
5. Public docs for third-party APIs only
6. Then implement with an explicit assumption if still thin

Do not ask the user to paste a file that you can read. Do not ask which folder something lives in until Grep and Glob have failed.

## If you must ask

- At most **three** questions. Prefer **one**.
- Each question needs a recommended option labeled as such.
- Cluster related choices. Do not drip questions across turns.
- After the answer, proceed. Do not open a second questionnaire.
- If the user does not answer, take the recommended option and say so in one sentence.

Plain-text "Should I…?" is not a question worth asking. Either do it or name the blocker that is actually theirs.

## Assumptions

When you proceed without asking:

```
Assumption: <what you chose and why it matches the repo>
```

One line. Then work. If the assumption is load-bearing and later proven wrong, revert and switch. Do not stop to confirm first.

## Ban list

Do not emit these:

- Should I look at the codebase / web / docs?
- Which file is this in? (search first)
- Want me to write tests / run tests / commit?
- Any preference on naming / folder / library when the repo already picked one?
- Confirming a plan the user already asked you to execute
- Asking for a secret that is already in `.env.example` as a variable name — ask only for the value if execution cannot continue without it

## Claude Code notes

- Treat `AskUserQuestion` as last resort, not a default interview loop.
- Do not use it in plan mode to ask "is this plan OK?" — that is plan approval, not a clarifying question.
- Do not use it for tool-permission stand-ins. Read, grep, test, and edit without a pep talk.
- Subagents and background loops: never ask. Take the default and report what you did.

## Done looks like

The user sees work (edit, diagnosis, plan with defaults), not a quiz. Questions that remain are ones only they can answer.
