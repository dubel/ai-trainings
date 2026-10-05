# Demo 03 prompts

## Step A — investigate without editing

> Read `README.md`, `include/range_check.h`, `src/range_check.cpp`, and `tests/range_check_test.cpp`. Reproduce the failing test using the documented command. Map the validation path, explain the 32-bit and 64-bit failure modes, and propose the smallest fix. State which target you actually ran. Do not edit files yet.

## Step B — make the bounded fix

> Apply the smallest correct change to `src/range_check.cpp`. Keep the public signature and acceptance criteria. Use the existing focused test; add no dependency or abstraction. Rebuild, run the test, inspect the diff, and report unverified targets explicitly.

Paste [ponytail-instructions.md](ponytail-instructions.md) into the chat before Step B if the skill is unavailable.
