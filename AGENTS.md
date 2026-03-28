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
