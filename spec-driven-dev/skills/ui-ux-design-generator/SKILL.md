---
disable-model-invocation: true
name: ui-ux-design-generator
description: "Design system skill that produces UX wireframes and UI visual designs through a structured two-phase workflow. Phase 1 (UX): researches interaction patterns, generates grayscale wireframe HTML previews for user flow validation, then produces a UX brief. Phase 2 (UI): researches visual styles, generates styled HTML previews with design tokens, then produces a UI brief. Each phase asks how many options to generate, supports review and iteration, and maintains state so work can resume across sessions. Trigger when: the user asks to design something, create a design system, generate wireframes, preview a design, define how something should look or behave, or says things like 'design the dashboard', 'how should this flow work', 'make it look like X', 'generate a UX wireframe', 'create a design preview'. Also triggers on 'continue the design' to resume from saved state."
---

# Design System

A two-phase design skill: **UX first** (how it works), then **UI** (how it looks). Each phase produces an interactive HTML preview for validation, then a structured brief after approval.

Uses **ui-ux-pro-max** as its research backend for both UX patterns and UI design decisions.

### Dependency Check

Before starting, verify that `ui-ux-pro-max` is available (check if the search script exists). If it's not installed:

Ask: **"The ui-ux-pro-max plugin is not available. It provides curated design research (styles, palettes, fonts, UX patterns). Would you like to:**
- **Continue without it** — I'll design based on general knowledge and your input. Less grounded but still functional.
- **Stop here** — Install the plugin first and come back."

If the user chooses to continue, skip all `ui-ux-pro-max` research steps (Step 1.2, Step 2.2) and proceed with design based on user input, references, and general knowledge.

## Step 0: Classify — Scope Detection

Before starting, determine the scope. There are three modes: **system**, **feature**, and **component**.

If mode, name, and paths were already provided as context (e.g., by a workflow orchestrator), use them and skip the questions below.

### Auto-detection

If the user's request clearly names a **single reusable UI primitive** (tooltip, dropdown, tabs, toast, popover, date picker, dialog, accordion, etc.), classify as **component** mode. If the request describes a **page, screen, or feature with user flows**, classify as **feature** or **system** mode. If ambiguous, ask: **"Is this a standalone reusable component (like a tooltip or dropdown), or a page/feature with user flows?"**

### Modes

- **New system** — full UX + UI from scratch. Ask: **"What should we call this system?"** (kebab-case, e.g., `identity-hub`). If the name isn't kebab-case, normalize it and confirm. This name is used for the specs folder and later for the official docs (`<system>-system-ux-design.md`, etc.). Do NOT proceed until the user confirms the name.
- **New feature** — extends an existing design system. Ask: **"Point me to the existing design"** (accepts any path — file or folder, e.g., `docs/identity-hub-system-ux-design.md` or `specs/ui-ux-design-identity-hub/`). Read its UX brief, UI brief, and design tokens before designing. The goal is to:
  - **UX phase**: wireframe only the new screens/flows, consistent with the existing UX patterns
  - **UI phase**: skip style/color/typography research — reuse the existing design system. Only generate styled previews for the new screens.
- **Component** — design a single reusable UI component. Ask: **"Point me to the existing design system"** (same as feature mode). Read its UI brief and design tokens. The goal is to:
  - **UX phase**: wireframe the component's **behavior** — triggers, variants, animations, content handling, accessibility. Uses `references/component-wireframe-template.md` instead of the page-level wireframe template.
  - **UI phase**: style the component using the existing design system tokens. Uses `references/component-preview-template.md` instead of the page-level preview template. Skip style/color/typography research — the component inherits from the system.
  - **Briefs**: use component-specific templates (`references/component-ux-brief-template.md`, `references/component-ui-brief-template.md`)
  - **Live demo**: skipped — not applicable for a single component.

If there's only one design folder in the project, suggest it — but wait for the user to confirm.

## State Management

This skill maintains state across sessions via a JSON file so work can be paused and resumed.

**State file location:** `specs/ui-ux-design-<name>/.design-state.json` (where `<name>` is the system name or feature name from Step 0)

### On every invocation:

1. Check if the user specified a name or path. If not, check for existing state files under `specs/ui-ux-design-*/`.
2. If one state file exists, read it and **resume from the current step**. If multiple exist, list them and ask which to resume. Tell the user: "Resuming design for `{name}` — you're at `{phase}/{step}`."
3. If no state exists, start fresh: proceed to Step 0.

