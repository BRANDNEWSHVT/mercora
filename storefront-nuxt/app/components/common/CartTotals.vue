<script setup lang="ts">
import { convertToLocale } from '~/utils/money'

defineProps<{
  totals: {
    total?: number | null
    subtotal?: number | null
    tax_total?: number | null
    shipping_total?: number | null
    discount_total?: number | null
    gift_card_total?: number | null
    currency_code: string
    shipping_subtotal?: number | null
  }
}>()
</script>

<template>
  <div>
    <div class="flex flex-col gap-y-2 txt-medium text-ui-fg-subtle">
      <div class="flex items-center justify-between">
        <span class="flex gap-x-1 items-center">Subtotal (excl. shipping and taxes)</span>
        <span
          data-testid="cart-subtotal"
          :data-value="totals.subtotal || 0"
        >
          {{ convertToLocale({ amount: totals.subtotal ?? 0, currency_code: totals.currency_code }) }}
        </span>
      </div>
      <div
        v-if="totals.discount_total"
        class="flex items-center justify-between"
      >
        <span>Discount</span>
        <span
          class="text-ui-fg-interactive"
          data-testid="cart-discount"
          :data-value="totals.discount_total || 0"
        >
          - {{ convertToLocale({ amount: totals.discount_total ?? 0, currency_code: totals.currency_code }) }}
        </span>
      </div>
      <div class="flex items-center justify-between">
        <span>Shipping</span>
        <span
          data-testid="cart-shipping"
          :data-value="totals.shipping_subtotal || 0"
        >
          {{ convertToLocale({ amount: totals.shipping_subtotal ?? 0, currency_code: totals.currency_code }) }}
        </span>
      </div>
      <div class="flex justify-between">
        <span class="flex gap-x-1 items-center">Taxes</span>
        <span
          data-testid="cart-taxes"
          :data-value="totals.tax_total || 0"
        >
          {{ convertToLocale({ amount: totals.tax_total ?? 0, currency_code: totals.currency_code }) }}
        </span>
      </div>
      <div
        v-if="totals.gift_card_total"
        class="flex items-center justify-between"
      >
        <span>Gift card</span>
        <span
          class="text-ui-fg-interactive"
          data-testid="cart-gift-card-amount"
          :data-value="totals.gift_card_total || 0"
        >
          - {{ convertToLocale({ amount: totals.gift_card_total ?? 0, currency_code: totals.currency_code }) }}
        </span>
      </div>
    </div>
    <div class="h-px w-full border-b border-gray-200 my-4" />
    <div class="flex items-center justify-between text-ui-fg-base mb-2 txt-medium">
      <span>Total</span>
      <span
        class="txt-xlarge-plus"
        data-testid="cart-total"
        :data-value="totals.total || 0"
      >
        {{ convertToLocale({ amount: totals.total ?? 0, currency_code: totals.currency_code }) }}
      </span>
    </div>
    <div class="h-px w-full border-b border-gray-200 mt-4" />
  </div>
</template>
