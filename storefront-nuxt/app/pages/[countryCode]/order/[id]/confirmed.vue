<script setup lang="ts">
const route = useRoute()
const orderId = computed(() => route.params.id as string)

useSeoMeta({
  title: 'Order Confirmed | Medusa Store',
  description: 'Your purchase was successful',
})

const { data: order } = await useAsyncData(
  `order-confirmed-${orderId.value}`,
  () => $fetch('/api/orders', { query: { id: orderId.value } })
)
</script>

<template>
  <OrderCompletedTemplate v-if="order" :order="order" />
  <div v-else class="flex items-center justify-center min-h-[50vh]">
    <UIcon name="i-lucide-loader-2" class="animate-spin w-8 h-8" />
  </div>
</template>
