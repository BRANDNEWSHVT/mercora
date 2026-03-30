<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const { cart } = useCart()
const cartId = computed(() => cart.value?.id ?? null)
const regionId = computed(() => cart.value?.region?.id ?? null)
const cartUpdatedAt = computed(() => cart.value?.updated_at ?? null)

async function fetchShippingMethods() {
  if (!cartId.value) {
    return []
  }

  try {
    const data = await $fetch<HttpTypes.StoreCartShippingOption[]>('/api/cart/shipping-options')
    shippingMethods.value = data || []
  } catch {
    shippingMethods.value = []
  }
}

async function fetchPaymentMethods() {
  if (!regionId.value) {
    paymentMethods.value = []
    return
  }

  try {
    const data = await $fetch<HttpTypes.StorePaymentProvider[]>('/api/cart/payment-methods', {
      params: { regionId: regionId.value }
    })
    paymentMethods.value = data || []
  } catch {
    paymentMethods.value = []
  }
}

const shippingMethods = ref<HttpTypes.StoreCartShippingOption[]>([])
const paymentMethods = ref<HttpTypes.StorePaymentProvider[]>([])

await Promise.all([fetchShippingMethods(), fetchPaymentMethods()])

watch([cartId, regionId, cartUpdatedAt], async ([nextCartId, nextRegionId, nextUpdatedAt], [prevCartId, prevRegionId, prevUpdatedAt]) => {
  if (nextCartId !== prevCartId || nextUpdatedAt !== prevUpdatedAt) {
    await fetchShippingMethods()
  }

  if (nextRegionId !== prevRegionId || nextUpdatedAt !== prevUpdatedAt) {
    await fetchPaymentMethods()
  }
})
</script>

<template>
  <div
    v-if="cart"
    class="w-full grid grid-cols-1 gap-y-8"
  >
    <CheckoutAddresses />
    <CheckoutShipping :available-shipping-methods="shippingMethods" />
    <CheckoutPayment :available-payment-methods="paymentMethods" />
    <CheckoutReview />
  </div>
</template>
