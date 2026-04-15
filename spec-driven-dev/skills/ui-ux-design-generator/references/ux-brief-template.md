# UX Brief Template

Use this template when outputting a UX brief after the user approves a wireframe.

---

```markdown
# UX Brief — <Feature/Screen Name>

## Product Context

<What is this feature? Who uses it? What problem does it solve?>

## App Layout

<Describe the spatial layout — panels, regions, their sizes and relationships.>

```
<ASCII diagram of the layout with dimensions>
```

## User Flows

### Flow 1: <Name>
1. **Entry point:** <Where the user starts>
2. **Action:** <What they do>
3. **System response:** <What happens>
4. **End state:** <Where they land>

### Flow 2: <Name>
...

## Interaction Patterns

| Component | Click | Hover | Keyboard | Long Content |
|-----------|-------|-------|----------|-------------|
| <name> | <behavior> | <behavior> | <behavior> | <behavior> |

## States

| State | Trigger | What the user sees | How to recover |
|-------|---------|-------------------|----------------|
| Empty | No data yet | <description> | <action> |
| Loading | Operation in progress | <description> | N/A |
| Error | Operation failed | <description> | <action> |
| Disconnected | Lost connection | <description> | <action> |
| Success | Operation completed | <description> | N/A |

## Real-Time Behavior

<How does streaming/live data appear? Token-by-token? Chunk updates? What animates?>

## Navigation & Information Architecture

- <How do users move between views?>
- <What's the tab/focus order?>
- <What's always visible vs. on-demand?>

## Accessibility

- <Keyboard navigation approach>
- <Screen reader considerations>
- <Reduced motion behavior>
- <Minimum contrast requirements>

## UX Principles (ranked)

1. <Most important UX principle for this feature>
2. <Second>
3. <Third>

## Do / Don't

| Do | Don't |
|----|-------|
| <Specific guidance> | <Anti-pattern> |

## Open Questions

- <Any UX decisions that need user input or testing>
```
