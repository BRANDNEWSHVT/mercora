---
description: "Code review checklist — use when reviewing code changes or preparing for PR review."
applyTo: "**/*"
---

# Code Review Checklist

## Before Approving Any Change, Verify:

### Correctness
- [ ] Logic is correct (no off-by-one, race conditions, null derefs)
- [ ] All code paths are handled (happy path, errors, edge cases)
- [ ] Types match (no implicit conversions or `any` abuse)
- [ ] Return values are checked
- [ ] Side effects are documented or eliminated

### Security
- [ ] User input is validated and sanitized
- [ ] SQL queries are parameterized
- [ ] Auth/authz checks are present where needed
- [ ] Sensitive data is not leaked in logs/responses
- [ ] No hardcoded secrets or credentials

### Performance
- [ ] No N+1 query patterns
- [ ] No unbounded loops or recursion
- [ ] Pagination for list endpoints
- [ ] No unnecessary re-renders (React)
- [ ] Expensive operations are cached where appropriate

### Maintainability
- [ ] Code is readable without comments
- [ ] Functions are small (< 50 lines)
- [ ] Follows existing project patterns
- [ ] No code duplication
- [ ] Names are descriptive and consistent
- [ ] Abstraction level is appropriate

### Testing
- [ ] Tests exist for new code
- [ ] Tests cover happy path AND error paths
- [ ] Tests are independent (no shared mutable state)
- [ ] No test regressions

### Severity Guide
- 🔴 **Critical (must fix):** Security vulnerability, data loss risk, crash
- 🟠 **Important (should fix):** Logic error, performance issue, missing validation
- 🟡 **Suggestion (nice to have):** Readability, convention, minor improvement
- 🟢 **Praise (keep doing this):** Well-written code, good patterns
