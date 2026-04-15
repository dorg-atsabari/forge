# Component UI Brief Template

Use this template when outputting a UI brief for a **single reusable component** after the user approves a styled preview.

---

```markdown
# Design Brief — <Component Name>

## Inspiration Source

<Which UI option was chosen and why. Reference the preview file.>

## Visual Direction

<One-line summary of the component's look. E.g., "Frosted glass tooltip with semi-transparent background and backdrop blur.">

## Component Tokens

CSS variables specific to this component. These extend the design system — they don't replace it.

` ` `css
:root {
  --<component>-bg: <value>;
  --<component>-text: <value>;
  --<component>-border: <value>;
  /* ... */
}

[data-theme="dark"] {
  --<component>-bg: <value>;
  --<component>-text: <value>;
  --<component>-border: <value>;
  /* ... */
}
` ` `

## Visual Spec

### <Part name> (e.g., Body, Arrow, Overlay)

| Property | Light Mode | Dark Mode |
|----------|-----------|-----------|
| Background | <value> | <value> |
| Text color | <value> | <value> |
| Font | <value> | <value> |
| Padding | <value> | <value> |
| Border radius | <value> | <value> |
| Border | <value> | <value> |
| Shadow | <value> | <value> |

<Repeat for each distinct visual part of the component.>

## Animation CSS

<If the component supports animation presets, document exact CSS for each.>

### <preset name>
` ` `css
/* Hidden state */
<property>: <value>;

/* Visible state */
<property>: <value>;

/* Transition */
transition: <value>;
` ` `

### Reduced Motion
` ` `css
@media (prefers-reduced-motion: reduce) {
  /* ... */
}
` ` `

## Technique Notes

<Document any non-obvious implementation techniques. E.g., "Arrow uses a rotated square with inner borders removed so only the outward-facing edges show the border." This section prevents future developers from re-discovering solutions the hard way.>

## Shared Component Strategy

| Component | Selector | Inputs | Notes |
|-----------|----------|--------|-------|
| <Name> | `<selector>` | <inputs with types and defaults> | <implementation notes — standalone, OnPush, ng-content, etc.> |

### Implementation notes

- <How the component wraps content — ng-content, template ref, etc.>
- <How show/hide is managed — CSS classes, Angular signals, etc.>
- <How theming works — CSS variables, no hardcoded colors>
- <Accessibility requirements — ARIA attributes, keyboard handling>

## Do / Don't

| Do | Don't |
|----|-------|
| <Specific positive guidance> | <Specific anti-pattern> |
```
