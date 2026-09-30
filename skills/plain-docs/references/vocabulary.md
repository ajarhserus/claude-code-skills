# Vocabulary

Use words the sources already use. Do not invent names, jargon, or prettier synonyms.

Sources for words, in order:

1. Code: types, functions, flags, tables, endpoints, error strings
2. Nearby docs on the same topic
3. The ticket or the user's message
4. Short common English for glue: `run`, `set`, `if`, `then`, `fails`

If the repo says `order`, write `order`. Do not write `commerce transaction`, `purchase entity`, or `fulfillment unit`.

If the repo says `Store.Insert`, write `Store.Insert`. Do not write `persistence layer`.

## Collect terms first

While gathering facts, also collect a term list from the files you opened. Reuse those strings in the doc.

Keep:

- exact command names (`make test`)
- exact paths (`internal/http/orders.go`)
- exact field names (`tax_cents`)
- exact error text if you quote it
- domain words already in that package or doc (`order`, `checkout`, `dead-letter queue` only if those words appear)

Do not add:

- a new product name
- a new abbreviation
- a synonym because it "sounds more professional"
- industry jargon the repo does not use (`orchestration`, `domain model`, `bounded context`, `control plane`) unless that file already says it

## Simple English

Glue language stays short and ordinary. Topic words stay scoped to what you read.

Allowed glue: run, set, get, put, send, read, write, fail, retry, start, stop, if, when, then, because, must, do not.

Not allowed as decoration: utilize, leverage, surface (as a verb), drive (as in "this drives alignment"), deliver (as in "deliver value").

A sentence should be understandable to someone who works on this repo and has not read a consulting deck.

## Do not rename

| Source said | Do not write |
| --- | --- |
| `orders-api` | the order orchestration service |
| `tax_cents` | tax amount in minor currency units |
| `make dev` | start the local developer experience |
| `dead-letter queue` (if that is the name) | failure sink |
| `Postgres` | relational persistence backend |

If two sources use different words for the same thing, pick the code's word and mention the other once (`the ticket says "levy"; the column is tax_cents`).

## Reuse a sentence when it is already clear

If an existing doc or comment already states the fact in plain words, keep that wording. Shorten it. Do not paraphrase into new jargon.

Copy-paste a command, flag, or error string. Do not rewrite it "for clarity" if the original is the real name.
