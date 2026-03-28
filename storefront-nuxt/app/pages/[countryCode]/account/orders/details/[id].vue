<script setup lang="ts">
const route = useRoute()
const orderId = computed(() => route.params.id as string)

const { data: order } = await useAsyncData(
  `order-${orderId.value}`,
  () => $fetch('/api/orders', { query: { id: orderId.value } })
)

useSeoMeta({
  title: () => order.value ? `Order #${(order.value as any).display_id} | Medusa Store` : 'Order Details',
})
</script>

<template>
  <OrderDetailsTemplate v-if="order" :order="order" />
  <div v-else class="flex items-center justify-center min-h-[50vh]">
    <UIcon name="i-lucide-loader-2" class="animate-spin w-8 h-8" />
  </div>
</template>
