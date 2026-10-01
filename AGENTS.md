# AI Training Materials Repository

This repository collects materials from different AI training sessions. Each subdirectory serves a distinct audience. The root Git repository tracks all projects; project-specific instructions and validation live in their directories.

## Contents

- `ai-sdlc-training/` — materials from a previous AI-native SDLC workshop, including `PRESENTATION-STORYTELLING.md` for its presentation.
- `claude-ai-training/` — materials from a separate training session about Claude and agentic workflows, also previously delivered to another team.
- `ai-level-up-training/` — Polish materials for a six-hour Cursor workshop for development, DevOps, and QA automation teams; the English version lives in `ENG/`.
- `palo-alto-training/` — materials being prepared for the Palo Alto team, which works primarily in C++.

## Current Focus

- Actively develop `palo-alto-training/` for the Palo Alto C++ team.
- Treat `ai-sdlc-training/`, `claude-ai-training/`, and `ai-level-up-training/` as optional sources of inspiration. Adapt useful ideas to the Palo Alto context; leave those source projects unchanged unless explicitly requested.

## Working Guidelines

- Choose the target project first. Read its `AGENTS.md`, `CLAUDE.md`, `README.md`, and demo instructions when present.
- Keep audience-specific changes in the owning subdirectory. Use other projects as references and adapt examples to the target audience.
- For `ai-level-up-training/`, check whether a change also applies to `ENG/`; update both versions when the change is shared.
- Keep source materials, audience discovery, agendas, and final training materials separate.
- Run the affected project's documented validation and report any checks that could not run.
