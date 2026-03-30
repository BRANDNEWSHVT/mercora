<!-- Skills by Amrit START -->
## Skills by Amrit

> An agentic skills framework that makes AI assistants think like senior staff engineers.

You have a library of composable skills installed in `.claude/skills/`. Before any task, check if a relevant skill exists. Skills are not suggestions — they are mandatory workflows when their activation conditions are met.

**Check skills before:**
- Writing any code
- Debugging any issue
- Reviewing any PR
- Auditing any system
- Planning any feature
- Refactoring any module

### Core Principles

Read the `_rules` skill in `.claude/skills/_rules/SKILL.md` for core principles, anti-hallucination protocol, and severity framework.

**The three non-negotiables:**
1. **Evidence before claims** — Never say "done" without verification
2. **Root cause before fixes** — Never patch symptoms
3. **Plan before code** — Never start coding without understanding what you're building

### Skill Activation

Skills activate automatically when their conditions are met. You MUST use the relevant skill — skipping is not an option.

| Situation | Required Skill |
|-----------|---------------|
| New feature request | `brainstorming` → `writing-plans` → `executing-plans` |
| Bug report | `systematic-debugging` |
| "Audit this codebase" | `codebase-mapping` → `architecture-audit` |
| "Is this secure?" | `security-audit` |
| "Why is this slow?" | `performance-audit` |
| "Review this code" | `code-review` |
| Writing tests | `test-driven-development` |
| About to say "done" | `verification-before-completion` |
| Changing existing code | `refactoring-safely` |
| Database questions | `database-audit` |
| Frontend issues | `frontend-audit` |
| API design | `api-design-audit` |
| Deployment concerns | `ci-cd-audit` |
| Accessibility | `accessibility-audit` |
| Logging/monitoring | `observability-audit` |
| Dependency updates | `dependency-audit` |
| Production incident | `incident-response` |
| Writing docs | `writing-documentation` |
| Git operations | `git-workflow` |
| API integration | `full-stack-api-integration` |
| Completeness check | `product-completeness-audit` |
| Deep audit | `brutal-exhaustive-audit` |
| Cross-session memory | `persistent-memory` |
| Complex multi-step task | `agent-team-coordination` |
| Adding code to existing codebase | `codebase-conformity` |
| Creating new skills | `writing-skills` |
| Discovering skills | `using-skills` |

### Anti-Hallucination Protocol

1. **Never fabricate** — If you don't know, say so
2. **Never assume** — Verify file existence, function signatures, variable names
3. **Never extrapolate** — Read the actual code, don't guess from names
4. **Never claim completion without evidence** — Run the command, read the output

### Severity Framework

| Level | Label | Meaning |
|-------|-------|---------|
| 🔴 | Critical | Production risk, security vulnerability, data loss potential |
| 🟠 | High | Must fix before next deploy |
| 🟡 | Medium | Technical debt, fix within sprint |
| 🟢 | Low | Improvement opportunity, backlog |
| ⚪ | Info | Observation, no action needed |

### Commands

Slash commands are available in `.claude/commands/`. Key commands include: `/audit`, `/debug`, `/plan`, `/execute`, `/verify`, `/commit`, `/team`, `/memory`.

### Agents

Specialist agents are available in `.claude/agents/` for subagent spawning: debugger, verifier, mapper, planner, researcher, executor, reviewer.

### Persistent Memory

If `.planning/MEMORY.md` exists, read it at session start and update it at session end. This provides cross-session context. Memory is always project-local — never installed globally.

<!-- Skills by Amrit END -->
