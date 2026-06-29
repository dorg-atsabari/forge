---
name: commit
description: "Analyze all changes in the working tree and create a well-structured conventional commit. Use when the user wants to commit their changes, stage and commit, or asks to create a git commit."
allowed-tools: Bash(git *)
---

# Commit

Analyze all changes in the working tree and create a well-structured commit.

## Steps

### 1. Gather context

Run these commands in parallel:

- `git status` — see all untracked and modified files. **Never** use the `-uall` flag.
- `git diff` — see unstaged changes.
- `git diff --cached` — see staged changes.
- `git log --oneline -5` — see recent commit message style.

If the branch has diverged from main, also run:

- `git diff origin/main...HEAD` — all changes since diverging from main.
- `git log origin/main..HEAD --oneline` — commits since diverging from main.

### 2. Check for changes

If there are no changes (no untracked files, no modifications, no staged changes), say so and **stop**. Do not create an empty commit.

### 3. Analyze changes

Review ALL changes (staged, unstaged, and untracked) and determine:

- **Type** using Conventional Commits: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `style`, `perf`, `ci`, `build`
- **Scope** (optional) — in parentheses if the change is localized (e.g., `feat(auth)`, `fix(api)`)
- **Description** — imperative mood, lowercase, no period
- If the change spans multiple types, use the most significant one

### 4. Stage files

Stage all relevant files **by name**. Rules:

- Do **NOT** use `git add -A` or `git add .`
- Do **NOT** stage files that contain secrets (`.env`, credentials, API keys, tokens)
- If you encounter files that look like they contain secrets, warn the user and skip them

### 5. Create the commit

Use this format:

```
<type>[optional scope]: <description>

[optional body explaining WHY, not WHAT]

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

Pass the message via HEREDOC:

```bash
git commit -m "$(cat <<'EOF'
<type>[optional scope]: <description>

<optional body>

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
EOF
)"
```

### 6. Verify

Run `git status` after the commit to verify success.

## Rules

- Do **NOT** push to remote unless explicitly asked.
- Do **NOT** amend previous commits. Always create new commits.
- If a pre-commit hook fails, fix the issue and create a **NEW** commit (do not amend).
- If `$ARGUMENTS` is provided, use it as context for the commit message but still analyze the actual changes to ensure accuracy.
