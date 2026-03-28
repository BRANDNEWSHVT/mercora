<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = defineProps<{
  order: HttpTypes.StoreOrder
}>()

const sortedItems = computed(() => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return [...(props.order.items || [])].sort((a: any, b: any) => {
    return (a.created_at ?? '') > (b.created_at ?? '') ? -1 : 1
  })
})
</script>

<template>
  <div>
    <CommonDivider class="mb-4" />
    <h2 class="text-xl-semi mb-4">
      Order Items
    </h2>
    <div class="flex flex-col divide-y divide-gray-200">
      <OrderItem
        v-for="item in sortedItems"
        :key="item.id"
        :item="item"
        :currency-code="order.currency_code"
      />
    </div>
  </div>
</template>
