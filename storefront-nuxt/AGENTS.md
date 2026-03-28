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
