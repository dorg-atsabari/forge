# Component UX Wireframe Preview Template

Use this as your structural guide when generating a UX wireframe for a **single reusable UI component** (tooltip, dropdown, tabs, toast, etc.). The output must be a **single, self-contained HTML file** — all CSS inline, no external dependencies.

## Purpose

This is a **behavioral wireframe** for a component, not a page. It demonstrates how the component works — triggers, states, variants, animations, accessibility, timing — with zero visual design. The user should evaluate *how it behaves*, not how it looks.

## Visual Style Rules

Same as page-level wireframes:
- **Font:** system-ui only — no Google Fonts, no custom fonts
- **Colors:** grayscale only — white, #F5F5F5, #E0E0E0, #999, #666, #333, black
- **One accent color:** blue (#2563EB) for interactive/clickable elements and focus states
- **Borders:** 1px solid #E0E0E0 — make structure visible
- **Border radius:** 4px max
- **Shadows:** none
- **Icons:** single-letter abbreviations or unicode symbols, not icon libraries

## Required Sections

### 1. Header
- Component name
- One-line description of what the component does
- Note: "This is a UX wireframe — evaluate the behavior and interactions, not the visual design."

### 2. Variant Demo
Show every supported configuration of the component:
- **Positions** — if the component supports positioning (top, bottom, left, right, etc.)
- **Sizes** — if the component supports size variants
- **Types** — if the component has different modes (e.g., informational vs interactive tooltip)

Each variant should be interactive — the user triggers it to see the behavior.

### 3. Animation Demo (if applicable)
If the component supports multiple animation presets:
- Show each animation side-by-side with a labeled trigger
- Animations should be clearly distinct from each other
- Label each with its name and a brief description of the transform

### 4. Content Variations
Show how the component handles different content:
- **Minimal** — shortest reasonable content
- **Typical** — normal use case
- **Maximum** — long text, overflow, wrapping behavior
- **Empty** — if applicable

### 5. Trigger & Dismiss Demo
Demonstrate all ways the component can be shown and hidden:
- Hover, click, focus, programmatic
- Dismiss via blur, escape, outside click, timeout
- Show delay and hide grace period if applicable

### 6. Accessibility Demo
- **Keyboard navigation** — Tab to trigger, Escape to dismiss, arrow keys if applicable
- **Focus indicators** — visible focus rings on all interactive elements
- **ARIA** — note which attributes are used (role, aria-describedby, aria-expanded, etc.)
- **Reduced motion** — note that animations are disabled

### 7. Composition Demo (optional)
Show the component used in realistic contexts:
- Inside a toolbar with other buttons
- In a table row
- Next to form elements
- Over different background areas

This helps the user evaluate whether the component works well in real layouts, not just in isolation.

## HTML Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UX Wireframe — {Component Name}</title>
  <style>
    /* System font only */
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: system-ui, sans-serif; background: #FAFAFA; color: #333; }
    /* Grayscale palette, interactive states with blue accent */
  </style>
</head>
<body>
  <header><!-- Component name, description, "this is a wireframe" note --></header>
  <main>
    <section id="variants"><!-- All variant configurations --></section>
    <section id="animations"><!-- Animation comparison --></section>
    <section id="content"><!-- Content variations --></section>
    <section id="triggers"><!-- Trigger & dismiss behavior --></section>
    <section id="accessibility"><!-- Keyboard and ARIA demo --></section>
    <section id="composition"><!-- In-context usage --></section>
  </main>
  <script>
    // Interactive behavior
  </script>
</body>
</html>
```

## Quality Bar

- Must be interactive — triggers should fire the component behavior
- Must show ALL supported variants and configurations
- Must demonstrate keyboard accessibility
- Must show content extremes (short, typical, long, overflow)
- Must work without a server — single HTML file, opens in any browser
- If animations are supported, each preset must be clearly distinguishable

## Anti-Patterns to Avoid

- Don't add colors, gradients, shadows, or visual flair — this is about behavior
- Don't show the component in isolation only — include at least one composition example
- Don't skip keyboard/accessibility demos — those are UX, not UI
- Don't use icon libraries — keep it dependency-free
- Don't include page-level concerns (navigation, layout, user flows) — this is a component wireframe