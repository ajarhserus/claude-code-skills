# Claude Code skills

Skills for Claude Code. Copy a skill folder into `.claude/skills/` in a project, or into `~/.claude/skills/` to use it everywhere.

This repo has a [CLAUDE.md](CLAUDE.md). In this repo, Claude Code should use `plain-docs` for every project doc.

## Skills

| Skill | What it does |
| --- | --- |
| [plain-docs](skills/plain-docs) | Write or rewrite docs and technical design documents (TDD) in short plain English from real findings. |

## Install plain-docs

```bash
git clone https://github.com/ajarhserus/claude-code-skills.git
mkdir -p ~/.claude/skills
cp -R claude-code-skills/skills/plain-docs ~/.claude/skills/plain-docs
```

One project only:

```bash
mkdir -p .claude/skills
cp -R skills/plain-docs .claude/skills/plain-docs
```

Already installed? Copy the folder again after a pull. Claude Code reads skills at session start.

Then ask for a README, runbook, ADR, TDD, or `/plain-docs`.

To force the skill in another repo, copy the block in [CLAUDE.md](CLAUDE.md) into that repo's `CLAUDE.md`.
