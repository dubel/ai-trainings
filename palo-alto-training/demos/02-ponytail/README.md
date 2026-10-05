# Demo 02 — Ponytail: the smallest correct C++ range check

This is a synthetic fallback exercise for the three-hour workshop. Use a real, bounded team issue when one is available. The code has one deliberate defect; it does not access a buffer, so a passing sanitizer run alone cannot prove the range check is correct.

## Jira-style issue

**Title:** Large offsets can pass buffer range validation

**Observed:** `can_copy(offset, count, capacity)` sometimes accepts a range that extends beyond a buffer. The problem is most visible around integer limits and on 64-bit builds.

**Expected:** A range is valid when `offset` is within the buffer and `count` fits in the remaining capacity. An empty range at the exact end is valid.

**Acceptance criteria**

1. Keep the existing function signature.
2. Accept an ordinary range and a range ending exactly at `capacity`.
3. Reject an offset beyond `capacity`, a count beyond the remaining capacity, and arithmetic overflow.
4. Reject values above 32 bits on a 64-bit target when they exceed `capacity`.
5. Run the regression test on every available target. Record untested targets explicitly.

## Files

- `include/range_check.h` — public contract.
- `src/range_check.cpp` — deliberately broken implementation.
- `tests/range_check_test.cpp` — focused regression test.
- `prompt.md` — two prompts for investigation and implementation.
- `ponytail-instructions.md` — pasteable fallback when the skill is unavailable.
- `instructor/` — solution and facilitation notes; leave this closed during the participant exercise.

## Participant flow

1. **Reproduce:** Build and run the test. Capture the failing cases before changing code.
2. **Map:** Ask Claude to identify the public contract, the validation path, the relevant integer types, and the smallest likely cause. Ask for file and line evidence. Do not request an edit yet.
3. **Contract:** Turn the issue into the acceptance criteria above, then state which targets you can actually run.
4. **Change:** Ask for one minimal fix that preserves the signature. Read the diff and explain why it is safe at `SIZE_MAX`.
5. **Verify:** Rebuild and run the test. Review the diff once against the acceptance criteria and once for C++ quality and security risks. Record the results.

Use [prompt.md](prompt.md) for the two live steps. Paste [ponytail-instructions.md](ponytail-instructions.md) before the implementation step if the custom skill is unavailable. This is a workflow instruction, not a built-in Claude command.

## Build and run (Windows)

You can run `build.bat` or compile directly from PowerShell or Command Prompt:

### Using MSVC (Visual Studio Developer Command Prompt):
```bat
cl /nologo /std:c++17 /W4 /EHsc /Iinclude src\range_check.cpp tests\range_check_test.cpp /Fe:range_check_test.exe
range_check_test.exe
```

### Using Clang / GCC on Windows:
```bat
clang++ -std=c++17 -Wall -Wextra -Wconversion -Werror -Iinclude src/range_check.cpp tests/range_check_test.cpp -o range_check_test.exe
.\range_check_test.exe
```

Or simply run:
```bat
build.bat
```

The initial run should exit nonzero. After fixing `src/range_check.cpp`, rebuild and expect all checks to pass. If a 32-bit toolchain is unavailable, mark that target **not run**; a 64-bit run does not cover it.

## Evidence to leave in the issue or PR

| Target and compiler | Baseline failures | Final result | Notes |
|---|---|---|---|
| Local target, compiler version | Fill in | Fill in | Include command and architecture |
| 32-bit target | Fill in or not run | Fill in or not run | State why if not run |
| 64-bit target | Fill in or not run | Fill in or not run | State why if not run |

Finish with the changed line, the acceptance criteria covered, any remaining untested target, and one review finding or the explicit result that no issue was found.
