# Shared Patterns Template

Use this template to document cross-flow shared behaviors. These are **behaviors**, not implementation details — they describe *what* the logic does and *which flows use it*, so the dev-plan and implementing agents know what to extract as shared code.

Generated after Phase 2 by analyzing all designed flows for logic that repeats across multiple flows.

---

```markdown
# Shared Patterns — <System Name>

Behaviors that appear across multiple flows. During implementation, these should be extracted into shared services or utilities to avoid duplication.

## <Pattern Name>

- **What it does**: <One-sentence description of the behavior>
- **Used by**: <List of flow docs that use this pattern>
- **Lifecycle**:
  1. <Step-by-step description of the full behavior, including edge cases>
  2. ...
- **Edge cases**:
  - <Notable edge case and how it's handled>

## <Pattern Name>

- **What it does**: ...
- **Used by**: ...
- **Lifecycle**: ...
- **Edge cases**: ...
```

---

## What qualifies as a shared pattern

A behavior qualifies if:
- It appears in **2 or more flows** with the same logic
- It involves **multiple steps** (not a single function call)
- Getting it wrong in one flow but right in another would cause bugs

Examples:
- Token resolution lifecycle (cache lookup → refresh → retry on stale → race condition handling)
- Encryption/decryption pattern (what gets encrypted, when, key source)
- Session verification (cookie → Redis → userId attachment)
- Authentication guard logic (API key hash → lookup → user resolution)

## What does NOT qualify

- Single-step operations (e.g., "hash a password") — too simple to document as a pattern
- Logic that only appears in one flow — not shared
- Implementation choices (e.g., "use argon2id") — belongs in design.md
