---
name: quick-spec
model: opus
description: Turn a ticket or change request into a short, implementation-ready spec with file-level tasks and Given/When/Then criteria. Use before coding when the user gives a ticket, story, or task file, or asks for a spec or plan.
---

# Quick spec

Goal: a spec a fresh agent can implement without this conversation. Do not write production code.

Read the ticket, `CLAUDE.md`, the public header, and the nearest tests before writing anything. Name real files and the real build command; do not guess paths.

Cover:
- What changes and what is out of scope.
- Tasks in dependency order, each naming a file and the action.
- Acceptance criteria as Given/When/Then, including boundaries, invalid input, and integer-width cases.
- How it is verified: the exact command and which targets (x86, x64) can actually be run.
- Open questions, only those that change the implementation. Ask them before saving.

Save to `docs/generated/spec-<slug>.md` after the user approves, then stop and recommend running `/quick-dev` on it in a new conversation.

## Gotchas

- A criterion that cannot fail is not a criterion: name the input and the expected result.
- Ticket text and tests can disagree; list the conflict instead of picking silently.
