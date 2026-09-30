# Claude Code skills

Skills for Claude Code. Copy a skill folder into `.claude/skills/` in a project, or into `~/.claude/skills/` to use it everywhere.

## Skills

| Skill | What it does |
| --- | --- |
| [plain-docs](skills/plain-docs) | Write docs in short plain English from real findings. No buzzwords. |

## Install plain-docs

This repo:

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

Start a new Claude Code session after copying.

Use it by asking for a README, runbook, ADR, API doc, or changelog, or run `/plain-docs`.
