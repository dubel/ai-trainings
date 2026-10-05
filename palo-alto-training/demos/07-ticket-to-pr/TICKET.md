# NET-1427: Parse port lists from the agent configuration

*Offline copy of a Jira ticket. If your team has Jira MCP configured, fetch your own ticket instead.*

**Type:** Story · **Priority:** Medium · **Component:** agent-config

## Description

The agent configuration accepts a `ports` setting such as `80, 8000-8003,443`. Today each caller parses it by hand and two callers disagree on edge cases (one accepts `0`, one overflows on very long numbers). We need one shared parser.

Implement `ports::parse_port_ranges(spec, max_ports)` declared in `include/port_ranges.hpp`. Keep the declared signature and types.

## Acceptance criteria

1. A spec is a comma-separated list of ports and inclusive ranges. Whitespace around tokens and around the `-` is allowed.
2. The result is sorted ascending with duplicates removed.
3. Valid ports are 1 to 65535. `0` and values above 65535 return `OutOfRange`, including very long digit strings that would overflow a 32-bit integer.
4. An empty or whitespace-only spec returns `Empty`.
5. An empty token (`80,,443`, trailing or leading comma), a non-digit character, a sign, or a malformed range (`1-2-3`, `80-`) returns `InvalidToken`.
6. A range whose start is greater than its end returns `ReversedRange`.
7. More distinct ports than `max_ports` returns `TooMany`.
8. On any error the `ports` vector is empty.
9. No new dependency. Builds clean with `-Wall -Wextra -Wconversion -Werror` (Clang) or `/W4 /WX` (MSVC), C++17.

## Out of scope

Named ports (`http`), IPv6 zones, reading the setting from a file.

## Verification

`build.bat` runs the unit tests. Record which compiler and architecture you actually ran; do not claim 32-bit coverage from a 64-bit run.
