# Preliminary Theory Presentation Steps

**Duration:** approximately 20 minutes  
**Purpose:** establish a shared mental model before the live demos.

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

Introduce `/claude-api prompt-audit` as a maintenance check when moving repository guidance to a newer Opus model. In Claude Code, it can audit `CLAUDE.md`, `AGENTS.md`, skills, and other instructions against the target model. It reports findings with file locations and proposes a diff; it does not apply that diff. The goal is to remove dated or conflicting instructions while keeping project facts, C++ build commands, platform constraints, and necessary safeguards.

Typical findings: capitalized emphasis (`IMPORTANT`, `MUST`), rigid step-by-step procedures, reasoning scaffolding, duplicated rules, stale paths or commands, and instruction files that contradict each other.

**Workshop exercise:** participants run the audit command (`/claude-api prompt-audit CLAUDE.md`) directly on their team's own repository `CLAUDE.md`. (Use [Demo 00](demos/00-prompt-audit/README.md) as a fallback if a participant's repository does not yet have instruction files). Review one finding and its proposed edit: ask what failure the original rule prevented, whether that failure still occurs, and what check catches regressions. Keep project facts and MSVC build flags; prune token waste. Check that the command is available in the participants' Claude Code installation before the session.

Sources: [Anthropic's prompt audit guide](https://github.com/anthropics/skills/blob/main/skills/claude-api/shared/prompt-audit.md) and [Claude Platform cost guidance](https://platform.claude.com/docs/en/about-claude/models/optimizing-for-cost-and-intelligence).

## 3. RTK, Caveman, Ponytail, and Model Routing — 5 minutes

Present these as practical controls for cost, context, and engineering effort:

- **RTK:** reduces noisy command output before it reaches the model.
- **Caveman:** compresses communication while preserving technical facts.
- **Ponytail:** prefers the smallest correct implementation and one focused check.
- **Model routing:** sends routine work to cheaper or faster models and reserves stronger models for difficult reasoning.

Use the [numbered demos](demos/README.md) if customer code is unavailable. Demo 00 provides a realistic legacy C++ instruction file to audit with `/claude-api prompt-audit`. Demo 01 uses saved C++ test output to show Caveman; Demo 02 uses runnable C++ code and a regression test to show Ponytail; Demo 03 compares vague prompts with contracts in C++ and Go; Demo 04 demonstrates pure domain logic rules in C++ and Go; Demo 05 shows RTK context compression on noisy test runs; Demo 06 shows hooks; Demo 07 runs a ticket-to-PR loop with Opus planning and Sonnet implementing. All include pasteable instructions if skills are not installed.

Discuss four costs: tokens, latency, engineer attention, and verification effort. The cheapest model call is not always the cheapest verified outcome.

Audit old instructions before measuring cost on a new model: unnecessary tool rounds can distort the comparison. Measure any savings on the team's own tasks.

## 4. The Harness and Matt Pocock's Framing — 5 minutes

Explain that the model is only one component. Reliable performance comes from the surrounding engineering harness:

- Repository instructions and task contracts.
- Skills and reusable workflows.
- Build tools, tests, hooks, and CI.
- **Multi-repo local workspace:** The team's tasks touch 4–5 repositories. Keep repositories checked out locally side-by-side in the workspace. Claude reads files, greps symbols, and runs builds locally—preventing token waste from repetitive remote API fetching.
- **GitHub MCP & tool integrations:** (see detailed guide [GITHUB-MCP.md](GITHUB-MCP.md)):
  - *Capabilities:* `get_pull_request`, `create_pull_request`, `add_issue_comment`, `get_issue`, `get_pull_request_status`.
  - *Role:* Dedicated to the PR and issue lifecycle (fetching Jira/GitHub issue requirements, tracking cross-repo PR status, and publishing reviewed PR diffs with verification evidence).
- Feedback loops with observable evidence.

Use Matt Pocock's material only after selecting and verifying the exact source. Connect the harness to the demos that follow.

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
