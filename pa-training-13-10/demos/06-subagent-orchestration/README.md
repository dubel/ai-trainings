# Exercise 06 — Subagent orchestration

## Goal

Run three bounded, read-only investigations without flooding the main conversation, then synthesize their evidence.

## Agents

- `inventory-reviewer`: service topology, ownership, and touched resources.
- `security-reviewer`: IAM, network exposure, and secret-handling risks.
- `verification-reviewer`: tests, policy checks, and rollback evidence.

The agent definitions live under `.claude/agents/` so they can be reviewed and versioned with the project.

## Orchestration prompt

```text
Review fixtures/change-request.md.
Run the inventory-reviewer, security-reviewer, and verification-reviewer in parallel.
Give every reviewer only the fixture files it needs and keep all work read-only.
Require this return schema: Finding, Evidence, Confidence, Missing evidence, Next check.
After they finish, synthesize one decision table. Resolve contradictions explicitly.
Do not edit files and do not call external systems.
```

You can guarantee one custom subagent invocation by selecting it with an `@` mention in Claude Code.

## Debrief

- Which file reads stayed out of the main context?
- Did the workers duplicate work?
- Could one worker have answered the entire question more cheaply?
- Which conclusion required full-conversation context and belonged to the main agent?

## Use it in your project

Delegate high-volume research, log inspection, or specialized review when the task has a crisp return value. Give each worker non-overlapping ownership, the smallest tool set, and a common evidence schema. Keep integration and shared-file edits with one owner.