### State schema:

```json
{
  "feature": "<feature-name>",
  "scope": "system | feature | component",
  "created": "2026-03-28",
  "phase": "ux | ui",
  "step": "research | preview | review | brief | done",
  "ux": {
    "options_requested": 2,
    "options_generated": [],
    "chosen_option": null,
    "brief": null
  },
  "ui": {
    "options_requested": 2,
    "options_generated": [],
    "chosen_option": null,
    "brief": null
  },
  "history": []
}
```

Update the state file after every step completes. Append to `history` with `{ "phase", "step", "completed": ISO timestamp }`.

## Output Folder

If an output path was provided as context (e.g., by a workflow orchestrator), write all outputs to that path instead of the default below.

Default — all files go under:

```
specs/ui-ux-design-<name>/
  .design-state.json
  ux-preview-option-a.html
  ux-preview-option-b.html
  ...
  ux-live-demo.html              # optional — generated for chosen UX option
  ux-brief.md
  ui-preview-option-a.html
  ui-preview-option-b.html
  ...
  ui-brief.md
  icon-set.md                    # optional — generated if design includes custom icons
```

The `<name>` is the system name (new system mode) or feature name (new feature mode), confirmed by the user in Step 0.

## Inputs

- **Screenshots** — Analyze for layout, interaction patterns, and visual style.
- **URLs** — Fetch and analyze. Ask for a screenshot if visual details matter.
- **Descriptions** — "I want it to work like Linear" or "dark mode like Vercel". Ask clarifying questions.
- **Mood references** — Multiple references that together define a direction.
- **Existing UI + changes** — "Here's our current UI, redesign the sidebar."
- **Technical architecture docs** — Read to understand the app's components, data flow, and structure.

## Research Tool

The ui-ux-pro-max search tool:

```bash
python3 /Users/alontsabari/.claude/plugins/cache/ui-ux-pro-max-skill/ui-ux-pro-max/2.0.1/.claude/skills/ui-ux-pro-max/scripts/search.py
```

### Available domains:

| Domain | Flag | Use for |
|--------|------|---------|
| Full design system | `--design-system -p "Name"` | Complete recommendation (style + color + font + effects) |
| Style | `--domain style` | Visual style patterns (dark mode, glassmorphism, etc.) |
| Color | `--domain color` | Color palettes by product type |
| Typography | `--domain typography` | Font pairings |
| Google Fonts | `--domain google-fonts` | Individual font search |
| **UX** | `--domain ux` | Interaction patterns, loading, feedback, navigation, accessibility |

---

## Phase 1: UX (How It Works)

### Step 1.1 — Collect context

This skill works with any input — specs, use cases, screenshots, a verbal description, or just an idea. Work with whatever the user provides as input. If the user points you to a specific doc (use cases, requirements, etc.), read it.

**The codebase is the primary source of truth.** If there's an existing codebase, read it to understand the actual components, screens, and data flow. If you find discrepancies between docs and code, trust the code — docs may lag behind in multi-developer environments. Flag discrepancies to the user but design based on the actual codebase state.

Gather the user's input (description, screenshot, architecture doc, etc.). Understand:
- What is the product/feature?
- Who are the users?
- What are the key user tasks?
- What components/panels exist?

### Step 1.2 — UX Research

Query ui-ux-pro-max for relevant UX patterns.

**For system/feature scope:**

```bash
python3 <path>/search.py "<primary interaction> <domain keywords>" --domain ux
python3 <path>/search.py "<navigation pattern> <layout keywords>" --domain ux
python3 <path>/search.py "loading feedback error states" --domain ux
```

Run multiple queries covering:
- **Core interaction** — the primary thing users do (chat, browse, configure)
- **Feedback** — loading, streaming, success/error states
- **Navigation** — how users move between views
- **Accessibility** — keyboard nav, screen readers, reduced motion

**For component scope:**

```bash
python3 <path>/search.py "<component name> <trigger type> <interaction pattern>" --domain ux
python3 <path>/search.py "<component name> animation transition timing" --domain ux
python3 <path>/search.py "accessible <component name> keyboard focus" --domain ux
```

Run queries covering:
- **Core behavior** — how the component is triggered and dismissed
- **Animation/timing** — transitions, delays, easing
- **Accessibility** — keyboard interaction, ARIA patterns, reduced motion

