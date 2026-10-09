# Expected discussion

- Semantic version comparison: deterministic code. The rules are complete and exact.
- High-volume alert routing: Jev candidate. Require typed routes, probabilities, calibration tests, and a safe queue for low confidence.
- Multi-service regression: Claude. The task requires open-ended evidence gathering and synthesis.
- Offline appliance tool selection: Needle 3 candidate. Keep a tool allowlist, grammar-constrained output, confidence gate, and manual fallback.
- Terraform module generation: Claude, with repository rules, tests, and human review.
- Edge extraction: Needle 3 candidate when the task must run locally; deterministic code may still win if the input format is fixed.

These are architecture hypotheses, not product approvals. Benchmark the actual workload.

