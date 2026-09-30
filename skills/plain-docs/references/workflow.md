# Workflow

Use this after the mode is picked in SKILL.md.

## Gather

Read before you write. Minimum set, in order, stop when you can source the one-sentence answer:

1. The file you are writing or replacing.
2. Sibling docs in that folder (voice + overlap).
3. The code paths, Makefile, or scripts the doc will name.
4. Prior messages in this session if the user said "from what we found."

Record each finding as `claim — confirmed source`. Example:

- listens on `:8080` — `cmd/api/main.go:22` (read)
- `make test` runs unit tests — `Makefile:14` (read)
- failover untested in prod — user said so this session

If you cannot name a source, it is not a finding. Do not promote it in the draft.

If two sources disagree, prefer code over docs. Say the docs were wrong if you are changing them.

Guesses go to Known gaps / Open questions as `Unverified`. See [evidence.md](evidence.md).

## Where the file goes

| Request | Put it here |
| --- | --- |
| Update an existing path | That path |
| "README" and one exists | Existing README |
| New API page | Next to the handler or under `docs/` if that tree already exists |
| Runbook | `docs/runbooks/` if present, else next to the service |
| ADR | `docs/adr/` or `adr/` if present. Number from the last one |
| TDD / technical design | `docs/design/` or `docs/tdd/` if present, else `docs/` |
| Comment | The code file they pointed at |

If none of these fit, ask one question: which path. Do not scatter new doc trees.

## Write mode

1. Gather.
2. Pick the skeleton in [templates.md](templates.md). For a TDD, also follow [tdd.md](tdd.md). Delete sections you cannot source.
3. Draft.
4. Run Checks in SKILL.md.
5. Write the file. In chat, show the path and the doc. No preamble.

## Rewrite mode

1. Read the current file all the way through. Keep its facts unless a repo finding disproves one.
2. Keep the same path and the same scope. A README stays a README.
3. Apply rewrite rules in SKILL.md.
4. If you drop a fact, it must be filler or false. Do not drop a command, flag, or URL.
5. Show the cleaned doc. If they asked for a diff of voice, list 2–3 habits only.

## Session mode

The investigation already happened. Do not reopen the architecture from scratch.

1. List the decisions and measurements from this session that were confirmed (code read, user stated, ticket quoted).
2. Confirm each against a file when a file exists.
3. Write only those. Mark anything still unverified as `Unverified`. Do not fill with a guessed design.

## When context is thin

Ask at most one question, and only if the answer chooses a path or a reader.

Do not ask:

- "What tone would you like?"
- "Should I include a features list?"
- "Want mermaid diagrams?"

If you must ship with holes:

```
## Known gaps

- We do not have a prod runbook for region B.
- Rate limits are not in code or config I could find.
```

## After

Do not add "let me know if you want a CONTRIBUTING guide." Stop.
