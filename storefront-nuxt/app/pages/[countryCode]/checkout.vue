<script setup lang="ts">
definePageMeta({
  layout: 'checkout',
})

useSeoMeta({
  title: 'Checkout | Medusa Store',
})

const { cart } = useCart()
const { customer } = useCustomer()
</script>

<template>
  <div v-if="cart" class="grid grid-cols-1 small:grid-cols-[1fr_416px] content-container gap-x-40 py-12">
    <CheckoutForm :cart="cart" :customer="customer" />
    <CheckoutSummary :cart="cart" />
  </div>
  <div v-else class="flex items-center justify-center min-h-[50vh]">
    <UIcon name="i-lucide-loader-2" class="animate-spin w-8 h-8" />
  </div>
</template>
