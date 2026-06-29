---
name: end-to-end
description: "Orchestrate a full development cycle — from technical design through UI/UX design, implementation planning, and execution. Supports both new systems and features on existing systems. Only invoke via /end-to-end."
---

# End-to-End Development Workflow

Orchestrate a full development cycle with isolated workflow folders. Each step must complete before the next begins. The user confirms every transition.

## State Management

Track workflow progress in `specs/.workflow-e2e-<name>-<YYYY-MM-DD>.json`:

```json
{
  "workflow": "end-to-end",
  "name": null,
  "mode": null,
  "workflow_folder": null,
  "existing_docs": {
    "tech_design": null,
    "ux_design": null,
    "ui_design": null
  },
  "steps_to_run": {
    "use_cases": true,
    "tech_design": true,
    "ui_ux_design": false,
    "dev_plan": true,
    "execute": true,
  },
  "requirements_input": null,
  "current_step": "init",
  "steps": {
    "use-cases": { "status": "pending", "specs_path": null },
    "tech-design": { "status": "pending", "specs_path": null, "published": false },
    "design": { "status": "pending", "specs_path": null, "published": false },
    "domain-grouping": { "status": "pending", "domains": [] },
    "dev-plans": { "status": "pending", "plans": {} },
    "execute": { "status": "pending", "current_domain": null, "current_step_index": null },
  },
  "history": []
}
```

Update the state file after every step transition. Append to `history` with `{ "step", "action", "timestamp" }`.

## Step Transitions

At every step transition, offer three options:
- **"Continue"** — proceed to the next enabled step
- **"Go back to [previous step]"** — reset that step's status to `in-progress` so the skill re-runs. Previous outputs remain for reference.
- **"Stop here"** — pause the workflow. On next invocation, resume from this point.

## On Every Invocation

1. Check for any `specs/.workflow-e2e-*.json` files
2. If one or more exist, list them and ask which to resume. Read the selected state and resume from `current_step`. Tell the user: "Resuming workflow for `<name>` — you're at the `<current_step>` step."
3. If none exist, start fresh

## Step 0: Initialize

Ask the user:

1. **"What are we building?"** — short description
2. **"What should we call it?"** (kebab-case, e.g., `jira-integration`) — normalize if needed, confirm before proceeding
3. **"Is this a new system or a feature on an existing one?"**
   - If existing: **"Point me to the existing tech design docs."** If there's only one system, suggest it but wait for confirmation.
4. **"What steps do you need?"**
   - **Use cases** — yes/no (default: yes)
   - **Technical design** — yes/no (default: yes)
   - **UI/UX design** — yes/no (default: no)
   - If UI/UX yes and extending an existing system: **"Point me to the existing design docs."**
5. **"What requirements should I work from?"** — a doc path, description, or conversation

Create the workflow folder: `specs/e2e-<name>-<YYYY-MM-DD>/`. All skill outputs go inside this folder.

Save answers to state. Proceed to the first enabled step.

## Step 1: Use Cases (if enabled)

Tell the user which step they're on (e.g., "**Step 1/N: Use Cases**").

Invoke `/use-cases-generator` with context:
- Requirements input: `<requirements_input>` (from Step 0)
- Output path: `<workflow_folder>/use-cases/`

**Wait for the skill to complete and the user to approve the use cases.**

After approved, update state.

## Step 2: Technical Design (if enabled)

Tell the user which step they're on.

Invoke `/tech-design-generator` with context:
- Mode: new system or new feature (based on Step 0)
- Name: `<name>`
- Output path: `<workflow_folder>/tech-design/`
- Existing system tech design: `<existing_docs.tech_design>` (if extending)
- Use cases path: `<workflow_folder>/use-cases/` (if use cases were run)
**Wait for the skill to complete its design cycle.**

After approved, update state.

## Step 3: UI/UX Design (if enabled)

Tell the user which step they're on.

Invoke `/ui-ux-design-generator` with context:
- Mode: new system or new feature (based on Step 0)
- Name: `<name>`
- Output path: `<workflow_folder>/design/`
- Existing design docs: `<existing_docs.ux_design>` and `<existing_docs.ui_design>` (if extending)
- Tech design path: `<workflow_folder>/tech-design/` (if tech design was run)
- Use cases path: `<workflow_folder>/use-cases/` (if use cases were run)

**Wait for the skill to complete its design cycle.**

After approved, update state.

## Step 4: Domain Grouping

Tell the user which step they're on (e.g., "**Step 4/N: Domain Grouping**").

Invoke `/create-implementation-order` with context:
- Tech design: `<workflow_folder>/tech-design/` (all files — design.md, api-contract.md, shared-patterns.md, flows/)
- UI/UX design: `<workflow_folder>/design/` (if it exists)
- Use cases: `<workflow_folder>/use-cases/` (if they exist)

The skill handles scope assessment, grouping, user approval, and writing `implementation-order.md`. Save the output to `<workflow_folder>/implementation-order.md`.

After the user approves and the file is written, update state.

## Step 5: Implementation Plans

Tell the user which step they're on.

For each domain from the grouping (in order):

1. Tell the user: **"Creating plan for domain: <domain name>"**
2. Invoke `/dev-plan` with context:
   - Output path: `<workflow_folder>/plan-<domain-name>/`
   - Tech design at `<workflow_folder>/tech-design/` (if it exists)
   - Design at `<workflow_folder>/design/` (if it exists)
   - Use cases at `<workflow_folder>/use-cases/` (if they exist)
   - Specific flow docs for this domain only
   - Name: `<name>-<domain-name>`
   - Instruction: Backend first, then frontend. Each step must be independently committable.
3. **Wait for the user to approve the plan before moving to the next domain.**

After all domain plans are approved, update state.

## Step 6: Execute Plans

Tell the user which step they're on.

Execute domain plans in order. For each domain:

1. Tell the user: **"Executing domain: <domain name>"**
2. For each step in the domain's plan:
   a. Show the step details (read from the step doc)
   b. Ask: **"Ready to execute this step?"**
   c. Only execute on confirmation
   d. After completion, update the plan README status via dev-plan
   e. Update workflow state with current domain and step index
3. After all steps in a domain are complete, tell the user before moving to the next domain

The user can stop at any point. On resume, pick up from the last incomplete step in the last incomplete domain.

Do NOT auto-commit. Do NOT offer to commit. Committing is the user's decision.

When all domain plans are complete, tell the user: **"Workflow complete. Specs are in `<workflow_folder>/`. Run `/document` when ready to sync documentation."**
