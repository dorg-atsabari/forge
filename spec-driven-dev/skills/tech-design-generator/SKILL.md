---
name: tech-design-generator
description: "Generate technical architecture designs for systems and applications. Produces component designs, communication patterns, database choices, API contracts, shared patterns, and detailed flow designs — all as structured markdown docs. Use this skill when the user says /tech-design-generator, 'design the architecture', 'technical design', 'system design', 'how should we architect this', or wants to define the technical structure before implementation. Also trigger when the user shares requirements or a spec and wants to plan the technical approach."
disable-model-invocation: true
---

# Technical Design Generator

Translate product requirements into a structured technical architecture design. Produces markdown docs for agents and humans — components, data stores, flows, API contracts, and shared patterns.

## Why this exists

Starting implementation without a technical design leads to rework, inconsistent patterns, and poor separation of concerns. This skill forces the thinking to happen upfront: what are the components, how do they communicate, what data do they own, and why these choices over alternatives.

## Inputs you can work with

- **Specs or PRDs** — a requirements doc, a feature brief, or any product spec
- **Verbal descriptions** — "we're building an identity hub with X, Y, Z"
- **Existing codebase** — the user wants to design a new feature within an existing system
- **Reference architectures** — "something like how Stripe handles webhooks"

## Workflow

The workflow has two phases. Phase 1 produces the architecture design. Phase 2 dives into individual flows and extracts shared patterns and API contracts. The user reviews and approves after each phase.

### Step 0: Classify — New System or New Feature?

Before anything else, determine the scope.

If mode, system/feature name, and paths were already provided as context (e.g., by a workflow orchestrator), use them and skip the questions below.

Otherwise, ask: **"Is this a new system, a new feature on an existing one, or an update to an existing design?"**

- **New system** — standalone architecture, fresh design. Ask: **"What should we call this system?"** (kebab-case, e.g., `identity-hub`). If the name isn't kebab-case, normalize it and confirm. This name is used for the specs folder (`specs/tech-design-<system>/`) and later for the official docs. Do NOT proceed until the user confirms the name.
- **New feature** — extends an existing system. Ask: **"Point me to the existing tech design"** (accepts any path — file or folder, e.g., `docs/identity-hub-system-tech-design.md` or `specs/tech-design-identity-hub/`). Read its design docs and flows before designing. The goal is to extend, not replace — add new components/flows and update existing ones as needed.
- **Update existing design** — brings an existing tech design up to date with the current skill templates. Ask: **"Point me to the existing tech design"** (same as new feature mode). Then follow the **Update Workflow** below instead of Phase 1/Phase 2.

If there's only one tech design folder in the project, suggest it — but wait for the user to confirm.

### Phase 1: Architecture Design

#### Step 1. Understand the system

This skill works with any input — specs, use cases, a verbal description, or just an idea. Work with whatever the user provides as input. If the user points you to a specific doc (use cases, requirements, etc.), read it.

Read the user's input carefully. Ask clarifying questions before designing — keep it to 2-3 focused questions.

**Always ask about structural decisions** (skip for new feature mode — these are already decided). Never assume these — they are hard to change later and reflect how the user thinks about their system:
- **Names**: app names, service names, library/package names (e.g., `apps/web` vs `apps/client`, `libs/shared/types` vs `libs/contracts`)
- **Boundaries**: what are the main components/services? Is this a monolith, modular monolith, or microservices?
- **Data**: what are the main data domains? Any existing databases or data stores to integrate with?
- **Constraints**: scale expectations, team size, deployment environment, existing tech stack
- **Development setup**: monorepo tool (Nx, Turborepo, etc.) or polyrepo? Any existing workspace conventions? How will the system run locally vs in production?
- **Conventions**: route prefixes, ports, folder structure choices

**Fine to default on:**
- Specific library choices within a stack
- Internal module organization
- Logging/monitoring specifics

**Ask which optional sections to include in the design.** Present the list:

