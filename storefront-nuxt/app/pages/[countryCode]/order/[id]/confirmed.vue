<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'

const route = useRoute()
const orderId = computed(() => route.params.id as string)

useSeoMeta({
  title: 'Order Confirmed',
  description: 'You purchase was successful'
})

const { data: order } = await useAsyncData<HttpTypes.StoreOrder>(
  `order-confirmed-${orderId.value}`,
  () => apiFetch('/api/orders', { query: { id: orderId.value } })
)

if (!order.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Order not found'
  })
}

const orderData = order.value
</script>

<template>
  <OrderCompletedTemplate :order="orderData" />
</template>
