# Deterministic fallback: two illustrative responses

## Ordinary update

> The regression test failed twice on Apple Clang 21.0.0 running on arm64 with 64-bit `size_t`. At `SIZE_MAX`, `offset + count` wraps; on this target, the cast to `std::uint32_t` also truncates a large offset. The safe change is to check `offset <= capacity` before comparing `count` with `capacity - offset`. Rebuild and run the focused regression test after the edit. The 32-bit and Windows/MSVC builds have not been run.

## Caveman update

> Apple Clang 21.0.0, arm64/64-bit `size_t`: 2 failures — `SIZE_MAX` wrap; 64-to-32-bit truncation. Cause: unchecked `offset + count`; narrowing to `std::uint32_t`. Fix: guard `offset <= capacity`, then check `count <= capacity - offset`. Rebuild and run focused test. 32-bit and Windows/MSVC: not run.

Check both versions for the same facts. The exact build command is in [Demo 02](../02-ponytail/README.md); this fixture does not supply one, so the response should not invent it.
