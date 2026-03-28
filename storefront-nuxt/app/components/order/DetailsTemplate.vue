<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  order: HttpTypes.StoreOrder
}>()

const countryCode = useCountryCode()
</script>

<template>
  <div class="flex flex-col justify-center gap-y-4">
    <div class="flex gap-2 justify-between items-center">
      <h1 class="text-2xl-semi">
        Order details
      </h1>
      <NuxtLink
        :to="`/${countryCode}/account/orders`"
        class="flex gap-2 items-center text-ui-fg-subtle hover:text-ui-fg-base"
        data-testid="back-to-overview-button"
      >
        <UIcon
          name="i-lucide-x"
          class="size-4"
        />
        Back to overview
      </NuxtLink>
    </div>
    <div
      class="flex flex-col gap-4 h-full bg-white w-full"
      data-testid="order-details-container"
    >
      <OrderDetails
        :order="order"
        :show-status="true"
      />
      <OrderItems :order="order" />
      <OrderShippingDetails :order="order" />
      <OrderSummary :order="order" />
      <OrderHelp />
    </div>
  </div>
</template>
