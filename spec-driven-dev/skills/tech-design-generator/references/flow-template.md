# Flow Template

Use this template when designing individual flows.

---

```markdown
# Flow: <Flow Name>

## Trigger
<What initiates this flow: user action, API call, scheduled job, event, etc.>

## Components Involved
<List of components that participate in this flow>

<ASCII box diagram showing data flow between components. Use box-drawing characters for rectangles and arrows for flow direction.>

Example (simple):
```
┌──────┐     ┌────────┐     ┌─────────┐     ┌────────────┐
│ User │────▶│ nhi-ui │────▶│ nhi-api │────▶│ PostgreSQL │
└──────┘     └────────┘     └─────────┘     └────────────┘
```

Example (complex, multi-layer):
```
┌──────┐     ┌────────┐     ┌─────────┐     ┌─────────┐
│ User │────▶│ nhi-ui │────▶│ nhi-api │────▶│  Redis  │ (access token cache)
└──────┘     └────────┘     └─────────┘     └─────────┘
                                 │
                                 ▼
                            ┌────────────┐
                            │ PostgreSQL │ (context note)
                            └────────────┘
```

## Description
<Narrative walkthrough of the flow from trigger to completion. Be specific about what each component does and what data moves between them.>

## Steps

1. **<Actor/Component>**: <what it does>
   - Input: <what it receives>
   - Output: <what it produces/sends>
   - Side effects: <DB writes, events emitted, etc.>

2. **<Actor/Component>**: <what it does>
   ...

## Error Handling

| Error Scenario | Where it occurs | How it's handled | User impact |
|---------------|-----------------|------------------|-------------|
| <what can go wrong> | <which step/component> | <retry, fallback, error response> | <what the user sees> |

## Edge Cases
- <Notable edge case and how it's handled>

```

---

## Referencing Shared Patterns

When a step's logic matches a shared pattern from `shared-patterns.md`, **do not inline the full logic**. Instead, reference the pattern:

```markdown
7. **nhi-api**: Resolves a valid access token via the [Jira Access Token Resolution](../shared-patterns.md#jira-access-token-resolution) shared pattern
   - Input: userId, jira_connection from step 6
   - Output: valid access token, or error if connection is dead
```

The shared pattern is the single source of truth for that behavior. Flow docs describe *that* the step happens and what it inputs/outputs — not *how* it works internally. This avoids duplication and keeps flows in sync when a pattern changes.
