# Exercise 05 — Sensitive-file guard

## Goal

Use defense in depth to stop Claude Code from reading or editing common secret files.

## Layers in the sample

1. `.claude/settings.json` denies built-in reads and edits for `.env`, `secrets/`, and private-key files.
2. A `PreToolUse` hook inspects Read, Edit, Write, Bash, and PowerShell requests before execution.
3. `scripts/test-hook.mjs` proves representative safe and blocked inputs.

Run the test:

```bash
node scripts/test-hook.mjs
```

## Important boundary

Permission patterns and hooks protect normal Claude Code tool paths. A command parser cannot reliably identify every obfuscated way to read a secret. When the requirement is “the agent must never read this value,” do not place the value in the agent's filesystem or environment. Use a sandbox, a separate identity, short-lived scoped credentials, or redacted fixtures.

## Exercise

1. Add a nested `.env.production` case to the test table.
2. Add a safe `.env.example` case.
3. Add a Windows-style path.
4. Explain why `CLAUDE.md` alone cannot enforce the boundary.
5. Name one operating-system or container boundary for your environment.

## Use it in your project

Inventory secret paths and credential sources. Deploy organization-level deny rules where possible, keep a repository hook for fast feedback, and run agents in a workspace that contains only the data they need.

