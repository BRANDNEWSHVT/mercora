<script setup lang="ts">
const { cart } = useCart()

const currencyCode = computed(() => cart.value?.currency_code || 'usd')
</script>

<template>
  <div
    v-if="cart"
    class="sticky top-12"
  >
    <h2 class="text-xl-semi mb-4 flex items-center gap-x-2">
      In your Cart
    </h2>
    <CommonDivider class="mb-4" />
    <CommonCartTotals :totals="{ ...cart, currency_code: currencyCode }" />
    <div class="my-4">
      <CartItemsPreview
        :items="cart.items || []"
        :currency-code="currencyCode"
      />
    </div>
    <CommonDivider class="my-4" />
    <CheckoutDiscountCode />
  </div>
</template>
