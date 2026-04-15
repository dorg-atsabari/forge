# Design Brief Template

Use this template when outputting a design brief from visual inspiration.

---

```markdown
# Design Brief — <Feature/Screen Name>

## Inspiration Source

<What was provided: screenshot description, URL, verbal description, or combination.>

## Visual Direction

<One-line summary of the target aesthetic. E.g., "Premium dark interface with glassmorphic depth, inspired by Linear and Vercel.">

## Color Palette

| Role | Hex | Usage |
|------|-----|-------|
| Background | #_____ | Page/app background |
| Surface | #_____ | Cards, panels, elevated areas |
| Surface raised | #_____ | Hover states, active items |
| Primary | #_____ | CTAs, links, active indicators |
| Text primary | #_____ | Headings, body text |
| Text secondary | #_____ | Captions, labels, metadata |
| Border | #_____ | Dividers, card borders |
| Success | #_____ | Positive states |
| Error | #_____ | Error states |

<Notes on color usage: gradients, opacity treatments, accent patterns.>

## Typography

- **Font family**: <Recommended font or style direction>
- **Heading style**: <Size range, weight, letter-spacing>
- **Body style**: <Size, weight, line-height>
- **Code/mono**: <If applicable>
- **Overall feel**: <Tight and dense? Open and spacious?>

## Spacing & Layout

- **Density**: <Compact / Balanced / Spacious>
- **Grid**: <Content width, sidebar width, gaps>
- **Border radius**: <Sharp (2-4px) / Rounded (8-12px) / Pill (16px+)>
- **Shadows**: <None / Subtle / Layered / Prominent>

## Iconography (if applicable)

If the design uses custom icons, document the icon set here or reference a separate `icon-set.md` file.

- **Style**: <Outline / Filled / Duo-tone>
- **Stroke**: <weight, linecap, linejoin>
- **Grid**: <viewBox size, safe area padding>
- **Color**: <currentColor / fixed colors>
- **Sizes**: <by context — e.g., 16px inline, 18px nav, 48px empty states>

### Icon Catalog Summary

| Category | Icons |
|----------|-------|
| Navigation | <list> |
| Actions | <list> |
| Status | <list> |
| General UI | <list> |

### Semantic colors for status icons

| Icon | CSS color variable |
|------|--------------------|
| <success icons> | `var(--success)` |
| <error icons> | `var(--destructive)` |
| <warning icons> | `var(--warning)` |

## Component Style

### Buttons
<Filled/outlined/ghost? Radius? Size? Hover effect?>

### Cards
<Background? Border? Shadow? Radius? Padding?>

### Inputs
<Border style? Focus treatment? Height?>

### Navigation
<Sidebar/top bar? Active indicator style?>

### Messages/Chat (if applicable)
<Bubble style? User vs assistant differentiation? Avatar treatment?>

## Visual Effects

- **Glassmorphism**: <Yes/No — if yes, where and how much>
- **Gradients**: <Where used, direction, colors>
- **Animations**: <Snappy (100-200ms) / Smooth (200-400ms) / Bouncy>
- **Depth**: <Flat / Subtle layers / Pronounced elevation>

## Key Principles (ranked)

1. <Most important aspect of the design direction>
2. <Second most important>
3. <Third>

## Do / Don't

| Do | Don't |
|----|-------|
| <Specific positive guidance> | <Specific anti-pattern to avoid> |
| <...> | <...> |

## Shared Component Strategy

Bridge from design specs to implementation. Identify which UI elements repeat across screens and should become shared components vs. which are page-specific.

### Extract as shared components

<List components that appear on 2+ screens and must stay visually consistent. For each, specify: component name, selector, key inputs/variants, and which design specs from Component Style apply.>

| Component | Selector | Variants / Inputs | Design Spec Reference |
|-----------|----------|-------------------|----------------------|
| <e.g., Button> | <e.g., app-button> | <e.g., variant: primary/secondary/ghost/destructive, disabled, loading> | <e.g., Component Style > Buttons> |

### Keep as page-level (not shared)

<List components that appear only once or are too feature-specific to extract. Note: extract later if a second consumer appears.>

### Global styles vs component styles

| Concern | Where it lives |
|---------|---------------|
| CSS variables (colors, spacing, radii, shadows, typography) | Global stylesheet `:root` |
| Font imports, CSS reset | Global stylesheet |
| Shared component styling | Inside the shared component — consumers don't override internals |
| Page-specific styling | Co-located in the page/feature component |

### Implementation notes

- Shared components are **presentational only** — inputs and outputs, no business logic or injected services.
- Use the `--on-*` CSS variable pattern for text on colored backgrounds (e.g., `--on-primary` for text on `--primary`).
- All interactive elements need a visible focus ring for accessibility.
- Dark mode must work via CSS variables — components never hardcode color values.

## Screens to Design

<List the screens/states that need this treatment applied, in priority order.>

1. <Screen name> — <brief description of what it shows>
2. <Screen name> — <brief description>
```
