# Storefront Next.js to Nuxt Migration Tasks

## Current Status

- [x] Fix critical checkout flow issues in `storefront-nuxt`
- [x] Restore Stripe payment session and card handling
- [x] Fix confirmed-order route navigation
- [x] Make `storefront-nuxt` pass `pnpm typecheck`
- [x] Make edited migration files pass targeted ESLint

## Route Parity Audit

- [x] Audit home route parity: `storefront/src/app/[countryCode]/(main)/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/index.vue`
- [x] Audit store listing parity: `storefront/src/app/[countryCode]/(main)/store/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/store.vue`
- [x] Audit category route parity: `storefront/src/app/[countryCode]/(main)/categories/[...category]/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/categories/[...category].vue`
- [x] Audit collection route parity: `storefront/src/app/[countryCode]/(main)/collections/[handle]/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/collections/[handle].vue`
- [x] Audit product route parity: `storefront/src/app/[countryCode]/(main)/products/[handle]/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/products/[handle].vue`
- [x] Audit cart route parity: `storefront/src/app/[countryCode]/(main)/cart/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/cart.vue`
- [x] Audit checkout route parity: `storefront/src/app/[countryCode]/(checkout)/checkout/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/checkout.vue`
- [x] Audit account overview parity: `storefront/src/app/[countryCode]/(main)/account/@dashboard/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/account/index.vue`
- [x] Audit account profile parity: `storefront/src/app/[countryCode]/(main)/account/@dashboard/profile/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/account/profile.vue`
- [x] Audit account addresses parity: `storefront/src/app/[countryCode]/(main)/account/@dashboard/addresses/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/account/addresses.vue`
- [x] Audit account order-details parity: `storefront/src/app/[countryCode]/(main)/account/@dashboard/orders/details/[id]/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/account/orders/details/[id].vue`
- [x] Audit order confirmed parity: `storefront/src/app/[countryCode]/(main)/order/[id]/confirmed/page.tsx` vs `storefront-nuxt/app/pages/[countryCode]/order/[id]/confirmed.vue`
- [x] Audit transfer-request flow parity: `storefront/src/app/[countryCode]/(main)/order/[id]/transfer/[token]/*` vs `storefront-nuxt/app/pages/[countryCode]/order/[id]/transfer/[token]/*`

## Account Module

- [x] Compare `storefront/src/modules/account/components/overview/index.tsx` with `storefront-nuxt/app/components/account/Overview.vue` for missing UI states and behaviors
- [x] Compare `storefront/src/modules/account/components/address-book/index.tsx` with `storefront-nuxt/app/components/account/AddressBook.vue` for missing create/edit/delete behaviors
- [x] Compare `storefront/src/modules/account/components/profile-name/index.tsx` with `storefront-nuxt/app/components/account/ProfileName.vue`
- [x] Compare `storefront/src/modules/account/components/profile-email/index.tsx` with `storefront-nuxt/app/components/account/ProfileEmail.vue`
- [x] Compare `storefront/src/modules/account/components/profile-phone/index.tsx` with `storefront-nuxt/app/components/account/ProfilePhone.vue`
- [x] Compare `storefront/src/modules/account/components/profile-billing-address/index.tsx` with `storefront-nuxt/app/components/account/ProfileBillingAddress.vue`
- [x] Compare `storefront/src/modules/account/components/profile-password/index.tsx` with `storefront-nuxt/app/components/account/ProfilePassword.vue`
- [x] Compare `storefront/src/modules/account/components/login/index.tsx` with `storefront-nuxt/app/components/account/Login.vue`
- [x] Compare `storefront/src/modules/account/components/register/index.tsx` with `storefront-nuxt/app/components/account/Register.vue`
- [x] Compare `storefront/src/modules/account/components/order-card/index.tsx` with `storefront-nuxt/app/components/account/OrderCard.vue`
- [x] Compare `storefront/src/modules/account/components/order-overview/index.tsx` with `storefront-nuxt/app/components/account/OrderOverview.vue`
- [x] Compare `storefront/src/modules/account/components/transfer-request-form/index.tsx` with `storefront-nuxt/app/components/account/TransferRequestForm.vue`

