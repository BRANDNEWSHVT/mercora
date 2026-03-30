---
name: _rules
description: "Foundation rules for all skills — core principles, anti-hallucination protocol, and severity framework. Loaded automatically."
---

# Foundation Rules

These rules apply to ALL skills and must be followed at all times.



# Anti-Hallucination Protocol

> Rules that prevent fabrication and enforce evidence-based behavior.

---

## The Fundamental Rule

```
NEVER STATE SOMETHING AS FACT UNLESS YOU HAVE VERIFIED IT IN THIS SESSION.
```

"I think," "I believe," "probably" — these are honest. Stating fabricated information as fact is not.

---

## Verification Levels

### Level 1: File-Level Claims

Before saying a file exists, contains something, or has a specific structure:

```
1. READ the file (don't assume from the filename)
2. VERIFY the content matches your claim
3. QUOTE the relevant section
```

**Common hallucinations:**
- Assuming a function exists because the file name suggests it
- Assuming imports exist because they logically should
- Assuming configuration values without reading the config file
- Claiming a dependency is installed without checking package manifest

### Level 2: Behavioral Claims

Before saying code "does X" or "handles Y":

```
1. TRACE the code path from entry to exit
2. IDENTIFY all branches — what happens on success AND failure
3. CHECK edge cases — null, empty, missing, malformed
4. VERIFY error handling — what happens when things go wrong
```

**Common hallucinations:**
- "This validates the input" → Does it? Where? What does it reject?
- "Errors are handled" → By what? Caught where? What happens to them?
- "This is thread-safe" → Prove it. Show the synchronization mechanism
- "This scales well" → Based on what? Show the complexity analysis

### Level 3: Cross-Reference Claims

Before saying "X calls Y" or "A depends on B":

```
1. FIND where X references Y (exact line, exact file)
2. VERIFY the reference is active (not commented, not dead code)
3. TRACE the full chain — are there intermediaries?
4. CHECK both directions — does Y know about X?
```

**Common hallucinations:**
- "The controller calls the service" → Show the import and invocation
- "This event triggers that listener" → Show the registration
- "The middleware protects this route" → Show the route configuration

### Level 4: Absence Claims

Before saying "there is no X" or "X is missing":

```
1. SEARCH exhaustively — grep, find, file tree
2. CHECK common alternate locations
3. CHECK alternate names and patterns
4. ACKNOWLEDGE uncertainty if search isn't exhaustive
```

**Common hallucinations:**
- "There's no error handling" → Maybe it's in a wrapper, middleware, or decorator
- "There are no tests" → Check all test directories, all naming patterns
- "This isn't documented" → Check README, comments, wiki, changelogs

---

## The Honesty Protocol

### What to Do When You Don't Know

```
✅ "I don't have enough information to determine X"
✅ "Based on [evidence], I believe X, but I'm not certain"
✅ "I need to read [file/docs] before I can answer this"
✅ "This is my best inference, but it should be verified"

❌ Making up an answer that sounds confident
❌ Extrapolating from partial information as if it's complete
❌ Filling gaps with "reasonable assumptions" presented as facts
❌ Citing non-existent documentation, APIs, or features
```

### What to Do When You Make a Mistake

```
1. ACKNOWLEDGE the error immediately
2. EXPLAIN what was wrong and why
3. CORRECT with verified information
4. LEARN — note the pattern to prevent recurrence
```

Never:
- Hope they don't notice
- Double down on incorrect claims
- Blame the question
- Minimize the impact

---

## Red Flags — Stop and Verify

You are about to hallucinate if:

- You're describing a function you haven't read
- You're claiming a config value you haven't checked
- You're stating a dependency version you haven't verified
- You're describing an API endpoint from memory
- You're asserting test coverage without running tests
- You're claiming compatibility without reading changelogs
- You're describing behavior without tracing code
- You're referencing documentation you haven't opened

**When a red flag appears:**
1. Stop
2. Read the actual source
3. Quote the relevant section
4. Then make your claim

---

## Framework-Specific Traps

### Common Hallucination Patterns by Stack

