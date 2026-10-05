# Repository Instructions & Guardrails

## Core Engineering Rules
- **Domain Logic Purity:** Keep retry and business calculations strictly pure. Do NOT add `std::this_thread::sleep_for`, `time.Sleep`, `Sleep()`, background threads, goroutines, system time calls, or I/O logging to domain packages.
- **Contract Preservation:** Preserve existing public signatures and return types (`RetryDecision` / `Decision`) unless explicitly specified in `task.md`.
- **Plan Mode First:** When a new requirement is presented, produce a test plan first for human review. Do NOT edit production files until the test cases and boundary conditions are agreed upon.
- **Ponytail Simplicity:** Prefer the simplest correct arithmetic formula over loops, lookup tables, or external math libraries.
- **Platform Invariants:**
  - C++: Windows only. Must compile clean with `/W4 /WX` on MSVC or `-Wall -Wextra -Werror` on Clang for Windows. C++17 standard.
  - Go: Windows environment. Standard library only. Idiomatic table-driven tests.
