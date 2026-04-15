# Document — Templates Reference

Templates for permanent system documentation. These capture how things work in the codebase — knowledge that future sessions and agents need. Templates are provided for markdown docs; HTML docs (e.g., design system previews) should be self-contained and well-structured but don't follow a rigid template.

## Table of Contents

1. [General conventions](#general-conventions)
2. [High-Level Design doc](#high-level-design-doc)
3. [Technical Infrastructure doc](#technical-infrastructure-doc)
4. [Technical Feature doc](#technical-feature-doc)
5. [Usage Guide](#usage-guide)
6. [CLAUDE.md registration examples](#claudemd-registration)

---

## General conventions

These apply to all doc types:

- **File naming**: lowercase, hyphen-separated, descriptive. Extension matches format (`.md`, `.html`, etc.)
  - Good: `conversation-technical.md`, `server-usage.md`, `design-system-preview.html`
  - Bad: `docs.md`, `new-doc.md`, `UX_Cases.md`
- **Title**: `# <Descriptive Title>` — specific enough that someone scanning a file list knows what it covers
  - Good: `# Conversation Message Formats`, `# AI Assistant Server — API Usage Guide`
  - Bad: `# Formats`, `# API Doc`
- **Overview**: 1-2 sentence paragraph right after the title explaining what the doc covers and why it exists
- **Structure**: `##` for major sections, `###` for subsections. Flat is better than deeply nested.
- **Tone**: Direct, technical, assumes the reader is a developer. No "In this document, we will explore..." filler.
- **Format**:
  - Tables for summaries and comparisons
  - Code blocks with language tags for examples
  - `---` horizontal rules between major sections
  - Bold for key terms on first use
- **Self-contained**: A reader should understand the doc without needing to read other docs. Include enough context to stand alone.
- **No duplication / cross-referencing**: Each concept has exactly one canonical location. Every other doc that touches that concept links to it rather than re-explaining. Use markdown links: `(see [Section Name](other-doc.md#section-anchor))`. If a shared behavior (e.g., auth, token resolution) is defined in doc X, doc Y's flow must reference doc X — never copy the explanation.

---

## High-Level Design doc

Use for: a presentable system overview — the doc you'd walk someone through in 10 minutes. Covers what the system is, what it's built with, how the pieces connect, and the key decisions. No implementation details — those live in infrastructure and feature docs.

**Naming**: `docs/architecture-overview.md`

```markdown
# <System Name> — High-Level Design

<1-2 sentences: what this system does and who it serves.>

## Component Diagram

<!-- ASCII diagram showing major components and how they communicate.
     Keep it high-level: apps, data stores, external services.
     Use box-drawing characters: ┌ ┐ └ ┘ │ ─ ├ ┤ ┬ ┴ ┼ ▼ ▲ -->

## Stack

<!-- One-liner per technology choice with rationale. Table format. -->

| Layer | Technology | Why |
|-------|-----------|-----|
| ... | ... | ... |

## Project Structure

<!-- Quick map of how the codebase is organized.
     For monorepos: apps vs libs, what lives where.
     Keep it scannable — no file-level detail. -->

## Key Decisions

<!-- Non-obvious architectural choices and their rationale.
     The things someone would ask "why did you do it this way?" about. -->

| Decision | Chosen | Alternative | Rationale |
|----------|--------|-------------|-----------|
| ... | ... | ... | ... |

## Security Posture

<!-- Bullet list of what's in place — not how it works.
     Link to infrastructure docs for details.
     e.g., "Session-based auth with Redis store (see [Auth & Sessions](auth-and-sessions.md))" -->

## Related Docs

<!-- Links to infrastructure and feature docs for deeper dives. -->
```

---

## Technical Infrastructure doc

Use for: documenting cross-cutting system concerns that multiple features depend on — authentication, session management, external integrations (e.g., Jira OAuth), security infrastructure. These are not user-facing features but foundational behaviors referenced by feature docs.

**Naming**: `docs/<topic>.md` (e.g., `auth-and-sessions.md`, `jira-integration.md`)

```markdown
# <Infrastructure Topic>

<1-2 sentences: what this covers and why it's a separate doc.>

## Key Decisions

<!-- Architectural choices with rationale. Format: decision → why. -->

| Decision | Chosen | Alternative | Rationale |
|----------|--------|-------------|-----------|
| ... | ... | ... | ... |

## Database Schema

<!-- Entity fields, types, relations, cascades, indexes.
     Only if this infrastructure owns entities.
     Omit section entirely if not applicable. -->

### <EntityName>

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| ... | ... | ... | ... |

**Relations**: ...
**Cascade**: ...
**Indexes**: ...

## How It Works

<!-- Step-by-step behavior for key operations. Numbered steps.
     This is the canonical explanation — feature docs link here. -->

### <Flow Name>

1. ...
2. ...
3. ...

## Error Handling

<!-- Edge cases, retries, failure modes specific to this infrastructure. -->

## Frontend

<!-- How the UI interacts — guards, interceptors, services.
     Omit if backend-only. -->
```

---

## Technical Feature doc

Use for: documenting user-facing features — tickets, API keys, automations, etc. Each feature gets its own file. These docs reference infrastructure docs for shared behaviors — never re-explain what's already documented elsewhere.

**Naming**: `docs/tech-feature-<name>.md` (e.g., `tech-feature-tickets.md`, `tech-feature-api-keys.md`, `tech-feature-automations.md`)

```markdown
# <Feature Name>

<1-2 sentences: what this feature does and why it exists.>

## Key Decisions

<!-- Architectural choices with rationale. Format: decision → why. -->

| Decision | Chosen | Alternative | Rationale |
|----------|--------|-------------|-----------|
| ... | ... | ... | ... |

## Database Schema

<!-- Entity fields, types, relations, cascades, indexes. -->

### <EntityName>

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| ... | ... | ... | ... |

**Relations**: ...
**Cascade**: ...
**Indexes**: ...

## API Endpoints

<!-- Routes, auth method, request/response shapes.
     For auth mechanism details, link to the canonical doc:
     "Authenticated via session (see [Auth & Sessions](auth-and-sessions.md#authguard))" -->

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| ... | ... | ... | ... |

## Flows

<!-- Step-by-step behavior for key operations.
     Reference shared behaviors by link — never re-explain:
     "Token resolved via [Jira token resolution](jira-integration.md#token-resolution)" -->

### <Flow Name>

1. ...
2. ...
3. ...

## Error Handling

<!-- Edge cases, retries, failure modes specific to this feature.
     Only what's unique here — shared error patterns belong in their source doc. -->

## Frontend

<!-- Components, signals, user interactions.
     Reference shared frontend patterns by link. -->
```

---

## Usage Guide

Use for: how-to guides for APIs, CLIs, tools, or features. Aimed at developers who need to use the system, not understand its internals.

```markdown
# <Feature/Tool> — Usage Guide

## Quick Start

<Minimal steps to get running — usually 2-3 commands.>

```bash
<command to start>
```

<One curl/command example showing the simplest happy path.>

## <Core Concept / Main Workflow>

<Explain the primary workflow step by step with examples.>

**Request:**

```bash
curl -X POST http://localhost:3000/endpoint \
  -H "Content-Type: application/json" \
  -d '{"field": "value"}'
```

**Response:**

```json
{
  "field": "value"
}
```

---

## Reference

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/endpoint` | ... |
| `POST` | `/endpoint` | ... |

---

## <Advanced Topic / Edge Cases>

<Anything non-obvious that users might need after getting started.>
```

---

## CLAUDE.md registration

After writing the doc, add it to the `Specs & Context` section in `CLAUDE.md`. This is what makes the doc discoverable by future sessions.

```markdown
## Specs & Context

Read only the docs relevant to your current task — do not load all of them by default:
- `docs/technical-architecture.md` -- Read when working on architecture, data flow, or system design
- `docs/design-system-preview.html` -- Read when working on UI styling, design tokens, or visual design decisions
- `docs/usage-guide.md` -- Read when working on the HTTP API, endpoints, server integration, CLI, or terminal UX
```

The trigger hint pattern: `Read when working on <specific domain keywords>`. Be specific enough that it only triggers for relevant tasks, but broad enough that it catches all relevant tasks within that domain. Works the same for all file formats — `.md`, `.html`, etc.
