# Workshop: Claude Code for C++ Development (3 Hours)

**Goal:** show developers what Claude Code can do across a C++ delivery workflow, from repository instructions to a ticket-to-PR loop, using prepared Windows C++ and Go demos. Participants follow each demo in their own Claude Code session and leave with tools, prompts, and a loop they can reuse on their own tasks.

**Pre-workshop preparation (each participant, 10 minutes):**
- Claude Code installed and signed in.
- Caveman and Ponytail plugins installed (commands in `demos/README.md`), then `/reload-plugins`.
- A C++ compiler on `PATH`: MSVC (Developer Command Prompt) or `clang++`. Go 1.20+ for the Go variants.
- The repository cloned. The instructor runs `demos\test_all_windows.bat` and `demos\06-hooks\test-hooks.ps1` once, and `/claude-api prompt-audit` in a fresh session.
- Optional: the team's own repository `CLAUDE.md` for Demo 00.

| Time | Session | Demo / material | Outcome |
|---|---|---|---|
| 0:00–0:20 | Theory briefing: models propose and engineering systems verify, repository instructions, mechanisms (rules, skills, hooks), task contracts, local multi-repo workspace with GitHub MCP, model routing, evidence. | `theory-presentation.html` (18 slides; skip the adoption ladder, cost anatomy, and safety slides if time is short) | Shared vocabulary and the map for the demos. |
| 0:20–0:35 | Repository instructions: audit a `CLAUDE.md` and prune filler while keeping MSVC flags. | [Demo 00 — Prompt Audit](demos/00-prompt-audit/README.md) | One justified audit decision. |
| 0:35–0:45 | Cost: concise status reports without evidence loss. | [Demo 01 — Caveman](demos/01-caveman/README.md) | Shorter reports that keep errors, targets, and unverified platforms. |
| 0:45–0:55 | Context: filtering noisy build and test output before it reaches the model. | [Demo 02 — Noisy CI (RTK)](demos/02-noisy-ci-rtk/README.md) | Compact logs that keep the failing test, line, and summary. |
| 0:55–1:15 | Implementation: the smallest correct fix for a 32-bit/64-bit range-check bug. | [Demo 03 — Ponytail](demos/03-ponytail/README.md) | A minimal fix with test evidence per target. |
| 1:15–1:25 | Break. | | |
| 1:25–1:45 | Prompt versus contract: the same task with a vague prompt and with an engineering contract (C++ or Go). | [Demo 04 — Contract vs Prompt](demos/04-contract-vs-prompt/README.md) | A task contract template. |
| 1:45–2:00 | Guardrails: plan tests first and keep domain logic pure in a legacy code base. | [Demo 05 — Rules & Guardrails](demos/05-rules-and-guardrails/README.md) | Repository rules that Claude follows. |
| 2:00–2:15 | Enforcement: hooks that block destructive commands and flag x86/x64 and syntax problems after every edit. | [Demo 06 — Hooks](demos/06-hooks/README.md) | One hook the team could adopt. |
| 2:15–2:50 | Delivery loop: ticket, spec on Opus, implementation on Sonnet in a fresh context, verification, adversarial review. Skip the draft PR step if time is short. | [Demo 07 — Ticket to PR](demos/07-ticket-to-pr/README.md), [MODEL-ROUTING.md](MODEL-ROUTING.md) | A reusable loop and a model-routing rule to test. |
| 2:50–3:00 | Wrap-up: pick 3–5 rules for the team's `CLAUDE.md`, choose one real task to run the loop on, and share the reading list. | [READING-LIST.md](READING-LIST.md) | Concrete next steps. |

**Facilitation rules:**
- The instructor demonstrates each demo briefly, then participants run it themselves. Use the fallback files in each demo if a live model call fails.
- Keep the instructor folders closed until participants finish.
- Present Caveman and Ponytail as specific plugins, not built-in Claude features. The hooks and skills in the demos are workshop examples.
- Never mark a result as verified on an architecture or compiler that was not run; state the target for every claim.
- Treat cost figures as list prices and unmeasured savings as unproven; participants measure routing on their own tasks.
- If the team has a ready, bounded task, use it in place of the sample in Demo 03 or Demo 07.
