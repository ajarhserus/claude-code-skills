---
name: java-debug
description: Debug and fix Java and Kotlin-on-JVM repo failures. Use when a Maven or Gradle build is red, a test fails, a stack trace is pasted, the app will not start, CI failed on a JVM job, or the user says fix this bug, debug this, tests are failing, NPE, NoSuchBean, cannot find symbol, classpath conflict, or dependency resolution. Do not use for greenfield features, non-JVM bugs, or an architecture review with no failing behavior.
---

# Java Debug

Find the failing command, the first frame this repo owns, and the cause. Fix that cause. Re-run the same command.

Do not start by rewriting the module.

## Loop

1. Classify the failure. Do not edit yet.
2. Detect the build (wrapper, Java release, module).
3. Reproduce with the smallest command that still fails.
4. Read the first owned frame, then the deepest `Caused by` that names a repo class, a missing key, or a missing type.
5. Write one hypothesis tied to a file.
6. Change the cause. Not the symptom.
7. Re-run the same command. If it is still red, new hypothesis. Do not stack guesses.
8. Report what failed, what you changed, and the command result.

Details: [references/reproduce.md](references/reproduce.md). Classes: [references/failure-classes.md](references/failure-classes.md). What a fix may do: [references/fix-rules.md](references/fix-rules.md). Worked cases: [references/examples.md](references/examples.md).

## Classify

| What you see | Class | First look |
|---|---|---|
| `cannot find symbol`, `package does not exist`, `invalid target release` | compile | owning file, module dep, generated sources, JDK release |
| assertion, `Wanted but not invoked`, status/body mismatch | test | the assertion and the production branch it calls |
| `ApplicationContext`, `NoSuchBean`, `UnsatisfiedDependency`, Flyway | context | the test slice, the missing bean or property, the migration |
| `Could not resolve`, `Conflict`, `NoClassDefFound`, `NoSuchMethodError` | classpath | tree for that artifact, duplicate classes, scope |
| NPE, CCE, `IllegalState` in `src/main` | runtime | first owned frame, null source, not the framework wrapper |
| passes alone, fails in suite or CI | order / shared state | statics, fixed ports, shared DB, time |
| checkstyle, spotbugs, enforcer, formatter | gate | the violation. Fix the code. Do not disable the gate |

If the log is an IDE run and CI uses Maven or Gradle, the build command is the truth.

## Detect

Read, do not ask:

- `mvnw` / `pom.xml` → Maven. `gradlew` / `build.gradle(.kts)` → Gradle. Both exist: use the one CI uses (`.github/workflows`, `Jenkinsfile`).
- Java release from `maven.compiler.release`, `java.toolchain.languageVersion`, `build.gradle` toolchain, `.java-version`, or `Dockerfile`. Not from a random `java -version` unless they match.
- Module from the failing path (`service/foo/...`) or the reactor log (`--- module ---`).

`bash scripts/detect-build.sh` from the repo root prints wrapper, release, and the newest Surefire/Gradle failure if a report is already on disk. It does not download anything.

## Reproduce

Maven, one test:

```
./mvnw -pl <module> -Dtest=<TestClass>#<method> -DfailIfNoTests=false test
```

Gradle, one test:

```
./gradlew :<module>:test --tests '<pkg.TestClass>.<method>'
```

No module: drop `-pl` / the project prefix. No wrapper: `mvn` or `gradle`, and say so.

Compile-only when the failure is compile: `./mvnw -pl <module> -DskipTests compile` or `./gradlew :<module>:compileJava`.

Read `target/surefire-reports/*Test.txt` or `build/reports/tests/test/`. The `.txt` next to the XML is the stack. The XML is for CI counts.

IDE green, build red: different JVM, working directory, profile, or generated sources. Reproduce the build. Do not "fix" the IDE run.

## Read the trace

Skip Spring, JUnit, Mockito, Tomcat, and reflection frames until a path under this repo's `src/main` or `src/test`.

Prefer the deepest `Caused by` that names a repo type, a missing property, or `ClassNotFoundException`. The top wrapper is usually `InvocationTargetException` or `BeanCreationException`.

Hypothesis line, then edit:

```
Hypothesis: <cause> because <file:line or config key>
```

Two causes fit: the one that explains the first owned frame wins.

## Fix

Allowed: a production change that makes the failing behavior correct, a test fix when the test is wrong, a missing module dependency that the code already imports, a property the test profile omitted, a generated-sources step the build skipped.

Not allowed: `@Disabled` / `@Ignore`, deleting the test, `catch (Exception ignored)`, a blanket dependency bump, weakening an assertion so it passes, disabling enforcer/spotbugs, a drive-by Java upgrade, a reformat of the file.

Match the repo's Java release and the neighbor class. Constructor injection if that is what the package uses. Do not introduce a framework the module does not have.

Full list: [references/fix-rules.md](references/fix-rules.md).

## Verify

1. The same command that failed.
2. The whole test class.
3. The module, if the change is in `src/main` or a shared test fixture.

Still red: revert the guess or leave it only if it is independently correct, then new hypothesis. Three failed guesses: stop and report the frames, what you ruled out, and the next check. Do not keep patching.

## Report

```
Failed: <command> — <exception, one line>
Cause: <file and why>
Change: <paths>
Re-ran: <command> — pass|fail
Left: <still red, or none>
```

No "should be fixed now" without the re-run.
