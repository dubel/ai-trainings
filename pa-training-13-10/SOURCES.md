# Sources and caveats

Last reviewed: 9 October 2026.

Product behavior changes quickly. Recheck the official Claude Code documentation and the installed version before delivery.

## Claude Code

- [Extend Claude Code](https://code.claude.com/docs/en/features-overview) — choosing between `CLAUDE.md`, rules, skills, hooks, MCP, subagents, and agent teams.
- [How Claude remembers your project](https://code.claude.com/docs/en/memory) — instruction scopes, `AGENTS.md`, and path-scoped rules.
- [Extend Claude with skills](https://code.claude.com/docs/en/skills) — skill structure, discovery, sharing, invocation control, and evaluation.
- [Create a Claude Code plugin](https://code.claude.com/docs/en/plugins/create) — plugin layout and validation.
- [Create a marketplace](https://code.claude.com/docs/en/plugins/create-marketplace) — team catalogs hosted in a Git repository.
- [Automate actions with hooks](https://code.claude.com/docs/en/hooks-guide) — lifecycle events and blocking `PreToolUse` hooks.
- [Configure permissions](https://code.claude.com/docs/en/permissions) — `allow`, `ask`, and `deny` rules, including `Read(.env)`.
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) — isolated context, tool restrictions, background execution, and reusable roles.
- [Agent teams](https://code.claude.com/docs/en/agent-teams) — shared tasks, peer messaging, use cases, cost, and current experimental status.
- [Keep Claude working toward a goal](https://code.claude.com/docs/en/goal) — `/goal`, evaluator behavior, completion conditions, and limits.
- [Run prompts on a schedule](https://code.claude.com/docs/en/scheduled-tasks) — `/loop`, intervals, session lifetime, and scheduling alternatives.

## Specialized models

- [TypeSafe AI: Introducing System One Models and Jev](https://typesafe.ai/blog/introducing-system-one-models-and-jev) — typed probabilistic decisions and vendor benchmarks. Jev is early access; performance and cost figures remain vendor claims.
- [Cactus Compute: Needle 3](https://www.cactuscompute.com/needle) — local tool calling and structured extraction for constrained devices. Size, speed, and benchmark figures remain vendor claims.

## Context and implementation-effort tools

- [RTK](https://github.com/rtk-ai/rtk) — filters command output before it reaches the model. RTK's percentages describe terminal output reduction, not total task cost.
- [Caveman](https://github.com/JuliusBrussee/caveman) — shortens prose output while preserving technical material. Reported savings come from the project authors.
- [Ponytail](https://github.com/DietrichGebert/ponytail) — encourages YAGNI, standard-library use, and smaller diffs. Simplicity never overrides acceptance criteria.

## Training design notes

- Adoption levels in this deck are a workshop model, not an industry standard.
- The security exercise uses permissions and hooks for defense in depth. The strongest secret boundary remains process isolation: do not mount or copy a secret into the agent's workspace when the agent must never read it.
- Agent teams consume more tokens and add coordination overhead. Use them only when workstreams can progress independently and need peer communication.

