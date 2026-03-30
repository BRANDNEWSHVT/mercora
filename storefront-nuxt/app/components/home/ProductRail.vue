<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = defineProps<{
  collection: HttpTypes.StoreCollection
  region: HttpTypes.StoreRegion
}>()

const { data: products } = await useAsyncData(
  `rail-${props.collection.id}`,
  async (): Promise<HttpTypes.StoreProduct[]> => {
    const res = await $fetch<{ products: HttpTypes.StoreProduct[] }>('/api/products', {
      query: {
        region_id: props.region?.id,
        collection_id: props.collection.id,
        fields: '*variants.calculated_price'
      }
    })
    return res.products ?? []
  }
)
</script>

<template>
  <div
    v-if="products?.length"
    class="content-container py-12 small:py-24"
  >
    <div class="flex justify-between mb-8">
      <span class="txt-xlarge">{{ collection.title }}</span>
      <CommonInteractiveLink :href="`/collections/${collection.handle}`">
        View all
      </CommonInteractiveLink>
    </div>
    <ul class="grid grid-cols-2 small:grid-cols-3 gap-x-6 gap-y-24 small:gap-y-36">
      <li
        v-for="product in products"
        :key="product.id"
      >
        <ProductPreview
          :product="product"
          :region="region"
          is-featured
        />
      </li>
    </ul>
  </div>
</template>
