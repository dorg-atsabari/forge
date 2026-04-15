# HTML Design Preview Template

Use this as your structural guide when generating a design preview HTML page. The output must be a **single, self-contained HTML file** — all CSS inline, no external dependencies except Google Fonts.

## Required Sections

Every preview page must include these sections, in order. Skip a section only if the design spec has no relevant tokens for it.

### 1. Header
- Design system name / feature name
- One-line description of the visual direction
- Theme toggle (light/dark) if both themes are defined

### 2. Color Palette
- Grid of color swatches
- Each swatch: rendered color block + hex value + token name + usage label
- Group by role: backgrounds, text, brand, semantic (success/error/warning/info), borders
- If light/dark themes exist, show both side by side or toggle between them

### 3. Typography
- Font family specimens (render actual text in the font)
- Full type scale: each step rendered at its actual size with token name, px value, and weight
- Show heading, body, small, and mono styles
- Include a paragraph of sample body text to demonstrate line-height and readability

### 4. Spacing & Layout
- Visual spacing scale: rendered blocks showing each spacing token (4px, 8px, 12px, 16px, etc.)
- Border radius examples: boxes rendered at each radius value
- Shadow examples: boxes rendered with each shadow level

### 5. Iconography (if applicable)
If the design defines custom icons or an icon style, show them in a visual grid.

- Grid of icon cards — each card shows the rendered SVG icon + its name in monospace below
- Group by category: navigation, actions, status, feedback, general UI, empty states
- Status icons should render in their semantic color (success=green, error=red, warning=yellow)
- Empty state icons render at their larger size (e.g., 48px) in a separate row
- Include a brief header noting the icon style (outline/filled, stroke width, linecap style, currentColor usage)

### 6. Components
Render real, interactive components — not just descriptions. Each component should show all relevant states.

**Buttons:**
- Primary, secondary, ghost/outline variants
- States: default, hover (use `:hover`), active, disabled
- Sizes if defined

**Cards:**
- Default card with sample content
- Elevated/raised variant if defined
- With and without borders

**Inputs:**
- Text input with placeholder
- Focus state (use `:focus-within`)
- Error state if defined
- With label and helper text

**Badges/Tags:**
- Status badges: pending, success, error, warning
- Size variants if defined

**Messages/Chat bubbles (if applicable):**
- User message bubble with sample text
- Assistant message bubble with sample text + avatar
- Show timestamp, footer, and any action buttons

**Tool cards (if applicable):**
- Collapsed state with header
- Expanded state with sample content
- Loading/skeleton state
- Error state

**Approval cards (if applicable):**
- Pending, approved, rejected states

### 7. Animations & Transitions
- Show a few interactive demos using the design's animation tokens
- E.g., a button that demonstrates the hover transition timing
- A card that demonstrates expand/collapse

### 8. Responsive Preview (optional)
- If space allows, show how key components look at mobile vs desktop widths
- Or include a note about breakpoints

## HTML Structure

```html
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Design Preview — {Feature Name}</title>
  <!-- Google Fonts (only what's needed) -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family={Font}:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    /* === CSS Custom Properties (Design Tokens) === */
    :root { /* light theme tokens */ }
    [data-theme="dark"] { /* dark theme tokens */ }

    /* === Reset & Base === */
    /* === Layout === */
    /* === Section Styles === */
    /* === Component Styles === */
    /* === Responsive === */
    /* === Reduced Motion === */
  </style>
</head>
<body>
  <header><!-- Title, description, theme toggle --></header>
  <nav class="sticky-nav">
    <!-- REQUIRED: links to every section, smooth-scroll on click -->
    <a href="#colors">Colors</a>
    <a href="#typography">Typography</a>
    <a href="#spacing">Spacing</a>
    <a href="#iconography">Iconography</a><!-- include only if icons section is rendered -->
    <a href="#components">Components</a>
    <a href="#animations">Animations</a>
    <a href="#responsive">Responsive</a><!-- include only if responsive section is rendered -->
  </nav>
  <main>
    <section id="colors"><!-- Color palette --></section>
    <section id="typography"><!-- Type scale --></section>
    <section id="spacing"><!-- Spacing, radius, shadows --></section>
    <section id="iconography"><!-- Icons (if applicable) --></section>
    <section id="components"><!-- Interactive components --></section>
    <section id="animations"><!-- Animation demos --></section>
    <section id="responsive"><!-- Responsive preview (optional) --></section>
  </main>
  <script>
    // Theme toggle logic
    // Smooth-scroll for nav links
    // Any interactive demos
  </script>
</body>
</html>
```

## Style Guidelines for the Preview Page Itself

The preview page should look good on its own — it's a design artifact, not a raw dump of values.

- **Use the design system's own tokens** to style the preview page. The page should feel like it belongs to the design system it's documenting.
- **Clean grid layouts** for swatches and component galleries
- **Clear section headings** with visual separation between sections
- **Generous whitespace** — the preview should breathe, not cram
- **Sticky nav** (required) — a sticky top or side nav with links to every section (Colors, Typography, Spacing, Iconography, Components, Animations, Responsive). Smooth-scroll on click.
- **Code snippets** — next to each token, optionally show the CSS variable name in a small mono label so engineers can reference it directly

## Anti-Patterns to Avoid

- Don't generate a plain table of hex values — that's a spreadsheet, not a preview
- Don't use placeholder gray boxes when you have actual colors
- Don't skip hover/focus states — interactivity is the whole point
- Don't load heavy frameworks (Tailwind CDN, Bootstrap, etc.) — write lean CSS using the design tokens
- Don't make the page wider than ~1200px — it should be comfortable to read
- Don't forget `prefers-reduced-motion` — respect the accessibility standard from the design spec