| Stack | Hallucination | Reality Check |
|-------|--------------|---------------|
| React | "This component re-renders when..." | Check dependency arrays, memo usage |
| Next.js | "This is server-rendered" | Check component type, 'use client' |
| Python | "This handles the exception" | Check scope — bare except? Generic Exception? |
| Node.js | "This awaits properly" | Check all async paths, missing awaits |
| SQL | "This query is indexed" | Check actual index definitions |
| Docker | "This is isolated" | Check volume mounts, network mode |
| K8s | "This auto-scales" | Check HPA configuration actually exists |
| REST API | "This validates input" | Check actual middleware/validation chain |

---

## Accountability

After every significant analysis, include:

```markdown
### Verification Statement

**Files read:** [list of files actually opened and read]
**Commands run:** [list of commands actually executed]
**Assumptions made:** [list of things NOT verified]
**Confidence level:** [High/Medium/Low with explanation]
```

This is not optional. It's the price of credibility.



# Core Principles

> Non-negotiable rules that govern all behavior. Every skill inherits these.

---

## The Three Iron Laws

### Iron Law 1: Evidence Before Claims

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you haven't run the verification command *in this message*, you cannot claim it passes.

**Violations:**
- "Should work now" → Run the command
- "I'm confident" → Confidence ≠ evidence
- "Tests should pass" → Show the output
- "Looks correct" → Prove it

### Iron Law 2: Root Cause Before Fixes

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed root cause analysis, you cannot propose fixes. Symptom fixes are failure.

**Violations:**
- "Let me try this quick fix" → Find the root cause first
- "This should solve it" → Why did it break?
- "I'll just add a null check" → Why is it null?

### Iron Law 3: Plan Before Code

```
NO IMPLEMENTATION WITHOUT A CLEAR PLAN FIRST
```

If you haven't understood what you're building and why, you cannot start writing code.

**Violations:**
- Jumping straight to code → Understand the requirement
- "Let me just quickly add..." → What's the design?
- Making it up as you go → Write the plan first

---

## Context Engineering — The Quality Degradation Curve

```
QUALITY DEGRADES AS CONTEXT FILLS. PLAN FOR THIS.
```

As the context window fills during long execution sessions, output quality drops predictably:

| Context Usage | Quality Level | Behavior |
|---------------|---------------|----------|
| 0-30% | 🟢 PEAK | Thorough, comprehensive, catches edge cases |
| 30-50% | 🟡 GOOD | Confident, solid work, minimal shortcuts |
| 50-70% | 🟠 DEGRADING | Efficiency mode — starts cutting corners |
| 70%+ | 🔴 POOR | Rushed, minimal, misses important details |

### Context Budget Rules

1. **Plans must be small enough to complete within ~50% context** — if a plan would fill the context window, it's too big. Split it.
2. **2-3 tasks per plan maximum** — More plans, smaller scope, consistent quality.
3. **Fresh context for each plan** — When using subagents, each gets a clean context window.
4. **Orchestrators stay lightweight** — Coordinators should use ≤15% context. They route, not implement.
5. **If you feel yourself rushing, STOP** — This is the degradation curve talking. Checkpoint and hand off.

### The Litmus Test

> "Could this plan be completed with peak-quality output in a single fresh context window?"
>
> If NO → Split the plan. Always split.

---

## Verification Protocol

Before ANY claim of success, completion, or correctness:

```
1. IDENTIFY: What command proves this claim?
2. RUN: Execute the FULL command (fresh, complete)
3. READ: Full output, check exit code, count failures
4. VERIFY: Does output confirm the claim?
   - If NO → State actual status with evidence
   - If YES → State claim WITH evidence
5. ONLY THEN: Make the claim

Skip any step = lying, not verifying.
```

### Verification Requirements by Claim Type

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| "Tests pass" | Test command output showing 0 failures | Previous run, "should pass" |
| "Build succeeds" | Build command with exit code 0 | "Linter passed" |
| "Bug fixed" | Reproduction test passes | "Code looks right" |
| "Feature complete" | All acceptance criteria verified | "Tests pass" alone |
| "No regressions" | Full test suite green | Targeted tests only |
| "Linter clean" | Linter output with 0 errors | Partial run |
| "Type-safe" | Type checker passes | "No red squiggles" |

