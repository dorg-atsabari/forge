---
name: pre-commit
description: Run pre-commit quality gates (unit tests, build) before committing code. Use this skill whenever the user says /pre-commit, "check before commit", "run pre-commit checks", "ready to commit", or wants to validate their changes are PR-ready. Also trigger when the user asks to commit and there's no evidence checks have been run yet.
disable-model-invocation: false
---

# Pre-Commit Quality Gates

Run two checks sequentially before allowing a commit. Each check must pass before moving to the next. If any check fails, stop immediately, report the failure, and do NOT commit.

The philosophy: a commit should be as clean as a PR. Every commit that lands should pass tests and build.

## Execution Order

1. **Unit Tests**
2. **Build**

Tests catch logic errors first (cheapest to fix), build catches structural issues next.

## Step 1: Detect the Project Stack

Look for config files in the working directory to determine the stack. Check all entries in the table below and collect all matches.

**If multiple stacks are detected**, list them and ask: "I found multiple stacks: [list]. Which should I run checks for? Or all of them?" Run checks for the selected stack(s) sequentially.

**If one stack is detected**, use it directly.

| Config file(s) | Stack | Test command | Build command |
|---|---|---|---|
| `package.json` | Node.js | `npm test` | `npm run build` |
| `pnpm-workspace.yaml` or `pnpm-lock.yaml` | Node.js (pnpm) | `pnpm test` | `pnpm run build` |
| `yarn.lock` | Node.js (yarn) | `yarn test` | `yarn build` |
| `bun.lockb` | Bun | `bun test` | `bun run build` |
| `pyproject.toml` or `setup.py` or `setup.cfg` | Python | `pytest` | (see below) |
| `requirements.txt` + test files | Python | `pytest` | (skip - interpreted) |
| `go.mod` | Go | `go test ./...` | `go build ./...` |
| `Cargo.toml` | Rust | `cargo test` | `cargo build` |
| `build.gradle` or `pom.xml` | Java/Kotlin | `./gradlew test` or `mvn test` | `./gradlew build` or `mvn package` |
| `Makefile` | Generic | `make test` | `make build` |

**Refinements:**
- For Node.js: read `package.json` `scripts` to confirm `test` and `build` scripts exist. If `test` script is missing or is the default `echo "Error: no test specified"`, skip the test step and warn the user. Same for `build`.
- For Python: if `pyproject.toml` has a `[tool.pytest]` or `[tool.pytest.ini_options]` section, use `pytest`. If it has a `[tool.hatch]` section, try `hatch build` for build. Otherwise skip build for Python.
- For monorepos: check for workspace config (`workspaces` in package.json, `pnpm-workspace.yaml`) and run commands at the root level.

If no stack is detected, tell the user you couldn't auto-detect and ask what commands to run.

## Step 2: Run Unit Tests

Run the detected test command. Capture stdout and stderr.

- **Pass**: exit code 0 → print `[PASS] Unit Tests` and continue
- **Fail**: non-zero exit → print `[FAIL] Unit Tests`, show the relevant failure output (last ~30 lines), and **stop here**

If the test runner isn't installed (e.g., `pytest` not found), warn the user and suggest installing it rather than silently skipping.

## Step 3: Run Build

Run the detected build command.

- **Pass**: exit code 0 → print `[PASS] Build` and continue
- **Fail**: non-zero exit → print `[FAIL] Build`, show error output, and **stop here**
- **Skip**: if the stack has no build step (e.g., plain Python), print `[SKIP] Build (not applicable for this stack)` and continue

## Final Result

If both checks pass:

```
--- Pre-Commit Checks ---
[PASS] Unit Tests
[PASS] Build  (or [SKIP])

All checks passed. Ready to commit.
```

Report the results. Do NOT auto-commit or offer to commit — committing is always the user's decision.

If any check fails, show the summary with the failure clearly marked and suggest what to fix.
