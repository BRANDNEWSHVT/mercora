<script setup lang="ts">
import { getProductPrice } from '~/utils/get-product-price'

const props = defineProps<{
  product: any
  isFeatured?: boolean
  region?: any
}>()

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)

const cheapestPrice = computed(() => {
  const { cheapestPrice } = getProductPrice({ product: props.product })
  return cheapestPrice
})
</script>

<template>
  <NuxtLink :to="`/${countryCode}/products/${product.handle}`" class="group">
    <div data-testid="product-wrapper">
      <ProductThumbnail
        :thumbnail="product.thumbnail"
        :images="product.images"
        size="full"
        :is-featured="isFeatured"
      />
      <div class="flex txt-compact-medium mt-4 justify-between">
        <span class="text-ui-fg-subtle" data-testid="product-title">{{ product.title }}</span>
        <div class="flex items-center gap-x-2">
          <ProductPreviewPrice v-if="cheapestPrice" :price="cheapestPrice" />
        </div>
      </div>
    </div>
  </NuxtLink>
</template>
