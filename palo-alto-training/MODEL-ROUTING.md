# Model routing: Opus plans, Sonnet implements

The team has no token limit during the adoption period, but cost control is expected to matter later. This note gives a routing pattern to try now, with the numbers it rests on. Measure it on your own tasks before adopting it as a rule.

## Prices (per million tokens, Claude API list prices)

| Model | Input | Output | Cache read |
|---|---|---|---|
| Opus 5.5 | $4 | $20 | $0.20 |
| Sonnet 5.5 | $2 | $10 | $0.20 |

Sonnet 5.5 costs half as much per input or output token. Its blog post also says it typically needs fewer tokens than Sonnet 5, up to about 30% lower cost; that is a comparison with Sonnet 5, not with Opus. The Opus 5.5 cost post reports a typical Claude Code session at $2.40 on Opus 5.5 versus $3.50 on Opus 5. No source here measures Opus versus Sonnet on the same task, so treat any saving as unproven until you measure it.

## When to use which

- **Opus 5.5:** complex work that needs careful judgment, long-horizon problems, specs, and reviews. The Opus cost post calls it the daily driver for supervised work.
- **Sonnet 5.5:** well-scoped everyday coding such as bug fixes and feature iteration, which is what an approved spec describes.
- **Caution from the Opus cost post:** cheaper models suit lookups and subagents, and their mistakes can send the main model in the wrong direction. A precise spec and a verifying build are what make handing implementation to Sonnet safe.

## The pattern

1. **Plan on Opus:** turn the ticket into a spec (acceptance criteria, files, tests, risks). Review it yourself.
2. **Implement on Sonnet in a fresh conversation:** the spec is the only contract; run the build and tests.
3. **Review on Opus:** an adversarial review of the diff against the spec.
4. **Escalate when stuck:** if Sonnet fails the same problem three times or the spec turns out to be wrong, return to Opus.

## Three ways to apply it

| Way | How | Notes |
|---|---|---|
| Built-in alias | `/model opusplan` (or `claude --model opusplan`) | Opus in plan mode, Sonnet in execution mode. Use `opusplan[1m]` for a 1M context window in both phases. |
| Skill frontmatter | `model: opus` or `model: sonnet` in a `SKILL.md` | Demo 07 does this: `quick-spec` and `adversarial-review` use Opus, `quick-dev` uses Sonnet. |
| Manual | `/model opus`, later `/model sonnet` (`s` in the picker keeps it to this session) | Simplest to explain; easy to forget. |

## Effort per step

From the claude.dev effort post: low for quick iteration while you are in the loop, medium for normal feature work, high for verification and edge cases, and max only for autonomous or security-critical work. A matching split: spec at low or medium, implementation at medium, verification and review at high. Change it with `/effort`.

## How to measure on your own task

Run the same ticket twice: once entirely on Opus, once with this split. Compare the session usage report, the number of retries, and whether the review found more defects in one run. Record the result in the PR evidence. A routing rule should come from a few of your tasks, not from this note.

## Sources

- [Building with Claude Sonnet 5.5](https://claude.dev/blog/building-with-claude-sonnet-5-5/)
- [What a task costs on Opus 5.5](https://claude.dev/blog/what-a-task-costs-on-opus-5-5/)
- [Using Claude Code: Spending your effort](https://claude.dev/blog/spending-your-effort/)
- [Claude Code model configuration](https://code.claude.com/docs/en/model-config)
