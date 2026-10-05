# Sample Prompt Audit Report

Illustrative output of `/claude-api prompt-audit CLAUDE.md` for the sample file. Real output varies by model and run.

**Assumptions:** scope is `CLAUDE.md`; target model is the model running the audit.

## Findings (highest confidence first)

| Location | Evidence | Pattern | Confidence | Action |
|---|---|---|---|---|
| `CLAUDE.md:20-21` | "use modern C++20 coroutines, concepts, and ranges" vs "Visual Studio 2017 (C++17 mode)" | Contradiction within one file (Group 2) | High | `rewrite`: keep the C++17 rule, drop the C++20 line |
| `CLAUDE.md:26,12` | "`Sleep(1000)` in retry code" vs "Do not introduce side effects in domain logic" | Contradiction (Group 2) | High | `rewrite`: keep domain logic pure; sleeping belongs in the caller |
| `CLAUDE.md:7-11` | "think step-by-step... read 3 times... 5 hypotheses... write out your chain of thought" | Reasoning scaffolding (1b) | High | `remove`: adaptive thinking and `effort` control depth |
| `CLAUDE.md:3` | "CRITICAL NOTICE: YOU MUST ALWAYS OBEY..." | Pressure language (1a) | High | `remove` |
| `CLAUDE.md:25` | "NEVER use raw pointers... wrap everything in `std::shared_ptr`" | Blanket prohibition (1c/1e) | Medium | `rewrite`: legacy non-owning observers stay raw; use `unique_ptr` only for new owning code |
| `CLAUDE.md:12` | "thoroughly explain all background concepts" | Padding (1c) | Medium | `remove` or state the audience and desired depth |
| `CLAUDE.md:6` | "senior principal C++ and Go engineer" | One-line role statement | — | Keep (not cruft) |

Kept on purpose: the MSVC build command (`CLAUDE.md:18`), the MSVC 19.16 constraint, `go test ./...`, "keep diffs small", and "pure functions preferred". These are project facts and constraints.

## Proposed Pruned Result

```markdown
# C++ & Go Guidelines

## Environment & Build
- C++ target: Visual Studio 2017 (C++17, MSVC 19.16) on Windows. Do not use C++20 features.
- Build and test (Windows):
  `cl /nologo /std:c++17 /W4 /EHsc /Iinclude src\*.cpp tests\*.cpp /Fe:test_runner.exe`
- Go microservices: `go test ./...`

## Code Invariants
- Keep domain logic pure: no `Sleep`, threads, or I/O inside decision calculations; retry waits belong to the caller.
- Preserve legacy signatures and ABI. Legacy non-owning raw pointers stay; use `std::unique_ptr` for new owning code.
- Keep diffs small and focused.
```
