# Examples

## Cannot find symbol, wrong module

`billing` fails compile: `cannot find symbol: class Money` in `TaxCalculator.java`. `Money` lives in `platform-kernel`.

Hypothesis: `billing` does not depend on `platform-kernel` because the import is already the kernel package and no local `Money` exists.

Change: add the dependency in `billing/pom.xml` with the same version property the other services use. Re-run `./mvnw -pl billing -am -DskipTests compile`.

Not this: copy `Money.java` into `billing`.

## Assertion, production wrong

`OrderServiceTest#rejectsEmptyCurrency` expects `IllegalArgumentException`. The method returns an order with a null currency.

Hypothesis: the guard was never written because `create` assigns `request.currency()` with no check, line 40.

Change: throw on blank currency. Leave the test. Re-run the method.

Not this: delete the `assertThrows`.

## Assertion, test wrong

The test expects HTTP 200. The controller has returned 201 since the handler was added, and the other create tests expect 201.

Hypothesis: this test was copied from a GET. Change the expected status. Re-run the class.

## Context, missing meter

`UserControllerIT` fails `NoSuchBeanDefinitionException: MeterRegistry`. Neighbor `OrderControllerIT` declares `@MockitoBean MeterRegistry meters`.

Hypothesis: the web slice does not include the actuator auto-config. Copy the test double. Re-run the IT.

Not this: `@SpringBootTest` on the unit slice, or a new `MeterRegistry` bean in `src/main` that exists only to boot the test.

## NoSuchMethodError

CI: `NoSuchMethodError: com.fasterxml.jackson.databind.ObjectMapper.readTree` inside `billing`. Tree shows `jackson-databind:2.13` pulled by an old SDK, parent BOM is 2.17.

Hypothesis: the SDK wins over the BOM because the SDK is a direct dependency with a transitive pinned version.

Change: exclude that transitive or import the BOM on the module the way `payments` already does. Re-run the test that threw.

Not this: upgrade Spring Boot.

## Passes in IntelliJ, fails on Maven

IntelliJ uses JDK 21. CI log says `invalid target release: 21` and the job image is 17. Parent POM `<maven.compiler.release>21</maven.compiler.release>`.

Hypothesis: the workflow JDK does not match the POM. The code is not the bug.

Change: the workflow `java-version` to 21, if the repo standard is 21. Say that. Do not rewrite syntax down to 17 unless the user said the standard is 17.

## Flake

`ReservationTest` fails only in the suite. It sets `server.port=8080` in `@BeforeAll` and never clears it.

Hypothesis: the next Spring test binds 8080 and the property leaks.

Change: clear the property in `@AfterAll`, or stop setting it and use `server.port=0`. Re-run the class, then the module tests.
