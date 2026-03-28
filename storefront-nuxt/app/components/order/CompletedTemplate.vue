<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  order: HttpTypes.StoreOrder
}>()
</script>

<template>
  <div class="py-6 min-h-[calc(100vh-64px)]">
    <div class="content-container flex flex-col justify-center items-center gap-y-10 max-w-4xl h-full w-full">
      <div
        class="flex flex-col gap-4 max-w-4xl h-full bg-white w-full py-10"
        data-testid="order-complete-container"
      >
        <h1 class="flex flex-col gap-y-3 text-ui-fg-base text-3xl mb-4">
          <span>Thank you!</span>
          <span>Your order was placed successfully.</span>
        </h1>
        <OrderDetails :order="order" />
        <h2 class="text-3xl-regular">
          Summary
        </h2>
        <OrderItems :order="order" />
        <CommonCartTotals
          :totals="{
            total: order.total,
            subtotal: order.subtotal,
            tax_total: order.tax_total,
            shipping_total: order.shipping_total,
            discount_total: order.discount_total,
            gift_card_total: order.gift_card_total,
            currency_code: order.currency_code,
            shipping_subtotal: order.shipping_subtotal ?? order.shipping_total
          }"
        />
        <OrderShippingDetails :order="order" />
        <OrderPaymentDetails :order="order" />
        <OrderHelp />
      </div>
    </div>
  </div>
</template>
