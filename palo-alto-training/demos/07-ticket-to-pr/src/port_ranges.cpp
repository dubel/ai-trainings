#include "port_ranges.hpp"

namespace ports {

// Starting point for the workshop: not implemented yet.
ParseResult parse_port_ranges(const std::string&, std::size_t) {
    return ParseResult{ParseError::Empty, {}};
}

}  // namespace ports
