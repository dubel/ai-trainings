# Demo 07 repository notes

- C++17 only; the team's legacy target is MSVC 19.16 (Visual Studio 2017). Do not use C++20 features.
- Build and test with `build.bat` (detects `cl`, `clang++`, or `g++`). Warnings are errors.
- `include/port_ranges.hpp` is the public contract; keep its signatures.
- `instructor/` holds the reference solution. Leave it alone.
- Port values are 16-bit but parsing happens in wider integers: guard overflow before narrowing, since `size_t` and `long` differ between x86, x64 Windows (LLP64) and Linux (LP64).
