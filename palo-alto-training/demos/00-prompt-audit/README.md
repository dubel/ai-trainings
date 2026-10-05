# Demo 00 — Prompt Audit: Cleaning Repository Instructions

**Goal:** Audit and prune repository instructions (`CLAUDE.md` / `AGENTS.md`) with `/claude-api prompt-audit` to remove outdated scaffolding while preserving essential C++ build rules, Windows/MSVC toolchain flags, and safety boundaries.

## Setup (nothing to install)

`prompt-audit` is a subcommand of the `claude-api` skill that ships with Claude Code. Check it is available:

```text
/claude-api prompt-audit CLAUDE.md
```

The command runs `shared/prompt-audit.md` from the skill and returns an audit report plus a proposed diff. It does not edit files unless you explicitly ask it to apply changes. If the command is unknown, update Claude Code and re-run it.

*Verified 2026-10-05 in Claude Code 2.1.286: the `claude-api` skill lists `prompt-audit` in its subcommand table.*

## Background

Repository instructions accumulate text written for older models, which current models follow more literally:
- Capitalized shouting (`MUST`, `ALWAYS`, `CRITICAL`).
- Rigid step-by-step thinking instructions and "show your reasoning" scaffolding.
- Stale paths or commands.
- Rules that contradict each other or the real toolchain.

## Files

- [CLAUDE.md](CLAUDE.md) — an unpruned, realistic repository instruction file for a legacy C++ and Go project on Windows.
- [expected-audit.md](expected-audit.md) — sample audit report and proposed diff for comparison. Illustrative, not recorded output.

## Participant Flow (Run on Your Own Repository)

1. Open **your team's repository** in Claude Code:
   ```bat
   cd <path-to-your-repo>
   ```
2. Run the audit scoped to your repository's `CLAUDE.md`:
   ```text
   /claude-api prompt-audit CLAUDE.md
   ```
3. If your repository has no `CLAUDE.md` yet, use the fallback sample:
   ```bat
   cd palo-alto-training\demos\00-prompt-audit
   ```
   ```text
   /claude-api prompt-audit CLAUDE.md
   ```
4. Review the findings:
   - Which rules were flagged, and at what confidence?
   - Did the proposed diff preserve the MSVC build command and the C++17 constraint?
   - What failure did the original rule try to prevent, and does it still occur?
5. **Key Takeaway:** Do not accept audit diffs blindly. Keep project-specific constraints (MSVC flags, 32/64-bit rules) and the reasons behind them; delete only instructions that no longer fit the model or the project. A clean audit is a valid result.
