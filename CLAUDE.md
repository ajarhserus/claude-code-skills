# Claude Code

When writing or rewriting any project doc, use the `plain-docs` skill. Do not write docs without it.

That includes README, TDD, ADR, runbook, API docs, changelog, onboarding, and comments.

On implement, fix, debug, refactor, review, plan, and ship work, use the `self-reasoning` skill. Look in the repo, git, local docs, and public vendor docs before asking the user.

## Rules for docs

- Facts only if verified or the user confirmed them (file, config, command, log, ticket, or an unhedged statement).
- If it is not verified, label it `Unverified` or leave it out.
- Use words from the repo, ticket, or nearby docs. Do not invent names or jargon.
- Short plain English. No banned filler. See `skills/plain-docs/references/banned-phrases.md`.

Skill path in this repo: `skills/plain-docs/`.

## Rules for questions

- Do not ask the user for a fact that lives in the repo, git, tests, local docs, or public vendor docs.
- Do not ask permission to read, grep, test, or edit. Do not ask which file or which library.
- Ask at most one question, only when the user is the unique source of truth, and say what you already looked at.
- Otherwise write one Assumption line and continue.

Skill path in this repo: `skills/self-reasoning/`.

## Install for other repos

Copy the skill, then copy the block below into that repo's `CLAUDE.md`.

```text
When writing or rewriting any project doc (README, TDD, ADR, runbook, API, changelog, onboarding, comments), use the plain-docs skill. Do not write docs without it.

Facts only if verified. Use the repo's own words. No invented jargon.

Look first, ask last. Before any question, search the repo, git, local docs, and public vendor docs. Do not ask permission to read, grep, test, or edit. Do not ask which file or which library. Ask at most one question, only when I am the unique source of truth, and include what you already looked at. Otherwise write one Assumption line and continue.
```

```bash
mkdir -p ~/.claude/skills
cp -R skills/plain-docs ~/.claude/skills/plain-docs
cp -R skills/self-reasoning ~/.claude/skills/self-reasoning
```

Or for one project:

```bash
mkdir -p .claude/skills
cp -R skills/plain-docs .claude/skills/plain-docs
cp -R skills/self-reasoning .claude/skills/self-reasoning
```

Start a new Claude Code session after the copy. You can also run `/plain-docs` or `/self-reasoning`.
