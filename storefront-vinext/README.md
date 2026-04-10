# Medusa Vinext Storefront

Vinext-based Medusa storefront for the `mercora` repo. This app keeps the App Router structure from the old Next.js storefront, but the runtime, build, lint, and start flow now run on Vinext.

## Quick Start

### Prerequisites

- Node.js 18+ with `corepack` available
- Yarn 3.2.3
- A running Medusa backend
- A valid Medusa publishable API key

### Install

```bash
yarn install
```

### Configure

Create `.env.local` and define at least:

```bash
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_...
MEDUSA_BACKEND_URL=http://localhost:9000
```

Notes:

- `NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY` is required. The app exits early if it is missing.
- `MEDUSA_BACKEND_URL` is optional. If omitted, the storefront defaults to `http://localhost:9000`.

### Run

```bash
yarn dev
```

The default development server runs on `http://localhost:8000`.

## Scripts

- `yarn dev`: start Vinext in development mode on port `8000`
- `yarn build`: build the storefront with Vinext
- `yarn start`: start the production server on port `8000`
- `yarn lint`: run ESLint with the flat config in [eslint.config.mjs](./eslint.config.mjs)

## Verification

These are the baseline verification commands for this app:

```bash
yarn lint
./node_modules/.bin/tsc --noEmit
yarn build
```

Current migration status:

- `next` has been removed from dependencies
- build passes on Vinext
- type check passes
- lint passes

## Architecture Notes

- Vinext is enabled through [vite.config.ts](./vite.config.ts).
- The app still uses App Router-style modules under `src/app`.
- Medusa SDK configuration lives in [src/lib/config.ts](./src/lib/config.ts).
- Compatibility declarations for `next/*` imports live in [vinext-env.d.ts](./vinext-env.d.ts).
- The main app config is still stored in [next.config.mjs](./next.config.mjs), but its type is `import("vinext").NextConfig`.

## Migration Notes: Next.js to Vinext

This repo has already been migrated away from the Next.js runtime. The important implementation details are below.

### 1. Runtime and Tooling

- All package scripts now call `vinext`, not `next`.
- The `next` package and `eslint-config-next` have been removed.
- ESLint now uses a local flat config instead of Next-specific lint integration.

### 2. Compatibility Strategy

This codebase intentionally still imports modules such as:

- `next/navigation`
- `next/cache`
- `next/headers`
- `next/image`
- `next/link`
- `next/server`

Those imports are preserved for compatibility and mapped through [vinext-env.d.ts](./vinext-env.d.ts) to Vinext shims.

Why this was kept:

- It minimizes diff against the original Medusa storefront structure.
- It preserves route/component parity during migration.
- It avoids a risky full rewrite of every framework-facing import at once.

### 3. Request Caching Notes

The project still uses `next`-style fetch metadata such as `next.tags` and `next.revalidate` in server-side data access. To keep TypeScript happy under Vinext, `RequestInit` is augmented in [vinext-env.d.ts](./vinext-env.d.ts).

### 4. Image Behavior Difference

One migration gotcha was image sizing.

Under Vinext, `next/image` compatibility with `fill` did not always size the rendered `<img>` to the full wrapper height by itself. In this storefront, the fix was to explicitly set:

- `h-full`
- `w-full`

on image elements that rely on `fill`, such as:

- [src/modules/products/components/thumbnail/index.tsx](./src/modules/products/components/thumbnail/index.tsx)
- [src/modules/products/components/image-gallery/index.tsx](./src/modules/products/components/image-gallery/index.tsx)

If product or gallery images stop filling their aspect-ratio containers after future upgrades, check those two components first.

### 5. Yarn / Corepack Notes

This repo uses Yarn Berry (`packageManager: yarn@3.2.3`).

To avoid failures on machines that still resolve to Yarn 1 globally, the repository vendors Yarn locally through:

- [`.yarnrc.yml`](./.yarnrc.yml)
- [`.yarn/releases/yarn-3.2.3.cjs`](./.yarn/releases/yarn-3.2.3.cjs)

So `yarn dev` should work even if the shell still points to a Yarn 1 binary first.

### 6. What Was Updated During Migration

- package scripts switched from Next.js to Vinext
- `next-env.d.ts` removed
- TypeScript config cleaned up for Vinext
- ambient framework shims added in [vinext-env.d.ts](./vinext-env.d.ts)
- product/account/order route parity fixes applied
- localized account and order links restored
- checkout hydration issues fixed
- product image sizing adjusted for Vinext image runtime behavior

### 7. What To Watch After Upgrades

If Vinext, Vite, or Medusa packages are upgraded, re-check:

- account and order routes
- checkout hydration and shipping selection flow
- image sizing in store grid and product gallery
- Medusa SDK query typings
- `next/*` shim compatibility

## Known Warnings

`yarn build` may still print non-blocking warnings from the underlying Vite/Rolldown toolchain, including:

- `treeshake.preset` input warnings
- chunk size warnings

These do not currently block a successful build, but they should be revisited if the toolchain is upgraded.

## Payment Integration

This storefront includes Stripe support.

Add the publishable key to `.env.local`:

```bash
NEXT_PUBLIC_STRIPE_KEY=pk_...
```

You must also configure Stripe in the Medusa backend.

## References

- Medusa: https://docs.medusajs.com/
- Vinext: https://github.com/cloudflare/vinext