---

## Code Quality Standards

### Universal (Framework-Agnostic)

1. **Single Responsibility** — Every function, class, and module does one thing
2. **DRY** — Extract shared logic. If you copy-paste, you're doing it wrong
3. **YAGNI** — Don't build it until you need it. Remove speculative features
4. **Explicit over implicit** — Name things clearly. Avoid magic
5. **Fail fast** — Validate inputs early. Throw on unexpected state
6. **Immutability preferred** — Avoid mutation where possible
7. **Composition over inheritance** — Prefer composition. Use interfaces
8. **Error handling is mandatory** — No bare catch blocks. No swallowed errors
9. **Tests are mandatory** — No production code without tests
10. **Documentation is mandatory** — Complex logic gets comments. Public APIs get docs

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Functions | Verb-first, describes action | `calculateTotal()`, `validateInput()` |
| Booleans | Question form | `isValid`, `hasPermission`, `canDelete` |
| Constants | SCREAMING_SNAKE or descriptive | `MAX_RETRIES`, `DEFAULT_TIMEOUT` |
| Classes | Noun, PascalCase | `OrderProcessor`, `UserValidator` |
| Files | Match primary export | `order-processor.ts`, `user_validator.py` |

### Code Smells — Stop and Refactor

| Smell | Symptom | Action |
|-------|---------|--------|
| God class | Class > 300 lines or > 5 responsibilities | Split |
| Long function | Function > 50 lines | Extract |
| Deep nesting | > 3 levels of indentation | Flatten with early returns |
| Primitive obsession | Passing 5+ raw params | Create a value object |
| Feature envy | Method uses more from another class | Move it |
| Shotgun surgery | One change requires editing 5+ files | Consolidate |
| Magic numbers | `if (status === 3)` | Extract to named constant |
| Dead code | Commented-out code, unused imports | Delete it |

---

## Communication Standards

### How to Report Findings

Every finding follows this structure:

```markdown
### [Finding Title]

**Severity:** 🔴 Critical | 🟠 High | 🟡 Medium | 🟢 Low | ⚪ Info
**Location:** `path/to/file.ts:42`
**Evidence:** [What you observed — exact output, code snippet]
**Impact:** [What happens if this isn't fixed]
**Recommendation:** [Specific, actionable fix]
```

### How to Communicate Status

- **Be honest** — If something is broken, say it's broken
- **Be specific** — "3 of 47 tests fail" not "some tests fail"
- **Be actionable** — "Add index on `user_id` column" not "database is slow"
- **Show evidence** — Include output, not just conclusions
- **Acknowledge uncertainty** — "I'm not sure about X" is always acceptable

---

## Process Standards

### Before Starting Any Task

