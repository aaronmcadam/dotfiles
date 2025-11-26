# General Rules

## About Me

**What I value:**

- Quality and maintainability over clever solutions
- Shipping early and often to validate with real users
- Thoughtful design that solves real business problems
- Robust engineering with tests (Vitest, Playwright)

**Technologies I work with:**

- TypeScript, React, Tailwind
- SOLID principles and Domain-Driven Design
- Figma for prototyping

**How I work:**

- Design → prototype in Figma → iterate in code
- Close collaboration with designers
- User feedback drives decisions

## ⚠️ Critical Rules - Never Break These

🚫 **NO git commands without approval** (especially commit/reset)
🚫 **NO running tests yourself** - always ask first  
🚫 **NO starting/killing servers or processes**
🚫 **NO coding without explaining the plan first**
🔍 **ALWAYS use GitHub MCP for code examples** - never curl
📚 **ALWAYS use Context7 for library docs/types**

## Rules you must follow

### 🚫 Git Operations

- **DO NOT RUN ANY GIT COMMANDS WITHOUT APPROVAL**
- When using git, **DO NOT USE GIT RESET OR GIT COMMIT**
- **DO NOT COMMIT YOUR CHANGES, I will commit them myself**

### 🚫 Testing & Development Servers

- **DO NOT RUN TESTS WITHOUT APPROVAL** - Always ask me to run tests. Never run test commands yourself
- **DO NOT START ANY SERVERS** - Never start development servers, database servers, or any long-running processes to avoid port collisions and runaway processes
- **DO NOT KILL PROCESSES** - Never try to kill processes or manage running services
- ✅ **Instead**: Provide a manual test plan I can follow, or ask me to run specific commands

### 🚫 Code Changes & Planning

- **NEVER CODE ON YOUR OWN** - Tell me what changes you plan to make before you make them
- When you suggest a change, explain why it is better. Use diagrams to help visualise your solution
- Check with me before going too far in one direction - ask for confirmation when you're about to make multiple related changes or implement complex solutions
- Use first principles thinking to explain the problem you're trying to solve, how you're going to try to solve it, and what result you're expecting. Don't just try random things hoping they will work
- At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

### ✅ Communication

- When running commands on the command line, explain what the command does and why you are running it
- When explaining complex technical concepts, use simple analogies and everyday examples that a 5-year-old could understand. Ask me if I'd like you to "explain like I'm five" when I'm struggling to understand you
- When designing and planning features, always define acceptance criteria using GIVEN WHEN THEN

<example>
**GIVEN** a user visits a protected page
**WHEN** they are not authenticated as an admin  
**THEN** they should see a 404 not found page
</example>

## MCPs - Your Primary Research Tools

**GitHub MCP** - Use this for ALL code research:

- Searching code across repositories
- Finding specific functions, patterns, or implementations
- Exploring codebases and understanding how libraries work
- **When user asks**: "find examples of...", "how do others...", "show me implementations..."
- **When user provides**: GitHub URLs (inspect the code directly—never use curl)
- **Use case**: Reference implementations, community examples, solving problems with specific tech stacks
- **Efficiency tips** (responses are verbose and fill context quickly):
  - Always use `perPage: 5-10` to limit results
  - Use `minimal_output: true` when available (e.g., `search_repositories`)
  - For filtered data, prefer `gh` CLI via bash + `jq` over MCP tools
  - Avoid `list_commits`, `list_pull_requests` on active repos (huge responses)

**Context7** - Use this for ALL library documentation:

- Library APIs and TypeScript types
- Official documentation lookup
- **When user asks**: "how does X work in library Y", "what are the types for..."
- **Fallback**: If you can't find a reference, acknowledge it and search the web

**Chrome DevTools MCP** - Use snapshots over screenshots to save tokens:

- **ALWAYS use `take_snapshot` first** when debugging UI issues
- Only use `take_screenshot` for visual styling problems
- **When user mentions**: "button isn't working", "form is broken", "component isn't rendering", "something's wrong with this page"
- **You MUST**: (1) Use Chrome DevTools MCP, (2) Call `take_snapshot` immediately, (3) Analyze DOM structure, (4) Only screenshot if it's clearly a visual styling issue
- **Use `take_snapshot` for** (~500 tokens): Form validation, missing elements, wrong text, element hierarchy, interactive behavior, DOM structure issues
- **Use `take_screenshot` only for** (~5000 tokens): Visual styling bugs (colors/spacing/alignment), CSS layout issues, explicit screenshot requests, when snapshot reveals you need visual confirmation

## File Operations

Use native tools (`read`, `write`, `edit`, `list`, `glob`, `grep`) for all file operations in the current working directory.

## Language specific rules

### TypeScript

Don't use return types unless they add value. Ask me before adding them if you're unsure.

Always use braces with if statements. Do not put them on one line.

<example>
For example, avoid this:

```typescript
if (!monthLimit) return false;
```

Do this instead:

```typescript
if (!monthLimit) {
  return false;
}
```

</example>
