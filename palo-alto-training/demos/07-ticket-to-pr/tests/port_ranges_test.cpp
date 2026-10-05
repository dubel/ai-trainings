#include "port_ranges.hpp"

#include <cstdint>
#include <iostream>
#include <vector>

using ports::ParseError;

int main() {
    int failures = 0;

    auto check = [&](const char* name, const std::string& spec, std::size_t max_ports,
                     ParseError expected_error, const std::vector<std::uint16_t>& expected_ports) {
        const ports::ParseResult result = ports::parse_port_ranges(spec, max_ports);
        if (result.error != expected_error || result.ports != expected_ports) {
            std::cerr << "FAIL: " << name << "\n";
            ++failures;
        }
    };

    check("single port", "80", 16, ParseError::None, {80});
    check("simple range", "8000-8002", 16, ParseError::None, {8000, 8001, 8002});

    if (failures != 0) {
        std::cerr << failures << " check(s) failed\n";
        return 1;
    }
    std::cout << "All checks passed\n";
    return 0;
}
