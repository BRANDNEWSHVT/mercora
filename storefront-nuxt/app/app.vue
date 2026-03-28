<script setup lang="ts">
const { cart, fetchCart } = useCart()
const { customer, fetchCustomer } = useCustomer()
const { fetchRegions } = useRegion()

await callOnce('cart', async () => {
  await fetchCart()
})

await callOnce('regions', async () => {
  await fetchRegions()
})

await callOnce('customer', async () => {
  await fetchCustomer()
})

onMounted(async () => {
  if (!cart.value) {
    await fetchCart()
  }

  if (!customer.value) {
    await fetchCustomer()
  }
})

useHead({
  meta: [
    { name: 'viewport', content: 'width=device-width, initial-scale=1' }
  ],
  link: [
    { rel: 'icon', href: '/favicon.ico' }
  ],
  htmlAttrs: {
    lang: 'en'
  }
})

useSeoMeta({
  title: 'Medusa Store',
  description: 'A performant ecommerce storefront powered by Medusa and Nuxt.',
  ogTitle: 'Medusa Store',
  ogDescription: 'A performant ecommerce storefront powered by Medusa and Nuxt.'
})
</script>

<template>
  <div>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>
