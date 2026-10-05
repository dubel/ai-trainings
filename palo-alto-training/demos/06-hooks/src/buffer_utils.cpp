#include <cstddef>
#include <vector>

// Starting point for the live demo. Ask Claude to add a function that
// returns the size of a buffer in bytes; the hooks check what it writes.
std::size_t buffer_bytes(const std::vector<unsigned char>& data) {
    return data.size();
}
