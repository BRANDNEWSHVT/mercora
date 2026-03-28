<script setup lang="ts">
const { cart } = useCart()

const currencyCode = computed(() => cart.value?.currency_code || 'usd')
</script>

<template>
  <div
    v-if="cart"
    class="sticky top-0 flex flex-col-reverse small:flex-col gap-y-8 py-8 small:py-0"
  >
    <div class="w-full bg-white flex flex-col">
      <CommonDivider class="my-6 small:hidden" />
      <h2 class="flex flex-row text-3xl-regular items-baseline">
        In your Cart
      </h2>
      <CommonDivider class="my-6" />
      <CommonCartTotals :totals="{ ...cart, currency_code: currencyCode }" />
      <CartItemsPreview
        :items="cart.items || []"
        :currency-code="currencyCode"
      />
      <div class="my-6">
        <CheckoutDiscountCode />
      </div>
    </div>
  </div>
</template>
