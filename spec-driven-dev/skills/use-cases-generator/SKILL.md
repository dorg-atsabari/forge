---
name: use-cases-generator
description: "Extract structured use cases from raw requirements. Takes requirements input (file, conversation, or description) and produces organized use case files grouped by high-level product surfaces. Use when the user says /use-cases-generator, 'extract use cases', 'break down requirements', 'what are the use cases', or wants to turn raw requirements into structured context before design or planning."
disable-model-invocation: true
---

# Use Cases Generator

Turn raw requirements into structured use cases. The output is organized context — not documentation. It lives in `specs/` and feeds downstream skills (tech design, dev plan) as input.

## Hierarchy

The skill produces a two-level structure:

- **Use Case** — a high-level product surface or interaction boundary. Each use case represents a distinct way actors interact with the system (e.g., a web application, a REST API, an automated process). Use cases differ by actor type, deployment boundary, or interaction model.
- **Flow** — a concrete user journey within a use case. Flows are the sequential scenarios an actor performs (e.g., login, create ticket, register API key). Each flow has steps, and error scenarios are part of the flow.

## Workflow

### 1. Get the requirements

If requirements were already provided as context (file path, conversation, or inline text), use them.

Otherwise, ask: **"What requirements should I work from?"** — accept a file path, a description, or a conversation.

### 2. Get the system name and output path

If a system name and output path were provided (e.g., by `/end-to-end`), use them.

Otherwise, ask: **"What should we call this system?"** (kebab-case, e.g., `identity-hub`). Use this to construct the output path: `specs/use-cases-<system-name>/` (e.g., `specs/use-cases-identity-hub/`). This naming convention matches the other design skills (`specs/tech-design-<name>/`, `specs/ui-ux-design-<name>/`).

### 3. Read the reference template

Read `references/output-template.md` in this skill directory for the output structure.

### 4. Analyze requirements

Read and analyze the requirements to identify:
- Distinct product surfaces / interaction boundaries (these become use cases)
- Actors involved in each surface (end users, external systems, automated processes)
- Concrete user journeys within each surface (these become flows)

Group by interaction boundary — not by functional area. Ask: "Would these be built, deployed, or secured differently?" If yes, they are separate use cases.

### 5. Present use cases for approval

Present the proposed use cases as a summary:

**"I identified these use cases:"**
- **Use Case A** — brief description of the product surface and its actor (N flows)
- **Use Case B** — brief description of the product surface and its actor (N flows)
- ...

For each use case, list the flows briefly.

Ask: **"Does this breakdown look right? Anything to add, merge, or split?"**

Wait for confirmation before writing files.

### 6. Write the output

Read the reference template, then produce:

1. **`README.md`** — summary index of all use cases and their flows
2. **`<use-case-name>.md`** — one file per use case with its flows and steps

Follow the structure defined in `references/output-template.md`.

### 7. Present the result

Tell the user what was created and where. List the files with a one-line summary of each.

## Guidelines

- Use cases represent product surfaces, not functional categories — group by how actors interact with the system, not by topic
- Flows describe what the actor does within a use case — they are concrete, sequential journeys
- Each flow should have a clear actor, trigger, and outcome
- Steps within flows alternate between actor actions and system responses
- Error scenarios are part of the flow, not separate flows
- A use case typically maps to a distinct deployment or security boundary
- Do not speculate beyond what the requirements state — if something is ambiguous, note it as an assumption
