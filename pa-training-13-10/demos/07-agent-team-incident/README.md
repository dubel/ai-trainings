# Exercise 07 — Agent team incident investigation

## Goal

Use an agent team for an incident with competing hypotheses and evidence spread across Kubernetes, infrastructure, and observability.

Agent teams are experimental and disabled by default. Use a training environment and confirm your installed Claude Code version supports the feature.

## Enable for the training session

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

## Team prompt

Paste `team-prompt.md` into Claude Code. The lead should create a shared task list and spawn three teammates:

- Kubernetes investigator;
- infrastructure investigator;
- observability investigator.

Each teammate owns one evidence file. They should message one another when timestamps or conclusions conflict. Only the lead writes `incident-summary.md`.

## Success criteria

- Every claim cites fixture evidence and a timestamp.
- The team distinguishes symptom, contributing factor, and root cause.
- Teammates share at least one cross-layer question.
- The lead lists missing production evidence and safe next checks.
- No teammate edits a shared file or proposes a production mutation.

## Use it in your project

Agent teams fit investigations with genuinely independent hypotheses, separate modules, or cross-layer ownership. Define file ownership and a single integration owner before spawning. Use a single session or subagents for serial work, same-file edits, or tasks that need one shared evolving context.

