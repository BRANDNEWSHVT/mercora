# Mercora

Mercora is a headless, composable commerce platform for brands that want a flexible backend, a modern storefront, and room to grow.

## Overview

This repository contains three apps:

- `medusa/`: the commerce backend and admin surface
- `storefront-vinext/`: the primary customer-facing storefront
- `storefront-nuxt/`: a separate Nuxt storefront/template for alternative frontend work

The root workspace uses Nx only to orchestrate `medusa/` and `storefront-vinext/`. `storefront-nuxt/` is kept separate and is not part of the root Nx project graph.

## What Mercora Includes

- Catalog, checkout, orders, pricing, and promotions
- Medusa-based commerce APIs
- Custom brand and CMS modules in the backend
- A Vinext/React/Vite/Tailwind storefront with Medusa SDK and Stripe integration
- A Nuxt 4 storefront option for teams that prefer Vue/Nuxt

## Repository Structure

```text
.
├── medusa/                # Backend commerce core
├── storefront-vinext/     # Primary storefront
├── storefront-nuxt/       # Separate Nuxt storefront/template
├── package.json           # Root Nx scripts
└── nx.json                # Nx workspace config
```

## Requirements

- Node.js 20 or newer for the root workspace and `medusa/`
- Yarn 3.x for `medusa/` and `storefront-vinext/`
- pnpm 10.x for `storefront-nuxt/`

## Setup

Install dependencies per app:

```bash
npm install
cd medusa && yarn install
cd storefront-vinext && yarn install
cd storefront-nuxt && pnpm install
```

## Run the workspace

Root Nx scripts run the backend and primary storefront together:

```bash
npm run dev
npm run build
npm run lint
```

Root scripts:

- `npm run dev` runs `medusa` and `storefront-vinext` in parallel
- `npm run build` builds `medusa` and `storefront-vinext` in parallel
- `npm run lint` runs linting for `storefront-vinext`

## Run each app

### `medusa/`

```bash
cd medusa
yarn dev
yarn build
yarn start
yarn seed
yarn test:unit
yarn test:integration:http
yarn test:integration:modules
```

### `storefront-vinext/`

```bash
cd storefront-vinext
yarn dev
yarn build
yarn start
yarn lint
yarn analyze
```

### `storefront-nuxt/`

```bash
cd storefront-nuxt
pnpm dev
pnpm build
pnpm preview
pnpm lint
pnpm typecheck
```

## Environment Variables

The apps rely on environment variables for backend and storefront integration. Common values include:

- `MEDUSA_BACKEND_URL`
- `NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY`
- `NEXT_PUBLIC_BASE_URL`
- `NEXT_PUBLIC_DEFAULT_REGION`
- `NEXT_PUBLIC_STRIPE_KEY`

Do not commit populated `.env` files.

## Notes

- `medusa/` is the commerce core and contains the backend business logic.
- `storefront-vinext/` is the main storefront for this repo.
- `storefront-nuxt/` is available as a separate frontend path, not as part of the root Nx workflow.
