# Demo 01 — Caveman: concise diagnostics without evidence loss

**Goal:** reduce status-message length while preserving cause, exact test evidence, safe action, verification, and untested targets. This is a communication style, not a built-in Claude command.

1. Open [input.md](input.md). It contains the broken predicate and a saved local test result.
2. In a fresh chat, provide the input and [prompt.md](prompt.md). Save the normal response.
3. In another fresh chat, provide the same input and prompt, plus [caveman-instructions.md](caveman-instructions.md). If the custom skill is installed, invoking it can replace the pasted instructions.
4. Compare both answers with [expected.md](expected.md). The shorter answer fails if it drops the target, either failure, the fix, the verification step, or unrun platforms.

If live model access is unavailable, show the two saved responses in `expected.md`. They are illustrative, not recorded model output. Do not claim measured token savings from this small comparison.
