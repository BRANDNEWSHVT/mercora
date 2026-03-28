<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { convertToLocale } from '~/utils/money'

const props = defineProps<{
  order: HttpTypes.StoreOrder
}>()

const getAmount = (amount?: number | null) => {
  if (!amount) return
  return convertToLocale({ amount, currency_code: props.order.currency_code })
}
</script>

<template>
  <div>
    <h2 class="text-base-semi">
      Order Summary
    </h2>
    <div class="text-small-regular text-ui-fg-base my-2">
      <div class="flex items-center justify-between text-base-regular text-ui-fg-base mb-2">
        <span>Subtotal</span>
        <span>{{ getAmount(order.subtotal) }}</span>
      </div>
      <div class="flex flex-col gap-y-1">
        <div
          v-if="order.discount_total > 0"
          class="flex items-center justify-between"
        >
          <span>Discount</span>
          <span>- {{ getAmount(order.discount_total) }}</span>
        </div>
        <div
          v-if="order.gift_card_total > 0"
          class="flex items-center justify-between"
        >
          <span>Discount</span>
          <span>- {{ getAmount(order.gift_card_total) }}</span>
        </div>
        <div class="flex items-center justify-between">
          <span>Shipping</span>
          <span>{{ getAmount(order.shipping_total) }}</span>
        </div>
        <div class="flex items-center justify-between">
          <span>Taxes</span>
          <span>{{ getAmount(order.tax_total) }}</span>
        </div>
      </div>
      <div class="h-px w-full border-b border-gray-200 border-dashed my-4" />
      <div class="flex items-center justify-between text-base-regular text-ui-fg-base mb-2">
        <span>Total</span>
        <span>{{ getAmount(order.total) }}</span>
      </div>
    </div>
  </div>
</template>
