# Demo 02 — Raw vs Compact Terminal Output (RTK)

**Goal:** Understand how noisy terminal and test runner outputs consume precious context window tokens in Claude Code, and how output filtering (like RTK) preserves diagnostic signal while cutting token usage by 85–95%.

## Context: Legacy Builds & Test Suites

In a 25-year-old C++ Windows codebase or Go microservice suite:
- C++ compilers (MSVC/Clang) often dump hundreds of lines of template instantiation warnings or informational notes.
- Test suites run 100+ passing tests before a single failure occurs.
- If an engineer pastes or pipes the raw 150-line output into Claude Code, ~1,200+ tokens are consumed by noise. The model's attention is diffused across irrelevant passes.
- A compact filter extracts only the failing test name, source line, expected vs actual values, and summary (~50 tokens).

## Modes

Both C++ and Go versions generate a simulated test suite of 120 passing checks and 1 failure:
- `--mode raw`: Full verbose runner output (all passes + failure).
- `--mode compact`: Filtered diagnostic signal (failure + line location + summary only).
- `--mode compare`: Comparison table of lines, bytes, and approximate tokens.

*(Note: Both programs exit with code `1` by design to simulate a failing CI check).*

## Running the Demo

### C++ (Windows build script):
```bat
cd cpp
build.bat
```

### C++ (Manual MSVC or Clang on Windows):
```bat
cd cpp
cl /nologo /std:c++17 /EHsc src\noisy_ci.cpp /Fe:noisy_ci.exe
noisy_ci.exe --mode compare
```

### Go:
```sh
cd go
go run ./cmd/noisy-ci --mode compare
```

### Fallback without compiling:
Inspect [fixtures/raw-output-excerpt.txt](fixtures/raw-output-excerpt.txt) and [fixtures/compact-output.txt](fixtures/compact-output.txt). Compare what information was kept and what was dropped.
