<script setup lang="ts">
definePageMeta({
  layout: 'checkout'
})

useSeoMeta({
  title: 'Checkout'
})

const { cart, loading } = useCart()
const { customer } = useCustomer()
</script>

<template>
  <div
    v-if="loading && !cart"
    class="content-container flex min-h-[40vh] items-center justify-center py-12 text-ui-fg-subtle"
  >
    <UIcon
      name="i-lucide-loader-2"
      class="h-8 w-8 animate-spin"
    />
  </div>
  <div
    v-else-if="cart"
    class="grid grid-cols-1 small:grid-cols-[1fr_416px] content-container gap-x-40 py-12"
  >
    <CheckoutForm
      :cart="cart"
      :customer="customer"
    />
    <CheckoutSummary :cart="cart" />
  </div>
  <div
    v-else
    class="content-container flex flex-col items-center justify-center gap-4 py-16 text-center"
  >
    <h1 class="text-2xl-semi">
      Your cart is empty
    </h1>
    <p class="max-w-xl text-ui-fg-subtle">
      Add a product to your cart before continuing to checkout.
    </p>
    <NuxtLinkLocale to="/store">
      <UButton size="lg">
        Explore products
      </UButton>
    </NuxtLinkLocale>
  </div>
</template>
