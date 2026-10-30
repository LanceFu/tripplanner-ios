# Conventions

Read this before changing code. The Sifu orchestrator loads it into every agent's prompt.

## Build and test

- Build: `swift build`
- Test: `swift test --enable-code-coverage`
- Lint, if installed: `swiftlint`

## Code

- Domain code lives in `Sources/TripPlannerCore`; tests live in `Tests/TripPlannerCoreTests`.
- Use the terms in `docs/glossary.yaml` in code, comments and tests (a Stop, not a waypoint).
- Public types and functions have `///` documentation comments.
- No force unwraps (`!`) and no `try!` outside tests.
- Prefer `struct` value types and mark them `Sendable`.
- Errors are cases of a typed `Error` enum.
- Do not add third-party dependencies.

## Tests

- Every behaviour change has a test. A bug fix starts with a failing test.
- Test names state the behaviour, for example `testRejectsDayOutsideTripDates`.
- No network access. Use fixed `Date(timeIntervalSince1970:)` values, never `Date()`.

## Protected files (a human reviews any change)

`.github/`, `.claude/`, `conventions.md`, `docs/glossary.yaml`, `Package.swift`

## Lessons

<!-- Sifu appends lessons here, through a pull request that a human must approve. -->
