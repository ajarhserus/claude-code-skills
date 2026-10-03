# Failure classes

Match the symptom. Do the first check. Do not skip to the "not this" column.

## Compile

| Symptom | First check | Not this |
|---|---|---|
| `cannot find symbol` on a repo type | module dep, source set (main vs test), typo in import | rewrite the caller to avoid the type |
| `cannot find symbol` on a generated type | generate step ran? Lombok/MapStruct/jOOQ/Protobuf/OpenAPI output dir on the compile classpath? | hand-write the generated class |
| `package X does not exist` | dependency scope (`provided` not on compile, `test` not on main), BOM did not import the module | add a random version |
| `invalid target release: 21` | compiler release vs the JDK running the build. Toolchain in the parent POM wins over a local `JAVA_HOME` mismatch | change source to Java 8 |
| Lombok getter missing | annotation processor path. JDK 16+ needs the processor on the annotation path, not only the dependency | write the getters by hand in one file |
| `incompatible types` after a bump | the method signature that changed. Call site must match the version the tree resolved | cast to raw |

## Test assertion

The assertion is a claim. Read it before changing production code.

- Expected value wrong, production matches the spec or the ticket: fix the test.
- Production wrong: fix production, keep the assertion.
- Mockito `Wanted but not invoked`: the branch was not taken. Read the condition. Do not `lenient()` the stub.
- `UnnecessaryStubbing`: delete the stub or `lenient()` only if the neighbor tests already do and the stub is shared setup.
- Time: a `Clock` or `InstantSource` bean exists in newer code. Use that. Do not `Thread.sleep` to make a timestamp match.

## Spring context

`Failed to load ApplicationContext` is the wrapper. The cause is under it.

| Cause under the wrapper | Fix |
|---|---|
| `NoSuchBeanDefinitionException` | test slice too narrow, missing `@Import`, conditional off, or no test double. Copy the neighbor test's setup. |
| `UnsatisfiedDependencyException` | constructor param with no bean. A new required constructor arg needs a bean or a test `@MockBean` / `@MockitoBean`. |
| `Could not resolve placeholder` | the key is missing from `src/test/resources` or the test profile. Add the key the main `application.yml` already documents. Do not hardcode a default in production to green a test. |
| Flyway / Liquibase | migration SQL, or Testcontainers not started. Fix the migration. Do not `ddl-auto=create` to skip it. |
| Port in use | `server.port=0` or Testcontainers. Do not kill a host process. |
| DataSource refused | Testcontainers, or the test pointed at a real host. Do not commit a local password. |

`@SpringBootTest` loading the whole context for a unit failure is a slow loop. If the failure is a pure unit assertion, run the plain JUnit test. If the failure is context, stay on the slice (`@WebMvcTest`, `@DataJpaTest`, `@JdbcTest`) the class already uses.

`@MockBean` replaces a bean. Adding one to hide a missing config is a mask. Add it only when the neighbor tests mock that boundary.

## Classpath

`NoClassDefFoundError` / `ClassNotFoundException`: the compile classpath had the type, the runtime classpath does not. Check scope (`provided`, `optional`) and the boot repackage.

`NoSuchMethodError` / `LinkageError`: two versions. `dependency:tree` or `dependencyInsight` on the class's artifact. Align to the version the BOM already manages. Exclude only the loser the tree names. Do not exclude `*`.

Split package or a shaded jar (Hive, Spark, gRPC, old Guava): the duplicate class is inside the fat dependency. Relocate or exclude the module the tree shows. Do not shade the world.

## Runtime in src/main

| Exception | Usual cause in this repo | Do not |
|---|---|---|
| NPE | optional value treated as present, uninitialized collaborator, map get | `Objects.requireNonNull` on every line |
| CCE | raw type or a JSON field bound to the wrong class | catch and return null |
| `IllegalArgumentException` from a library | the caller passed a value the API rejects. Read the message. | upgrade the library first |
| lazy init / circular bean | constructor cycle. Break it the way the neighbor service did (setter or event), not with `@Lazy` everywhere |

## Order and flakes

Passes alone, fails in the class: static mutable field, shared mock, `System.setProperty` not cleared, fixed port, schema not truncated.

Passes locally, fails in CI: timezone (`UTC` vs host), locale, filesystem case, container resource limit, test order. Set the clock and zone in the test. Do not `@Disabled` on CI.

Parallel Surefire (`forkCount`, `parallel`): a test that needs a fixed port or a static cannot run parallel. Isolate that class. Do not turn off parallel for the reactor.

## Gates

Checkstyle, Error Prone, SpotBugs, PMD, Enforcer, Spotless: the violation text names the rule and the line. Fix the line. Suppress with the repo's existing suppression file only when the rule cannot see a real invariant, and say why in the suppression comment.

Enforcer banned dependency: the ban is the policy. Use the allowed artifact. Do not lower the enforcer version.