## Cart And Checkout Module

- [x] Re-check `Addresses` parity for saved addresses, billing/shipping sync, summary state, and error state
- [x] Re-check `Shipping` parity for pickup logic, calculated shipping prices, disabled options, and summary state
- [x] Re-check `Payment` parity for all provider types, Stripe card state, summary state, and error handling
- [x] Re-check `Review` parity for order placement behavior and error handling
- [x] Compare `storefront/src/modules/cart/templates/index.tsx` with `storefront-nuxt/app/components/cart/CartTemplate.vue`
- [x] Compare `storefront/src/modules/cart/templates/items.tsx` with `storefront-nuxt/app/components/cart/CartItems.vue`
- [x] Compare `storefront/src/modules/cart/templates/summary.tsx` with `storefront-nuxt/app/components/cart/CartSummary.vue`
- [x] Compare `storefront/src/modules/cart/templates/preview.tsx` with `storefront-nuxt/app/components/cart/CartItemsPreview.vue`
- [x] Compare `storefront/src/modules/cart/components/item/index.tsx` with `storefront-nuxt/app/components/cart/CartItem.vue`
- [x] Compare `storefront/src/modules/cart/components/empty-cart-message/index.tsx` with `storefront-nuxt/app/components/cart/EmptyCart.vue`
- [x] Compare `storefront/src/modules/cart/components/sign-in-prompt/index.tsx` with `storefront-nuxt/app/components/cart/SignInPrompt.vue`
- [x] Compare `storefront/src/modules/checkout/components/discount-code/index.tsx` with `storefront-nuxt/app/components/checkout/DiscountCode.vue`
- [x] Compare `storefront/src/modules/checkout/templates/checkout-summary/index.tsx` with `storefront-nuxt/app/components/checkout/CheckoutSummary.vue`

## Product And Store Module

- [x] Compare `storefront/src/modules/products/templates/index.tsx` with the Nuxt product page composition
- [x] Compare `storefront/src/modules/products/templates/product-info/index.tsx` with `storefront-nuxt/app/components/product/Info.vue`
- [x] Compare `storefront/src/modules/products/components/image-gallery/index.tsx` with `storefront-nuxt/app/components/product/ImageGallery.vue`
- [x] Compare `storefront/src/modules/products/components/product-actions/index.tsx` with `storefront-nuxt/app/components/product/Actions.vue`
- [x] Compare `storefront/src/modules/products/components/product-actions/mobile-actions.tsx` with `storefront-nuxt/app/components/product/MobileActions.vue`
- [x] Compare `storefront/src/modules/products/components/product-actions/option-select.tsx` with `storefront-nuxt/app/components/product/OptionSelect.vue`
- [x] Compare `storefront/src/modules/products/components/product-price/index.tsx` with `storefront-nuxt/app/components/product/Price.vue`
- [x] Compare `storefront/src/modules/products/components/product-preview/index.tsx` with `storefront-nuxt/app/components/product/Preview.vue`
- [x] Compare `storefront/src/modules/products/components/product-preview/price.tsx` with `storefront-nuxt/app/components/product/PreviewPrice.vue`
- [x] Compare `storefront/src/modules/products/components/product-tabs/index.tsx` with `storefront-nuxt/app/components/product/Tabs.vue`
- [x] Compare `storefront/src/modules/products/components/related-products/index.tsx` with `storefront-nuxt/app/components/product/RelatedProducts.vue`
- [x] Compare `storefront/src/modules/products/components/thumbnail/index.tsx` with `storefront-nuxt/app/components/product/Thumbnail.vue`
- [x] Compare `storefront/src/modules/store/templates/index.tsx` with `storefront-nuxt/app/components/store/StoreTemplate.vue`
- [x] Compare `storefront/src/modules/store/templates/paginated-products.tsx` with `storefront-nuxt/app/components/store/PaginatedProducts.vue`
- [x] Compare `storefront/src/modules/store/components/refinement-list/index.tsx` with `storefront-nuxt/app/components/store/RefinementList.vue`
- [x] Verify sort, pagination, query-param sync, and product-count behavior in store/category/collection views

