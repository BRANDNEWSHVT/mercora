<script setup lang="ts">
const { cart } = useCart()

const shippingMethods = ref<Record<string, unknown>[]>([])
const paymentMethods = ref<Record<string, unknown>[]>([])

onMounted(async () => {
  if (!cart.value) return
  await Promise.all([fetchShippingMethods(), fetchPaymentMethods()])
})

watch(() => cart.value?.id, async () => {
  if (cart.value) {
    await Promise.all([fetchShippingMethods(), fetchPaymentMethods()])
  }
})

async function fetchShippingMethods() {
  try {
    const data = await $fetch<Record<string, unknown>[]>('/api/cart/shipping-options')
    shippingMethods.value = data || []
  } catch {
    shippingMethods.value = []
  }
}

async function fetchPaymentMethods() {
  if (!cart.value?.region?.id) return
  try {
    const data = await $fetch<Record<string, unknown>[]>('/api/cart/payment-methods', {
      params: { regionId: cart.value.region.id }
    })
    paymentMethods.value = data || []
  } catch {
    paymentMethods.value = []
  }
}
</script>

<template>
  <div
    v-if="cart"
    class="w-full flex flex-col gap-y-8"
  >
    <CheckoutAddresses />
    <CommonDivider />
    <CheckoutShipping :available-shipping-methods="shippingMethods" />
    <CommonDivider />
    <CheckoutPayment :available-payment-methods="paymentMethods" />
    <CommonDivider />
    <CheckoutReview />
  </div>
</template>
