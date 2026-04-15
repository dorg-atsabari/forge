# API Contract Template

Use this template for the API contract — a consolidated endpoint reference extracted from the flow designs. Generated after Phase 2 when all endpoints are defined.

---

```markdown
# API Contract — <System Name>

Consolidated endpoint reference. Grouped by controller/domain. Source of truth is the flow docs — this file is a summary for quick lookup.

## <Controller/Domain Name> (`<route prefix>`)

| Method | Path | Auth | Request Body | Response (success) | Key Errors |
|--------|------|------|--------------|--------------------|------------|
| POST | /api/auth/login | None | `{ email, password }` | 200 `{ id, email }` + session cookie | 401 invalid credentials |
| ... | ... | ... | ... | ... | ... |

## <Controller/Domain Name> (`<route prefix>`)

| Method | Path | Auth | Request Body | Response (success) | Key Errors |
|--------|------|------|--------------|--------------------|------------|
| ... | ... | ... | ... | ... | ... |
```
