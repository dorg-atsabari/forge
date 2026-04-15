# Example: A completed plan for adding user authentication

This shows what a well-structured plan looks like in practice.

---

## README.md

```markdown
# Implementation Plan: User Authentication

## Overview
Add JWT-based authentication to the API so that endpoints can be protected and users can sign up, log in, and access their own data.

## Status

| Step | Description | Status |
|------|-------------|--------|
| [01](step-01-user-model.md) | Create user model and migration | done |
| [02](step-02-auth-endpoints.md) | Implement signup and login endpoints | done |
| [03](step-03-auth-middleware.md) | Add JWT middleware to protected routes | in-progress |

## Current State
Users can sign up and log in. Tokens are issued but not yet validated on protected routes. All existing endpoints still work without auth (backwards compatible).

## Decisions & Notes
- Chose JWT over session cookies — API-first, no server-side state needed
- Password hashing with bcrypt (cost factor 12)
- Tokens expire after 24h, no refresh tokens in v1
```

---

## step-01-user-model.md

```markdown
# Step 01: User Model and Migration

## Goal
Create the users table and ORM model so auth endpoints have something to read/write.

## Why This Step
Everything else depends on having a user record — this is the foundation.

## Changes
- `src/models/user.ts`: Create User model with id, email, password_hash, created_at
- `src/migrations/001_create_users.ts`: Migration to create users table
- `src/models/index.ts`: Export the new model

## Acceptance Criteria
- [ ] Migration runs and creates users table
- [ ] User model can create and query records
- [ ] Existing tests still pass — no changes to other models
- [ ] System builds and existing tests pass

## Notes
- email has a unique constraint
- password_hash stores bcrypt output, never plaintext
```

---

## step-02-auth-endpoints.md

```markdown
# Step 02: Signup and Login Endpoints

## Goal
Users can create an account and receive a JWT token.

## Why This Step
Provides the entry point for authentication — without this, there are no tokens to validate.

## Changes
- `src/routes/auth.ts`: POST /auth/signup (create user, return token), POST /auth/login (verify credentials, return token)
- `src/utils/jwt.ts`: Helper to sign and verify JWT tokens
- `tests/auth.test.ts`: Tests for signup, login, duplicate email, wrong password

## Acceptance Criteria
- [ ] POST /auth/signup creates user and returns 201 with token
- [ ] POST /auth/login returns 200 with token for valid credentials
- [ ] POST /auth/login returns 401 for invalid credentials
- [ ] Duplicate email returns 409
- [ ] System builds and existing tests pass

## Notes
- Token payload: { userId, email, iat, exp }
- Existing routes are unaffected — no middleware yet
```

---

## step-03-auth-middleware.md

```markdown
# Step 03: Auth Middleware on Protected Routes

## Goal
Protected endpoints require a valid JWT token in the Authorization header.

## Why This Step
This is what actually makes auth useful — without it, tokens are issued but never checked.

## Changes
- `src/middleware/auth.ts`: Middleware that extracts and verifies JWT from Bearer token
- `src/routes/items.ts`: Apply auth middleware to CRUD endpoints
- `tests/auth-middleware.test.ts`: Tests for missing token, invalid token, expired token, valid token

## Acceptance Criteria
- [ ] Requests without token get 401
- [ ] Requests with invalid token get 401
- [ ] Requests with valid token proceed normally
- [ ] Public routes (signup, login) remain accessible
- [ ] System builds and existing tests pass

## Notes
- Middleware attaches decoded user to request object for downstream use
- Health check endpoint stays public
```
