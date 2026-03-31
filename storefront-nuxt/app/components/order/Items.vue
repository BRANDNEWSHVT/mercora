<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = defineProps<{
  order: HttpTypes.StoreOrder
}>()

const sortedItems = computed(() => {
  return [...(props.order.items || [])].sort((a, b) => {
    return (a.created_at ?? '') > (b.created_at ?? '') ? -1 : 1
  })
})
</script>

<template>
  <div class="flex flex-col">
    <CommonDivider class="mb-0!" />
    <table>
      <tbody data-testid="products-table">
        <OrderItem
          v-for="item in sortedItems"
          :key="item.id"
          :item="item"
          :currency-code="order.currency_code"
        />
      </tbody>
    </table>
  </div>
</template>
