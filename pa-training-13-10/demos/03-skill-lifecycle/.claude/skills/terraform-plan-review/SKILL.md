---
name: terraform-plan-review
description: Reviews Terraform plan output for destructive or high-risk infrastructure changes. Use when the user asks to assess a Terraform plan, summarize infrastructure risk, or prepare plan evidence for review. Do not use for Kubernetes manifests, application code, or running terraform apply.
disable-model-invocation: true
allowed-tools: Read Grep
---

# Terraform plan review

Read `references/risk-policy.md` before evaluating the supplied plan.

## Method

1. Identify resource adds, changes, replacements, and destroys from the supplied plan output.
2. Map each risky change to the policy using exact resource evidence.
3. Classify the plan as `LOW`, `MEDIUM`, `HIGH`, or `BLOCKED`.
4. State missing evidence. Never infer an unseen plan or environment.
5. Return exactly these headings:
   - `Risk class`
   - `Blocking changes`
   - `Evidence`
   - `Required human decisions`
   - `Next verification command`

## Gotchas

- A `-/+` replacement includes a destroy even when the resource keeps the same logical name.
- A saved text fixture is evidence for the exercise only. Never describe it as a live plan.

