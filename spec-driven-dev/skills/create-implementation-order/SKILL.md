---
name: create-implementation-order
description: "Analyze all available specs and propose an implementation order — either as a single dev-plan (small scope) or grouped into dependency-ordered domains (larger scope). Invoke via /create-implementation-order. Waits for approval before writing specs/implementation-order.md."
disable-model-invocation: true
---

# Create Implementation Order

Analyze all available specs and determine whether the work needs domain grouping or can be planned as a single unit.

## Contract

This skill **always** produces `specs/implementation-order.md` with a list of `/dev-plan` commands to run. It **never** invokes `/dev-plan` itself — execution is the caller's responsibility (e.g., the `end-to-end` skill's Step 5, or the user running each command manually).

- Small scope → `implementation-order.md` with **1 domain** (the whole feature as a single dev-plan)
- Larger scope → `implementation-order.md` with **N domains** (dependency-ordered)

The output schema is identical in both cases so downstream consumers have a uniform contract.

## Steps

1. Read all available spec files (use cases, design docs, flow docs, patterns, UI/UX briefs)
2. Assess the scope:
   - **Small scope** (1-4 flows, single domain, no cross-cutting concerns) → skip to step 6 with a single domain named after the feature
   - **Larger scope** (5+ flows, multiple domains, shared infrastructure needed) → continue to step 3
3. Identify cross-cutting infrastructure and shared logic
4. Group work into implementation domains:
   - **Scaffolding** is always first for new systems (workspace, infra, DB, shared services)
   - Group remaining work by shared dependencies, components, or logical boundaries
   - Each domain should be independently buildable after its dependencies are complete
5. Order domains by dependency chain
6. Present the grouping as a numbered list:
   - Domain name
   - What work belongs to it
   - Scope (what it covers)
   - What it depends on
7. **Wait for approval** — do not write anything until confirmed
8. After approval, write `specs/implementation-order.md`:
   - **Status table** at the top — one row per domain with columns: Domain number, Description, Status (`pending` | `planned` | `in-progress` | `implemented`). All domains start as `pending`.
   - One section per domain containing:
     - Exact `/dev-plan` command with all relevant `@` file references
     - Scope description
     - Dependency chain
9. Tell the user the file has been written and that execution (running each `/dev-plan`) is the next step — **do not invoke `/dev-plan` from this skill**.
