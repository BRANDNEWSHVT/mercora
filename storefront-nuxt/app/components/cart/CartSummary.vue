<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const { cart } = useCart()

function getCheckoutStep(c: HttpTypes.StoreCart | null | undefined): string {
  if (!c?.shipping_address?.address_1 || !c.email) {
    return 'address'
  } else if (c?.shipping_methods?.length === 0) {
    return 'delivery'
  } else {
    return 'payment'
  }
}

const step = computed(() => getCheckoutStep(cart.value))
</script>

<template>
  <div
    v-if="cart"
    class="flex flex-col gap-y-4"
  >
    <h2 class="text-[2rem] leading-11 text-ui-fg-base">
      Summary
    </h2>
    <CheckoutDiscountCode />
    <CommonDivider />
    <CommonCartTotals :totals="cart" />
    <NuxtLinkLocale
      :to="`/checkout?step=${step}`"
      class="block"
    >
      <button
        type="button"
        class="flex h-10 w-full items-center justify-center rounded-md bg-black px-4 text-sm font-medium text-white transition-opacity hover:opacity-90"
        data-testid="checkout-button"
      >
        Go to checkout
      </button>
    </NuxtLinkLocale>
  </div>
</template>
