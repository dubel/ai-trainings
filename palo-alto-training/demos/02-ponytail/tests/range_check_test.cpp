#include "range_check.h"

#include <cstddef>
#include <cstdint>
#include <iostream>
#include <limits>

int main() {
    struct Case {
        const char* name;
        std::size_t offset;
        std::size_t count;
        std::size_t capacity;
        bool expected;
    };

    const std::size_t max = std::numeric_limits<std::size_t>::max();
    const Case cases[] = {
        {"ordinary range", 2, 3, 10, true},
        {"ends exactly at capacity", 7, 3, 10, true},
        {"empty range at end", 10, 0, 10, true},
        {"offset beyond capacity", 11, 0, 10, false},
        {"count beyond remaining capacity", 7, 4, 10, false},
        {"addition wraps at SIZE_MAX", max, 1, 10, false},
    };

    int failures = 0;
    for (const Case& test : cases) {
        const bool actual = can_copy(test.offset, test.count, test.capacity);
        if (actual != test.expected) {
            std::cerr << "FAIL: " << test.name << " (expected " << test.expected
                      << ", got " << actual << ")\n";
            ++failures;
        }
    }

    if (sizeof(std::size_t) > sizeof(std::uint32_t)) {
        const std::size_t wide_offset = static_cast<std::size_t>(std::uint64_t{1} << 32);
        if (can_copy(wide_offset, 0, 10)) {
            std::cerr << "FAIL: 64-bit offset truncated to 32 bits\n";
            ++failures;
        }
    }

    if (failures != 0) {
        std::cerr << failures << " check(s) failed on " << sizeof(std::size_t) * 8
                  << "-bit size_t\n";
        return 1;
    }

    std::cout << "All range checks passed on " << sizeof(std::size_t) * 8
              << "-bit size_t\n";
    return 0;
}
