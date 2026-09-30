---
name: self-reasoning
description: Look first, ask last. Before AskUserQuestion or any clarifying question, search the repo, git, tests, local docs, and public vendor docs, then either do the work or state one assumption. Use on implement, fix, debug, refactor, review, plan, and ship work, when multiple approaches exist, when Claude is about to ask which file or which library, or when the user says don't ask, just do it, figure it out, stop interrupting, or stop asking. Do not use when the user explicitly wants an interview, a spec workshop, grill-me, or a product or taste decision only they can make.
---

# Self Reasoning

Do not interview the user for a fact you can read.

A reversible guess plus one assumption line beats a question that stops the session.

## Loop

Before `AskUserQuestion` or a "quick question" in chat, fill this and keep it to yourself unless you ask:

```
Almost asked: <the question>
Source: request | repo | git | docs | user
Looked: <tool + path, or "none yet">
Action: look | assume | ask
```

Rules:

1. If `Source` is not `user`, `Action` cannot be `ask`.
2. If `Looked` is `none yet`, `Action` is `look`. Go look. Do not talk to the user.
3. After a bounded look, set `Action` to `assume` unless the user is the only person who knows.
4. `ask` needs an evidence line in the question itself (see below).

Bounded look: one targeted Grep or Glob, the obvious neighbor file or test, the house file (`CLAUDE.md`, package manifest, CI). Not a repo tour.

Details: [references/look-order.md](references/look-order.md). Gate: [references/ask-gate.md](references/ask-gate.md). Failures: [references/gotchas.md](references/gotchas.md). Worked cases: [references/examples.md](references/examples.md).

## Action = assume

Write one line, then work:

```
Assumption: <choice> because <file or pattern>
```

Pick defaults in this order: same package → sibling feature → `CLAUDE.md` / ADR → framework default → the change you can revert (additive, flag off, no delete).

If the assumption is later wrong, revert and switch. Do not stop to confirm first.

## Action = ask

Allowed only when **all** are true:

- The answer changes work you cannot cheaply undo.
- You already looked (request, repo, git, public docs).
- Neighbor code does not already pick a pattern.
- No safe default exists.
- The user is the only person who knows.

Cheap undo: a file edit, a new test, a naming choice, a library the repo already uses, a plan the user can reject in plan mode. Those are assume, not ask.

Hard-to-undo: prod migrate, delete, force-push, email, spend money, a secret value not in the environment, a product fork the repo never chose.

Cap: **one** question. Two only if they are independent and both user-owned. Never three. Never a second round after they answer.

Shape:

```
Looked: Grep `rateLimit`, Read `apps/api/src/webhooks/rateLimit.ts`. No public-API limiter.
Recommended: reuse that Redis helper at 60/min/IP.
Other: in-memory, single instance only.
```

If you use `AskUserQuestion`: recommended option first, header ≤ 12 chars, 2–4 options. Do not ask "is the plan OK?" — that is plan approval.

If they do not answer, take Recommended and say so in one sentence.

## Never ask

Convert each stall to an action. Full table: [references/ask-gate.md](references/ask-gate.md).

- Where is the file / which folder / which package manager / which test command
- Should I read, grep, search the web, run tests, add a test, commit
- Is this the right file / does this match what you meant (after you already found it)
- Naming, folder, or library when the repo already picked one
- Confirming a plan they already asked you to execute
- Asking them to paste a file, log, or stack trace that is in the workspace or terminal
- Scope they did not name ("also rewrite billing?")
- Greenfield stack questions when `package.json` / lockfile / existing app already chose

## Claude Code

- `AskUserQuestion` is last resort, not an interview loop.
- Plan mode: ask only for a real product fork. Write the plan with defaults. Wait for plan approval.
- Subagents and background loops: never ask. Assume and report.
- User said "don't ask" / "just do it": `Action` cannot be `ask` for the rest of the turn. Assume.

## Done

The user sees an edit, a diagnosis, or a plan with defaults. Not a quiz.
