---
name: plain-docs
description: Write or rewrite README, API docs, runbooks, ADRs, design docs, changelogs, comments, and onboarding guides in short plain English grounded in repo files and prior findings. Use when the user asks to document this, write docs, update the README, explain the system, draft a runbook, write an ADR, clean this doc, make it simple, kill buzzwords, less corporate, stop the slop, or de-AI the writing. Do not use for marketing pages, sales copy, or inventing features the code does not have.
---

# Plain Docs

Write the doc a tired teammate can use. Not a brochure.

Every factual sentence must come from a finding. A finding is a file, log, ticket, measurement, or something already established in this session. If you did not find it, do not write it.

Load extra rules only when needed:

- Rewrite and gather steps: [references/workflow.md](references/workflow.md)
- Extra slop to cut: [references/anti-patterns.md](references/anti-patterns.md)
- Phrase swaps: [references/banned-phrases.md](references/banned-phrases.md)
- Before/after: [references/examples.md](references/examples.md)
- Skeletons: [references/templates.md](references/templates.md)

## Mode

Pick one. Do not mix.

| User intent | Mode |
| --- | --- |
| New README / runbook / ADR / API page | **Write** |
| "Rewrite this", "clean this", "make this readable" | **Rewrite** |
| "Document what we just found" | **Session** — treat the investigation as the source. Do not re-invent it. |

Rewrite mode: keep the same facts and file path. Change voice and structure only. Do not add features the old doc did not claim unless a repo finding proves them.

## Do this first

1. Find the destination. Existing file wins. Else use [references/workflow.md](references/workflow.md) § Where the file goes.
2. Sniff voice. Read one nearby doc in the same folder. Match heading style, pronoun, and how commands are shown. Do not invent a new brand voice.
3. Build a findings list for yourself. Source each fact (`cmd/server/main.go:40`, `make test`, "session: p99 was 420ms"). Do not dump this list unless the user asked how you know.
4. Name the reader and the job of the doc in one line each. Keep them in your head.
5. Write the one-sentence answer. Expand only what that sentence cannot carry.

If the list is thin, gather more from the repo before writing. If a needed fact is still missing, write the gap in the doc. Do not paper it with adjectives.

## Voice

- Instructions: `Run`, `Set`, `Do not`.
- Team choice only when the team owns it: `We keep retries at 3 because Postgres advisory locks already cover the row.`
- Short sentences. One idea.
- Contractions are fine.
- Numbers over adjectives. `30s timeout` not `robust timeout handling`.
- Headings a person would search (`Rotate the API key`, not `Key Management Considerations`).
- Match the repo. No jokes or swearing unless that file already does.

## Default shape

```
What this is
When to use it
Do this
If it breaks
Why it is this way (optional, short)
```

Happy path first, in order. Failures and defaults next. Rare edges last or in another file.

Length budget unless the user asked for more:

- README section or comment: as short as the facts allow
- Runbook: one screen
- ADR: context + decision + consequences + rejected options. No appendix of vibes

## Ban list

Never use these unless quoting a spec or a proper noun. Full list: [references/banned-phrases.md](references/banned-phrases.md).

- delve, tapestry, landscape, realm, showcase, leverage, utilize, harness
- robust, seamless, holistic, cutting-edge, state-of-the-art, best-in-class
- empower, unlock, elevate, supercharge, streamline (as decoration)
- furthermore, moreover, additionally (throat-clearing)
- it is important to note, it is worth mentioning, in today's world
- serves as, acts as a, provides a way to
- comprehensive suite, rich set of features, out of the box
- revolutionize, game-changer, next-generation
- ensure that / carefully / simply / just / easily
- as an AI, hope this helps, let me know if
- Welcome to the X documentation / This document aims to / In conclusion

Also cut unprompted decoration. See [references/anti-patterns.md](references/anti-patterns.md):

- Emoji in headings
- Mermaid / ASCII architecture nobody asked for
- "Key features" / "Key takeaways" / "Let's dive in"
- Bold on every other noun
- Fake completeness ("typically", "usually", "should just work")

## Rewrite rules

1. Cut the opening pep talk. Start at the work.
2. Noun stack → one verb (`perform a deployment of` → `deploy`).
3. Vague praise → a measured claim from findings, or delete.
4. Name the file, flag, endpoint, or person.
5. Examples must be pasteable. Fake `foo` only when the real name would mislead.
6. Two sentences same idea → keep the shorter one.
7. Would you Slack this at 2am? If not, rewrite.

## Doc types

**README.** What it is, run locally, test, configure. No mission statement unless this repo is the product homepage.

**API.** Method, path, auth, required fields, one real request, one real response, status codes that happen, idempotency and rate limits if they exist.

**Runbook.** Symptom → check → action → expected result. Time bounds. Who to page. Dashboard links. Not "monitor accordingly."

**ADR / design.** Context, decision, consequences. Rejected options in one paragraph each.

**Changelog.** User-facing change first. PR or issue id if you have one. Breaking change as an instruction (`You must set FOO or the process will exit`).

**Comment.** Why it exists or why it is weird. Do not narrate the next line.

**Onboarding.** Access, clone, one working command, done-when, who to ask.

## Hard rules

- Do not invent a capability.
- Do not write a style lecture. Ship the doc.
- Voice diff only if asked, and only 2–3 habits.
- Do not create extra files the user did not ask for (`CONTRIBUTING.md`, `ARCHITECTURE.md`, `docs/overview.md`) unless they did.
- Do not replace working commands with "similar" ones.
- After writing, run the Checks. If a check fails, fix the doc before showing it.

## Checks

- Someone can follow it without asking you.
- There is a pasteable example when the job is a command or API call.
- Every factual sentence has a finding behind it.
- Gaps are named, not smoothed over.
- No banned phrase, no unprompted diagram, no welcome paragraph.
- A tired person at 2am can parse it.
