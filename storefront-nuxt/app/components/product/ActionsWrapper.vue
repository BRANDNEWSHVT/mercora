<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = defineProps<{
  id: string
  region: HttpTypes.StoreRegion
  fallbackProduct: HttpTypes.StoreProduct
}>()

const { data: product } = await useAsyncData(
  `product-actions-${props.id}-${props.region.id}`,
  async (): Promise<HttpTypes.StoreProduct | null> => {
    const response = await $fetch<{ products?: HttpTypes.StoreProduct[] }>('/api/products', {
      query: {
        id: props.id,
        region_id: props.region.id
      }
    })

    return response.products?.[0] ?? null
  }
)
</script>

<template>
  <ProductActions
    v-if="product"
    :product="product"
    :region="region"
  />
  <ProductActions
    v-else
    :product="fallbackProduct"
    :region="region"
    disabled
  />
</template>
