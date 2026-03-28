<script setup lang="ts">
import { convertToLocale } from '~/utils/money'

const props = defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  item: any
  currencyCode: string
}>()

const unitPrice = computed(() => {
  const original = props.item.unit_price ?? 0
  return convertToLocale({ amount: original, currency_code: props.currencyCode })
})

const totalPrice = computed(() => {
  const total = (props.item.unit_price ?? 0) * props.item.quantity
  return convertToLocale({ amount: total, currency_code: props.currencyCode })
})

const options = computed(() => {
  return props.item.variant?.title || ''
})
</script>

<template>
  <div class="flex gap-x-4 py-3">
    <div class="w-16 shrink-0">
      <ProductThumbnail
        :thumbnail="item.thumbnail"
        size="square"
      />
    </div>
    <div class="flex flex-1 items-center justify-between">
      <div class="flex flex-col">
        <p class="text-base-regular">
          {{ item.title || item.product_title }}
        </p>
        <p
          v-if="options"
          class="text-small-regular text-ui-fg-subtle"
        >
          {{ options }}
        </p>
        <p class="text-small-regular text-ui-fg-subtle">
          {{ item.quantity }} x {{ unitPrice }}
        </p>
      </div>
      <p class="text-base-semi">
        {{ totalPrice }}
      </p>
    </div>
  </div>
</template>