> "The design always includes: **Overview, Components, Data Stores, Communication Patterns, Key Decisions**. Which of these optional sections do you want?"
>
> - **DB Schema Detail** — column types, constraints (PK, FK, unique, not null), and indexes per table
> - **Session / Auth Management** — how authentication works end-to-end (session generation, storage, verification, lifecycle, data model)
> - **Non-Functional Considerations** — scalability, security, observability decisions
> - **Open Questions** — unresolved decisions that need flagging

Note: **API Contract** and **Shared Patterns** are always generated as separate files after Phase 2 — they depend on flow designs being complete.

Skip this question if the user already specified which sections they want.

#### Step 2. Research the codebase

**The codebase is the primary source of truth.** If there's an existing codebase, understand what's actually in place:
- Current architecture patterns
- Existing services, databases, and communication patterns
- Conventions and tech stack decisions already made

If you find discrepancies between docs and code (e.g., a component listed in the architecture doc that doesn't exist in code, or code that's diverged from the documented design), trust the code. Docs may lag behind in multi-developer environments. Flag discrepancies to the user but design based on the actual codebase state.

#### Step 3. Design the architecture

Produce the design doc. For each component, cover:

- **What it is** — name, responsibility, one-line purpose
- **Why it exists** — what would go wrong without it, why it's a separate component
- **What it owns** — data, state, domain logic
- **How it communicates** — with which other components, via what protocol/pattern (REST, events, gRPC, direct call)

For databases/data stores:
- **What type and why** — relational, document, key-value, cache, message queue
- **What it stores** — which domain's data
- **Why this choice** — reasoning over alternatives (e.g., "Postgres over Mongo because the data is highly relational with strong consistency needs")

#### Step 4. Generate the Phase 1 artifacts

**1. README.md** (always) — saved to `specs/tech-design-<system-name>/README.md`
Use the template at `references/readme-template.md`. Overview of the system and index linking to all other files.

**2. Design doc** (always) — saved to `specs/tech-design-<system-name>/design.md`
Use the template at `references/design-template.md`. Include the must-have sections always. Include optional sections the user selected in Step 1.

**3. Dev setup doc** (new system mode only) — saved to `specs/tech-design-<system-name>/dev-setup.md`
Use the template at `references/dev-setup-template.md`. Covers repository structure, dev tooling, and how to run locally.

**Then stop and wait for the user's review.** Do not proceed to Phase 2 until the user approves or requests changes to the design.

### Phase 2: Flow Designs, API Contract & Shared Patterns

#### Step 5. Identify and list flows

List all significant flows in the system. For each, note:
- Flow name
- Trigger (user action, scheduled job, event, etc.)
- Components involved
- Complexity assessment: **simple** (2 components, linear) or **complex** (3+ components, branching, async, retries, error handling)

Present this list to the user.

Then ask: **"Which flows do you want to design now? You can pick specific ones, a group, or all."**

Do NOT generate all flows automatically. Let the user control the pace — they may want to review and discuss each flow before moving to the next.

#### Step 6. Design selected flows

For each flow the user selected, produce a markdown doc saved to `specs/tech-design-<system-name>/flows/flow-<name>.md`.
Use the template at `references/flow-template.md`.

**After completing the selected flows, stop and present the result.** Show which flows are done and which remain. Ask: **"Which flows do you want to design next?"** — the user may want to review, adjust, or continue.

Repeat until all flows are designed or the user is satisfied.

#### Step 7. Generate API Contract

Generate `specs/tech-design-<system-name>/api-contract.md` once flows are designed — the endpoints aren't fully defined until then. If the user is designing flows incrementally, ask whether to generate the API Contract now or wait for more flows.

Use the template at `references/api-contract-template.md`. Extract every endpoint from the flow docs and consolidate them. Group by controller/domain. Ensure consistency with the flow docs — the contract is a summary, not a separate source of truth.

#### Step 8. Generate Shared Patterns

