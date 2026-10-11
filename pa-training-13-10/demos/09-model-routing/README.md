# Exercise 09 — Model routing: Claude, Jev, Needle 3, or code

## Goal

Choose a model class based on task shape rather than novelty.

## Model cards

- Claude: open-ended investigation, synthesis, planning, and code generation.
- Jev: typed probabilistic decisions from unstructured state, optimized for high-volume software automation. It is early access; validate vendor claims independently.
- Needle 3: local structured extraction and tool selection on constrained devices. Its size, speed, and benchmark numbers are vendor claims.
- Deterministic code: known rules with complete inputs and an exact algorithm.

## Exercise

Fill `routing-worksheet.md`. For every task, choose one option and state:

1. required output type;
2. latency and deployment location;
3. confidence or abstention policy;
4. deterministic validation;
5. fallback path.

Compare with `expected-discussion.md` after the group discussion.

## Use it in your project

Choose one high-volume routing, scoring, extraction, or offline tool-selection task. Record a deterministic baseline and representative eval set. Compare accepted outcomes, calibration, latency, and operational failure handling. Do not route an ambiguous task to a specialized model simply because it is faster.

