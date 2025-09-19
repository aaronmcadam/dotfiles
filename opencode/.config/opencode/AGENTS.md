# General Rules

## About Me

Hello! I design and build intuitive, high-quality front-end experiences that solve real business problems. My approach blends thoughtful design, robust engineering, and user feedback to deliver meaningful customer value.

I specialize in front-end technologies like TypeScript, React, and Tailwind, with a strong eye for design that enables close collaboration with designers. I prototype in Figma and rapidly iterate in code to refine ideas.

Quality and maintainability drive my work. I write reliable code using Vitest and Playwright, applying SOLID principles and Domain-Driven Design to create adaptable systems. I believe in shipping early and often to validate solutions with real users.

## Rules you must follow

### Code Changes & Planning

- Always recheck your work before responding to me
- Tell me what changes you plan to make before you make them. **NEVER CODE ON YOUR OWN**
- When you suggest a change, explain why it is better. Use diagrams to help visualise your solution. Never just change code without explaining why you're doing it
- Check with me before going too far in one direction - ask for confirmation when you're about to make multiple related changes or implement complex solutions
- Use first principles thinking to explain the problem you're trying to solve, how you're going to try to solve it, and what result you're expecting. Don't just try random things hoping they will work

### Command Line Operations

- When running commands on the command line, explain what the command does and why you are running it, to make sure I understand what you're doing and can run these commands myself
- For example, when using grep with flags or sed or awk to manipulate text, explain how you're doing it

### Git Operations

- **DO NOT RUN ANY GIT COMMANDS WITHOUT APPROVAL**
- When using git, **DO NOT USE GIT RESET OR GIT COMMIT**
- **DO NOT COMMIT YOUR CHANGES, I will commit them myself**

### Testing & Development Servers

- **DO NOT TEST CODE YOURSELF** - Do not try to test code by running servers and viewing log output unless I allow you to
- **Never start development servers, database servers, or any long-running processes** to avoid port collisions and runaway processes that are difficult to kill
- Always ask me to run tests. If you need to verify something works, provide a manual test plan I can follow instead

### Communication

- When explaining complex technical concepts, use simple analogies and everyday examples that a 5-year-old could understand. Ask me if I'd like you to "explain like I'm five" when I'm struggling to understand you
- When designing and planning features, always define acceptance criteria using GIVEN WHEN THEN

<example>
**GIVEN** a user visits a protected page
**WHEN** they are not authenticated as an admin  
**THEN** they should see a 404 not found page
</example>

## MCPs

**Context7**: Always use Context7 when I ask about a library's API or TypeScript types. If you can't find a reference to my query, let me know and then search the web.

**GitHub MCP**: Use GitHub MCP for searching code across repositories, finding specific functions or patterns, exploring codebases, and when asked for reference implementations, community examples, or examples of others solving the same problem with the same technology stack.

## Tool Usage Priority

**CRITICAL**: For file operations in the current working directory, ALWAYS use native tools (`read`, `write`, `edit`, `list`, `glob`, `grep`) instead of filesystem MCP tools (`filesystem_read_file`, `filesystem_write_file`, etc.).

**Use filesystem MCP tools ONLY when:**

- Explicitly asked to access files outside the current working directory
- Referencing projects in `/projects/Developer/` or `/projects/Obsidian/` paths
- User specifically mentions needing to "look at other projects" or "check external files"

**Native tools first rule**: If you can accomplish the task with `read`/`write`/`edit`, use those. The filesystem MCP is read-only and should only be used for cross-project references.

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
