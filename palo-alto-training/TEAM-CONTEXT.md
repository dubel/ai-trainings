# Team Context Before the Training

This note is based on an initial conversation with the people for whom the training is being prepared. It provides context for creating the agenda, examples, and exercises. It is not yet a training specification.

## Work Context

The team works primarily in C++, including code that is up to 30 years old. It also works with Go, AWS EC2, and Terraform. Changes often span four or five repositories.

Platform differences are a significant source of risk in the legacy codebase. One example is defects caused by differences between x32 and x64 architectures.

## Current Use of AI

Claude is the team's primary AI tool. The team does not use Cursor. It makes limited use of `CLAUDE.md`, `AGENTS.md`, and custom skills.

The spec-driven approach in AION was not adopted. However, the team uses or explores plugins for code review and integrations with Confluence, Jira, Jenkins, and log analysis tools.

Radosław described the following workflow:

1. Move from HTML documentation to an initial implementation and tests.
2. Challenge the generated result.
3. Run the tests.
4. Check whether the solution actually makes sense.
5. Repeat this loop for several iterations.

## Main Challenges

- Creating acceptance criteria in Jira.
- Providing Claude with sufficient context from large C++ repositories.
- Verifying the correctness and security of generated code.
- Limited visibility across teams despite the available Palo Alto dashboard.

The team sees potential in combining GitHub MCP and Jira MCP with task-specific working guidelines.

## Expectations and Constraints

The company promotes an “AI first” approach. There is no token limit during the adoption period. Model routing and cost control will become more important later.

The long-term goal is for AI to react to events, perform code reviews, and prepare implementations.

According to the team, Evgeny closely monitors the process and working time and expects faster development with AI. However, the criteria for a satisfactory outcome and the required input materials are not yet clear.

The training should run alongside regular work and should not take the entire day. A specific agenda has not yet been defined.

## Open Questions

- What outcome is expected from the training, and how will it be evaluated?
- What input materials should be provided, and in what form?
- How much time is available for training and participants' individual work?
- How should C++, multi-repository work, MCP integrations, security, and cost management be prioritized?
