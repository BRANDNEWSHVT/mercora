<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  orders: HttpTypes.StoreOrder[]
}>()

const countryCode = useCountryCode()
</script>

<template>
  <div>
    <div
      v-if="orders.length"
      class="flex flex-col gap-y-8"
    >
      <AccountOrderCard
        v-for="order in orders"
        :key="order.id"
        :order="order"
      />
    </div>
    <div
      v-else
      class="flex flex-col items-center gap-y-4 text-center w-full"
    >
      <h2 class="text-large-semi">
        Nothing to see here
      </h2>
      <p class="text-base-regular text-ui-fg-subtle max-w-md">
        You don't have any orders yet, let us change that :)
      </p>
      <NuxtLink :to="`/${countryCode}`">
        <UButton size="lg">
          Continue shopping
        </UButton>
      </NuxtLink>
    </div>
  </div>
</template>
