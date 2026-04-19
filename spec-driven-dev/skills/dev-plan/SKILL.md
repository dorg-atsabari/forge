---
name: dev-plan
description: Create, continue, or execute a structured implementation plan. Breaks work into minimal, independently committable steps — each with its own doc — and tracks progress via a README.md. Use this skill when the user says /dev-plan, "create a plan", "continue the plan", "what's the plan status", "implement step X", or wants a structured approach before coding. Also trigger when the user references a plan folder by path (e.g., "continue with the plan under specs/plan-x/", "pick up from specs/plan-roadmap/"), wants to resume work, check progress, or execute the next step of an existing plan.
disable-model-invocation: true
---

# Execution Plan

Create and execute structured, step-by-step implementation plans that live in the project as a folder of docs. Each step is a self-contained unit of work that leaves the system in a working, committable state.

## Core Principles

- **Least steps possible**: combine work that naturally belongs together. Don't create a step for every file change — group by logical unit. But don't make steps so large they can't be reviewed in one sitting.
- **System works after every step**: this is the hard constraint. After completing any step and committing, the app/system must build, tests must pass, and existing functionality must not break. This means you sometimes need to introduce feature flags, backwards-compatible interfaces, or stub implementations before wiring things up.
- **README.md is the state**: the README tracks which steps are done, in progress, or pending. Any future session (or person) can read it and know exactly where things stand and what to do next.

## Step 0: Check for Existing Plans

Before doing anything else, check if the user wants to create a new plan or continue an existing one:

1. **If the user provided a specific path** (e.g., "continue with specs/plan-x/"), go directly to that folder and read its README.md
2. **If the user explicitly asked to create a new plan**, skip to "Workflow: Creating a New Plan"
3. **Otherwise**, look for `specs/plan-*/` folders. If any exist, list them briefly and ask: "I found existing plans. Would you like to continue one of these, or create a new plan?" If none exist, proceed to create a new one.

**If a matching plan is found and it follows the dev-plan structure** (README.md with status table + step docs):
- Show the plan name, overview, and current status table
- Ask: "I found an existing plan for this. Would you like to continue it, update it, or start fresh?"
- Do NOT create a new plan or start implementing until the user confirms

**If a matching plan is found but it doesn't follow the dev-plan structure** (e.g., a single doc, no status table, no step files):
- Show what was found and its format
- Ask: "This plan doesn't follow the dev-plan structure. Would you like me to migrate it (restructure into README + step docs), or just work with it as-is?"
- **If the user chooses to migrate**: restructure the content into the dev-plan format, preserving all existing information
- **If the user chooses to work with it as-is**: stop here — hand control back to the main agent and let it work with the existing format directly. The dev-plan skill adds no value without its structure.

**If multiple plans could match**, list them and let the user pick.

**If no matching plan is found**, proceed to create a new one.

## Workflow: Creating a New Plan

### 1. Understand the Task

Read the user's request carefully. Ask clarifying questions before proceeding — keep it to 2-3 focused questions, not an interview.

**Always ask about structural decisions** — these are hard to change later and reflect how the user thinks about their system. Never assume them:
- **Names**: app names, service names, library/package names
- **Boundaries**: what belongs in which app/service, how things are split
- **Conventions**: route prefixes, ports, folder structure choices, API naming patterns

**Fine to default on implementation details** — these are easy to change and the user usually doesn't care:
- Which test runner, linter config, formatting rules
- Internal file organization within a module
- Specific library versions

Also consider:
- What is the end result?
- Are there constraints (tech stack, existing patterns, deadlines)?

### 2. Research the Codebase

Before planning, understand what exists:
- Find related code, patterns, and conventions already in use
- Identify which modules/files will be touched
- Check for existing tests, CI config, build setup

### 3. Design the Steps

Break the implementation into the minimum number of ordered steps where:

- Each step leaves the system in a **working, committable state**
- Steps are ordered so that each builds on the previous
- No step is so large it can't be understood and reviewed quickly
- No step is so small it's trivial noise

For each step, think: "If I stopped here and committed, would CI pass? Would the app work?" If not, merge it with the next step or restructure.

### 4. Create the Plan Folder

If an output path was provided as context (e.g., by a workflow orchestrator), write to that path instead of the default below.

Default structure:

```
specs/plan-<plan-name>/
├── README.md              # Summary + status tracker
├── step-01-<slug>.md      # Step 1 details
├── step-02-<slug>.md      # Step 2 details
└── ...
```

Use a descriptive kebab-case name for the folder (e.g., `specs/plan-user-auth/`, `specs/plan-api-redesign/`).

### Templates & Example

Use the templates in the `references/` folder:
- `references/readme-template.md` — README.md format with status table
- `references/step-template.md` — step doc format with goal, changes, acceptance criteria
- `references/example-plan.md` — a complete example showing what a well-structured plan looks like

The slug should be a short, descriptive kebab-case name (e.g., `step-01-setup-db-schema.md`).

## Workflow: Continuing / Executing a Plan

When the user asks to continue, execute, or check status:

1. Read the README.md to understand current state
2. Check which steps are `done`, `in-progress`, or `pending`
3. If a step is `in-progress`, read its doc and check the codebase to see what's actually been completed
4. Update the README.md status and "Current State" section to reflect reality
5. Present the current state to the user and ask how to proceed

### Executing a Step

When starting work on a step:
- Update its status to `in-progress` in README.md immediately, before doing any implementation work

When a step is completed:
- Verify acceptance criteria in the step doc are met
- Update its status to `done` in README.md
- Update the next pending step to `in-progress`
- Update the "Current State" section

### Updating the Plan

If the plan needs to change (new requirements, different approach, step was too big/small):
- Update the affected step docs and README
- Add new steps, renumber if needed
- Always keep README.md as the source of truth

## Guidelines

- When a step introduces new directories or enough new files that spatial context helps, include a **Folder Structure** section showing the tree with `+` for new and `(update)` for modified items. If Changes already lists 2-3 files and no new directories, skip this section — it would just duplicate Changes.
- Keep step descriptions concrete — name specific files, functions, endpoints. Vague steps like "implement the feature" are useless.
- **Include short code examples** in each step's Changes section. Show the key code for each new file or significant change — enough to convey the shape, imports, and patterns. This helps reviewers understand the approach at a glance and gives the execution phase concrete context to work from. Match existing codebase conventions in the examples (e.g., DI style, decorator usage, naming).
- **Include a Tests section** in each step doc. List the test file(s) to create and show concrete test cases with setup (mocks, test module) and assertions. If a step genuinely has nothing to test (e.g., a migration-only step), state that explicitly and explain why.
- If a step requires a migration or schema change, it should be its own step (or the first part of a step) since those are hard to undo.
- If you realize during execution that a step needs to be split, update the plan — add the new steps, renumber if needed, update README.md.
- The plan is a living document. It should reflect reality, not the original guess.
