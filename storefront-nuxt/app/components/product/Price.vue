<script setup lang="ts">
import { getProductPrice } from '~/utils/get-product-price'

const props = defineProps<{
  product: any
  variant?: any
}>()

const priceData = computed(() => {
  const { cheapestPrice, variantPrice } = getProductPrice({
    product: props.product,
    variantId: props.variant?.id,
  })
  return props.variant ? variantPrice : cheapestPrice
})
</script>

<template>
  <div v-if="!priceData" class="block w-32 h-9 bg-gray-100 animate-pulse" />
  <div v-else class="flex flex-col text-ui-fg-base">
    <span
      :class="['text-xl-semi', priceData.price_type === 'sale' ? 'text-ui-fg-interactive' : '']"
    >
      <template v-if="!variant">From </template>
      <span data-testid="product-price" :data-value="priceData.calculated_price_number">
        {{ priceData.calculated_price }}
      </span>
    </span>
    <template v-if="priceData.price_type === 'sale'">
      <p>
        <span class="text-ui-fg-subtle">Original: </span>
        <span class="line-through" data-testid="original-product-price" :data-value="priceData.original_price_number">
          {{ priceData.original_price }}
        </span>
      </p>
      <span class="text-ui-fg-interactive">-{{ priceData.percentage_diff }}%</span>
    </template>
  </div>
</template>
