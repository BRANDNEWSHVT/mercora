# Repository Guidelines

## Project Structure & Module Organization
This repository is a Nuxt 4 storefront backed by Medusa APIs. UI code lives in `app/`: pages in `app/pages`, shared components in `app/components`, reusable logic in `app/composables`, helpers in `app/utils`, layouts in `app/layouts`, and global styles in `app/assets/css/main.css`. Server endpoints and integration helpers live in `server/api` and `server/utils`. Static files belong in `public/`.

## Build, Test, and Development Commands
Use `pnpm` because the repo is pinned to `pnpm@10`.

- `pnpm install`: install dependencies and run `nuxt prepare`.
- `pnpm dev`: start the local dev server at `http://localhost:3000`.
- `pnpm build`: create the production build.
- `pnpm preview`: serve the production build locally.
- `pnpm lint`: run ESLint across the repo.
- `pnpm typecheck`: run Nuxt and TypeScript checks.

## Coding Style & Naming Conventions
Follow the existing Nuxt and Vue 3 Composition API patterns with `<script setup lang="ts">`. Use 2-space indentation and keep ESLint clean before opening a PR. The Nuxt ESLint config is defined in `eslint.config.mjs`; stylistic rules currently enforce `commaDangle: never` and `braceStyle: 1tbs`.

Use PascalCase for Vue components like `CartDropdown.vue`, camelCase for composables and utilities like `useCart.ts`, and file-based route names that mirror the URL structure, such as `app/pages/[countryCode]/products/[handle].vue`. Keep server handlers named by route and method, for example `server/api/cart/add-item.post.ts`.

## Testing Guidelines
There is no automated test suite configured yet. Until one is added, treat `pnpm lint` and `pnpm typecheck` as required checks for every change. If you introduce tests, place them near the feature or in a dedicated `tests/` directory and prefer names ending in `.test.ts`.

## Commit & Pull Request Guidelines
This repository does not yet have commit history, so adopt Conventional Commits going forward, for example `feat: add checkout shipping validation` or `fix: handle empty cart state`. Keep commits focused and reviewable.

Pull requests should include a short description, linked issue or task when available, validation steps, and screenshots or recordings for UI changes. Call out any environment or Medusa backend assumptions explicitly.

## Security & Configuration Tips
Runtime configuration in `nuxt.config.ts` depends on environment variables such as `MEDUSA_BACKEND_URL`, `NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY`, `NEXT_PUBLIC_BASE_URL`, `NEXT_PUBLIC_DEFAULT_REGION`, and `NEXT_PUBLIC_STRIPE_KEY`. Do not hardcode secrets or commit populated `.env` files.

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