Generate `specs/tech-design-<system-name>/shared-patterns.md` by analyzing all designed flows for logic that repeats across multiple flows.

Use the template at `references/shared-patterns-template.md`. For each shared pattern, document the behavior (not implementation) — what it does, which flows use it, and the full lifecycle including edge cases. These patterns inform the dev-plan skill about what logic should be extracted as shared code during implementation.

After generating shared patterns, **go back and update the flow docs**: replace any inlined logic that now lives in a shared pattern with a reference link to the pattern (e.g., "Resolves a valid access token via the [Jira Access Token Resolution](../shared-patterns.md#pattern-name) shared pattern"). The shared pattern is the source of truth — flow docs should not duplicate it.

#### Step 9. Update README

Update `README.md` to link to all generated files including the new `api-contract.md` and `shared-patterns.md`.

### Update Workflow

Used when the user wants to align an existing tech design with the current skill templates. This is not a redesign — it fills structural gaps and aligns formatting without changing architectural decisions.

#### Step 1. Inventory existing artifacts

Read the existing tech design folder and catalog what's present:
- `README.md`
- `design.md`
- `dev-setup.md`
- `api-contract.md`
- `shared-patterns.md`
- `flows/flow-*.md`

#### Step 2. Detect gaps

Compare the existing artifacts against the expected output structure (see **Output Structure** below) and the current templates in `references/`. Identify:

- **Missing files** — e.g., `shared-patterns.md` doesn't exist
- **Missing sections** — e.g., a flow doc exists but is missing the Error Handling table
- **Structural drift** — e.g., a section exists but doesn't follow the current template format

Present the findings to the user as a checklist:
```
Existing design: specs/tech-design-<name>/
✅ README.md — present
✅ design.md — all sections present
❌ api-contract.md — missing
❌ shared-patterns.md — missing
✅ dev-setup.md — present
✅ flows/ — 8 flow docs
   ✅ flow-login.md — all sections present
   ⚠️ flow-register.md — missing Error Handling table
   ...
```

#### Step 3. Fill gaps

For each gap, ask the user for any needed input, then generate the missing content. Rules:

- **Missing files**: Generate from the corresponding template. Ask clarifying questions as needed.
- **Missing sections**: Add the section to the existing file, following the template structure. Do not rewrite existing sections.
- **Structural drift**: Show the user what the template expects vs what exists. Only reformat if the user approves — content decisions made in the original design are preserved.

Do not modify architectural decisions, component choices, or flow logic. The update workflow is purely structural alignment.

## Output Structure

If an output path was provided as context (e.g., by a workflow orchestrator), write all outputs to that path instead of the defaults below.

### New System mode:
```
specs/tech-design-<system-name>/
├── README.md                     # Overview + index linking to all files
├── design.md                     # Components, DBs, communication, key decisions, optional sections
├── dev-setup.md                  # Repo structure, tooling, local dev environment
├── api-contract.md               # Consolidated endpoint reference (generated after Phase 2)
├── shared-patterns.md            # Cross-flow shared behaviors (generated after Phase 2)
└── flows/
    ├── flow-<name>.md            # Per-flow design doc
    └── ...
```

### New Feature mode:
```
specs/tech-design-<feature-name>/
├── README.md                     # Overview + index
├── feature-design.md             # What's new/changed, references system design
├── api-contract.md               # New/changed endpoints only
├── shared-patterns.md            # New shared behaviors (if any)
└── flows/
    ├── flow-<name>.md            # New flow docs for this feature
    └── ...
```

## Guidelines

- Every design decision needs a "why" — not just what you chose, but why over the alternatives
- Keep component boundaries clean — each component should have a single clear owner (team or domain)
- Prefer boring technology — don't introduce complexity (event sourcing, CQRS, microservices) unless the requirements actually demand it
- Name things consistently — if the product calls it "identity", don't call it "user" in the architecture
- The design should be readable by someone who joins the project tomorrow — no assumed context
