# TripPlanner (fictional)

A fictional offline-first iOS trip planner. It exists as the target product for the
[Sifu](https://github.com/LanceFu/sifu) ticket pipeline, so all names, requirements and data are invented.

- Product requirements: `docs/PRD.md`
- Glossary (machine-readable): `docs/glossary.yaml`
- Agent conventions: `conventions.md`

## Develop

```bash
swift build
swift test --enable-code-coverage
```

The code is a Swift package (`TripPlannerCore`) with no Xcode project, so the tests run from the command line.

## CI

`.github/workflows/ci.yml` runs `swift test` on a macOS runner for every pull request. Make the `test` job a
required status check on `main`. macOS minutes cost more than Linux minutes on private repositories.
