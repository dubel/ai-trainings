# Saved input for Demo 01

The range check under investigation is:

```cpp
return static_cast<std::uint32_t>(offset + count) <= capacity;
```

Local environment: Apple Clang 21.0.0 on arm64; `size_t` is 64 bits.

Saved output from the focused regression test:

```text
FAIL: addition wraps at SIZE_MAX (expected 0, got 1)
FAIL: 64-bit offset truncated to 32 bits
2 check(s) failed on 64-bit size_t
```

32-bit and Windows/MSVC builds were not run.
