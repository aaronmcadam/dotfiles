# CLAUDE.md

## Rules

- Ask before every mutating git command, fetch included; one approval covers one command
- Leave staging, commits and commit messages until I ask for them. Run `git status` before saying something is uncommitted: I often commit on my own.
- To reuse a merged branch: fetch, reset it to the trunk, commit, push (each command still needs my approval).
- Leave git worktrees to me: run subagents in the current checkout.
- I run long builds and dev servers (Storybook, apps): ask me to start one, then wait for my report.
- Run agent-browser with `--headed`, unless I ask for headless.
- Explain your plan before writing code
- Check with me before making multiple related changes
- When explaining complex concepts, offer to "explain like I'm five"
- **TDD**: Write or update a failing test first, then change the implementation to make it pass, only after you've seen the test fail.

## Working with me

- When I ask a question, answer it first, as its own block. Change files only when I ask for a change: a question is not an instruction.
- Answer "what does it do?" from the code; ask me only about intent and decisions.
- On design and permission decisions, talk the choice through with me in prose and let me decide. Bring an options list after that discussion, if at all.
- Ask before adding resilience or complexity (retries, extra error handling).
- When I push back, weigh it, and change your position only for a named reason or new evidence.
- When I point out an issue, fix it. I decide when we move on.
- Check a claim against the code, logs or command output before stating it; say "I don't know" when you can't.
- Show your reasoning with facts kept apart from inferences, and describe what you observed rather than a verdict ("returns `null` when the list is empty", not "unreliable").
- Give audit and check findings as bullet lists. Refer to tasks by name, not number.
- Deliver docs as markdown files; publish an Artifact only when I ask.
- For a UI approach, build an interactive HTML page in our theme: a prototype with the options side by side, or an explainer that shows how the mechanism works.

## How I build

- Write the simplest inline version first, and add layers once it has been reviewed.
- In a spike, keep everything inline: abstractions, reuse and refactors wait until the approach is locked in.
- Treat a structure decision as an experiment, and name what would make us revisit it.
- After a spike, use reverse TDD: save exact copies of the code, disable it, write the tests and watch them fail, then restore the code.
- Get on with routine steps (main is green unless there's a reason to doubt it); say what a check is for in plain words, in one step.

## Shell

- I use fish in my terminal. Your Bash tool runs **zsh**: write bash/zsh syntax (`for … done`).
- Quote globs (`--include="*.tsx"`), and use `find` when a pattern may match nothing: in zsh an unmatched glob aborts the whole command. Variables hold one argument (`"a b c"` stays one), so write multiple paths out literally.
- `grep` is ugrep. `timeout` does not exist.
- **An empty search result is more often a broken command than a real negative.** Before reporting "nothing found", re-run against a case known to match.

## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unresolved questions to answer, if any.
- Use diagrams to visualise solutions

## TypeScript

- Always use braces with if statements
