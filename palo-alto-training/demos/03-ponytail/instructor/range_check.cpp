#include "range_check.h"

bool can_copy(std::size_t offset, std::size_t count, std::size_t capacity) {
    return offset <= capacity && count <= capacity - offset;
}
