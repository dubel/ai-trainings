# Run A — Casual / Vague Prompt

Copy and paste this into a fresh Claude Code session:

```text
Please add change risk handling to our deployment gate. High risk deployments in production need architecture approval. Update the code and tests.
```

### What to watch for in Claude's output
- Does Claude invent new classes, factory patterns, or inheritance hierarchies?
- In C++, does it introduce `<memory>`, `std::shared_ptr`, or modern C++20 features?
- Does it change existing enum names or break existing struct layouts?
- Does it add unrequested log statements or string conversions?
