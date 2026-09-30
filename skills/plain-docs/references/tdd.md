# Technical design document (TDD)

TDD here means a technical design document: how we will build a change. Not test-driven development. If the user asked for a test plan or red-green-refactor notes, write that as a short test plan in the same voice. Do not mix the two.

Reader: the engineer who will implement or review the change.

Job of the doc: they can start work without a meeting.

## TDD vs ADR

| | ADR | TDD |
| --- | --- | --- |
| Question | What did we decide? | How do we build it? |
| Length | One decision | The change, end to end |
| Skip if | The change is one line in an existing ADR | Someone only asked for the decision |

If they asked for both, write the TDD and link the ADR. Do not copy the same paragraphs into both.

## Must come from findings

Name real things:

- files and packages that will change
- endpoints, events, tables, flags
- numbers we already have (QPS, size, timeout, ticket id)
- current behavior that is wrong

Do not invent a future service, queue, or "platform layer" that is not in the repo or the session.

## Shape

Use the skeleton in [templates.md](templates.md). Required sections, even if short:

1. Problem
2. Constraints
3. In scope / out of scope
4. Design (interfaces + data)
5. Failure modes
6. Rollout / rollback
7. Open questions
8. Rejected options

Delete a subsection only when it cannot apply (example: no data store change → drop Data, say "no new tables").

## Design section rules

- Write the happy path as steps. Then the branch that fails.
- Prefer a sequence of calls over a box diagram. Add a diagram only if the user asked, or an existing TDD in this repo uses one.
- One real request and response when an API changes.
- Config and flags belong here, not in a speech about flexibility.

## Failure modes

Every design has at least one. If you cannot name a failure, you have not read the change.

Examples of real rows:

| Failure | What happens | How we see it |
| --- | --- | --- |
| checkout-db timeout | request returns 502, job goes to `orders-dlq` | `orders_dlq_depth` on the orders Grafana board |
| flag off | old path unchanged | flag `orders.tax_v2` in config service |

## TDD slop — delete

- Goals / non-goals that restate in/out of scope
- "Strategic alignment with the platform roadmap"
- "This design is flexible and future-proof"
- A 2-page Current State that is a tour of the whole company
- Risks that are generic (`there may be unforeseen issues`)
- Success metrics you did not find (`improve engagement`)
- Implementation phases dated with hope, not a plan

## Open questions

List only questions that block coding. Each one needs an owner if the session named one. "TBD" with no subject is not a question.

## Checks for a TDD

- An implementer knows which files to open first.
- Out of scope stops a likely argument.
- Rollback is a command or a flag, not "revert if needed."
- No sentence that would also fit a different product.
