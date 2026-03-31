<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = defineProps<{
  product: HttpTypes.StoreProduct
  countryCode: string
}>()

const { getRegion } = useRegion()

const { data: relatedProducts } = useAsyncData(
  `related-${props.product.id}`,
  async (): Promise<HttpTypes.StoreProduct[]> => {
    const region = await getRegion(props.countryCode)
    if (!region) return []

    const query: Record<string, string | boolean | string[]> = {
      region_id: region.id,
      is_giftcard: false,
      fields: '*variants.calculated_price'
    }
    if (props.product.collection_id) {
      query.collection_id = [props.product.collection_id]
    }
    if (props.product.tags?.length) {
      query.tag_id = props.product.tags
        .map(tag => tag.id)
        .filter((id): id is string => Boolean(id))
    }

    const res = await $fetch<{ products?: HttpTypes.StoreProduct[] }>('/api/products', { query })
    return res.products?.filter(item => item.id !== props.product.id) ?? []
  }
)
</script>

<template>
  <div v-if="relatedProducts?.length">
    <div class="flex flex-col items-center text-center mb-16">
      <span class="text-base-regular text-gray-600 mb-6">Related products</span>
      <p class="text-2xl-regular text-ui-fg-base max-w-lg">
        You might also want to check out these products.
      </p>
    </div>
    <ul class="grid grid-cols-2 small:grid-cols-3 medium:grid-cols-4 gap-x-6 gap-y-8">
      <li
        v-for="p in relatedProducts"
        :key="p.id"
      >
        <ProductPreview :product="p" />
      </li>
    </ul>
  </div>
</template>
