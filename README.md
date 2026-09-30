# Claude Code skills

Skills for Claude Code. Copy a skill folder into `.claude/skills/` in a project, or into `~/.claude/skills/` to use it everywhere.

## Skills

| Skill | What it does |
| --- | --- |
| [plain-docs](skills/plain-docs) | Write or rewrite docs in short plain English from real findings. No buzzwords. |

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

Then ask for a README, runbook, ADR, or `/plain-docs`.
