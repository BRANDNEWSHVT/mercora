<script setup lang="ts">
import { convertToLocale } from '~/utils/money'

const props = defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  item: any
  styleType?: 'default' | 'tight'
  currencyCode: string
}>()

const style = computed(() => props.styleType ?? 'default')
const hasReducedPrice = computed(() => props.item.total < props.item.original_total)
const percentageDiff = computed(() =>
  Math.round(((props.item.original_total - props.item.total) / props.item.original_total) * 100)
)
</script>

<template>
  <div class="flex flex-col text-ui-fg-muted justify-center h-full">
    <template v-if="hasReducedPrice">
      <p>
        <span
          v-if="style === 'default'"
          class="text-ui-fg-muted"
        >Original: </span>
        <span
          class="line-through"
          data-testid="product-unit-original-price"
        >
          {{ convertToLocale({ amount: item.original_total / item.quantity, currency_code: currencyCode }) }}
        </span>
      </p>
      <span
        v-if="style === 'default'"
        class="text-ui-fg-interactive"
      >-{{ percentageDiff }}%</span>
    </template>
    <span
      :class="['text-base-regular', hasReducedPrice ? 'text-ui-fg-interactive' : '']"
      data-testid="product-unit-price"
    >
      {{ convertToLocale({ amount: item.total / item.quantity, currency_code: currencyCode }) }}
    </span>
  </div>
</template>
