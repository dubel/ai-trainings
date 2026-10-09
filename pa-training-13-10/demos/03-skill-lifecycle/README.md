# Exercise 03 — Skill lifecycle

## Goal

Evaluate a project skill that reviews Terraform plan summaries and improve it only from observed failures.

## Inspect

- `.claude/skills/terraform-plan-review/SKILL.md` contains the workflow.
- `.claude/skills/terraform-plan-review/references/risk-policy.md` contains the policy.
- `fixtures/plan-destructive.txt` is the positive case.
- `eval-cases.md` defines positive, negative, and edge prompts.

## Exercise

1. Read only the frontmatter description. Predict when Claude should load the skill.
2. Run the positive prompt and check the required output fields.
3. Run the negative prompt. The skill should stay silent.
4. Run the edge prompt. The result must state uncertainty rather than inventing plan detail.
5. Add a gotcha only if an actual output violates the rubric.

## Maintenance rule

A good skill has an owner, a trigger, a versioned policy source, positive and negative evals, and a small set of observed gotchas. Do not turn it into a copy of the whole platform handbook.

## Use it in your project

Replace the fixture with your plan format and link to the policy file the team already reviews. Include approved read-only commands and the evidence format expected in a pull request. Keep credentials, environment selection, and apply permission outside the skill.

