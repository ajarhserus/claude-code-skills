# Anti-patterns

Cut these even if they are not on the phrase ban list.

## Unprompted decoration

Do not add unless the user asked, or an existing doc in that folder already uses them:

- Emoji in titles or lists
- Mermaid, PlantUML, or ASCII art of the "system"
- Table of contents for a file under ~80 lines
- Badge rows
- "Built with" logo gardens
- Collapsible FAQ
- Frontmatter the repo does not already use

## Padding sections

Delete if they only exist to look like a doc:

- Overview that repeats the next heading
- Vision / mission / philosophy
- Key features
- Key takeaways
- Why this matters
- Let's dive in / Let's get started
- Next steps (when the next step is "read the rest of this file")
- Conclusion
- Related reading that is three generic links

## False precision

| Slop | Problem |
| --- | --- |
| typically / usually / generally | Hides that you do not know |
| should just work | Hides setup |
| most users | You did not count them |
| production-ready | Verdict, not a fact |
| supports X | Often means "there is a type named X" |
| automatically | Name the trigger |
| etc. at the end of a short list | Either list the rest or stop |
| likely / probably / seems | Guess written as fact |

## Hallucinated design

- A store, queue, or service you did not open
- Ports, retries, and timeouts you did not read
- "Same as the other service"
- Filling Failure modes with generic disasters so the table is not empty

If the row is not from code or a confirmed incident, delete it or mark `Unverified`.

## Structure slop

- Heading then a sentence that restates the heading
- Numbered steps that are not an order
- Nested bullets three deep
- A paragraph of caveats before the command
- Command buried after a lecture

Put the command first, then the one line of why or when.

## Rewrite slop

- Renaming a working flag to something "clearer"
- Turning a specific URL into "the dashboard"
- Promoting a helper script you did not find
- Adding an Architecture section the old file did not have
- Changing `make test` to `npm test` because it "looks standard"

## Invented language

- Renaming `order` to `commerce transaction`
- Calling `Store.Insert` the persistence layer
- Introducing an abbreviation the repo does not use
- Paraphrasing a clear existing sentence into new jargon

## TDD slop

- Current State that retells the whole company
- Goals that repeat in-scope
- "Future-proof" / "flexible design"
- Rollback that only says "revert if needed"
- Success metrics nobody measured

## Chat slop around the doc

Do not wrap the doc in:

- "Absolutely, I'll write a clean README."
- "Here is a comprehensive draft."
- "I hope this captures the architecture."
- A second copy of the file in the chat after you already wrote it, unless they asked to see it
