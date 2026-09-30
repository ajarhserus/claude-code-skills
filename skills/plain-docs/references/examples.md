# Before / after

These are the target voice. Match this tightness.

## README intro

Before:

> Welcome to the Order Service! This comprehensive, robust microservice aims to provide a seamless way to leverage our orchestration layer to empower teams to manage orders at scale in today's fast-paced commerce landscape.

After:

> HTTP API for creating and reading orders. Used by checkout and the admin UI.
>
> Run it locally with `make dev`. Postgres and Redis must be up.

## Feature bullet

Before:

> Additionally, the platform utilizes cutting-edge retry logic to ensure that requests are seamlessly completed.

After:

> Failed calls retry 3 times with 200ms exponential backoff. After that the client gets `502` and the job goes on the dead-letter queue.

## Runbook

Before:

> If issues arise, it is important to monitor the relevant dashboards and take appropriate action as needed.

After:

> 1. Check error rate on https://grafana.example/d/orders
> 2. If p99 > 800ms for 5 minutes, restart `orders-api` in prod-a (`kubectl rollout restart deploy/orders-api -n prod`)
> 3. If it is still high, page #orders-oncall

## API paragraph

Before:

> This endpoint serves as a mechanism that provides the ability to retrieve user information in a flexible manner.

After:

> `GET /v1/users/:id`
>
> Auth — bearer token with `users:read`.
>
> Returns 404 if the user is missing, 401 if the token is bad.

## ADR fragment

Before:

> After careful consideration of the evolving landscape, we have decided to leverage Postgres to holistically meet our needs.

After:

> We store orders in Postgres.
>
> We looked at DynamoDB. We need multi-row transactions and our team already runs Postgres. We will revisit if a single region becomes a hard limit.

## Changelog

Before:

> We are thrilled to announce a rich set of improvements that enhance the overall developer experience.

After:

> - `POST /v1/orders` now rejects unknown fields (`400`) instead of ignoring them.
> - Breaking — `tax_cents` is required. Old clients must send `0`.

## Comment

Before:

> // This function iterates through the list and incrementally appends items in order to build the result

After:

> // Cap at 50 because the billing UI paginates there. Do not raise without checking the invoice PDF renderer.

## Finding with a hole

Before:

> The system provides robust multi-region failover capabilities.

After:

> Failover is coded for region A → region B. We have not tested it in production. Last drill was 2025-11-02 and it was tabletop only.

## Session dump → runbook

Before (what the model wants to write after an investigation):

> ## Architecture Overview
> At a high level, the orders platform leverages a robust pipeline to ensure seamless processing.

After (only what the session actually found):

> # Orders 5xx after deploy
>
> ## Check
> 1. `kubectl logs deploy/orders-api -n prod --since=15m | grep timeout`
> 2. If you see `checkout-db:5432: i/o timeout`, the new chart dropped the network policy.
>
> ## Act
> 1. `kubectl apply -f deploy/prod/networkpolicy.yaml`
> 2. Error rate on https://grafana.example/d/orders should fall under 1% within 2 minutes.
> 3. Still high → page #orders-oncall

## TDD fragment

Before:

> This document aims to provide a holistic, future-proof design that leverages our orchestration layer to seamlessly unlock next-generation tax calculation capabilities.

After:

> # TDD: charge tax in the orders API
>
> Status: draft
> Links: TICKET-1842
>
> ## Problem
>
> `POST /v1/orders` ignores `tax_cents`. Finance has to backfill ~12k orders/month.
>
> ## Constraints
>
> - Old clients send no tax field. They must keep working until 2026-12-01.
> - We already use Postgres for orders (`orders.orders`).
>
> ## Design
>
> Add required `tax_cents` on `POST /v1/orders` behind flag `orders.tax_v2`.
> Writer: `internal/http/orders.go`. Column: `orders.tax_cents int not null default 0`.
>
> Flag off: accept the body, store `0`, do not 400.
> Flag on: missing field → `400` `{ "error": "tax_cents required" }`.
>
> ## Rollout
>
> 1. Migrate column.
> 2. Ship code, flag off.
> 3. Flag on for internal clients, then all.
> 4. Roll back: set `orders.tax_v2=off`. Column can stay.

## Guess vs confirmed

Before:

> The API probably sits behind Redis and typically retries failed writes three times.

After:

> Writer is `internal/http/orders.go`. It calls `Store.Insert`.
>
> ## Open questions
>
> - Unverified: cache. No Redis client in the files read.
> - Unverified: retry count. No retry loop in `orders.go`.
