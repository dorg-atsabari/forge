# Design Template

Use this template when outputting the architecture design doc (`design.md`). Must-have sections are always included. Optional sections are included only when the user selects them.

API Contract and Shared Patterns are **separate files** — not sections in this doc. See `api-contract-template.md` and `shared-patterns-template.md`.

---

## Must-Have Sections

```markdown
# Technical Design — <System Name>

## Overview
<2-3 sentences: what this system does, who it serves, and the core technical approach.>

## Components

### <Component Name>
- **Responsibility**: <one sentence>
- **Why it exists**: <what would break or be wrong without it>
- **Owns**: <data, state, domain logic it's responsible for>
- **Communicates with**: <list of other components + protocol>
- **Tech stack**: <language, framework, runtime>

### <Component Name>
...

## Component Diagram

<ASCII box diagram showing all components and their connections. Use box-drawing characters for rectangles and arrows for flow direction. Label arrows with protocol (REST, gRPC, events, etc.).>

Example (simple):
```
┌──────────┐     REST     ┌──────────┐     SQL      ┌────────────┐
│  web-ui  │────────────▶│  api-svc  │────────────▶│ PostgreSQL │
└──────────┘              └──────────┘              └────────────┘
```

Example (multi-layer):
```
┌──────────┐     REST     ┌──────────┐     SQL      ┌────────────┐
│  web-ui  │────────────▶│  api-svc  │────────────▶│ PostgreSQL │
└──────────┘              └──────────┘              └────────────┘
                               │
                               │ REST
                               ▼
                          ┌──────────┐
                          │ Jira API │ (external)
                          └──────────┘
```

If the diagram gets too complex (10+ nodes), simplify by grouping related components.

## Data Stores

### <Store Name> (<type: Postgres, Redis, S3, etc.>)
- **Purpose**: <what data it holds and for which component>
- **Why this type**: <reasoning over alternatives>
- **Key entities/collections**: <list of main tables/collections/keys>
- **Access pattern**: <read-heavy, write-heavy, mixed; hot/cold data>

### <Store Name>
...

## Communication Patterns

| From | To | Protocol | Pattern | Notes |
|------|----|----------|---------|-------|
| <component> | <component> | REST / gRPC / events / direct | sync / async | <any notes> |

## Key Decisions

| Decision | Choice | Alternatives Considered | Reasoning |
|----------|--------|------------------------|-----------|
| <what was decided> | <what was chosen> | <what else was considered> | <why this choice> |
```

---

## Optional Sections

Include only the sections the user selected. Insert them after the must-have sections, in the order listed below.

### DB Schema Detail

Detailed table definitions with column types, constraints, and indexes. Replaces the basic "Key entities" list in the Data Stores section when selected.

```markdown
## DB Schema

### <table_name>

<One-sentence description of what this table is for and why it exists.>

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| id | uuid | PK | |
| email | varchar(255) | unique, not null | |
| password_hash | varchar(255) | not null | argon2id output |
| created_at | timestamptz | not null, default now() | |

**Indexes**: <list any non-PK indexes and why>

### <table_name>
...
```

### Session / Auth Management

How authentication works end-to-end. Structure as: how sessions/tokens are generated, how they're stored, how they're verified, the data model, cookie/header configuration, lifecycle, and frontend behavior.

```markdown
## Session Management

### How Sessions Are Generated
<What generates the session/token, what crypto is used>

### How Sessions Are Stored
<Where (Redis, DB, memory), key format, TTL>

### Data Model
<What's stored in the session — table of fields with source and reasoning>

### How Sessions Are Verified
<What happens on each request — lookup, validation, attach to request context>

### Cookie / Header Configuration
<httpOnly, secure, sameSite, maxAge — with reasoning for each>

### Lifecycle
<Create, regenerate, destroy, expire — when each happens and why>

### Frontend Behavior
<How the SPA/client handles auth — startup check, interceptors, token storage (or lack of)>
```

### Non-Functional Considerations

```markdown
## Non-Functional Considerations

### Scalability
<How the system scales. What's the bottleneck? What would you change at 10x/100x load?>

### Security
<Auth approach, data encryption, API security, secrets management>

### Observability
<Logging strategy, metrics, health checks, alerting approach>
```

### Open Questions

```markdown
## Open Questions
<Things that still need to be decided or validated>
```
