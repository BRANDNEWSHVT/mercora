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
    <h2 class="text-[2rem] leading-11">
      Summary
    </h2>
    <CheckoutDiscountCode />
    <CommonDivider />
    <CommonCartTotals :totals="cart" />
    <NuxtLinkLocale :to="`/checkout?step=${step}`">
      <UButton
        block
        size="lg"
        data-testid="checkout-button"
      >
        Go to checkout
      </UButton>
    </NuxtLinkLocale>
  </div>
</template>
