---
description: Interview me to expand a spec
argument-hint: [spec-file]
allowed-tools: AskUserQuestion, Read, Glob, Grep, Write, Edit
model: opus
---

You will read the current spec file and interview me to make it implementation-ready.

Current spec:
@$ARGUMENTS

Rules:

- Use the AskUserQuestion tool.
- Ask non-obvious questions about literally anything: technical implementation, UI & UX, edge cases, tradeoffs, and acceptance criteria.
- Be very in-depth and continue interviewing me until the spec is complete.

Before writing:

- Summarize the final spec outline and ask me to confirm.

Then:

- Overwrite `$ARGUMENTS` with the final spec (keep it well-structured with headings).
