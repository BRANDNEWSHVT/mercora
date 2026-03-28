<script setup lang="ts">
import { convertToLocale } from '~/utils/money'
import { getPercentageDiff } from '~/utils/get-percentage-diff'

const props = defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  item: any
  styleType?: 'default' | 'tight'
  currencyCode: string
}>()

const style = computed(() => props.styleType ?? 'default')
const originalPrice = computed(() => props.item.original_total)
const currentPrice = computed(() => props.item.total)
const hasReducedPrice = computed(() => currentPrice.value < originalPrice.value)
</script>

<template>
  <div class="flex flex-col gap-x-2 text-ui-fg-subtle items-end">
    <div class="text-left">
      <template v-if="hasReducedPrice">
        <p>
          <span
            v-if="style === 'default'"
            class="text-ui-fg-subtle"
          >Original: </span>
          <span
            class="line-through text-ui-fg-muted"
            data-testid="product-original-price"
          >
            {{ convertToLocale({ amount: originalPrice, currency_code: currencyCode }) }}
          </span>
        </p>
        <span
          v-if="style === 'default'"
          class="text-ui-fg-interactive"
        >
          -{{ getPercentageDiff(originalPrice, currentPrice || 0) }}%
        </span>
      </template>
      <span
        :class="['text-base-regular', hasReducedPrice ? 'text-ui-fg-interactive' : '']"
        data-testid="product-price"
      >
        {{ convertToLocale({ amount: currentPrice, currency_code: currencyCode }) }}
      </span>
    </div>
  </div>
</template>
