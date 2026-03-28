<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'

const route = useRoute()
const orderId = computed(() => route.params.id as string)

const { data: order } = await useAsyncData<HttpTypes.StoreOrder>(
  `order-${orderId.value}`,
  () => apiFetch('/api/orders', { query: { id: orderId.value } })
)

useSeoMeta({
  title: () => order.value ? `Order #${order.value.display_id} | Medusa Store` : 'Order Details'
})
</script>

<template>
  <OrderDetailsTemplate
    v-if="order"
    :order="order"
  />
  <div
    v-else
    class="flex items-center justify-center min-h-[50vh]"
  >
    <UIcon
      name="i-lucide-loader-2"
      class="animate-spin w-8 h-8"
    />
  </div>
</template>
