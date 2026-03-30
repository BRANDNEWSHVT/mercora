# Repository Guidelines

## Project Structure & Module Organization
`mercora` is a multi-app commerce repo. `medusa/` contains the backend and admin extensions, with business logic under `src/modules`, API routes under `src/api`, workflows under `src/workflows`, subscribers/jobs for async hooks, and Jest tests in `integration-tests/` or `src/**/__tests__`. `storefront/` is the Next.js customer app; most code lives in `src/app`, `src/modules`, `src/lib`, and `src/styles`, with static assets in `public/`. `storefront-nuxt/` is a Nuxt-based frontend variant with pages in `app/pages`, shared UI in `app/components`, and styles in `app/assets`.

## Build, Test, and Development Commands
Run commands from the relevant package directory, not the repo root.

- `cd medusa && yarn dev`: start the Medusa backend in development.
- `cd medusa && yarn build && yarn start`: build and run production backend output.
- `cd medusa && yarn test:unit` or `yarn test:integration:http`: run Jest unit or HTTP integration suites.
- `cd storefront && yarn dev`: run the Next.js storefront on port `8000`.
- `cd storefront && yarn build && yarn start`: build and serve the production Next app.
- `cd storefront && yarn lint`: run Next.js ESLint checks.
- `cd storefront-nuxt && pnpm dev`: start the Nuxt frontend.
- `cd storefront-nuxt && pnpm lint && pnpm typecheck`: run ESLint and TypeScript validation.

## Coding Style & Naming Conventions
Prefer TypeScript across all apps. Follow existing 2-space indentation and keep names descriptive: React components in PascalCase, utilities/hooks in camelCase, route folders in framework-native lowercase patterns. In `storefront/`, Prettier enforces `semi: false` and double quotes; use the repo config instead of personal defaults. Keep Medusa modules grouped by capability, for example `src/modules/brand` and related routes/workflows beside it.

## Testing Guidelines
Backend coverage is centered in `medusa/` using Jest with `*.spec.ts` and `*.unit.spec.ts` naming. Add integration tests for API or workflow changes and unit tests for isolated module logic. Frontend packages currently rely on linting and type checks more than formal test suites, so at minimum run `yarn lint` in `storefront` and `pnpm lint && pnpm typecheck` in `storefront-nuxt` before opening a PR.

## Commit & Pull Request Guidelines
Recent history favors short, imperative commits with prefixes like `feat:` and `chore:`. Keep that pattern, for example `feat: add brand sync workflow`. PRs should describe the affected app (`medusa`, `storefront`, or `storefront-nuxt`), summarize behavior changes, link any issue, and include screenshots for visible UI updates. Note any required env or seed-data changes explicitly.

<!-- Skills by Amrit START -->
# Skills by Amrit

> An agentic skills framework that makes AI assistants think like senior staff engineers.

You have a library of composable skills installed in `.agents/skills/`. Before any task, check if a relevant skill exists. Skills are not suggestions — they are mandatory workflows when their activation conditions are met.

**Check skills before:**
- Writing any code
- Debugging any issue
- Reviewing any PR
- Auditing any system
- Planning any feature
- Refactoring any module

## Core Principles

Read the `_rules` skill in `.agents/skills/_rules/SKILL.md` for core principles, anti-hallucination protocol, and severity framework.

**The three non-negotiables:**
1. **Evidence before claims** — Never say "done" without verification
2. **Root cause before fixes** — Never patch symptoms
3. **Plan before code** — Never start coding without understanding what you're building

## Skill Activation

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

## Anti-Hallucination Protocol

1. **Never fabricate** — If you don't know, say so
2. **Never assume** — Verify file existence, function signatures, variable names
3. **Never extrapolate** — Read the actual code, don't guess from names
4. **Never claim completion without evidence** — Run the command, read the output

## Severity Framework

| Level | Label | Meaning |
|-------|-------|---------|
| 🔴 | Critical | Production risk, security vulnerability, data loss potential |
| 🟠 | High | Must fix before next deploy |
| 🟡 | Medium | Technical debt, fix within sprint |
| 🟢 | Low | Improvement opportunity, backlog |
| ⚪ | Info | Observation, no action needed |

## Persistent Memory

If `.planning/MEMORY.md` exists, read it at session start and update it at session end. This provides cross-session context. Memory is always project-local — never installed globally.

<!-- Skills by Amrit END -->
