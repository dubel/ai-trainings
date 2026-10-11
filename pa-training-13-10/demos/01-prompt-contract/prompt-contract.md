Goal: implement every requirement in `task.md` so the focused test suite passes.

Context:
- Read `task.md`, `src/deploy-gate.mjs`, and `test/deploy-gate.test.mjs`.
- The tests are the executable examples, but `task.md` is the policy authority.

Boundaries:
- Preserve the exported function name and input shape.
- Change only `src/deploy-gate.mjs` unless a test is demonstrably wrong.
- Add no dependency, I/O, logging, retry, or refactor.
- Stop and ask if requirements conflict.

Evidence:
- Plan before editing.
- Run `node --test test/deploy-gate.test.mjs` after the change.
- Report the exact files changed, the test result, and any unverified assumption.

