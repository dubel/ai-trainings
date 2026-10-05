# Reading list for developers (claude.dev blog)

Short list of posts that support the workshop. Takeaways are from summaries of each post; read the originals before quoting them.

| Post | Takeaway for this team | Workshop link |
|---|---|---|
| [Using Claude Code: Spending your effort](https://claude.dev/blog/spending-your-effort/) | Match effort to the step: low for fast iteration, medium for normal feature work, high for verification and edge cases, max only for autonomous or security-critical work. Interview-then-implement: give a spec, let Claude interview you, implement at low effort, verify at high effort. Change it mid-session with `/effort`. | Demo 07 steps 2–4 |
| [Lessons from building Claude Code: How we use skills](https://claude.dev/blog/lessons-from-building-claude-code-how-we-use-skills/) | The most valuable part of a skill is its Gotchas section, grown from real failures. State goals, not step-by-step scripts. Write the description as trigger conditions. Use a folder of references and scripts around one `SKILL.md`. | Demo 07 skills, Demo 02 |
| [The new rules of context engineering for Claude 5 generation models](https://claude.dev/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models/) | Prefer judgment to rigid rules, avoid duplicate instructions, keep `CLAUDE.md` to repository quirks and gotchas, load detail through skills, and use `claude doctor` to find overconstrained context. | Demo 00, `CLAUDE.md` rules |
| [A harness for every task: dynamic workflows in Claude Code](https://claude.dev/blog/a-harness-for-every-task-dynamic-workflows-in-claude-code/) | Claude can write its own multi-agent harness for a task: classify-and-act, fan-out-and-synthesize, adversarial verification, per-component migration. Worth it only for high-value, complex work where parallelism pays for the coordination cost. | Demo 07 stretch |
| [Getting the most out of Opus 5.5 in Claude and Claude Code](https://claude.dev/blog/getting-the-most-out-of-opus-5-5/) | Model-specific tuning tips. Not summarized yet: read before the workshop. | Cost and model routing |
| [What a task costs on Opus 5.5](https://claude.dev/blog/what-a-task-costs-on-opus-5-5/) | Cost per completed task. Not summarized yet: read when the team plans cost control after the adoption period. | Cost and model routing |

The blog also has posts on Claude Code mods and on automating eval design. They are not part of this workshop.
