# Instructor notes

The intended fix is a single return expression:

```cpp
return offset <= capacity && count <= capacity - offset;
```

The first comparison prevents subtraction underflow. The second compares the count with the remaining capacity, so no addition can overflow. On the broken implementation, the `SIZE_MAX` case fails on both 32-bit and 64-bit `size_t`; the wide-offset case is an additional failure on 64-bit `size_t`.

The header comment describes a mathematical half-open range; the implementation must reject values that cannot fit even if `offset + count` wraps in machine arithmetic. A sanitizer may report nothing because this demo makes no out-of-bounds memory access. The regression test is the primary proof of this specific logic bug.

For a green reference build without changing the participant's source file, compile `instructor/range_check.cpp` instead of `src/range_check.cpp`. Do not describe a target as verified unless that binary ran there.
