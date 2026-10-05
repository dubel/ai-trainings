# Demo 04 Prompts

## Step A — Test Planning (Plan Mode)

Paste into Claude Code:

```text
Inspect `task.md` and `CLAUDE.md`.
Review the current implementation and test suite in `cpp/` (or `go/`).
Formulate a complete test plan covering all edge cases for RATE_LIMITED (attempts 1 to 5, negative/zero attempts, and existing error codes).
Do NOT modify production files yet. Output the plan and test cases first for review.
```

## Step B — Bounded Implementation (Ponytail Rule)

Paste into Claude Code after approving the test plan:

```text
Apply the implementation according to `task.md` and our repository rules in `CLAUDE.md`.
Use the simplest possible arithmetic calculation (Ponytail principle: YAGNI, no unneeded abstractions or loops).
Update the test suite, run the compiler/test commands, and verify all tests pass without warnings.
```
