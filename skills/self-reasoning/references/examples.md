---
description: "Good and bad agent behavior. Read before asking a question or when the user said stop asking."
---

# Examples

## User: "Fix the 500 on POST /orders"

Bad:

> Which file handles orders? Should I look at the API folder? Do you use Prisma or raw SQL?

Good:

Grep `POST` + `orders`, read the handler and the test, patch the nil case, run the existing order tests.

Assumption only if needed: `Assumption: /orders is apps/api/src/orders/create.ts; the 500 matches the unchecked inventory lookup.`

## User: "Add rate limiting to the public API"

Bad:

> Redis or memory? Which library? What limit?

Good if the repo already rate-limits webhooks with Redis:

Implement the same helper on public routes. Say: `Matching apps/api/src/webhooks/rateLimit.ts (Redis, 60/min). Applying that to public routes.`

Good if the repo has no limiter and the user named none:

One question: `No rate limiter in repo. Recommended: reuse the Redis client in lib/redis.ts at 60 req/min/IP (same budget as webhooks). Other option: in-memory, single-instance only.`

## User: "Deploy this"

Bad:

> Should I deploy? Which environment? Want me to read the workflow file?

Good:

Read `.github/workflows` and the deploy script. If the only target is staging and the user said "deploy this" after a staging discussion, deploy staging. If prod vs staging is unmarked and both exist, ask once: `Recommended: staging via scripts/deploy.sh. Prod needs an explicit go-ahead.`

## User: "Don't ask, just do it"

Treat every later impulse to question as failed. Take the repo default. Log assumptions. Keep moving.

## Plan mode

Bad: AskUserQuestion "Does this plan look good?"
Good: Write the plan with defaults and wait for plan approval.
