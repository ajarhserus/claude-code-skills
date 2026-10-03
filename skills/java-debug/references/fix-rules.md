# Fix rules

A fix makes the failing command pass for the right reason.

## Allowed

- Change the production branch the owned frame points at.
- Change the test when the expected value disagrees with the spec, the ticket, or the neighbor test.
- Add a module dependency the source already imports, in the scope the source set needs.
- Add a test property or test configuration the main config already implies.
- Register a bean that the component scan missed because the class lives outside the scan base. Prefer the scan base the application already uses.
- Run or fix a generate step so a generated type exists.
- Align a transitive to the BOM version the parent already imports.
- Add a regression test when the bug had no coverage and the repo already tests that layer.

## Not allowed

- `@Disabled`, `@Ignore`, `Assumptions.abort`, or deleting the test. Quarantine only if the user said quarantine, and name the ticket in the annotation.
- `catch (Exception e) { log; return null; }` or an empty catch.
- Weakening an assertion (`assertNotNull` instead of the expected value, `any()` instead of the argument).
- A dependency bump that is not required by the resolved conflict. No "while I'm here" Spring Boot upgrades.
- Changing `maven.compiler.release` or the toolchain to match a laptop JDK.
- Disabling a plugin (Surefire, Enforcer, Spotless, SpotBugs) in the POM.
- `@SuppressWarnings("unchecked")` on the class. Suppress the smallest element, or fix the type.
- Reformatting unrelated lines. Reviewers cannot see the fix.
- New framework (WebFlux, MapStruct, a second logger) the module does not use.
- `System.out` as the diagnosis left in the diff.
- Committing secrets that a test printed.

## Size

One cause, one diff. If the trace has two independent failures, fix the first, re-run, then the second.

Do not extract a new package, rename the public API, or "clean up" the class. A rename that is required for the symbol to resolve is fine. A rename for taste is not.

## Tests you add

Use the test style already in the class: JUnit 4 vs 5, AssertJ vs Jupiter assertions, Mockito vs hand stubs. Do not convert the file.

Unit failure stays a unit test. Do not promote it to `@SpringBootTest` to make a mock easier.

Database failure stays on Testcontainers or the embedded setup the module already uses. Do not point a test at localhost Postgres.

## Multi-module and public API

If the fix changes a signature in a published module (`api`, `spi`, a versioned client), check callers with a search before compiling one module. Update the callers in the same change. Do not leave the reactor red.

## When to stop

Stop after three hypotheses that did not change the failure, or when the next step needs a secret, a prod database, or a product decision. Report frames ruled out and the next command. Do not keep editing.
