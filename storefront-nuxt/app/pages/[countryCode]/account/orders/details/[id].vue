<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'

const route = useRoute()
const orderId = computed(() => route.params.id as string)

const { data: order } = await useAsyncData<HttpTypes.StoreOrder>(
  `order-${orderId.value}`,
  () => apiFetch('/api/orders', { query: { id: orderId.value } })
)

if (!order.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Order not found'
  })
}

const orderData = order.value

useSeoMeta({
  title: () => order.value ? `Order #${order.value.display_id}` : 'Order Details',
  description: 'View your order'
})
</script>

<template>
  <OrderDetailsTemplate :order="orderData" />
</template>
