# Reproduce

The build command is the bug. An IDE run is a hint.

## Which tool

| Found | Use |
|---|---|
| `mvnw` and CI calls it | `./mvnw` |
| `gradlew` and CI calls it | `./gradlew` |
| both wrappers | the one in `.github/workflows` or `Jenkinsfile` |
| `pom.xml` only | `mvn` |
| `build.gradle` or `build.gradle.kts` only | `gradle` |
| neither | not this skill |

Kotlin on JVM uses the same commands. Annotation processing is kapt or KSP, not Lombok, unless both are present.

## Maven

Single test method:

```
./mvnw -pl billing -Dtest=OrderServiceTest#rejectsEmptyCurrency -DfailIfNoTests=false test
```

Whole class, one module, also build dependencies:

```
./mvnw -pl billing -am -Dtest=OrderServiceTest -DfailIfNoTests=false test
```

Compile only:

```
./mvnw -pl billing -am -DskipTests compile
```

Integration tests (Failsafe, `*IT`):

```
./mvnw -pl billing -DskipITs=false -Dit.test=OrderIT verify
```

Dependency conflict for one artifact:

```
./mvnw -pl billing dependency:tree -Dincludes=com.fasterxml.jackson.core:jackson-databind
```

Verbose tree when the winner is an omitted transitive:

```
./mvnw -pl billing dependency:tree -Dverbose -Dincludes=com.google.guava
```

Generated sources (Lombok, MapStruct, jOOQ, Protobuf, OpenAPI) are not on disk until the generate step runs. If the symbol is a generated type, run `generate-sources` / `compile` before concluding the import is wrong.

Surefire forks a JVM. `mvnDebug` attaches to Maven, not to the test. To attach to the test JVM:

```
./mvnw -pl billing -Dtest=OrderServiceTest -Dmaven.surefire.debug test
```

That listens on port 5005. Do not use it as the default. Use it only when a breakpoint is required.

Reports: `billing/target/surefire-reports/<Test>.txt` and `failsafe-reports/`.

Spring Boot fat jar and Failsafe: if IT fails with `Unable to find a @SpringBootConfiguration` only under Failsafe, the plugin is putting the repackaged jar on the classpath (`BOOT-INF/classes`). Point Failsafe `classesDirectory` at `target/classes`. Do not "fix" it by adding a fake `@SpringBootConfiguration` in the test.

## Gradle

Single test:

```
./gradlew :billing:test --tests 'com.acme.billing.OrderServiceTest.rejectsEmptyCurrency'
```

Compile:

```
./gradlew :billing:compileJava
```

Dependency insight:

```
./gradlew :billing:dependencyInsight --dependency jackson-databind --configuration testRuntimeClasspath
```

Reports: `billing/build/reports/tests/test/index.html` and `billing/build/test-results/test/TEST-*.xml`.

`--debug-jvm` suspends the test worker. Do not pass it on a normal re-run.

Configuration cache or build cache hiding a stale class: re-run the failing task with `--rerun-tasks` once before blaming the test.

## Multi-module

Fix in the module that owns the type. A missing symbol in `billing` that refers to `platform-api` is a dependency declaration in `billing`, not a new class copied into `billing`.

Maven reactor order matters. `-am` builds required modules. `-pl billing` alone fails if a snapshot sibling is not installed. Prefer `-pl billing -am` over `clean install` of the reactor.

## What not to run first

- `clean install` of the whole repo. Slow, and it hides which module failed.
- `test` with no `-Dtest` when the user named a class.
- A version bump "to refresh the lock" before reading the tree.
- `dependency:purge-local-repository`. That is a network retry, not a fix.
