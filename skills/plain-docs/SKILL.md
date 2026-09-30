---
name: plain-docs
description: Write or rewrite documentation in short plain English from real repo findings and prior context. Use when drafting or cleaning a README, API doc, runbook, ADR, design doc, changelog, comment, onboarding guide, or any doc that sounds like AI filler. Also use when the user says write docs, document this, explain the system, update the README, make it simple, kill the buzzwords, less corporate, or stop the slop. Do not use for marketing copy, sales pages, or inventing features the code does not have.
---

# Plain Docs

Write the doc a tired teammate can use. Not a brochure. Not a model showing off vocabulary.

Ground every claim in prior findings: the conversation, the repo, logs, tickets, or an investigation you already did. If you did not find it, do not write it.

## Before you write

Do this in order. Do not skip.

1. **Collect findings.** Read the files, notes, and prior analysis that exist. Name the source of each fact (`auth.go:88`, `ADR-12`, "we measured p99 at 420ms").
2. **Name the reader.** On-call engineer, new hire, API consumer, PM.
3. **Name the job of this doc.** Start the service, call the endpoint, decide a trade-off, recover from X.
4. **Write the one-sentence answer first.** Then expand only what that sentence cannot carry.
5. **Prefer names that exist.** Files, commands, flags, tables, endpoints, ticket ids. Not "the orchestration layer."

If findings conflict or are missing, say so in the doc. Do not paper over gaps with adjectives.

## Voice

- Instructions in second person: `Run`, `Set`, `Do not`.
- Team choices in first person plural only when the team owns them: `We keep retries at 3 because...`
- Short sentences. One idea each.
- Contractions are fine.
- Specific numbers beat adjectives. `30s timeout` beats `robust timeout handling`.
- Admit gaps. `We have not tested failover in region B` is better than fake completeness.
- Match the repo's existing voice. Do not add jokes or swearing the codebase does not already use.

## Default shape

Use this unless the user asked for a different format:

```
What this is
When to use it
Do this
If it breaks
Why it is this way (optional, short)
```

Headings should be searchable phrases someone would type (`Rotate the API key`, not `Key Management Considerations`).

Lead with what it is and when you use it. Then the happy path in order. Then failure modes, defaults, and why. Rare edge cases last or in a linked file.

## Ban list

Never use these unless quoting an external spec or a proper noun. Full list and swaps: [references/banned-phrases.md](references/banned-phrases.md).

Delete on sight:

- delve, tapestry, landscape, realm, showcase, leverage, utilize, harness
- robust, seamless, holistic, cutting-edge, state-of-the-art, best-in-class
- empower, unlock, elevate, supercharge, streamline (as decoration)
- furthermore, moreover, additionally (as throat-clearing)
- it is important to note, it is worth mentioning, in today's world
- serves as, acts as a, provides a way to
- comprehensive suite, rich set of features, out of the box
- revolutionize, game-changer, next-generation
- ensure that (say what actually happens)
- carefully, simply, just, easily (they hide work)
- as an AI, hope this helps, let me know if
- "In conclusion" in a README
- Welcome to the X documentation / This document aims to

## Rewrite rules

Apply in order:

1. Cut the opening pep talk. Start at the work.
2. Replace noun stacks with one verb (`perform a deployment of` → `deploy`).
3. Replace vague praise with a measured claim from findings, or delete it.
4. Name the system, file, flag, or person.
5. Keep examples runnable or copy-pasteable. Fake `foo`/`bar` only when the real name would mislead.
6. If two sentences say the same thing, keep the shorter one.
7. Read it as if you would Slack it to a coworker at 2am. If not, rewrite.

Before/after samples: [references/examples.md](references/examples.md).
Doc-type skeletons: [references/templates.md](references/templates.md).

## Doc types

**README.** What it is, how to run it locally, how to test, how to configure. No mission statement unless the repo is a product homepage.

**API.** Method, path, auth, required fields, one real request, one real response, status codes that actually happen, idempotency and rate limits if they exist.

**Runbook.** Symptom → check → action → expected result. Time bounds. Who to page. Links to dashboards, not "monitor accordingly."

**ADR / design doc.** Context, decision, consequences. Rejected options in one paragraph each. No "we aligned on a strategic direction."

**Changelog.** User-facing change first. PR or issue id if you have one. Breaking changes in plain language (`You must set FOO or the process will exit`).

**Code comments.** Why this exists or why it is weird. Never narrate the next line.

**Onboarding.** First day path only. Accounts, clone, one working command, who to ask. Not the company story.

## Hard rules

- Do not invent a capability the code or findings do not have.
- Do not fill holes with "typically", "usually", or "should just work."
- Do not write a style lecture. If they asked for a rewrite, give the cleaned doc.
- If they want a voice diff, mention only the 2–3 habits you changed.
- If prior context is thin, gather it first. Then write. Do not guess the architecture into existence.

## Checks before you ship

- Can someone follow it without asking you?
- Is there an example they can paste?
- Did every factual sentence come from a finding?
- Any sentence that only exists to sound complete? Remove it.
- Would a tired person at 2am parse this?
