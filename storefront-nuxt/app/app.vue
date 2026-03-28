<script setup>
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