### Step 1.3 — Ask options count

Ask the user: **"How many UX options would you like to review?"** (default: 2)

Wait for their answer before proceeding.

### Step 1.4 — Generate UX wireframe previews

Generate N wireframe HTML files — one per option. **Use the Agent tool to generate all options in parallel** (one agent per option) for speed.

**Template selection by scope:**
- **System/feature**: Read `references/ux-wireframe-template.md`
- **Component**: Read `references/component-wireframe-template.md`

Key rules for **system/feature**:
- **Grayscale only** — no visual design, system fonts, basic borders
- **Interactive** — clicking things should do things (JS state toggles)
- **Realistic content** — use real names, file paths, and data from the project
- **All states** — empty, loading, error, success, disconnected
- **Labeled** — each option should have a name and a one-line description of its UX approach

Key rules for **component**:
- **Grayscale only** — same visual rules as above
- **Interactive** — all trigger/dismiss mechanisms must work
- **All variants** — every supported configuration (positions, sizes, types)
- **Animation comparison** — if applicable, side-by-side demos of each animation preset
- **Content extremes** — short, typical, long, overflow
- **Accessibility** — keyboard tab flow, ARIA attributes, reduced motion

Save as: `specs/ui-ux-design-<name>/ux-preview-option-{letter}.html`

Present a summary of each option:

```
## UX Option A: <Name>
<One-line approach>
- Layout: <structure>
- Key interaction: <what's different>
- Navigation: <how users move>

## UX Option B: <Name>
...

Open the HTML files to interact with them. Pick one, or tell me what to mix.
```

Update state: `phase: "ux"`, `step: "review"`, list generated files.

**Stop and wait for the user's choice.**

### Step 1.5 — Refine

Apply the user's feedback:
- **"A"** — proceed with Option A
- **"B but with A's sidebar"** — merge as requested
- **"Neither"** — go back to Step 1.4 with new direction

Update state: `chosen_option`.

### Step 1.6 — Generate UX brief

Produce the UX brief using the chosen wireframe.

**Template selection by scope:**
- **System/feature**: Read `references/ux-brief-template.md`
- **Component**: Read `references/component-ux-brief-template.md`

Save as: `specs/ui-ux-design-<name>/ux-brief.md`

Update state: `ux.brief` set. Log in history.

### Step 1.7 — Offer Live Demo (optional, system/feature scope only)

**Skip this step entirely for component scope** — live demos simulate full app flows, which don't apply to a single component. The wireframe preview already demonstrates all component behavior interactively.

After the UX brief is generated, ask: **"Would you like me to generate a live demo? This is an interactive simulation where you experience the full app flow end-to-end — splash, project picker, connecting, and a working workspace with simulated responses. It's a larger file so it takes a moment."**

- If **yes**: Generate a live demo HTML **based on the UX brief** using the Agent tool (to avoid blocking). The brief is the spec — the live demo should implement the layout, flows, states, and interaction patterns documented in it. The live demo should:
  - Walk through the full startup flow automatically (e.g., splash → selection → loading → main view)
  - Allow real interactions with simulated responses
  - Simulate state changes and transitions in real time
  - Use the same grayscale wireframe style as the previews
  - Have NO state-switching tabs — the user experiences the app as if it were real
  - Save as: `specs/ui-ux-design-<name>/ux-live-demo.html`
- If **no**: Skip.

Update state: `step: "done"`.

Tell the user: "UX phase complete. Ready to start the UI phase when you are."

---

## Phase 2: UI (How It Looks)

### Step 2.1 — Collect visual inspiration

The UX brief is already done. Now gather visual direction:
- Does the user have screenshots, references, or descriptions?
- Any existing brand guidelines or color preferences?
- Light mode, dark mode, or both?

**For system/feature scope only:**
- **Icons**: Ask: **"Do you want custom SVG icons designed for this app, or are generic/emoji icons fine?"**
  - **Custom** — the skill will design a consistent icon set (outline style, stroke weight, sizes) and generate `icon-set.md` with SVG source + an Iconography section in the UI brief and preview HTML.
  - **Generic** — skip icon design entirely. Use emoji or placeholder text for icons in previews. No `icon-set.md`, no Iconography section.

