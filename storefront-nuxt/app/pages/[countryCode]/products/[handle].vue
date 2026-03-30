<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const handle = computed(() => route.params.handle as string)
const { getRegion } = useRegion()

const { data: region } = await useAsyncData(
  `product-region-${countryCode.value}`,
  () => getRegion(countryCode.value)
)

const { data: productData } = await useAsyncData(
  `product-${handle.value}`,
  async (): Promise<HttpTypes.StoreProduct | null> => {
    const r = region.value
    if (!r) return null
    const res = await $fetch<{ products?: HttpTypes.StoreProduct[] }>('/api/products', {
      query: {
        handle: handle.value,
        region_id: r.id,
        fields: '*variants.calculated_price,+variants.inventory_quantity,+metadata,+tags'
      }
    })
    return res.products?.[0] ?? null
  }
)

if (!region.value || !productData.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Product not found'
  })
}

useSeoMeta({
  title: () => productData.value ? `${productData.value.title} | Medusa Store` : 'Product | Medusa Store',
  description: () => productData.value?.title ?? undefined,
  ogTitle: () => productData.value ? `${productData.value.title} | Medusa Store` : '',
  ogImage: () => productData.value?.thumbnail ?? undefined
})
</script>

<template>
  <div v-if="productData && region">
    <div
      class="content-container flex flex-col small:flex-row small:items-start py-6 relative"
      data-testid="product-container"
    >
      <div class="flex flex-col small:sticky small:top-48 small:py-0 small:max-w-[300px] w-full py-8 gap-y-6">
        <ProductInfo :product="productData" />
        <ProductTabs :product="productData" />
      </div>
      <div class="block w-full relative">
        <ProductImageGallery :images="productData.images ?? []" />
      </div>
      <div class="flex flex-col small:sticky small:top-48 small:py-0 small:max-w-[300px] w-full py-8 gap-y-12">
        <ProductOnboardingCta />
        <ProductActionsWrapper
          :id="productData.id"
          :region="region"
          :fallback-product="productData"
        />
      </div>
    </div>
    <div
      class="content-container my-16 small:my-32"
      data-testid="related-products-container"
    >
      <ProductRelatedProducts
        :product="productData"
        :country-code="countryCode"
      />
    </div>
  </div>
  <div
    v-else
    class="flex items-center justify-center min-h-[50vh]"
  >
    <UIcon
      name="i-lucide-loader-2"
      class="animate-spin w-8 h-8"
    />
  </div>
</template>
