# Demo 03 — Spec Contract vs Vague Prompt (C++ & Go)

**Goal:** Compare the diffs produced by Claude Code when given a casual/vague user prompt versus an explicit engineering contract with acceptance criteria, non-goals, and boundary constraints.

This exercise is especially critical in **25-year-old C++ codebases** and **Go microservices**:
- In legacy C++, vague prompts often lead Claude to introduce unneeded dynamic heap allocations, modern C++20 features unsupported by legacy MSVC compilers, complex template hierarchies, or breaking ABI changes.
- In Go microservices, vague prompts lead Claude to introduce unneeded goroutines, channels, external packages, or complex interfaces.
- An explicit **Spec Contract** binds Claude to pure logic, existing signatures, zero unnecessary allocations, and strict toolchain compatibility.

## Structure

Participants can choose either the **C++** stack or the **Go** stack:

- `cpp/` — C++17 deployment gate (Windows, MSVC).
- `go/` — Go microservice deployment gate (`go test ./...`).
- `task.md` — The feature specification derived from Jira.
- `prompts/` — The two contrasting prompts to test in Claude Code:
  - `prompt-vague.md` (Run A): Casual prompt ("Add change risk handling...").
  - `contract.md` (Run B): Specification contract with strict non-goals and verification commands.
- `instructor/` — Facilitator notes and reference solutions.

## Participant Flow

1. **Verify Baseline:**
   - **C++ (Windows build script):**
     ```bat
     cd cpp
     build.bat
     ```
   - **C++ (Manual MSVC or Clang on Windows):**
     ```bat
     cd cpp
     cl /nologo /std:c++17 /W4 /EHsc /Iinclude src\deployment_gate.cpp tests\deployment_gate_test.cpp /Fe:deployment_gate_test.exe
     deployment_gate_test.exe
     ```
   - **Go:**
     ```sh
     cd go
     go test -v ./...
     ```
   Ensure baseline tests pass.

2. **Run A (Vague Prompt):**
   - Start a fresh Claude Code session.
   - Run prompt from [prompts/prompt-vague.md](prompts/prompt-vague.md).
   - Inspect the generated diff: Did Claude add new abstractions? Did it allocate memory? Did it break existing call sites?

3. **Run B (Contract):**
   - Reset the workspace (`git checkout .`).
   - Start a fresh Claude Code session.
   - Run prompt from [prompts/contract.md](prompts/contract.md).
   - Inspect the generated diff: Notice the minimal, bounded footprint, pure function logic, and zero unnecessary headers.

4. **Verify:**
   - Re-run the test suite and confirm all acceptance criteria are met.
