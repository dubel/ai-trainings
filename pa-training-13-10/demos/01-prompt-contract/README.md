# Exercise 01 — Prompt contract

## Goal

Repair a small deployment gate while comparing a vague request with a testable engineering contract.

## Start

```bash
node --test test/deploy-gate.test.mjs
```

The starter intentionally fails production approval and destructive-plan cases.

## Run A: vague prompt

Start a clean Claude Code session and paste `prompt-vague.md`. Before allowing edits, record:

- assumptions Claude made;
- files it proposes to change;
- tests it plans to run;
- extra behavior it invents.

## Run B: contract

Start a fresh session and paste `prompt-contract.md`. Compare the plan and final evidence with Run A.

## Debrief

- Did the goal name an observable end state?
- Did context point to the smallest useful evidence?
- Did boundaries prevent unrelated refactoring?
- Did Claude show the command output that supports its completion claim?

## Use it in your project

Choose one policy decision with a fast test: a Terraform plan gate, Kubernetes rollout check, image-signing policy, or CI promotion rule. Supply its implementation, current tests, immutable interfaces, and the exact proof command. Keep product decisions out of the implementation prompt.

