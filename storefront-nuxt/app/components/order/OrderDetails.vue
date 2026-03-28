<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  order: HttpTypes.StoreOrder
  showStatus?: boolean
}>()

const formatStatus = (str: string) => {
  const formatted = str.split('_').join(' ')
  return formatted.slice(0, 1).toUpperCase() + formatted.slice(1)
}
</script>

<template>
  <div>
    <p class="text-base-regular text-ui-fg-subtle">
      We have sent the order confirmation details to
      <span class="text-ui-fg-medium-plus font-semibold" data-testid="order-email">{{ order.email }}</span>.
    </p>
    <p class="mt-2">
      Order date: <span data-testid="order-date">{{ new Date(order.created_at).toDateString() }}</span>
    </p>
    <p class="mt-2 text-ui-fg-interactive">
      Order number: <span data-testid="order-id">{{ order.display_id }}</span>
    </p>
    <div class="flex items-center text-compact-small gap-x-4 mt-4">
      <template v-if="showStatus">
        <p>
          Order status: <span class="text-ui-fg-subtle" data-testid="order-status">{{ formatStatus(order.fulfillment_status) }}</span>
        </p>
        <p>
          Payment status: <span class="text-ui-fg-subtle" data-testid="order-payment-status">{{ formatStatus(order.payment_status) }}</span>
        </p>
      </template>
    </div>
  </div>
</template>
