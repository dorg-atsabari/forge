# Dev Setup Template

Use this template when outputting the development setup doc. **New system mode only** — new features inherit the existing setup.

---

```markdown
# Development Setup — <System Name>

## Repository & Workspace

- **Monorepo tool**: <Nx, Turborepo, pnpm workspaces, none, etc.>
- **Why**: <reasoning over alternatives>
- **Workspace structure**:
  ```
  <project root layout — apps, libs, shared, etc.>
  ```
- **Project/library boundaries**: <how code is split across workspace projects — by feature, by layer, by domain, etc.>

## Dev Tooling

- **Package manager**: <npm, pnpm, yarn, etc.>
- **Testing**: <framework and strategy — e.g., Jest for unit, Playwright for e2e>
- **Linting & formatting**: <ESLint, Prettier, Biome, etc.>
- **Type checking**: <TypeScript config approach — project references, path aliases, etc.>
- **Git hooks**: <Husky, lint-staged, etc. — or "none">

## Running in Development

<How a developer gets the system running locally after cloning.>

- **Prerequisites**: <Node version, Docker, global CLIs, etc.>
- **Setup steps**:
  1. <step>
  2. <step>
  ...
- **Dev server**: <command to start, what it runs, hot reload behavior>
- **Local dependencies**: <databases, queues, external services — how they're provided locally (Docker Compose, in-memory, mocks, etc.)>
- **Seed data / fixtures**: <how to populate local environment with test data, if applicable>
- **Environment variables**: <where they're defined, how to configure locally>

## Key Decisions

| Decision | Choice | Alternatives Considered | Reasoning |
|----------|--------|------------------------|-----------|
| <what was decided> | <what was chosen> | <what else was considered> | <why this choice> |
```
