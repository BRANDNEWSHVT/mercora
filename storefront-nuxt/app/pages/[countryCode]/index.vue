<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { getRegion } = useRegion()

useSeoMeta({
  title: 'Medusa Next.js Starter Template',
  description: 'A performant frontend ecommerce starter template with Next.js 15 and Medusa.'
})

const { data: collections, error: collectionsError } = await useAsyncData('home-collections', () =>
  $fetch<HttpTypes.StoreCollection[]>('/api/collections', { query: { fields: 'id,handle,title' } })
)

const { data: region, error: regionError } = await useAsyncData(
  `home-region-${countryCode.value}`,
  () => getRegion(countryCode.value)
)

const hasFeaturedCollections = computed(() => {
  return Boolean(collections.value?.length && region.value)
})

const hasLoadError = computed(() => {
  return Boolean(collectionsError.value || regionError.value)
})

const featuredCollections = computed<HttpTypes.StoreCollection[]>(() => {
  return collections.value ?? []
})

const featuredRegion = computed<HttpTypes.StoreRegion | null>(() => {
  return region.value ?? null
})
</script>

<template>
  <div>
    <HomeHero />
    <div class="py-12">
      <ul
        v-if="hasFeaturedCollections"
        class="flex flex-col gap-x-6"
      >
        <HomeFeaturedProducts
          :collections="featuredCollections"
          :region="featuredRegion!"
        />
      </ul>
      <div
        v-else-if="hasLoadError"
        class="content-container"
      >
        <div class="rounded-xl border border-rose-200 bg-rose-50 px-6 py-8 text-center text-sm text-rose-700">
          <p class="font-medium">
            We couldn't load the featured collections.
          </p>
          <p class="mt-2 text-rose-600">
            Browse the full catalog while we retry in the background.
          </p>
          <NuxtLinkLocale
            to="/store"
            class="mt-4 inline-flex"
          >
            <UButton size="lg">
              Visit the store
            </UButton>
          </NuxtLinkLocale>
        </div>
      </div>
      <div
        v-else
        class="content-container"
      >
        <div class="rounded-xl border border-gray-200 bg-white px-6 py-8 text-center">
          <h2 class="text-xl-semi">
            New collections are on the way
          </h2>
          <p class="mt-2 text-ui-fg-subtle">
            The storefront is live, but there are no featured collections to show yet.
          </p>
          <NuxtLinkLocale
            to="/store"
            class="mt-4 inline-flex"
          >
            <UButton size="lg">
              Shop all products
            </UButton>
          </NuxtLinkLocale>
        </div>
      </div>
    </div>
  </div>
</template>
