# Use Cases Generator — Output Template

## README.md

The README is the entry point. It summarizes all use cases (product surfaces) and their flows.

```markdown
# Use Cases — <Project/Feature Name>

## Overview

<1-2 sentences: what these use cases cover and what requirements they were derived from.>

## Use Cases

| Use Case | File | Actor | Description |
|----------|------|-------|-------------|
| <UC-1: Name> | [<use-case-name>.md](<use-case-name>.md) | <Primary actor> | <What this product surface does> |
| <UC-2: Name> | [<use-case-name>.md](<use-case-name>.md) | <Primary actor> | <What this product surface does> |

## Actors

| Actor | Description |
|-------|-------------|
| <Actor 1> | <Who they are and how they interact with the system> |
| <Actor 2> | <Who they are and how they interact with the system> |

## Assumptions

- <Any assumptions made when interpreting the requirements>
```

---

## Use Case File — `<use-case-name>.md`

One file per use case (product surface). Contains all flows within that surface.

```markdown
# <UC-ID>: <Use Case Name>

<1-2 sentences: what this product surface is, who uses it, and how they interact with it.>

**Actor:** <primary actor for this surface>

---

## Flow: <Flow Name>

**Trigger:** <what starts this flow>
**Outcome:** <what the actor achieves>

### Steps

1. <Actor does X>
2. <System responds with Y>
3. <Actor does Z>
4. ...

### Error Scenarios

- **<Condition>** — <what happens>
- **<Condition>** — <what happens>

---

## Flow: <Flow Name>

**Trigger:** <what starts this flow>
**Outcome:** <what the actor achieves>

### Steps

1. ...

### Error Scenarios

- ...
```

---

## Conventions

- **File naming**: lowercase, hyphen-separated use case names (e.g., `web-app.md`, `rest-api.md`, `blog-digest-automation.md`)
- **UC-ID format**: `UC-<number>` — sequential across all use cases (e.g., UC-1, UC-2, UC-3)
- **Use cases**: one per distinct product surface / interaction boundary — group by how actors interact, not by topic
- **Flows**: concrete user journeys within a use case. Numbered steps, written from the actor's perspective, alternating between actor actions and system responses
- **Error scenarios**: only include those that are implied or stated in the requirements — don't invent edge cases
- **Assumptions**: surface them in the README, not buried in individual use cases
