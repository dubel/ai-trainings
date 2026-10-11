# Exercise 02 — Global and local rules

## Goal

Turn one overloaded instruction file into concise global guidance and path-scoped rules.

## Task

1. Read `starter/CLAUDE.md`.
2. Keep only facts required across the whole repository in the root file.
3. Move Terraform guidance to a rule whose `paths` match `infra/**/*.tf`.
4. Move Kubernetes guidance to a rule whose `paths` match `deploy/**/*.yaml` and `deploy/**/*.yml`.
5. Delete instructions that repeat formatter or CI behavior.
6. Compare the result with `solution/`.

## Review questions

- Which rule expresses a repository surprise rather than a preference?
- Which instruction can a tool enforce without spending model context?
- What happens when a root and nested instruction conflict?
- Which content is a reusable procedure and should become a skill?

## Use it in your project

Collect repeated corrections from code review and recent Claude sessions. Keep commands, architecture, and shared invariants in the root. Put exceptions next to the directory or file type they govern. Use hooks or CI for actions that must happen every time.

