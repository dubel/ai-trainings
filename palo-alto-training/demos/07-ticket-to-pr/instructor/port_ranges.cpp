#include "port_ranges.hpp"

#include <cstdint>
#include <string>

namespace ports {
namespace {

std::string trim(const std::string& s) {
    const char* ws = " \t";
    const std::size_t first = s.find_first_not_of(ws);
    if (first == std::string::npos) return std::string();
    return s.substr(first, s.find_last_not_of(ws) - first + 1);
}

enum class Number { Ok, Invalid, OutOfRange };

// Digits only; saturates above 65535 so a huge value cannot overflow the accumulator.
Number parse_number(const std::string& text, std::uint32_t& value) {
    if (text.empty()) return Number::Invalid;
    std::uint32_t v = 0;
    for (const char c : text) {
        if (c < '0' || c > '9') return Number::Invalid;
        v = v * 10 + static_cast<std::uint32_t>(c - '0');
        if (v > 65535) v = 65536;
    }
    if (v == 0 || v > 65535) return Number::OutOfRange;
    value = v;
    return Number::Ok;
}

ParseResult fail(ParseError error) { return ParseResult{error, {}}; }

}  // namespace

ParseResult parse_port_ranges(const std::string& spec, std::size_t max_ports) {
    if (trim(spec).empty()) return fail(ParseError::Empty);

    std::vector<bool> seen(65536, false);
    std::size_t begin = 0;
    for (bool more = true; more;) {
        std::size_t end = spec.find(',', begin);
        more = end != std::string::npos;
        if (!more) end = spec.size();
        const std::string token = trim(spec.substr(begin, end - begin));
        begin = end + 1;

        const std::size_t dash = token.find('-');
        std::uint32_t low = 0;
        std::uint32_t high = 0;
        Number first = Number::Ok;
        Number second = Number::Ok;
        if (dash == std::string::npos) {
            first = parse_number(token, low);
            high = low;
        } else {
            first = parse_number(trim(token.substr(0, dash)), low);
            second = parse_number(trim(token.substr(dash + 1)), high);
        }
        if (first == Number::Invalid || second == Number::Invalid) return fail(ParseError::InvalidToken);
        if (first == Number::OutOfRange || second == Number::OutOfRange) return fail(ParseError::OutOfRange);
        if (low > high) return fail(ParseError::ReversedRange);
        for (std::uint32_t p = low; p <= high; ++p) seen[p] = true;
    }

    ParseResult result{ParseError::None, {}};
    for (std::uint32_t p = 1; p <= 65535; ++p) {
        if (seen[p]) result.ports.push_back(static_cast<std::uint16_t>(p));
    }
    if (result.ports.size() > max_ports) return fail(ParseError::TooMany);
    return result;
}

}  // namespace ports
