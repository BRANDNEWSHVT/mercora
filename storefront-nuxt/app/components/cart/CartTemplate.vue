<script setup lang="ts">
const { cart, loading } = useCart()
const { customer } = useCustomer()
</script>

<template>
  <div class="py-12">
    <div
      class="content-container"
      data-testid="cart-container"
    >
      <template v-if="loading && !cart">
        <div class="flex min-h-[40vh] items-center justify-center text-ui-fg-subtle">
          <UIcon
            name="i-lucide-loader-2"
            class="h-8 w-8 animate-spin"
          />
        </div>
      </template>
      <template v-else-if="cart?.items?.length">
        <div class="grid grid-cols-1 gap-y-10 small:grid-cols-[1fr_360px] small:gap-x-40 small:gap-y-0">
          <div class="flex flex-col gap-y-6 bg-white py-6">
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
            <div
              v-if="cart.region"
              class="flex flex-col gap-y-8 sticky top-12"
            >
              <div class="bg-white py-6">
                <CartSummary />
              </div>
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
