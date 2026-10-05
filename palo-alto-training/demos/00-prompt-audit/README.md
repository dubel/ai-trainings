# Demo 00 — Prompt Audit: Cleaning Repository Instructions

**Goal:** Audit and prune repository instructions (`CLAUDE.md` / `AGENTS.md`) using `/claude-api prompt-audit` (or `/doctor prompt-audit`) to remove token-wasting anti-patterns while preserving essential C++ build rules, Windows/MSVC toolchain flags, and safety boundaries.

## Background

As Claude models advance (e.g. Claude 3.5 Sonnet to Claude Opus / 3.7 Sonnet), repository instructions often accumulate outdated scaffolding:
- Capitalized shouting (`MUST`, `ALWAYS`, `CRITICAL`).
- Rigid step-by-step thinking instructions.
- Stale paths or toolchain commands (e.g., GCC flags in a Windows MSVC project).
- Contradictory guidelines that confuse the model.

## Files

- [CLAUDE.md](CLAUDE.md) — an unpruned, realistic repository instruction file for a legacy C++ and Go project on Windows.
- [expected-audit.md](expected-audit.md) — sample audit output and proposed diff for comparison.

## Participant Flow (Run on Your Own Repository)

1. Open **your team's repository** in Claude Code:
   ```bat
   cd <path-to-your-repo>
   ```
2. Run the audit command scoped to your repo's `CLAUDE.md`:
   ```text
   /claude-api prompt-audit CLAUDE.md
   ```
   *(Or in recent versions: `/doctor prompt-audit`)*

3. If your repo does not have a `CLAUDE.md` yet, use the provided fallback sample in this directory:
   ```bat
   cd palo-alto-training\demos\00-prompt-audit
   /claude-api prompt-audit CLAUDE.md
   ```
4. Review the findings:
   - Which rules were flagged as redundant or counter-productive?
   - Did the audit proposal preserve Windows MSVC commands and architecture constraints?
   - What failure did the original rule try to prevent, and is it still necessary?
5. **Key Takeaway:** Do not accept audit diffs blindly. Keep project-specific constraints (e.g. MSVC flags, 32/64-bit rules), but delete token-wasting procedural filler.
