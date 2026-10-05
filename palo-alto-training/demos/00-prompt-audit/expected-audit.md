# Sample Prompt Audit Report

Running `/claude-api prompt-audit CLAUDE.md` produces findings similar to the following:

## Flagged Issues

1. **Emotional shouting & capitalization (`CRITICAL NOTICE`, `MUST ALWAYS`)**:
   - *Finding:* Overuse of all-caps emphasis consumes tokens and creates negative steering or stubborn refusal without improving compliance.
   - *Recommendation:* State requirements in neutral declarative sentences.

2. **Reasoning scaffolding / artificial chain-of-thought**:
   - *Finding:* Instructions like *"Read 3 times, formulate 5 hypotheses, explain background concepts"* inflate response latency and token count.
   - *Recommendation:* Remove procedural micromanagement; modern Claude models naturally reason through code tasks.

3. **Direct contradictions**:
   - *Finding:* Line states *"use modern C++20 coroutines, concepts, ranges"*, but later states *"target compiler is Visual Studio 2017 (C++17 mode)"*.
   - *Finding:* Line states *"ensure you use Sleep(1000)"*, but later states *"pure functions are preferred. Do not introduce side effects in domain logic"*.
   - *Recommendation:* Resolve contradictions explicitly to avoid unpredictable agent behavior.

4. **Blanket dogmatic rules (`NEVER use raw pointers`, `wrap everything in shared_ptr`)**:
   - *Finding:* In a 25-year-old C++ codebase, forcing `std::shared_ptr` on legacy non-owning observer parameters causes performance regressions, reference cycles, and ABI breakage.
   - *Recommendation:* Target specific safety invariants rather than universal dogmas.

## Pruned Result

```markdown
# C++ & Go Guidelines

## Environment & Build
- C++ target: Visual Studio 2017 (C++17) on Windows. Do not use C++20 features.
- Build & test command (Windows):
  `cl /nologo /std:c++17 /W4 /EHsc /Iinclude src\*.cpp tests\*.cpp /Fe:test_runner.exe`
- Go microservices:
  `go test ./...`

## Code Invariants
- Keep domain logic pure: no `Sleep`, threads, or I/O inside decision calculations.
- Preserve legacy signatures and ABI compatibility.
- Use `std::unique_ptr` or references for ownership; do not add unrequested `std::shared_ptr`.
- Keep diffs focused and minimal (Ponytail principle).
```