## Order And Layout Module

- [x] Compare `storefront/src/modules/order/templates/order-completed-template.tsx` with `storefront-nuxt/app/components/order/CompletedTemplate.vue`
- [x] Compare `storefront/src/modules/order/templates/order-details-template.tsx` with `storefront-nuxt/app/components/order/DetailsTemplate.vue`
- [x] Compare `storefront/src/modules/order/components/order-details/index.tsx` with `storefront-nuxt/app/components/order/OrderDetails.vue`
- [x] Compare `storefront/src/modules/order/components/order-summary/index.tsx` with `storefront-nuxt/app/components/order/OrderSummary.vue`
- [x] Compare `storefront/src/modules/order/components/payment-details/index.tsx` with `storefront-nuxt/app/components/order/PaymentDetails.vue`
- [x] Compare `storefront/src/modules/order/components/shipping-details/index.tsx` with `storefront-nuxt/app/components/order/ShippingDetails.vue`
- [x] Compare `storefront/src/modules/order/components/transfer-actions/index.tsx` with `storefront-nuxt/app/components/order/TransferActions.vue`
- [x] Compare `storefront/src/modules/layout/templates/nav/index.tsx` with `storefront-nuxt/app/components/layout/Nav.vue`
- [x] Compare `storefront/src/modules/layout/components/side-menu/index.tsx` with `storefront-nuxt/app/components/layout/SideMenu.vue`
- [x] Compare `storefront/src/modules/layout/components/cart-dropdown/index.tsx` with `storefront-nuxt/app/components/layout/CartDropdown.vue`
- [x] Compare `storefront/src/modules/layout/components/country-select/index.tsx` with `storefront-nuxt/app/components/layout/CountrySelect.vue`
- [x] Compare `storefront/src/modules/layout/templates/footer/index.tsx` with `storefront-nuxt/app/components/layout/Footer.vue`

## Data, API, And Utility Parity

- [x] Audit `storefront/src/lib/data/*` usage against `storefront-nuxt/server/api/*` coverage
- [x] Verify all Medusa query fields in Nuxt server routes match the Next.js source requirements
- [x] Re-check cart server handlers for parameter shapes and auth headers
- [x] Re-check order server handlers for list/detail parity
- [x] Re-check product server handler for filtering, region, tags, and collection behavior
- [x] Re-check region bootstrap and default-region redirect behavior
- [x] Audit shared utility parity: money, compare-addresses, sort-products, get-product-price, product helpers

## UX And State Completeness

- [x] Verify every migrated page has correct loading state
- [x] Verify every migrated page has correct empty state
- [x] Verify every migrated page has correct error state
- [x] Verify responsive behavior on mobile and desktop for cart, checkout, account, and product pages
- [x] Verify internal links use locale-aware routing consistently
- [x] Verify no remaining broken navigation paths exist in `storefront-nuxt`

## Validation

- [ ] Run full manual browser test for home, store, category, collection, product, cart, checkout, account, and order routes
- [ ] Verify login, register, logout, address CRUD, and account profile update flows end to end
- [ ] Verify add-to-cart, cart update, shipping selection, payment selection, and place-order flows end to end
- [ ] Verify order history, order detail, order confirmation, and transfer flows end to end
- [ ] Run `pnpm typecheck` after each parity batch
- [ ] Run targeted ESLint on touched files after each parity batch
- [ ] Decide whether to clean the unrelated repo-wide lint backlog under `.claude/`, `.github/hooks/`, and other non-migration files
