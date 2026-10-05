# Palo Alto Workshop Demos

These self-contained, numbered demos support both **instructor presentations** and **hands-on participant exercises** during the 3-hour workshop. They do not require access to customer source code or pre-installed custom skills.

The exercises specifically target the team's stack: **C++17 on Windows (MSVC)** dealing with a **25-year-old legacy codebase**, and **Go microservices**.

| Demo | Stack | Format | Lesson & Workshop Mapping |
|---|---|---|---|
| [00 — Prompt Audit](00-prompt-audit/README.md) | Shared | Realistic unpruned `CLAUDE.md`, sample audit report | **Claude 101:** Audit repository guidance with `/claude-api prompt-audit` directly on the team's own `CLAUDE.md` (with fallback demo sample). Prune filler while preserving Windows MSVC flags. |
| [01 — Caveman](01-caveman/README.md) | C++ | Saved C++ test output, prompt, expected responses | **Diagnostics:** Compress status updates and bug reports without losing error codes, reproduction steps, or unverified architectures. |
| [02 — Ponytail](02-ponytail/README.md) | C++17 | C++17 source, regression test, instructor solution | **Implementation & Verification:** Fix a subtle range-check bug around integer overflow and 32-bit vs 64-bit (`size_t`) limits with one minimal check. |
| [03 — Contract vs Prompt](03-contract-vs-prompt/README.md) | C++ & Go | Bounded deployment gate, unit tests, Run A vs Run B prompts | **Spec & Acceptance Criteria:** Compare a vague prompt (which causes Claude to add unneeded allocations, modern C++20, or breaking ABI) vs an engineering contract that enforces pure, bounded logic. |
| [04 — Rules & Guardrails](04-rules-and-guardrails/README.md) | C++ & Go | Exponential retry policy, unit tests, `CLAUDE.md` rules | **Bounded Refactoring:** Enforce pure domain logic in legacy systems. Prevent Claude from hallucinating `Sleep()`, threads, or I/O into business calculations. Plan tests first. |
| [05 — Noisy CI (RTK)](05-noisy-ci-rtk/README.md) | C++ & Go | Simulated test runner, line/token comparison, fixtures | **Context Optimization:** Filter verbose compiler warnings and passing test noise before they exhaust Claude's context window. |
| [06 — Hooks](06-hooks/README.md) | C++ & Terraform | Three PowerShell hooks, dry-run test, sample files | **Enforcement:** block destructive commands and catch x86/x64 and syntax defects automatically after every edit, instead of relying on prompt rules. |
| [07 — Ticket to PR](07-ticket-to-pr/README.md) | C++17 | Ticket, three skills, starter code, tests, instructor solution | **Delivery loop:** fetch a ticket, spec it, implement in a fresh context, verify, adversarially review, and draft a PR. Reusable on the team's own tasks. |

## One-time setup (each participant, inside Claude Code, before the workshop)

```text
/plugin marketplace add JuliusBrussee/caveman
/plugin install caveman@caveman
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail
/reload-plugins
```

Prompt audit needs no install (`/claude-api prompt-audit CLAUDE.md`). Per-demo checks and paste-in fallbacks are in the Setup section of Demos [00](00-prompt-audit/README.md), [01](01-caveman/README.md), and [02](02-ponytail/README.md). Plugins come from public repositories; follow the team's policy on third-party plugins.

## Recommended Agenda Mapping (3 Hours)

1. **Foundations (0:00–0:30):**
   - Live demo of **Demo 00** (`/claude-api prompt-audit` on legacy `CLAUDE.md`).
   - Live demo or quick exercise with **Demo 01** (Caveman concise reporting) and **Demo 05** (Noisy CI / RTK context saving).
2. **Context & Acceptance Criteria (0:30–1:15):**
   - Hands-on exercise with **Demo 03** (Run A vague prompt vs Run B specification contract in C++ or Go).
3. **Break (1:15–1:25)**
4. **Hands-On Bounded Coding & Ponytail (1:25–2:20):**
   - Real customer issue if ready; fallback to **Demo 02** (C++ integer limits & 32/64-bit MSVC) or **Demo 04** (Rate-limited retry policy in C++ or Go).
5. **Critical Diff Review & Safeguards (2:20–2:45):**
   - Review the diffs against acceptance criteria, LLP64 vs LP64 differences, security risks, and Ponytail over-engineering rules.
6. **Retrospective & Instructions (2:45–3:00):**
   - Extract 3–5 reusable rules into the team's production `CLAUDE.md`.

## Compiler & Runtime Requirements (Windows)

- **C++ (Windows):** C++17 compiler on Windows.
  - Visual Studio Developer Command Prompt (`cl.exe`).
  - Or LLVM / MinGW on Windows (`clang++` / `g++`).
  - Each demo directory contains a self-contained `build.bat` that auto-detects available compilers.
  - To test all demos at once, run:
    ```bat
    test_all_windows.bat
    ```
- **Go:** Go 1.20+ for Windows (`go test ./...` / `go run`).
