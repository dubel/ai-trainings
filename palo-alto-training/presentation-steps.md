# Preliminary Theory Presentation Steps

**Duration:** approximately 20 minutes  
**Purpose:** establish a shared mental model before the practical C++ task.

## 1. AI Adoption Levels — 3 minutes

Show adoption as a progression in the scope of delegated decisions:

1. **Prompting — answer:** the human asks and evaluates each response.
2. **Assisted coding — edit:** the model prepares a bounded code change.
3. **Agentic coding — task:** the agent executes a complete engineering task.
4. **Spec driven — contract:** the agent implements an explicit specification and acceptance criteria.
5. **Bounded autonomy — process:** the agent handles part of a recurring process within defined permissions and guardrails.

The level is process-specific. A team can use bounded autonomy for test generation while remaining at assisted coding for security-sensitive changes.

This is a workshop model, not an industry standard. Maturity comes from a repeatable process, controlled decision scope, and evidence—not from purchasing access to a model.

## 2. Claude 101 — 4 minutes

Explain the minimum needed to work effectively with Claude:

- Claude produces probable answers, not guaranteed truth.
- Context quality directly affects output quality.
- Repository instructions should live in `CLAUDE.md` or `AGENTS.md`.
- Effective work follows a loop: understand, plan, change, test, challenge, repeat.
- Large repositories require focused context rather than loading everything.

## 3. RTK, Caveman, Ponytail, and Model Routing — 5 minutes

Present these as practical controls for cost, context, and engineering effort:

- **RTK:** reduces noisy command output before it reaches the model.
- **Caveman:** compresses communication while preserving technical facts.
- **Ponytail:** prefers the smallest correct implementation and one focused check.
- **Model routing:** sends routine work to cheaper or faster models and reserves stronger models for difficult reasoning.

Discuss four costs: tokens, latency, engineer attention, and verification effort. The cheapest model call is not always the cheapest verified outcome.

## 4. The Harness and Matt Pocock's Framing — 5 minutes

Explain that the model is only one component. Reliable performance comes from the surrounding engineering harness:

- Repository instructions and task contracts.
- Skills and reusable workflows.
- Build tools, tests, hooks, and CI.
- Jira, documentation, and repository integrations.
- Feedback loops with observable evidence.

Use Matt Pocock's material only after selecting and verifying the exact source. Connect the harness directly to the practical C++ exercise.

## 5. System One Models and Jev — 3 minutes

Introduce Jev as TypeSafe AI's early-access System One Model for fast, structured decisions:

- It accepts unstructured program state.
- It returns predefined, type-safe decisions with calibrated probabilities.
- It produces outputs in parallel instead of generating text token by token.
- Its target use cases include classification, routing, scoring, extraction, branching, verification, and guardrails.

Position it beside model routing: Claude handles open-ended reasoning and code generation, while Jev targets high-volume decisions that software must consume directly.

Treat speed, cost, and reliability numbers as vendor claims from an early-access product. Use them to explain the model category rather than as independently verified benchmarks.

Source: [Introducing System One Models & Jev](https://typesafe.ai/blog/introducing-system-one-models-and-jev)

## Narrative

The sequence should answer five questions:

1. Where are we in AI adoption?
2. How does Claude actually behave?
3. How do we control cost and unnecessary work?
4. What system makes model output reliable?
5. When should software use a structured decision model?

## Items to Confirm

- Select the exact Matt Pocock article, talk, or example.
- Decide whether model routing will be demonstrated live or explained conceptually.
- Decide whether Jev will be a future-looking example or a live demonstration.
