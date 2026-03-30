---
description: "Run a comprehensive audit of the codebase covering security, performance, architecture, and database."
---

# /audit — Comprehensive Codebase Audit

Run a thorough audit of the codebase. Scope: `$ARGUMENTS` (default: all).

## Instructions

1. **Determine scope** from `$ARGUMENTS`:
   - `security` → Focus on security vulnerabilities, auth, input validation, secrets
   - `performance` → Focus on N+1 queries, missing indexes, memory leaks, caching
   - `architecture` → Focus on SOLID violations, coupling, separation of concerns
   - `database` → Focus on schema design, migrations, indexes, constraints
   - `all` or empty → Run all four audits

2. **For each audit scope**, follow these steps:
   a. Scan the entire codebase for issues in that category
   b. Classify each finding by severity: 🔴 Critical, 🟠 High, 🟡 Medium, 🔵 Low
   c. Provide the file path, line number, and a clear description
   d. Suggest a concrete fix with code example

3. **Output format** — Create an `AUDIT-REPORT.md` file with:
   ```markdown
   # Audit Report — [Date]
   ## Summary
   - 🔴 Critical: X findings
   - 🟠 High: X findings
   - 🟡 Medium: X findings
   - 🔵 Low: X findings

   ## Findings
   ### 🔴 [Finding Title]
   - **File**: `path/to/file.ts:42`
   - **Issue**: Description
   - **Fix**: Code suggestion
   ```

4. **Prioritize** findings by severity — critical issues first.

5. **Do NOT** fabricate findings. Only report genuine issues you can verify in the code.
