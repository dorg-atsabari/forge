# Component UX Brief Template

Use this template when outputting a UX brief for a **single reusable UI component** after the user approves a wireframe.

---

```markdown
# UX Brief — <Component Name>

## Product Context

<What is this component? Where is it used across the app? What problem does it solve?>

## Behavior

### Trigger
- **Show**: <How the component appears — hover, click, focus, programmatic>
- **Hide**: <How the component disappears — blur, escape, outside click, timeout>

### Timing
- **Show delay**: <Delay before component appears, with rationale>
- **Hide grace period**: <Delay before component hides, with rationale>
- **Animation duration**: <Show and hide durations with easing>

### Positioning
<If the component supports multiple positions, list them with defaults>

### Content
<How the component handles different content lengths — wrapping, truncation, max-width>

## API Surface

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| <name> | <type> | <default> | <what it controls> |

| Output | Type | Description |
|--------|------|-------------|
| <name> | <type> | <when it fires> |

## Animation Presets

<If the component supports multiple animations, list each with show/hide transforms>

| Preset | Show | Hide | Character |
|--------|------|------|-----------|
| <name> | <transform description> | <transform description> | <one-word feel> |

## Interaction Patterns

| Trigger Type | Hover | Focus | Keyboard | Long Content |
|-------------|-------|-------|----------|-------------|
| <context> | <behavior> | <behavior> | <behavior> | <behavior> |

## Variants & States

| State | Trigger | What the user sees |
|-------|---------|-------------------|
| <state> | <what causes it> | <description> |

## Accessibility

- **ARIA**: <Which attributes — role, aria-describedby, aria-expanded, etc.>
- **Keyboard**: <Tab, Escape, arrow keys — what does what>
- **Reduced motion**: <Behavior when prefers-reduced-motion is set>
- **Screen readers**: <How content is announced>

## Composition

<How this component interacts with other components — z-index considerations, nesting behavior, overflow clipping concerns>

## UX Principles (ranked)

1. <Most important UX principle for this component>
2. <Second>
3. <Third>

## Do / Don't

| Do | Don't |
|----|-------|
| <Specific guidance> | <Anti-pattern> |
```