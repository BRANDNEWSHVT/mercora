<script setup lang="ts">
const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { getRegion } = useRegion()

useSeoMeta({
  title: 'Medusa Store',
  description: 'A performant frontend ecommerce storefront with Nuxt and Medusa.',
})

const { data: collections } = await useAsyncData('home-collections', () =>
  $fetch('/api/collections', { query: { fields: 'id,handle,title' } })
)

const { data: region } = await useAsyncData(
  `home-region-${countryCode.value}`,
  () => getRegion(countryCode.value)
)
</script>

<template>
  <div>
    <HomeHero />
    <div class="py-12">
      <ul class="flex flex-col gap-x-6">
        <HomeFeaturedProducts
          v-if="collections?.length && region"
          :collections="collections"
          :region="region"
        />
      </ul>
    </div>
  </div>
</template>
