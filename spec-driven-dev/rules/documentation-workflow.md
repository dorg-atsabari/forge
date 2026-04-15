# Documentation Workflow

- Development and documentation are separate workflows. Devs code — they don't write or update docs as part of their feature work.
- Documentation is an offline process that runs independently, typically after code is merged, using `/document` to sync docs with the current codebase.
- No skill should promote specs to `docs/` as part of a development workflow. Specs stay in `specs/` until documentation is explicitly aligned.
- This avoids merge conflicts on shared doc files when multiple devs work in parallel.
