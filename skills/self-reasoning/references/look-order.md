---
description: "Search order and tools to use before asking the user. Read when you do not know where a fact lives."
---

# Look order

Use the smallest tool that can answer. Stop when you have the fact.

## 1. What the user already said

Re-read the current message and the last few turns. @-mentioned paths are the start, not a hint to ignore.

## 2. Exact strings

Grep the error, symbol, route, flag, and unique phrase. Glob the likely folder names (`**/*auth*`, `**/*billing*`).

## 3. The file and its neighbors

Read the implementation, the test next to it, and the type or proto it imports. Conventions live in siblings more often than in README.

## 4. Project memory

Read `CLAUDE.md`, `.claude/`, ADRs, `docs/`, runbooks, `.env.example`, CI workflows, Makefile / package.json scripts. These are the house style.

## 5. Git

`git log -S` and `git blame` for "why is this like this?" The commit message often beats asking the author who is sitting next to you.

## 6. Third-party only: web

Search vendor docs when the gap is an external API, CLI flag, or error from a library. Do not search the web for how *this* repo names things.

## Stop conditions

- You found the pattern: copy it.
- You found two patterns: pick the one in the same package, say so.
- You found nothing after a bounded search: state the assumption and implement in the smallest place that compiles.

A bounded search is: one targeted grep, one glob, the obvious config file, and the nearest test. Not a repository tour.
