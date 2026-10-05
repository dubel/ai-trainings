#include <cstddef>
#include <vector>

// Deliberately risky on x64: used to show the check-32-64 hook. Do not copy.
int buffer_bytes(const std::vector<unsigned char>& data) {
    int count = data.size();
    return (int)sizeof(unsigned char) * count;
}
