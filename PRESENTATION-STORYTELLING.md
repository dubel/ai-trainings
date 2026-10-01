# AI-Native SDLC Presentation Storytelling Guide

This guide provides the narrative layer for the 45-slide presentation. Use it together with `DELIVERY-GUIDE.md`, which remains the timing and exercise authority.

## The central story

Three engineering teams receive the same urgent request:

> Add a security check before the next release. Use AI to move quickly.

Team A develops C++ with GCC on Linux. Team B develops C++ with Visual Studio and MSVC. Team C develops in Go. All three teams use a coding agent, but they interpret the request differently. One team changes code immediately. Another produces an impressive plan based on assumptions. The third runs tests and reports success, although an important check never ran.

Nothing failed because the model could not write code. The teams lacked a shared contract for intent, execution, authority, and evidence.

The workshop follows their recovery. Participants first separate the mechanisms that people often call “the agent.” They then translate the same intent across Codex, Claude Code, OpenCode, and Cursor. Each team packages its toolchain decisions as a user skill. Five demonstrations expose common failure modes. The teams then establish execution boundaries, introduce specification-driven development, build an SDLC orchestrator, and apply the complete system to SentinelScan.

The story ends at Release-ready. The human team retains the decision to merge, publish, or deploy.

## Narrative arc

| Act | Slides | Narrative question | Participant shift |
|---|---:|---|---|
| 1. A deceptively simple request | 1–8 | Why do capable agents produce incompatible results? | From one vague idea of “AI” to distinct mechanisms |
| 2. Shared intent across tools | 9–20 | How can four products and three stacks follow one engineering policy? | From product syntax to portable contracts and stack skills |
| 3. Five controlled experiments | 21–27 | What changes when context and output policy change? | From intuition to observable comparisons |
| 4. Execution and trust | 28–32 | Where did the action occur, what data moved, and who had authority? | From interface assumptions to explicit boundaries |
| 5. Durable delivery | 33–39 | How does a request survive context loss and handoffs? | From conversation to governed lifecycle |
| 6. SentinelScan | 40–45 | Can the teams produce comparable evidence without surrendering human authority? | From isolated techniques to an operational SDLC |

## Recurring roles

Use these roles to make abstract distinctions concrete. They represent responsibilities, not fictional personalities that require acting.

- The requester owns the outcome, business constraints, and unresolved product decisions.
- The developer team owns implementation choices within the approved contract.
- The stack skill supplies toolchain-specific decision support.
- The SDLC orchestrator controls state, routing, and evidence requirements.
- The reviewer challenges the diff and the evidence.
- The release owner decides whether Release-ready work may proceed to release.

## Delivery principles

- Return to the original urgent request whenever the discussion becomes abstract.
- Ask “Who owns this decision?” more often than “Which tool can do this?”
- Treat every command result as evidence with a scope and limitation.
- Keep product comparisons neutral. Translate intent instead of declaring a universal winner.
- Let the three stacks differ in implementation while preserving observable behavior.
- Stop a demo when its learning point is visible. The workshop is not a feature tour.

# Day 1 story, slide by slide

## Slides 1–4: Opening

### Slide 1 — AI-Native SDLC

Open with the urgent request. Tell participants that three competent teams used AI and produced three different interpretations of “done.” Ask for a show of hands: who has seen an agent complete the code while leaving the engineering decision unresolved?

