# Claude Code

When writing or rewriting any project doc, use the `plain-docs` skill. Do not write docs without it.

That includes README, TDD, ADR, runbook, API docs, changelog, onboarding, and comments.

## Rules for docs

- Facts only if verified or the user confirmed them (file, config, command, log, ticket, or an unhedged statement).
- If it is not verified, label it `Unverified` or leave it out.
- Use words from the repo, ticket, or nearby docs. Do not invent names or jargon.
- Short plain English. No banned filler. See `skills/plain-docs/references/banned-phrases.md`.

Skill path in this repo: `skills/plain-docs/`.

## Install for other repos

Copy the skill, then copy the block below into that repo's `CLAUDE.md`.

```text
When writing or rewriting any project doc (README, TDD, ADR, runbook, API, changelog, onboarding, comments), use the plain-docs skill. Do not write docs without it.

Facts only if verified. Use the repo's own words. No invented jargon.
```

```bash
mkdir -p ~/.claude/skills
cp -R skills/plain-docs ~/.claude/skills/plain-docs
```

Or for one project:

```bash
mkdir -p .claude/skills
cp -R skills/plain-docs .claude/skills/plain-docs
```

Start a new Claude Code session after the copy. You can also run `/plain-docs`.
