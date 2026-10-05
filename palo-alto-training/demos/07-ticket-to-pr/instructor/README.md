# Demo 07 — instructor notes

Reference solution: `instructor/port_ranges.cpp`. It passes the starter tests and an extended 19-case edge check (`1-65535` with a large `max_ports`, 20-digit and 4294967297 inputs, `80,`, `,80`, `1-2-3`, `80-`, duplicates, reversed ranges, `TooMany` at the boundary). To check a participant result:

```powershell
clang++ -std=c++17 -Wall -Wextra -Wconversion -Werror -Iinclude instructor\port_ranges.cpp tests\port_ranges_test.cpp -o t.exe; .\t.exe
```

## What to watch for

- **Overflow:** parsing with `std::stoi`/`strtol`/`int` accumulation on `99999999999999999999` throws, wraps, or saturates differently per platform. The reference saturates above 65535 inside a `uint32_t`.
- **Narrowing:** casting to `std::uint16_t` before the range check turns 65536 into 0. `-Wconversion -Werror` catches some of this.
- **Trailing and leading commas** are easy to accept silently by splitting with a loop that stops at the end of the string.
- **Signs and whitespace:** `std::stoi` accepts `+5`, `-5`, and leading spaces; the ticket does not.
- **Tests that cannot fail:** a spec criterion without a concrete input and expected error is a smell in step 2.
- **Over-engineering:** a tokenizer class or regex library for this task is what `/ponytail-review` should flag.
- **Unverified claims:** the summary says "tested on 32-bit" while only an x64 compiler ran. Require the architecture in the PR evidence.

## Timing (about 55 minutes)

Fetch 5, spec 10, implement 15, verify 10, review 10, PR 5. If time is short, skip step 6 and the stretch section; keep verify and review.
