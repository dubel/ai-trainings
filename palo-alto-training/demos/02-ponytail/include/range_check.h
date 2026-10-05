#pragma once

#include <cstddef>

// True if [offset, offset + count) lies within a buffer of capacity elements.
bool can_copy(std::size_t offset, std::size_t count, std::size_t capacity);
