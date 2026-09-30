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
