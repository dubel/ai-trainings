#include "range_check.h"

#include <cstdint>

bool can_copy(std::size_t offset, std::size_t count, std::size_t capacity) {
    return static_cast<std::uint32_t>(offset + count) <= capacity;
}