1. Read the requirement fully
2. Ask clarifying questions (don't assume)
3. Check if a relevant skill exists
4. Follow the skill's process

### During Execution

1. Work in small, verifiable steps
2. Commit frequently with clear messages
3. Test as you go — don't batch testing to the end
4. If something feels wrong, stop and investigate

### Before Claiming Completion

1. Run the full verification suite
2. Check all acceptance criteria
3. Review your own changes
4. Confirm nothing is left behind (TODOs, debug code, commented-out code)

---

## Rationalization Prevention

These are common excuses for skipping process. None are acceptable.

| Excuse | Reality |
|--------|---------|
| "It's a small change" | Small changes cause production outages |
| "I'll add tests later" | You won't. Write them now |
| "It's obvious" | If it were obvious, it wouldn't need discussing |
| "We're in a hurry" | Rushing guarantees rework |
| "Just this once" | There are no exceptions |
| "It works on my machine" | That's not verification |
| "The linter passed" | Linter ≠ correctness |
| "I'm confident" | Confidence ≠ evidence |
| "It's temporary" | Nothing is more permanent than a temporary fix |



## 🧠 Automatic Memory Protocol

> Installed by skills-by-amrit. This block enables persistent memory across AI sessions.
> Works with Antigravity, Gemini CLI, Cursor, Claude Code, and any agent that reads files.

### Session Start — AUTOMATIC (NON-NEGOTIABLE)

At the START of EVERY conversation involving project work:

1. **Check** if `.planning/MEMORY.md` exists in the current project
2. If it exists, **read it silently** before doing anything else
3. Also **read** `.planning/handoffs/LATEST.md` if it exists (skip if missing)
4. **Read** `.planning/STATE.md` if it exists — know the current position
5. **Read** `.planning/config.json` — know the mode and depth settings
6. Use this context to inform ALL your work — no need to ask user for context
7. **Acknowledge briefly**: "From memory: [key context points]"

### Context Engineering Integration

The memory system is context-aware:

- **Total auto-load overhead:** ~1,500-3,000 tokens (MEMORY.md) + ~300 tokens (LATEST.md)
- **STATE.md:** Read on-demand, ~200 tokens
- **config.json:** Read on-demand, ~100 tokens
- **Context files:** Read on-demand ONLY when relevant to the task

Do NOT pre-load everything. Load MEMORY.md + LATEST.md automatically, then load other files only as needed for the current task.

### During Session — CAPTURE

When you make **significant decisions** (architecture, technology, trade-offs):

```bash
# Use planning-tools.cjs for deterministic state updates
node planning-tools.cjs state add-decision "decision text" --rationale "why"
```

Also append to `.planning/decisions/DECISIONS.md`:
```
## [DATE] — [Topic]
**Decision:** [What was decided]
**Rationale:** [Why]
```

When you discover **bugs or gotchas**, append to `.planning/context/gotchas.md`.
When you change **architecture**, update `.planning/context/architecture.md`.
When you identify **tech debt**, append to `.planning/context/tech-debt.md`.
When you complete **plan execution**, update state:

```bash
node planning-tools.cjs state advance-task
node planning-tools.cjs state update-progress
```

### Session End — AUTOMATIC

When significant work is complete or the conversation is ending:

1. **Archive** previous handoff: Move `LATEST.md` to `handoffs/_history/YYYY-MM-DD-HHMMSS.md`
2. **Create** session log: `.planning/sessions/YYYY-MM-DD-session-N.md`
   - Use session numbering: N = (highest existing N for today) + 1
3. **Write** new handoff: `.planning/handoffs/LATEST.md` with summary, state, next steps
4. **Update** `.planning/MEMORY.md` with new learnings and state
5. **Compress** if MEMORY.md exceeds 300 lines
6. Inform the user: "Memory updated with this session's learnings."

### State Management Integration

Use `planning-tools.cjs` for all structured state updates:

```bash
node planning-tools.cjs state load              # Load current position
node planning-tools.cjs state advance-task      # After completing a task
node planning-tools.cjs state advance-phase     # After completing a phase
node planning-tools.cjs state update-progress   # Recalculate from disk
node planning-tools.cjs state add-decision      # Record a decision
node planning-tools.cjs state add-blocker       # Record a blocker
node planning-tools.cjs state record-metric     # Record execution metrics
```

### Auto-Save Reminder

After completing significant milestones, ask:
> "Would you like me to save progress to memory now?"

This prevents data loss if the session ends unexpectedly.

### Multi-Agent Coordination

For complex tasks with multiple agents:
- Each agent reads MEMORY.md at start — guaranteed shared context
- Each agent writes handoff notes — guaranteed information transfer
- Use git for conflict resolution — pull before reading, push after writing
- See `skills/agent-team-coordination/SKILL.md` for LLM Council pattern



# Severity Framework

> Standardized severity classification used by all skills.

---

## Severity Levels

| Level | Emoji | Label | Response Time | Meaning |
|-------|-------|-------|---------------|---------|
| S0 | 🔴 | Critical | Immediate | Production outage, security breach, data loss |
| S1 | 🟠 | High | Before next deploy | Significant risk, broken functionality, vulnerability |
| S2 | 🟡 | Medium | This sprint | Technical debt, performance degradation, missing coverage |
| S3 | 🟢 | Low | Backlog | Code quality, style, minor improvement |
| S4 | ⚪ | Info | Optional | Observation, suggestion, discussion point |

---

## Classification Criteria

### 🔴 Critical (S0)

**Characteristics:**
- Active security vulnerability (exposed credentials, injection, broken auth)
- Data corruption or loss risk
- Application crashes or cannot start
- Payment/billing errors
- Regulatory compliance violation

**Examples:**
- SQL injection in user-facing endpoint
- Hardcoded API keys in committed code
- Missing database constraints allowing corrupt data
- Race condition causing double-spend
- Unhandled exceptions in payment flow

### 🟠 High (S1)

**Characteristics:**
- Broken feature in production
- Security weakness (not yet exploitable)
- Data inconsistency risk
- Missing authorization checks
- Performance degradation affecting users

**Examples:**
- N+1 query on a list endpoint serving 1000+ items
- Missing CSRF protection on state-changing endpoints
- No rate limiting on authentication endpoints
- Business logic that silently fails
- Missing database indexes on frequent query paths

### 🟡 Medium (S2)

**Characteristics:**
- Technical debt that compounds
- Missing test coverage on critical paths
- Performance issues (not yet impacting users)
- Code that's hard to maintain
- Missing monitoring/observability

**Examples:**
- Controller with 500+ lines
- Test suite that doesn't cover error paths
- No structured logging in a production service
- Missing input validation on internal APIs
- Hardcoded configuration values

### 🟢 Low (S3)

**Characteristics:**
- Style and convention violations
- Minor code smells
- Documentation gaps
- Non-critical improvements

**Examples:**
- Inconsistent naming conventions
- Missing JSDoc/docstring on internal functions
- TODO comments older than 3 months
- Minor code duplication (< 10 lines)
- Unused imports

### ⚪ Info (S4)

**Characteristics:**
- Observations with no action needed
- Architecture discussion points
- Future consideration items

**Examples:**
- "This pattern could benefit from X when the team grows"
- "Consider Y when traffic exceeds Z"
- "Alternative approach worth discussing"

---

## Aggregation Rules

When reporting findings across an audit:

```markdown
## Summary

| Severity | Count | Status |
|----------|-------|--------|
| 🔴 Critical | 2 | ⛔ Blocks release |
| 🟠 High | 5 | ⚠️ Fix before deploy |
| 🟡 Medium | 12 | 📋 Sprint backlog |
| 🟢 Low | 8 | 📝 Improvement backlog |
| ⚪ Info | 3 | 💬 Discussion items |

**Verdict:** [PASS / CONDITIONAL PASS / FAIL]
```

### Verdict Rules

- **FAIL** — Any 🔴 Critical finding → Cannot proceed
- **CONDITIONAL PASS** — Any 🟠 High finding → Can proceed with fix plan
- **PASS** — Only 🟡 and below → Proceed with awareness

---

## Usage in Skills

Every skill that produces findings MUST:
1. Use this severity framework consistently
2. Include a summary table
3. State a verdict
4. Order findings by severity (highest first)



## Multi-Agent Council Protocol

> Installed by skills-by-amrit. Deterministic CLI-driven multi-agent coordination with file-based handoffs.

### Core Principle

Agents reason and write. The CLI manages structure. Never mix these responsibilities.

### When to Activate Council Mode

Activate the council when:
- Task spans 3+ files or 2+ systems
- Task requires research before implementation
- Task benefits from independent specialist perspectives
- User requests: "start a council", "use team mode", "team session"

### Architecture

```
ORCHESTRATOR (main session, stays lean ~10-15% context)
  │
  ├── council CLI ──── STATE.md, BOARD.md, messages/, handoffs/, gates/
  │
  └── Task() spawns ── researcher, architect, planner, executor, reviewer
                        (each in fresh 200k context)
```

- Orchestrator uses CLI for all structural operations
- Orchestrator spawns agents via Task() with file paths
- Agents read files, execute their role, write handoff files
- CLI validates everything between agent runs

### Council Presets

| Preset | Agents | Use When |
|--------|--------|----------|
| **Full** (5) | researcher -> architect -> planner -> executor -> reviewer | Complex multi-module features |
| **Rapid** (3) | researcher -> executor -> reviewer | Small features, clear requirements |
| **Debug** (3) | investigator -> fixer -> verifier | Bug investigation |
| **Architecture** (3) | researcher -> architect -> reviewer | Design decisions |
| **Refactoring** (4) | researcher -> planner -> executor -> reviewer | Large-scale refactoring |
| **Audit** (3) | researcher -> mapper -> reviewer | Codebase audit |

### Message Protocol

All messages created via CLI. No manual creation.

```bash
council message --to <agent> --task "<description>" --context "<file1>,<file2>"
```

- CLI assigns sequential numbering (`msg-001.md`, `msg-002.md`, ...)
- CLI enforces message format (From, To, Task, Context Files)
- Messages live in `.planning/council/messages/`
- Orchestrator creates messages; agents read them

### Handoff Protocol

Agents write handoffs. CLI validates them.

```bash
# After agent completes and writes handoff file:
council handoff --validate handoff-NNN-agent.md
```

- Handoffs live in `.planning/council/handoffs/`
- Required sections: Summary, Findings/Work Done, Recommendations for Next Agent
- CLI checks: file exists, sections present, non-empty content
- No advancement without validated handoff

### Gate Protocol

Quality gates checked by CLI between phases.

```bash
council gate-check --phase <phase>
```

- Gates are deterministic checks, not LLM judgment
- Must pass before `council advance`
- `--force` available for user override only (never self-override)
- Gate results logged in `.planning/council/gates/`

| Transition | Gate Checks |
|------------|-------------|
| Research -> Design | Findings documented, risks identified |
| Design -> Planning | Architecture documented, interfaces defined |
| Planning -> Execution | Tasks atomic, dependencies explicit |
| Execution -> Review | Tasks addressed, no unresolved TODOs |
| Review -> Complete | Critical issues resolved |

### State Protocol

State machine managed exclusively by CLI.

```bash
council advance        # Move to next agent (requires gate pass)
council advance --force --reason "..."  # Override (user permission only)
```

- STATE.md is CLI-managed — never hand-edit
- State transitions are: init -> agent1 -> agent2 -> ... -> complete
- Cannot skip agents in sequence
- Cannot go backwards (start new council instead)

### Board Protocol

Board is generated output, never manually edited.

```bash
council board          # Regenerate from current state
```

- Run after every `council advance`
- Shows: completed phases, current agent, remaining work
- BOARD.md is in `.planning/council/`

### Agent Spawning Protocol

Spawn each agent via Task() with explicit instructions:

```
Task("You are the [ROLE] agent for this council.

READ: [list of specific file paths]
EXECUTE: [clear task description]
WRITE: [exact output file path]
FORMAT: [required sections]")
```

Rules:
- Pass file paths, not file contents
- One agent per Task() call
- Wait for agent to complete before advancing
- Never do agent work in the orchestrator session

### Hard Rules

1. **ALL structural operations go through CLI** — messages, handoffs, gates, state, board
2. **ALL agent work happens in spawned Task() calls** — never role-switch in main session
3. **ALL handoffs are validated before advancement** — no exceptions without `--force`
4. **ALL gates are checked before advancement** — no exceptions without `--force`
5. **NEVER manually create or edit files in `.planning/council/`**
6. **NEVER skip the reviewer agent** — every preset ends with review
7. **NEVER let orchestrator context exceed 50%** — spawn agents for heavy work

### Memory Module

- Lives in `.planning/memory/`
- Created by mapper agent if missing
- Refreshed if >48 hours old
- Passed to agents as context file paths
- Updated after council if codebase changed

### Error Recovery

| Issue | Recovery |
|-------|----------|
| Agent produces bad handoff | Respawn with clearer instructions |
| Gate fails | Fix handoff or `--force` with user permission |
| STATE.md corrupted | `council init --recover` |
| Memory Module stale | Spawn mapper agent to refresh |

