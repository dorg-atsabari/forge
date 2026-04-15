# Component UI Preview Template

Use this as your structural guide when generating a styled UI preview for a **single reusable component**. The output must be a **single, self-contained HTML file** — all CSS inline, no external dependencies except Google Fonts.

## Purpose

This preview shows the component with the **actual design system applied** — real colors, typography, spacing, shadows, animations. The user evaluates how the component looks and feels within the visual language of the app.

## Required Sections

### 1. Header
- Component name and design option name (e.g., "Tooltip — Option B: Frosted Glass")
- One-line description of the visual direction
- Theme toggle (light/dark) if both themes are defined

### 2. Anatomy
A single large, static rendering of the component with annotated callouts pointing to each design token:
- Background (color, opacity, blur)
- Text (color, size, weight, font)
- Padding, border radius
- Border (color, width)
- Shadow
- Arrow/pointer (if applicable)

Each callout should name the CSS variable or exact value used.

### 3. All Variants Styled
Every configuration from the UX wireframe, now with the design system:
- **Positions** — if applicable
- **Sizes** — if applicable
- **Types** — if applicable

All should be interactive (hover/click to trigger).

### 4. Animation Demos
Interactive demos for each animation preset:
- Side-by-side or grid layout
- Each trigger labeled with the animation name
- Description of the transform below each

### 5. Content Variations
- Short, medium, long/wrapping content — styled
- Show max-width behavior

### 6. In-Context Examples
The component placed in realistic app scenarios using the design system's component styles:
- Next to buttons, badges, icons
- Inside table rows
- In toolbars or form layouts
- Use realistic content from the project (ticket keys, API key labels, etc.)

### 7. Backdrop/Surface Demo (for overlay components)
If the component overlays content (tooltip, dropdown, modal, popover):
- Show it over different colored backgrounds (card, sidebar, gradient, image)
- Demonstrates how transparency/blur/shadow behaves over varied surfaces

### 8. Theme Comparison
Side-by-side static rendering of the component in light and dark themes with token callouts for each.

## HTML Structure

```html
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UI Preview — {Component Name} — {Option Name}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family={Font}:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    :root { /* light theme tokens from the design system */ }
    [data-theme="dark"] { /* dark theme tokens */ }
    /* Component-specific tokens */
    /* Component styles */
    /* Demo layout styles */
  </style>
</head>
<body>
  <header><!-- Title, description, theme toggle --></header>
  <main>
    <section id="anatomy"><!-- Annotated component breakdown --></section>
    <section id="variants"><!-- All styled variants --></section>
    <section id="animations"><!-- Interactive animation demos --></section>
    <section id="content"><!-- Content variations --></section>
    <section id="in-context"><!-- Realistic usage examples --></section>
    <section id="backdrop"><!-- Over different surfaces --></section>
    <section id="theme-comparison"><!-- Light vs dark side by side --></section>
  </main>
  <script>
    // Theme toggle
    // Interactive component behavior
  </script>
</body>
</html>
```

## Style Guidelines

- **Use the design system's tokens** — all colors, spacing, radii, shadows via CSS variables
- **Import only the fonts the design system uses** — no extra dependencies
- **The preview page itself should look polished** — clean section headings, generous whitespace, clear labels
- **Include `prefers-reduced-motion: reduce` support** — disable animations when set

## Anti-Patterns to Avoid

- Don't include full color palette swatches or typography specimens — those belong in the system-level preview, not a component preview
- Don't include spacing scale demos — the component just consumes the system's tokens
- Don't show full-page mockups — focus on the component in isolation and in context
- Don't load heavy frameworks — write lean CSS using the design tokens
- Don't forget hover/focus states — interactivity is the point
- Don't skip the theme toggle — both themes must be evaluable