**For component scope:** Skip the icons question — the component inherits icons from the existing design system. Focus visual inspiration on the component's unique styling (e.g., tooltip background treatment, dropdown shadow, modal backdrop).

Read the UX brief to understand what needs visual treatment.

### Step 2.2 — UI Research

Query ui-ux-pro-max for visual design decisions:

```bash
# Full design system recommendation
python3 <path>/search.py "<product_type> <style_keywords>" --design-system -p "<Name>"

# Deep-dive specific dimensions
python3 <path>/search.py "<keywords>" --domain style
python3 <path>/search.py "<keywords>" --domain color
python3 <path>/search.py "<keywords>" --domain typography
python3 <path>/search.py "<keywords>" --domain google-fonts
```

### Step 2.3 — Ask options count

Ask the user: **"How many UI options would you like to review?"** (default: 2)

Wait for their answer before proceeding.

### Step 2.4 — Generate UI preview HTMLs

Generate N styled HTML preview files — one per option.

**Template selection by scope:**
- **System/feature**: Read `references/preview-template.md`
- **Component**: Read `references/component-preview-template.md`

**For system/feature**, each option should:
- Apply visual styling to the **same UX layout** from Phase 1
- Have a distinct name and visual direction
- Show: color palette, typography, spacing, and all components rendered with the design
- Include light/dark toggle if both themes are defined
- Show the full app mockup with realistic content

**For component**, each option should:
- Apply visual styling to the **same component behavior** from Phase 1
- Have a distinct name and visual direction for the component (e.g., "Classic Dark" vs "Frosted Glass")
- Show: anatomy breakdown, all variants styled, animation demos, in-context examples
- Include light/dark toggle
- Show the component over different backgrounds (for overlay components)

Save as: `specs/ui-ux-design-<name>/ui-preview-option-{letter}.html`

Present a summary:

```
## UI Option A: <Name>
<One-line vibe>
- Style: <style from ui-ux-pro-max>
- Colors: <palette summary>
- Typography: <font pairing>
- Key trait: <what makes this distinctive>

## UI Option B: <Name>
...

Open the HTML files to compare. Pick one, or tell me what to mix.
```

Update state: `phase: "ui"`, `step: "review"`, list generated files.

**Stop and wait for the user's choice.**

### Step 2.5 — Refine

Apply the user's feedback. Same as Step 1.5.

### Step 2.6 — Generate UI brief and icon set

Produce the UI brief using the chosen design.

**Template selection by scope:**
- **System/feature**: Read `references/ui-brief-template.md`
- **Component**: Read `references/component-ui-brief-template.md`

Save as: `specs/ui-ux-design-<name>/ui-brief.md`

If the user chose custom icons in Step 2.1, also generate a standalone icon set file containing the full SVG source code for every icon. The UI brief should reference this file rather than inlining SVG markup. If the user chose generic icons, skip this — no `icon-set.md`, no Iconography section in the brief.

Save as: `specs/ui-ux-design-<name>/icon-set.md`

The icon set file should include:
- Design principles (style, stroke, grid, color approach)
- Every icon grouped by category, each with its SVG source in a code block
- Size guidelines (which icons at which sizes)
- CSS usage examples (semantic color application)
- Integration notes (how to use in the target framework)

Update state: `ui.brief` set, `step: "done"`. Log in history.

---

## Working with Screenshots

When the user provides a screenshot:

1. **Describe what you see** — Confirm understanding of layout and interactions.
2. **Extract specifics** — For UX phase: flows, states, navigation. For UI phase: colors, fonts, spacing.
3. **Ask what they like about it** — "Is it the layout/flow or the visual style you want?"
4. **Compare to current state** — If the project has existing UI code, note what would change.

## Resuming Work

When the user says "continue the design", "resume", or invokes this skill with an existing state:

1. Search for `specs/ui-ux-design-*/.design-state.json` files
2. If one exists, read it. If multiple exist, list them and ask which to resume.
3. Tell the user exactly where they are:
   - "You're in the UX phase, reviewing 2 wireframe options. Ready to pick one?"
   - "UX is done. Ready to start the UI phase?"
   - "You're in the UI phase, I need to generate previews. How many options?"
4. Continue from that step — do not repeat completed work

## When This Skill Hands Off

- **To a designer agent**: Provide both briefs + HTML previews. The agent creates detailed designs.
- **To a frontend engineer agent**: Provide both briefs + CSS tokens. The agent implements.
