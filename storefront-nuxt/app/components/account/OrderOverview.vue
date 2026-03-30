<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  orders: HttpTypes.StoreOrder[]
}>()
</script>

<template>
  <div>
    <div
      v-if="orders.length"
      class="flex flex-col gap-y-8 w-full"
    >
      <div
        v-for="order in orders"
        :key="order.id"
        class="border-b border-gray-200 pb-6 last:pb-0 last:border-none"
      >
        <AccountOrderCard :order="order" />
      </div>
    </div>
    <div
      v-else
      class="w-full flex flex-col items-center gap-y-4"
      data-testid="no-orders-container"
    >
      <h2 class="text-large-semi">
        Nothing to see here
      </h2>
      <p class="text-base-regular">
        You don't have any orders yet, let us change that :)
      </p>
      <div class="mt-4">
        <NuxtLinkLocale to="/">
          <UButton data-testid="continue-shopping-button">
            Continue shopping
          </UButton>
        </NuxtLinkLocale>
      </div>
    </div>
  </div>
</template>
