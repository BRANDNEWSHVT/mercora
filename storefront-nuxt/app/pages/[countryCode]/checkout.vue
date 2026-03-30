<script setup lang="ts">
definePageMeta({
  layout: 'checkout'
})

useSeoMeta({
  title: 'Checkout'
})

const { cart } = useCart()
const { customer } = useCustomer()

if (!cart.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Cart not found'
  })
}

const checkoutCart = cart.value
</script>

<template>
  <div class="grid grid-cols-1 small:grid-cols-[1fr_416px] content-container gap-x-40 py-12">
    <CheckoutForm
      :cart="checkoutCart"
      :customer="customer"
    />
    <CheckoutSummary :cart="checkoutCart" />
  </div>
</template>
