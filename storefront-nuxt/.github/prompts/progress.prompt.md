---
description: "Show current project progress, phase status, and task completion."
tools:
  - read
  - bash
  - search
---

# /progress — Project Progress

Display the current state of the project, including phase completion, task status, and recent activity.

## Instructions

### Step 1: Load Project State

```bash
# Check if .planning exists
ls .planning/ 2>/dev/null

# Load state
cat .planning/STATE.md 2>/dev/null
cat .planning/ROADMAP.md 2>/dev/null
cat .planning/config.json 2>/dev/null
```

If `.planning/` doesn't exist, inform the user:
> No project state found. Run `/init-project` to initialize project tracking.

### Step 2: Calculate Progress

Parse the state and roadmap to determine:
- Which phase is current
- How many tasks are complete vs. remaining
- What's active right now
- Any blockers

### Step 3: Display Progress Dashboard

```markdown
# 📊 Project Progress: [Name]

## Overall Status: 🟢 On Track / 🟡 At Risk / 🔴 Blocked

### Phase Overview
| Phase | Name | Status | Progress |
|-------|------|--------|----------|
| 1 | [Name] | ✅ Complete | 5/5 tasks |
| 2 | [Name] | 🔄 In Progress | 3/7 tasks |
| 3 | [Name] | ⬜ Not Started | 0/4 tasks |

### Current Phase: Phase [N] — [Name]
**Active tasks:**
- 🔄 Task 3: [title] — in progress
- ⬜ Task 4: [title] — waiting on Task 3

**Completed tasks:**
- ✅ Task 1: [title]
- ✅ Task 2: [title]

**Blocked tasks:**
- 🔴 Task 5: [title] — blocked by [reason]

### Recent Activity
- [timestamp] — Completed Task 2
- [timestamp] — Started Phase 2
- [timestamp] — Verified Phase 1

### Plans
| Plan | Phase | Status | Tasks |
|------|-------|--------|-------|
| [plan-1] | 1 | ✅ | 5/5 |
| [plan-2] | 2 | 🔄 | 3/7 |

### Verification Status
- Phase 1: ✅ Verified
- Phase 2: ⬜ Not yet verified

### Blockers
[None / List of current blockers]

### What's Next
- [Next logical action based on current state]
```

### Step 4: Phase Detail (If Requested)

If `$ARGUMENTS` contains a phase number, show detailed task-level status for that phase including individual task completion, files modified, and verification status.
