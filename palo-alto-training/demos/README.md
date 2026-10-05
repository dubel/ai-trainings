# Palo Alto workshop demos

These numbered demos work without customer source code or installed custom skills. Open each directory separately. The input and expected outputs are synthetic training material; the C++ test in Demo 02 is runnable.

| Demo | Format | Lesson |
|---|---|---|
| [01 — Caveman](01-caveman/README.md) | Saved C++ test output, prompt, fallback response | Shorten an issue update without losing evidence or uncertainty. |
| [02 — Ponytail](02-ponytail/README.md) | C++17 source, regression test, instructor solution | Make the smallest correct fix and prove it with one focused check. |

Suggested order: show Demo 01 during the short foundations block, then use Demo 02 for the practical task. `/claude-api prompt-audit` remains a separate live check of repository instructions; it does not require either demo.

Demo 02 needs a C++17 compiler. Run its documented command on every architecture or toolchain you claim to have verified. On the authoring arm64 host, the broken test fails twice and the instructor solution passes; 32-bit and Windows/MSVC were not run.
