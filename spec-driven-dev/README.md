# spec-driven-dev

A Claude Code plugin that provides a full product-development pipeline — from raw requirements all the way to shipped code.

## What's inside

### Skills

| Skill | Purpose |
|---|---|
| `use-cases-generator` | Extract structured use cases from raw requirements |
| `tech-design-generator` | Produce technical architecture designs (components, APIs, data flows) |
| `ui-ux-design-generator` | Two-phase UX + UI design with interactive HTML previews and briefs |
| `create-implementation-order` | Analyze specs and propose a domain-grouped implementation order |
| `dev-plan` | Break work into minimal, independently committable implementation steps |
| `end-to-end` | Run the full pipeline end-to-end |
| `document` | Align documentation with the current codebase |
| `pre-commit` | Run quality gates (tests, build) before committing |
| `commit` | Analyze staged changes and craft a conventional commit |

### Rules

Generic rules the skills rely on. They live in `rules/` and are included for reference — Claude Code plugins don't auto-load rules, so consumers should wire them into their own project (see [Install](#install)).

| Rule | What it enforces |
|---|---|
| `context-source-of-truth` | The codebase is the primary source of truth. Trust code over docs; verify before designing from docs |
| `documentation-workflow` | Dev and docs are separate workflows. Specs stay in `specs/` until `/document` syncs them |

## Install

Add the marketplace, then install the plugin:

```
/plugin marketplace add https://github.com/dorg-atsabari/forge
/plugin install spec-driven-dev@forge
```

After installing, skills are available as `/spec-driven-dev:<skill>` (e.g., `/spec-driven-dev:commit`).

### Wire up the rules (optional but recommended)

Rules aren't auto-loaded by installed plugins. To enforce them in your project, copy them into your project's `.claude/rules/` and reference them from your `CLAUDE.md`:

```bash
mkdir -p .claude/rules
cp <plugin-location>/rules/*.md .claude/rules/
```

Then add to your `CLAUDE.md`:

```markdown
## Rules
- `.claude/rules/context-source-of-truth.md` — trust code over docs
- `.claude/rules/documentation-workflow.md` — dev and docs are separate workflows
```

## Typical flow

```
requirements → /use-cases-generator
            → /tech-design-generator
            → /ui-ux-design-generator
            → /create-implementation-order
            → /dev-plan → implement → /pre-commit → /commit → /document
```

## License

MIT
