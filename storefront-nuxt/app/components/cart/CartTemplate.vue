<script setup lang="ts">
const { cart } = useCart()
const { customer } = useCustomer()
</script>

<template>
  <div class="py-12">
    <div
      class="content-container"
      data-testid="cart-container"
    >
      <template v-if="cart?.items?.length">
        <div class="grid grid-cols-1 small:grid-cols-[1fr_360px] gap-x-40">
          <div class="flex flex-col bg-white py-6">
            <template v-if="!customer">
              <CartSignInPrompt />
              <CommonDivider />
            </template>
            <CartItems
              :items="cart.items"
              :currency-code="cart.currency_code"
            />
          </div>
          <div class="relative">
            <div class="flex flex-col gap-y-8 sticky top-12">
              <CartSummary />
            </div>
          </div>
        </div>
      </template>
      <template v-else>
        <CartEmptyCart />
      </template>
    </div>
  </div>
</template>