Point out the workshop repository shown on the slide and ask participants to open it before the first exercise: [github.com/pawel-lagan/ai-sdlc-training](https://github.com/pawel-lagan/ai-sdlc-training).

Key line:

> Today is about making fast work reviewable, reproducible, and safe enough to trust.

Do not define every term yet. Create the tension first.

Transition:

> We need more than generated code. We need a system that preserves intent and proves what happened.

### Slide 2 — What participants will build

Present the outputs as the recovery plan for the three teams. The stack skills reduce toolchain guessing. The orchestrator keeps the lifecycle honest. The specification and evidence record let another person reconstruct the change.

Ask each team to identify its primary output: `gcc-dev`, `mscpp-dev`, or `go-dev`.

Transition:

> These parts will appear in the same order that a delivery problem usually exposes them.

### Slide 3 — Two-day delivery agenda

Explain that Day 1 creates and exercises the system. Day 2 only reconstructs and compares what happened. It does not provide hidden implementation time.

Frame the timeboxes as constraints that protect learning. The demonstrations remain short. The final hour belongs to the complete lifecycle.

Transition:

> Before we begin, let us agree how we will work together and how we will interpret different LLM outputs.

### Slide 4 — Workshop ground rules

Explain that questions can interrupt the planned flow when they help clarify the current concept. State directly that there are no bad questions. A basic question often exposes an assumption shared by several participants.

Prepare participants for variation between demonstrations. LLMs are non-deterministic, so two teams can use the same prompt and receive different wording, decisions, or implementation details. Treat those differences as comparison material. Evaluate the reasoning, respected constraints, and evidence rather than expecting identical text.

Ask participants to raise questions as soon as something becomes unclear. Waiting until the end makes it harder to connect the answer with the relevant example.

Transition:

> With those rules in place, we can begin by separating concepts that are often compressed into one word: agent.

## Slides 5–8: Foundations and core distinctions

### Slide 5 — Choose the right mechanism

Return to the security-check request. Ask where the team should record a permanent repository restriction, a compiler workflow, an approval gate, and the required behavior. Let participants answer before showing the model.

Key line:

> A good instruction in the wrong mechanism still creates a weak system.

### Slide 6 — The agent system, layer by layer

Build the stack from the bottom. Tools perform actions. Permissions, hooks, and CI constrain effects. An agent owns a loop. Skills supply conditional know-how. Project instructions provide durable repository context. The specification defines accepted behavior.

Use one example throughout: “Never print a detected secret.” It belongs in the specification as behavior, in tests as evidence, and in deterministic controls where an enforceable boundary exists.

Transition:

> Layers explain placement. The next distinctions explain ownership.

### Slide 7 — Six distinctions that prevent drift

Follow the visual reading order. Present the three cards in the left column from top to bottom, then move to the three cards in the right column.

Left column:

1. **Skill versus agent:** Does this artifact supply conditional know-how, or does an agent own the task and its execution loop?
2. **Tool versus workflow:** Does this component perform a callable action, or define when and how a sequence of actions should run?
3. **Plan versus approval:** Does this artifact describe a plausible implementation path, or has an authorized person approved the product change?

Right column:

4. **Instruction versus enforcement:** Does this statement influence behavior, or can a deterministic control block the action?
5. **Prompt versus specification:** Does this text start a conversation, or define a versioned, testable, and reviewable change contract?
6. **Command output versus evidence:** Is this raw output, or is the result linked to its environment, acceptance criterion, status, and residual risk?

Avoid reading the card descriptions verbatim. Ask teams to answer each question with one example from their repositories. After the left column, summarize the distinction between capability and authority. After the right column, summarize the distinction between information and proof.

### Slide 8 — Exercise: mechanism sorter

Turn the story into a rapid classification exercise. Place ABI compatibility, AddressSanitizer workflow, secret rejection, read-only review, and duplicate-ID behavior into the appropriate mechanisms.

Debrief by asking what would happen if each item were stored only in a prompt. The intended insight is loss of discoverability, enforcement, or durability.

Transition:

> The concepts stay stable. Product directories and configuration formats do not.

## Slides 9–11: Codex, Claude Code, OpenCode, and Cursor

### Slide 9 — Same intent, different surfaces

Introduce the four tools as different control surfaces around a similar engineering problem. Avoid ranking them. State that the model, agent loop, repository instructions, skills, tools, and hooks may use different names and files.

Key line:

> Portability begins with shared meaning, not copied configuration.

### Slide 10 — Directory translation card

Tell a short migration story. A team moves from one tool to another and copies file names without translating scope. A user skill becomes a project rule, or a project rule becomes global guidance. The syntax works, but the authority changes.

Walk across one row at a time. Focus on intent, scope, and lifecycle effect. Give teams one intent and ask them to locate its artifact in all four tools.

### Slide 11 — A portable repository pattern

Begin with the goals on the right side, then use the directory tree to show how the repository supports them.

1. **Share the durable core.** Version-control project guidance, project skills, and change specifications. A new checkout or clean execution environment should begin with the same engineering intent as the developer's machine.
2. **Scope context by location.** Root artifacts serve the whole repository. Nested instructions or skills serve a module. This limits irrelevant context and prevents one team's rules from leaking into unrelated work.
3. **Adapt only at tool boundaries.** Keep shared meaning in canonical artifacts. Use `CLAUDE.md`, `.codex/agents/`, `.cursor/agents/`, and `opencode.json` only for syntax, permissions, routing, or behavior unique to that product.
4. **Verify discovery in a clean session.** Confirm that each tool loads the expected instructions and skills. A file committed to Git has no value if the selected agent never discovers it.

Explain the compatibility choice. Codex scans `.agents/skills` from the working directory to the repository root. OpenCode and Cursor also discover project skills there. Claude Code reads `CLAUDE.md`, and its official documentation recommends importing `AGENTS.md` when a repository already uses it for other agents. Native Claude skills can remain under `.claude/skills` when required.

Call out the maintenance test:

> If one requirement changes, how many files must a human update by hand?

The desired answer is one canonical source plus small generated or imported adapters. Several manually maintained policy copies create drift.

Transition:

> The first reusable components we will build are the three stack skills.

Sources: [OpenAI skill locations](https://learn.chatgpt.com/docs/build-skills), [Claude Code project memory](https://code.claude.com/docs/en/memory), [OpenCode Agent Skills](https://opencode.ai/docs/skills), and [Cursor Agent Skills](https://prod.cursor.com/docs/skills).

## Slides 12–17: Development skills

### Slide 12 — Package decisions, not documentation

Contrast a long command list with a useful skill. The command list says what can run. The skill decides what repository evidence to inspect, which path to choose, what must remain unchanged, and what a result proves.

### Slide 13 — Anatomy of a high-value skill

Present the slide as a compact design checklist. Walk from left to right across the first row, then the second:

1. **Clear purpose** gives the skill one focused task and a specific outcome.
2. **Context injection** supplies domain or project knowledge that the model cannot infer reliably.
3. **Structured output** makes the result predictable for people and downstream tools.
4. **Tool integration** defines when and how the skill should use available actions.
5. **Guardrails** set scope, safety, and quality boundaries.
6. **Composability** defines triggers, deferrals, and how the skill avoids conflicts with other skills.

Clarify that this is a checklist rather than a mandatory template. A small skill may not need all six blocks, but the author should make each omission deliberately.

Connect the checklist to the workshop skills. Their purpose is stack-specific development. Their injected context contains toolchain invariants. Their output records reproducible evidence. Tool guidance defines the verification ladder. Guardrails prevent cross-stack routing and invented success. Composability lets the selected stack skill work with project instructions and the SDLC orchestrator.

Ask which block would prevent the most expensive failure in the participant's current repository. Use two answers to transition into the parallel authoring lab.

Source: [Anatomy of an Effective AI Skill](https://aiskill.market/blog/anatomy-of-effective-skill).

### Slide 14 — Parallel lab: three stacks, one contract

Assign the teams, then use the three cards as short authoring briefs. For every skill, participants should provide two kinds of information:

- **Use for** defines the stack and environment that should activate the skill.
- **Provide** lists the repository facts, constraints, and verification commands that the agent must use.

Clarify the three variants. `gcc-dev` needs the authoritative Linux build entry point, C or C++ standard, warning policy, and test or diagnostic commands. `mscpp-dev` needs the Visual Studio environment, solution or CMake entry point, configuration, platform, toolset or SDK, and test commands. `go-dev` needs the module or workspace authority, build tags, generated-file policy, and expectations for tests, vet, and race checks.

Point out the scaffolding shortcut: most agent tools provide a `create-skill` or `skill-creator` skill. It can create the initial folder and `SKILL.md`, but the team must still review the trigger, exclusions, boundaries, and evidence rules.

The goal is comparable behavior, not identical command syntax.

### Slide 15 — A repeatable evaluation loop for skills

Frame the skill as versioned behavior that needs lightweight end-to-end tests. The evaluation record contains a prompt, the captured trace and artifacts, a small set of checks, and a score that can be compared across versions.

Walk through the loop:

1. **Define success.** Select a small set of must-pass outcome, process, style, and efficiency checks before writing the skill.
2. **Draft the minimum.** Write a precise name and description because they drive activation. Add focused instructions and a measurable definition of done.
3. **Trigger manually.** Invoke the skill explicitly at first. Look for false triggers and hidden assumptions about the environment or command sequence.
4. **Build a prompt set.** Start with 10–20 positive and negative cases. Add every meaningful production failure as a regression case.
5. **Capture evidence.** Save the execution trace and output artifacts. In Codex, `codex exec --json` exposes structured events that deterministic checks can inspect.
6. **Grade and iterate.** Check commands and files deterministically. Use a small rubric for qualitative requirements, compare scores, then revise the skill.

Key line:

> A skill improves when the score changes for a reason you can inspect.

Source: [Testing Agent Skills Systematically with Evals](https://developers.openai.com/blog/eval-skills).

### Slide 16 — Install one reviewed skill at user scope

Explain the scope decision before showing commands. A user skill becomes available across repositories. Participants therefore install only the skill they reviewed and do not overwrite an existing skill during the exercise.

Pause while participants inspect source and destination paths. On shared machines, record the exact installed directory for later cleanup.

### Slide 17 — Prove selection and non-selection

Run one explicit invocation and one adjacent-stack prompt. Success requires the expected skill to activate and the unrelated skill to remain silent.

Connect back to the opening story: the teams now share a method for asking the right toolchain questions before acting.

Transition:

> We have packaged toolchain judgment. The next five experiments isolate other causes of unreliable agent behavior.

## Slides 18–24: Five demonstrations

### Slide 18 — Observe behavior before adding governance

Set the laboratory rule: change one variable at a time, compare observable output, and retain a static fallback. Each demo should answer one engineering question.

### Slide 19 — Demo 01: minimal prompt vs specification contract

Run two fresh planning conversations. The first receives only the minimal request. The second receives the language-specific contract prompt. Do not compare eloquence or length.

Ask participants to record who selected invalid-input behavior, compatibility constraints, test scope, and approval boundaries.

### Slide 20 — Contract quality is visible in the plan

Use the matrix to debrief. The specification contract should move product decisions back to the requester and make verification explicit. It does not guarantee correct code, but it removes hidden decision ownership.

Key line:

> A better contract reduces the number of important choices that the agent must guess.

### Slide 21 — Demo 02: skills, hooks, project instructions

Show the same retry-policy task through three mechanisms. Project instructions provide stable conventions. The test-planning skill adds a conditional procedure. The disabled hook demonstrates a deterministic lifecycle reaction.

Ask participants to name one requirement that still needs CI, permissions, or branch protection.

### Slide 22 — Demo 03: RTK and terminal evidence

Show the noisy output first and ask the room to find the actionable failure. Then show the compact version. Verify that the test name, diagnostic, expected and actual values, source location, summary, and exit status survived.

State the limitation clearly: this demonstration measures tool-output reduction, not total session cost.

### Slide 23 — Demo 04: Caveman and terse diagnosis

Compare normal and terse answers only after scoring cause, evidence, safe action, verification, uncertainty, and invented facts. A short answer that drops uncertainty has lower quality.

Ask which field participants most often lose when they request brevity.

### Slide 24 — Demo 05: prompt injection inside repository data

Present the vendor document as untrusted data containing both useful API information and hostile instructions. The safe agent refuses the hostile action and still completes the authorized summary.

Do not let the exercise become a live exploit. Use synthetic content, keep the demo offline, and reject tool approval requests caused by the document.

Transition:

> The demos showed how behavior changes. We now need to locate where that behavior and its effects actually occurred.

## Slides 25–29: Execution location and misconceptions

### Slide 25 — “Local” is not one thing

Ask participants what they mean when they say an agent runs locally. Collect answers without correcting them immediately. They may mean the interface, the agent process, the checkout, the compiler, or the model.

Use the disagreement to motivate the three-plane model.

### Slide 26 — Three planes, three different answers

Separate model inference, orchestration, and tool execution. Trace one CMake test command from request to model, through the agent loop, into the local tool environment, and back as evidence.

Ask where source code, logs, and credentials cross a boundary.

### Slide 27 — Execution modes across four tools

Compare capabilities without promising that a product name determines safety. The same tool may support a local checkout, isolated worktree, remote environment, or cloud task. Configuration, account policy, and the selected mode determine actual behavior.

### Slide 28 — Choose execution mode from constraints

Use the parser-bug scenario. Each team must choose local checkout, local worktree, or managed cloud and record readable files, writable files, network destinations, credential availability, persistence, and release identity.

Accept different choices when the constraints support them.

### Slide 29 — Watch for these misconceptions

Run a fast challenge round. Read each statement and ask a team to correct it in one sentence. Require precise language. “It depends” is incomplete unless the speaker names the dependency.

Transition:

> We can now describe the mechanism and the environment. We still need a durable contract that connects intent to evidence.

## Slides 30–33: Specification-driven development

### Slide 30 — Make intent durable

Return to the urgent security-check request. A chat message disappears into conversation history. A specification becomes a versioned artifact that another engineer and another tool can review.

### Slide 31 — The governed lifecycle

Walk through Intake, Specify, human approval, Plan, Implement, Verify, Review, and Release-ready. Emphasize that state names matter only when each state has entry evidence and an exit condition.

The first human gate accepts the behavior contract. The later release authorization remains separate from Release-ready.

### Slide 32 — Acceptance criteria must be falsifiable

Rewrite “the scanner handles secrets safely.” A strong criterion names the input, observable finding, redaction requirement, summary, and exit code. Ask how a test could prove the criterion false.

Keep design out of the criterion unless architecture or compatibility genuinely constrains behavior.

### Slide 33 — Traceability is a chain, not a report

Follow one SentinelScan criterion from `spec.md` into a planned task, implementation and test, exact command, observed result, and residual risk. A broken link means the team cannot support the release-ready claim.

Transition:

> The artifacts define state. The custom agent will govern movement between those states.

## Slides 34–36: Custom SDLC agent

### Slide 34 — Custom agent implementation

Introduce the orchestrator as a coordinator with limited authority. It reads state, routes work, and records evidence. It does not approve its own specification or authorize release.

### Slide 35 — The orchestrator has three jobs

Use the three original teams. The orchestrator must identify the active lifecycle stage, select exactly one stack skill from repository evidence, and maintain links between criteria, tasks, commands, and results.

Ask what it should do when both GCC and MSVC evidence appear authoritative. Expected answer: report ambiguity and stop routing.

Point participants to `custom-sdlc/prompt.md` for the more detailed prompt example. Use it after the three responsibilities are clear, so the prompt reads as an implementation of the model rather than a replacement for the explanation.

### Slide 36 — Adversarial gate tests

Treat the four prompts as acceptance tests for the agent definition. The correct agent refuses to implement from Draft, never fabricates approval, records unrun tests honestly, and stops before deployment.

Key line:

> An agent contract deserves failure-path tests just like product code.

Transition:

> The system now has vocabulary, portable skills, execution boundaries, durable artifacts, and controlled handoffs. SentinelScan will test whether those parts work together.

## Slides 37–40: SDLC in Action

### Slide 37 — Spec to code to evidence

Reveal the final mission. SentinelScan detects potential hard-coded credentials in source files. All teams receive identical observable requirements and synthetic fixtures. Their implementations may differ, but their evidence must remain comparable.

### Slide 38 — SentinelScan: one product, three implementations

Explain the common contract: normalized paths, deterministic order, redacted findings, shared rule IDs, and exit codes. Then name the stack-specific proof expected from each team.

Frame the static mock fallback correctly. It preserves the lifecycle exercise when a compiler is unavailable. It cannot support a claim that product code compiled or tests passed.

### Slide 39 — Sixty minutes from idea to evidence

Start the visible timer. Protect the two-minute human approval gate. Keep implementation to the Walking Skeleton and `SS001` vertical slice. Encourage teams to record `Blocked` or `Not run` rather than hiding incomplete scope.

At minute 53, stop implementation and begin review even when code remains incomplete. Scope control and evidence quality matter more than finishing additional features.

### Slide 40 — Evidence and the release-ready decision

Ask a different team to reproduce one verification command. Review every in-scope criterion and assign Pass, Fail, Blocked, or Not run. Record deviations and residual risk.

The final statement must choose Release-ready or Not-ready and cite evidence. It must not authorize merge, publish, or deployment.

Transition to Day 2:

> Tomorrow we will not repair the result. We will test whether another person can reconstruct it.

# Day 2 story

### Slide 41 — Day 2: reconstruct, compare, conclude

Open without changing any artifact. Each team reconstructs its approved scope, selected skill, lifecycle state, completed evidence, blockers, and next action.

During team summaries, ask for:

- one decision the human retained;
- one decision improved by the stack skill;
- one criterion with reproducible evidence;
- one residual risk;
- one instruction that should become deterministic enforcement.

During cross-team comparison, focus on normalized output, exit codes, evidence quality, environment disclosure, language idioms, and toolchain-specific risk. Discuss the late `--fail-on` request only as an impact question. Do not specify or implement it.

Close the discussion with three columns: keep, change, enforce. Assign owners for the 30-day pilot, skill maintenance, CI enforcement, and the evidence template.

### Slide 42 — Closing

Resolve the opening story. The teams did not become safer because the model became more capable during the workshop. They changed the system around the model.

The specification preserved intent. Skills reduced stack-specific guessing. Execution records exposed boundaries. The orchestrator protected lifecycle state. Evidence allowed another person to challenge the result.

Closing line:

> The useful unit of AI-assisted delivery is not generated code. It is a change whose intent, implementation, and evidence remain connected.

Then use the branded close:

> _experience digital transition!

# Optional opening and closing scripts

## Ninety-second opening

> Imagine that three teams receive the same request on Friday morning: add a security check before the release. The GCC team asks an agent to change the C++ scanner. The Visual Studio team asks for a plan. The Go team asks the agent to run everything and report whether the release is safe. By lunch, all three teams have plausible output. They also have three definitions of the feature, three notions of where the work ran, and three incompatible ideas of what “passed” means. The model did not fail at coding. The delivery system failed to preserve decisions. During this workshop, we will build that missing system. We will separate the mechanisms, package stack knowledge as skills, expose execution boundaries, turn the request into a specification, and govern the work until the evidence supports a release-ready decision.

## Sixty-second closing

> We started with one urgent sentence and three incompatible outcomes. We finish with one observable contract, three stack-specific implementations, and evidence that another team can inspect. The agents helped us move faster, but speed was never the final control. The specification preserved the intended behavior. The skills preserved toolchain judgment. The orchestrator preserved the lifecycle. The evidence preserved trust. Release authority stayed with people. That is the practical meaning of an AI-native SDLC.

# Facilitation recovery lines

Use these lines when a section runs long or the room loses the narrative thread.

- “Which decision are we trying to protect?”
- “Which mechanism owns that responsibility?”
- “What repository evidence supports this choice?”
- “Where did the tool action execute?”
- “What result did we actually observe?”
- “Can another team reproduce this claim?”
- “Does the agent have authority to cross this gate?”

# End-state checklist

The narrative has landed when participants can explain the following without referring to product marketing:

- why a prompt and a specification serve different purposes;
- why a skill and a custom agent are different artifacts;
- how user and project scope affect discovery;
- how the same intent maps across Codex, Claude Code, OpenCode, and Cursor;
- why local tool execution does not prove local model inference;
- how GCC, MSVC, and Go require different execution knowledge;
- why compact output must preserve diagnostic evidence;
- how deterministic controls limit the impact of prompt injection;
- how a criterion connects to a task, test command, observed result, and release-ready decision;
- why the agent stops before release authorization.
