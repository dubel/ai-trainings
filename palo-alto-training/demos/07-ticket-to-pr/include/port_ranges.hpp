#pragma once

#include <cstddef>
#include <cstdint>
#include <string>
#include <vector>

namespace ports {

enum class ParseError {
    None,
    Empty,         // spec is empty or only whitespace
    InvalidToken,  // empty token, non-digit character, or malformed range
    OutOfRange,    // a port is 0 or above 65535
    ReversedRange, // range start is greater than range end
    TooMany        // more distinct ports than max_ports
};

struct ParseResult {
    ParseError error;
    std::vector<std::uint16_t> ports;  // sorted ascending, no duplicates; empty on error
};

// Parses a comma-separated list of ports and inclusive ranges, e.g. "80, 8000-8003,443".
ParseResult parse_port_ranges(const std::string& spec, std::size_t max_ports);

}  // namespace ports
