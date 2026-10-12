# About this demo

## Quick orientation

This demo is an architecture exercise, not a model popularity contest. Participants choose among deterministic code, Claude, Jev, and Needle 3 by examining task shape, output contract, deployment location, confidence handling, validation, and fallback.

Jev and Needle 3 are candidates whose capabilities and performance claims must be tested on the team's own workload. The worksheet produces hypotheses for an evaluation plan, not purchase or production approval.

## Decision process

Ask these questions in order:

1. **Are the rules complete and exact?** If yes, prefer deterministic code.
2. **Does the task require open-ended investigation, synthesis, planning, or code generation?** Claude is the natural candidate.
3. **Is the work a high-volume typed probabilistic decision from unstructured input?** Jev may be a candidate if it can return calibrated probabilities and abstain.
4. **Must structured extraction or tool selection run locally, offline, or on constrained hardware?** Needle 3 may be a candidate.
5. **What is the output type?** A model that cannot be constrained to the required schema is not a viable component.
6. **How will uncertainty be handled?** Define confidence, abstention, manual queue, or deterministic fallback before deployment.
7. **What deterministic checks remain possible?** Schema validation, allowlists, policy checks, compiler/tests, and range checks still apply around probabilistic components.
8. **What happens when the model is slow, unavailable, wrong, or out of distribution?** Name a safe fallback.

## Expected worksheet discussion

### Semantic version comparison

- **Choice:** deterministic code.
- **Why:** semantic version rules are exact and libraries already implement them.
- **Typed output:** comparison result or boolean.
- **Validation:** standard test vectors and property tests.
- **Fallback:** reject invalid input; no model needed.

### Route 50,000 daily alerts

- **Choice:** Jev candidate.
- **Why:** repeated typed classification at high volume with useful probabilities.
- **Typed output:** runbook route, confidence, optional reason code.
- **Validation:** held-out labelled alerts, calibration, per-route precision/recall, drift checks.
- **Fallback:** low-confidence alerts enter a safe human queue or deterministic default route.

### Investigate an unfamiliar multi-service latency regression

- **Choice:** Claude.
- **Why:** the task needs open-ended evidence gathering, hypothesis formation, and synthesis across systems.
- **Typed output:** evidence-backed findings and next checks.
- **Validation:** source citations, reproducible queries, human review, and runbook constraints.
- **Fallback:** manual incident process or narrower specialist investigations.

### Offline appliance tool selection

- **Choice:** Needle 3 candidate.
- **Why:** local, disconnected, constrained selection among 18 safe tools.
- **Typed output:** allowlisted tool name and arguments.
- **Validation:** grammar-constrained output, tool allowlist, argument schema, scenario evals.
- **Fallback:** abstain and ask the technician to select manually.

### Generate a Terraform module and tests

- **Choice:** Claude.
- **Why:** generation requires architecture interpretation, repository context, code, and tests.
- **Typed output:** repository diff and evidence.
- **Validation:** formatting, validation, tests, plan review, policy checks, and human review.
- **Fallback:** template or manual implementation.

### Extract fields from operator notes on an edge gateway

- **Choice:** Needle 3 candidate when local/offline execution is required. Deterministic parsing may still win for a fixed note format.
- **Typed output:** device, region, severity, and ticket ID schema.
- **Validation:** schema and range checks plus representative edge-note evals.
- **Fallback:** deterministic parser or manual entry for low confidence.

## Suggested live flow

1. Hide `expected-discussion.md` and assign one worksheet row per pair or small group.
2. Require every group to fill all columns, not just the model choice.
3. Ask groups to defend the fallback before discussing benchmarks.
4. Reveal the expected discussion and compare assumptions.
5. Challenge one answer by changing a constraint. For example, make operator notes strictly fixed-format and see whether deterministic code becomes better.
6. Finish by writing the smallest real benchmark the team would run before adopting a candidate.

## Expected exercise result

There is no universal “best model” answer. A correct result explains why the component fits the task, how its output is typed, where it runs, how uncertainty is handled, what deterministic validation surrounds it, and what safe path is used on failure.

The participant should leave with a routing rule that minimizes unnecessary model use. Exact rules stay in code. Open-ended engineering work stays with a general reasoning model. Specialized probabilistic or edge models are evaluated only where their operating shape creates measurable value.

## Common wrong turns

- Choosing the newest or fastest model without defining the output contract.
- Using a probabilistic model for exact semantic-version rules.
- Sending open-ended incident investigation to a narrow classifier.
- Treating vendor benchmark numbers as results on the team's data.
- Omitting abstention and routing every low-confidence result automatically.
- Validating only happy-path accuracy while ignoring calibration and operational failures.
- Forgetting that deterministic checks should still wrap model output.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| Participants do not know Jev or Needle 3 | The products are unfamiliar or evolving | Use the model cards as abstract classes: typed probabilistic automation and local constrained tool calling. Focus on architecture, not brand trivia. |
| The group debates benchmark claims | Claims are not verified for this workload | Mark them as vendor claims and return to the proposed local eval. |
| Every row is assigned to Claude | Decision criteria are too vague | Ask first whether exact code or a smaller typed model can meet the contract more cheaply and safely. |
| Every row is assigned to deterministic code | Uncertainty and unstructured input are being ignored | Ask how exact rules would cover unfamiliar evidence or natural-language variation. |
| No runtime is available | The exercise is discussion-based | Complete the worksheet and evaluation design without calling any external model. |

**Trainer fallback:** read one scenario at a time and use the eight decision questions as a group checklist. Reveal the expected choice only after the group names validation and fallback.

## Transfer to a real project

Pick one high-volume or edge task with measurable current cost. Establish a deterministic baseline, representative data, output schema, safety gate, abstention policy, and operational fallback. Benchmark accepted outcomes, calibration, latency, throughput, resource use, and failure handling. Keep the architecture reversible until real workload evidence supports the model choice.
