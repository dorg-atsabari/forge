# Step XX: <Title>

## Goal
<What this step accomplishes — one sentence>

## Why This Step
<Brief context: why this is needed, what it unblocks>

## Changes

### <File or module> — `path/to/file.ts`

<What to do>

```ts
// Short code example showing the key shape, imports, and patterns.
// Enough to convey the approach — not a full implementation dump.
```

### <File or module> — `path/to/another-file.ts`

<What to do>

```ts
// ...
```

## Folder Structure
<!-- Include only when the step introduces new directories or enough new files that spatial context helps.
     If Changes already lists 2-3 files and no new directories, skip this section — it would just duplicate Changes.
     Mark new items with +, updated items with (update). -->
```
path/to/parent/
├── new-folder/                    +
│   ├── new-file.ts                +
│   └── existing-file.ts           (update)
```

## Acceptance Criteria
- [ ] <How you know this step is done>
- [ ] <Tests pass>
- [ ] System builds and existing tests pass

## Tests

<!-- Show concrete test cases with setup (mocks, test module) and assertions.
     If this step has nothing to test (e.g., migration-only), state that and explain why. -->

### `path/to/file.spec.ts`

```ts
describe('Component', () => {
  // Show mock setup, test module config, and key test cases
  it('should do the expected thing', () => {
    // assertion
  });
});
```

## Notes
<Any gotchas, edge cases, or decisions specific to this step>
