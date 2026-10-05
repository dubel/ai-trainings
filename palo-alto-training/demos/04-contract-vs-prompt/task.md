# Task: Change Risk Evaluation in Deployment Gate

Extend the deployment gate evaluation to account for change risk levels.

## Requirements

1. Introduce change risk levels: `Low`, `Medium`, and `High`.
2. Add `architecture_approved` flag.
3. Behavior:
   - For `Low` and `Medium` risk: no additional approval needed.
   - For `High` risk in `Production`: requires `architecture_approved == true` in addition to normal `release_approved`. If missing, reject with reason `"architecture-not-approved"`.
   - For `High` risk outside `Production` (Staging, Development): architecture approval is NOT required.
4. Input validation:
   - Invalid or unrecognized values must be rejected cleanly.
5. Invariants:
   - Preserve existing public decision shape: `{allowed: bool, reason: string}`.
   - Do NOT add heap allocations, logging frameworks, background threads, or external dependencies.
   - Keep the evaluation function strictly pure and deterministic.
