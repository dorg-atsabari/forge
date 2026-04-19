---
name: document
description: "Create or align documentation with the current codebase. Takes a topic, finds matching docs, and updates them to reflect the actual code — or creates new docs if none exist. Use this skill when the user says /document, 'document the auth system', 'docs are stale', 'update docs to match the code', 'document how X works', or wants to ensure documentation reflects the current state of the codebase."
disable-model-invocation: true
---

# Align Docs

Ensure documentation matches the current codebase. Takes a topic, finds relevant existing docs, and either updates them to reflect reality or creates new ones if nothing exists.

## Why this exists

Docs drift from code. After a refactor, a new feature, or a bug fix, the architecture doc or usage guide may describe something that no longer exists. This skill closes that gap by reading the code and aligning the docs to what's actually there.

## Workflow

### 1. Get the topic

If a topic was already provided as context (e.g., in the user's message), use it and skip the question below.

Otherwise, ask: **"What topic should I align?"** — e.g., "authentication", "API endpoints", "database schema", "Jira integration"

### 2. Determine mode — update or create

Ask: **"Are there existing docs to update, or should I create new ones?"**
- **Update** — user points to existing docs (e.g., `docs/identity-hub-system-tech-design.md`). Read them and proceed to Step 5. Doc type and audience are inferred from the existing doc.
- **Create** — no existing doc. Proceed to Step 3.

### 3. New doc setup (create mode only)

Ask two questions:

**"What type of documentation?"**
- **High-Level Design** — presentable system overview: component diagram, stack with rationale, project structure, key decisions, security posture. The 10-minute walkthrough doc. Use the *High-Level Design doc* template. File naming: `docs/architecture-overview.md`
- **Technical Infrastructure** — cross-cutting concerns that multiple features depend on (auth, sessions, Jira OAuth, security). Not a user-facing feature — foundational behavior referenced by feature docs. Use the *Technical Infrastructure doc* template. File naming: `docs/<topic>.md`
- **Technical Feature** — user-facing feature documentation (tickets, API keys, automations). Each feature gets its own file following a consistent structure. References infrastructure docs for shared behaviors — never re-explains. Use the *Technical Feature doc* template. File naming: `docs/tech-feature-<name>.md`
- **UI/UX design** — interaction patterns, user flows, visual design, design tokens
- **Usage guide** — how to use an API, CLI, or feature
- **HTML preview** — interactive visual reference (diagrams, design previews)

**"Who will consume this?"**
- **Agents** — markdown doc registered in CLAUDE.md with trigger hints, loaded automatically in relevant sessions
- **Humans** — HTML file listed under Human-Friendly Previews in CLAUDE.md, opened in browser
- **Both** — markdown doc for agents + HTML preview for humans

### 4. Read templates (create mode only)

Read `references/doc-templates.md` in this skill directory. It contains templates for:
- **Technical / Architecture doc** — for documenting how systems, subsystems, and data flows work
- **Usage Guide** — for documenting how to use an API, CLI, or feature

For HTML docs (e.g., design system previews), there is no rigid template — the file should be self-contained, well-structured, and render correctly in a browser.

### 5. Ask for context files

Ask: **"Any other files I should read for context? Specs, design outputs, anything that helps."**

The user may point to:
- Specs from a recent workflow (e.g., `specs/e2e-jira-integration/tech-design/`)
- Any other file that provides context

If the user provides files, read them. If not, proceed with codebase exploration only.

### 6. Explore the codebase

Read the relevant parts of the codebase to understand the current state:
- Find files, modules, and patterns related to the topic
- Understand the actual architecture, data flow, and conventions in use
- Note any discrepancies with existing docs (if updating)

### 7. Determine the delta

**If updating:**
- Compare what the doc says vs what the code actually does
- Identify: what's stale, what's missing, what's wrong, what's still accurate
- Present the delta to the user: "Here's what changed: X was renamed to Y, Z was removed, W is new"
- Get confirmation before applying changes

**If creating:**
- Present what you found in the codebase as a summary
- Get confirmation on scope and structure before writing

### 8. Write or update the doc

**Create:**

Create `docs/<descriptive-name>.<ext>` using the appropriate template from Step 4.

**Update:**

1. Read the existing doc fully
2. Identify what's stale, missing, or incorrect
3. Update in place — preserve structure and sections that are still accurate
4. Do not create a new file alongside the old one — update the existing file

Key conventions:
- **File naming**: lowercase, hyphen-separated, descriptive (e.g., `technical-architecture.md`, `design-system-preview.html`)
- **Title**: specific and clear — someone scanning a file list should know what it covers
- **Tone**: direct, technical, assumes developer audience, no filler
- **Self-contained**: include enough context to stand alone without cross-referencing
- **Format**: tables for summaries, code blocks for examples, `---` between major sections (markdown); self-contained single file with inline styles (HTML)

### 9. Register in CLAUDE.md

If `CLAUDE.md` doesn't exist yet, create it with a `## Specs & Context` section.

**For new docs** — add an entry:

```markdown
- `docs/<filename>.<ext>` -- Read when working on <specific trigger context>
```

**For updated docs** — check if the existing CLAUDE.md entry still has an accurate trigger hint. Update it if the doc's scope changed.

**For human-friendly previews** (HTML files meant to be opened in a browser, not read by agents) — add to a separate `## Human-Friendly Previews (do not read — open in browser)` section in CLAUDE.md. Create this section if it doesn't exist. These entries use "Open when..." instead of "Read when...". Example:
```markdown
## Human-Friendly Previews (do not read — open in browser)
- `docs/identity-hub-system-ux-design-preview.html` -- Open when the user asks to see the UX design
```

The trigger hint is what makes this doc load at the right time. Be specific enough to be useful but broad enough to catch all relevant tasks.

**Good triggers:**
- "Read when working on architecture, data flow, or system design"
- "Read when working on the HTTP API, endpoints, or server integration"
- "Read when working on UI styling, design tokens, or visual design decisions"

**Bad triggers:**
- "Read when relevant" — too vague, never triggers
- "Read when working on the project" — too broad, always triggers

### 10. Verify

- Read the final doc — check completeness and consistency with existing docs
- Confirm the CLAUDE.md entry exists with a specific trigger hint
- If the doc references code paths, verify those paths still exist
- For HTML docs: confirm the file is self-contained and renders correctly
- For updates: confirm the old content was replaced, not duplicated

## Guidelines

- Trust the code over the doc — if they disagree, the code is right
- Don't add speculation — only document what you can verify in the codebase
- Preserve the existing doc's structure and tone when updating — don't rewrite sections that are still accurate
- If the delta is large (major refactor), suggest a full rewrite rather than patching
- If you find docs that reference files or functions that no longer exist, flag them explicitly
