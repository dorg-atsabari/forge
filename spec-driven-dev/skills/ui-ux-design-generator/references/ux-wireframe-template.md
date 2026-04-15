# UX Wireframe Preview Template

Use this as your structural guide when generating a UX wireframe HTML page. The output must be a **single, self-contained HTML file** — all CSS inline, no external dependencies.

## Purpose

This is a **functional wireframe**, not a visual design. It demonstrates user flows, layout structure, interaction patterns, and states — with zero visual styling. Think: grayscale, system fonts, basic borders. The user should evaluate *how it works*, not how it looks.

## Visual Style Rules

- **Font:** system-ui only — no Google Fonts, no custom fonts
- **Colors:** grayscale only — white, #F5F5F5, #E0E0E0, #999, #666, #333, black
- **One accent color allowed:** a single blue (#2563EB) for interactive/clickable elements and focus states — this signals "this is tappable" without introducing visual design
- **Borders:** 1px solid #E0E0E0 everywhere — make structure visible
- **Border radius:** 4px max — keep it plain
- **Shadows:** none
- **Icons:** use single-letter abbreviations or unicode symbols, not icon libraries
- **Images/avatars:** gray circles or squares with initials

## Required Sections

### 1. Header
- Feature name
- One-line description of what the user is evaluating
- Note: "This is a UX wireframe — evaluate the layout, flows, and interactions, not the visual design."

### 2. App Layout Wireframe
- Render the **actual app layout** at realistic proportions
- Show all panels/regions with labeled placeholders
- Must be interactive — clicking sidebar items should filter content, tabs should switch, panels should collapse/expand where applicable
- Use realistic sample data, not "Lorem ipsum"

### 3. User Flows
For each key flow, show:
- **Starting state** — what the user sees initially
- **Interaction** — what they click/type
- **Resulting state** — what changes on screen
- Implement these as actual interactive states in the HTML (use JS to toggle between states)

### 4. States & Feedback
Demonstrate these states visually within the wireframe:
- **Empty state** — no data yet
- **Loading state** — skeleton/spinner
- **Success state** — operation completed
- **Error state** — something went wrong
- **Disconnected state** — lost connection

### 5. Component Behavior (not appearance)
For each component, show:
- What it does when clicked
- What it does when hovered
- What keyboard navigation looks like (tab order, focus)
- What happens on long content (truncation, scrolling, wrapping)

### 6. Responsive Notes (optional)
- If the wireframe has responsive behavior, show how panels collapse or reorganize
- Or include a text note about intended responsive behavior

## HTML Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UX Wireframe — {Feature Name}</title>
  <style>
    /* System font only */
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: system-ui, sans-serif; background: #FAFAFA; color: #333; }

    /* Grayscale palette */
    /* Simple borders and structure */
    /* Interactive states with blue accent */
    /* State toggles */
  </style>
</head>
<body>
  <header><!-- Feature name, description, "this is a wireframe" note --></header>
  <main>
    <section id="app-wireframe"><!-- Interactive app layout --></section>
    <section id="states"><!-- State demonstrations --></section>
  </main>
  <script>
    // State toggles
    // Flow interactions
    // Panel switching
  </script>
</body>
</html>
```

## Quality Bar

- Must be interactive — clicking things should do things
- Must use realistic content — real file names, real agent names, real tool names from the project
- Must show all key states (empty, loading, error, success, disconnected)
- Must demonstrate the primary user flow end-to-end
- Must work without a server — single HTML file, opens in any browser
- Layout proportions should be realistic — if the sidebar is 200px in the spec, make it 200px

## Anti-Patterns to Avoid

- Don't add colors, gradients, shadows, or visual flair — this is about structure and behavior
- Don't use Lorem ipsum — use real content from the project context
- Don't make it static — if something is clickable in the real app, make it clickable here
- Don't skip error/empty states — those are the hardest UX problems
- Don't forget keyboard navigation indicators (focus outlines)
- Don't use icon libraries — keep it dependency-free
