# Mercora Repo Guidelines

## Scope
- This repo has 3 apps:
  - `medusa` backend
  - `storefront-vinext` storefront
  - `storefront-nuxt` Nuxt storefront
- Nx is set up only for `medusa` and `storefront-vinext`.
- Do not add `storefront-nuxt` to the Nx project graph.

## Package Managers
- Root: `npm` for Nx tooling.
- `medusa`: `yarn`
- `storefront-vinext`: `yarn`
- `storefront-nuxt`: `pnpm`

## Root Commands

```bash
npm install
npm run dev
npm run build
npm run lint
npx nx show projects
npx nx run medusa:build
npx nx run storefront-vinext:lint
```

## App Commands

```bash
cd medusa && yarn dev
cd medusa && yarn build
cd medusa && yarn start
cd medusa && yarn test:unit
cd medusa && yarn test:integration:http
cd medusa && yarn test:integration:modules

cd storefront-vinext && yarn dev
cd storefront-vinext && yarn build
cd storefront-vinext && yarn start
cd storefront-vinext && yarn lint
cd storefront-vinext && yarn analyze

cd storefront-nuxt && pnpm dev
cd storefront-nuxt && pnpm build
cd storefront-nuxt && pnpm preview
cd storefront-nuxt && pnpm lint
cd storefront-nuxt && pnpm typecheck
```

## Working Rules
- Use Nx for cross-app work on `medusa` and `storefront-vinext`.
- Keep `storefront-nuxt` isolated unless the user explicitly asks to touch it.
- If editing inside `storefront-nuxt`, follow its local [AGENTS.md](./storefront-nuxt/AGENTS.md).
- Prefer existing scripts and local package managers over ad hoc commands.
- Keep changes scoped to the app you are editing.

## Verification
- If root Nx tooling changes: run `npx nx show projects`.
- If `medusa` changes: run the relevant `yarn` test/build command.
- If `storefront-vinext` changes: run `yarn lint` and `yarn build`.
- If `storefront-nuxt` changes: run `pnpm lint` and `pnpm typecheck`.

