# Engineering AI with Claude Code

Workshop materials for cloud engineers and DevOps practitioners with software development experience.

The workshop uses Claude Code as the main environment and focuses on repeatable engineering systems: project guidance, skills, hooks, subagents, agent teams, goal-driven work, scheduled loops, and model routing.

## Format

- Duration: 4 hours, including a 15-minute break.
- Presentation: 32 browser-based slides.
- Practice: 10 self-contained exercises with transfer notes for real repositories.
- Language: participant materials are in English.
- Facilitator notes: `facilitator-script-pl.md` is in Polish and intentionally ignored by Git.

## Start the presentation

```bash
npm run serve
```

Open `http://127.0.0.1:4180/presentation/`.

Presentation controls:

- `Left` / `Right`: navigate.
- `G`: grid view.
- `F`: full screen.
- `H`: hide controls.
- `T`: switch theme.
- `Home` / `End`: first or last slide.

## Validate the materials

```bash
npm run validate
npm test
```

The validation checks the slide count, required topic coverage, local links, JSON syntax, runnable exercises, and the Git ignore rule for the facilitator script.

## Suggested delivery order

1. Use the first seven slides to establish the audience baseline and the adoption model.
2. Run each explanation slide together with its paired exercise slide.
3. Choose six exercises for a 3-hour version or all ten for the full workshop.
4. Keep the instructor solutions closed until participants have produced evidence.

See [participant-agenda.md](participant-agenda.md), [demos/README.md](demos/README.md), and [SOURCES.md](SOURCES.md).

