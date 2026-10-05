# Run B — Specification Contract Prompt

Copy and paste this into a fresh Claude Code session:

```text
Act as a senior engineer maintaining a high-reliability codebase.
Goal: Implement the requirements in `task.md`.

Context:
- For C++: inspect `cpp/include/deployment_gate.hpp`, `cpp/src/deployment_gate.cpp`, `cpp/tests/deployment_gate_test.cpp`.
- For Go: inspect `go/deploymentgate/gate.go`, `go/deploymentgate/gate_test.go`.

Constraints:
- Work in Plan Mode first: list exact files, struct field additions, logic branches, and test cases before making changes.
- In C++: preserve C++17 MSVC compatibility (`cl /W4 /WX`). No heap allocations (`new`, `malloc`, `std::make_shared`). Keep evaluation function pure.
- In Go: idiomatic standard library only. No external packages, goroutines, or interface bloat.
- Non-goals: Do NOT add logging, persistence, HTTP clients, or refactor existing test helper functions.
- Verification: Run the documented test command and ensure all new and existing cases pass.
```
