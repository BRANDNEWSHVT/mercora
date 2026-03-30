<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { getRegion } = useRegion()

useSeoMeta({
  title: 'Medusa Next.js Starter Template',
  description: 'A performant frontend ecommerce starter template with Next.js 15 and Medusa.'
})

const { data: collections } = await useAsyncData('home-collections', () =>
  $fetch<HttpTypes.StoreCollection[]>('/api/collections', { query: { fields: 'id,handle,title' } })
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
