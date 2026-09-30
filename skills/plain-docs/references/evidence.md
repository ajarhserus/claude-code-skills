# Evidence

The body of the doc is confirmed facts only. A hypothesis is not a fact. An inference is not a fact. A similar system you remember is not a fact.

## Confirmed — may be written as fact

A claim is confirmed only if you can point at one of these:

| Source | Example |
| --- | --- |
| File you read in this session | `cmd/api/main.go:22` listens on `:8080` |
| Config or flag you read | `TIMEOUT_MS=30000` in `.env.example` |
| Command that exists | `make test` in `Makefile` |
| Log, metric, or dashboard value quoted here | p99 420ms from the session paste |
| Ticket, PR, or ADR text that exists | `TICKET-1842` says tax is ignored |
| The user stated it and it was not hedged | "we page #orders-oncall" |

Old docs in the repo are **not** confirmation by themselves. Check the code. If the README and the code disagree, write the code and note the README was wrong.

## Not confirmed — do not write as fact

- You inferred a queue / service / table that you did not open
- "This is probably Redis"
- "Typically we'd put a cache here"
- "Should just work if Postgres is up" when you did not read the compose file
- Default values you assumed (`port 3000`, `3 retries`) without seeing them
- Architecture from another product
- Planned work the user did not accept
- Failure modes you invented to look complete

## How to write the gap

Put unconfirmed items in `Known gaps` or `Open questions`. Label them.

```
## Open questions

- Unverified: where timeouts are configured. Not in `cmd/api` or `.env.example`.
```

Never launder a guess:

| Banned | Use |
| --- | --- |
| Postgres is likely the store | Unverified: data store. `orders.go` calls `Store.Insert`. No implementation read. |
| We should add a retry queue | Rejected for this draft — not in the repo or the ticket |
| Requests usually finish in under a second | No latency number in session or metrics |

Words that mean you are guessing — delete or move to gaps:

likely, probably, perhaps, might, may, seems, appears, typically, generally, assume, should be, expected to, in most cases, it follows that

Exception: `may` / `might` in a failure-mode row only when the trigger is confirmed and the outcome is the code path you read (`if err != nil { return 502 }`).

## Before each sentence

Ask: can I name the source? If no, cut it or move it to gaps.

Do not pad gaps with extra design so the doc "feels finished."
