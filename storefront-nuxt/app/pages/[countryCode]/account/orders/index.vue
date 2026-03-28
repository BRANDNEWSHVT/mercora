<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'

useSeoMeta({
  title: 'Orders | Medusa Store',
  description: 'Overview of your previous orders.'
})

const { data: orders } = await useAsyncData<HttpTypes.StoreOrder[]>('my-orders', () =>
  apiFetch('/api/orders')
)
</script>

<template>
  <div
    class="w-full"
    data-testid="orders-page-wrapper"
  >
    <div class="mb-8 flex flex-col gap-y-4">
      <h1 class="text-2xl-semi">
        Orders
      </h1>
      <p class="text-base-regular">
        View your previous orders and their status. You can also create returns or exchanges for your orders if needed.
      </p>
    </div>
    <div>
      <AccountOrderOverview :orders="orders ?? []" />
      <div class="w-full h-px bg-gray-200 my-16" />
      <AccountTransferRequestForm />
    </div>
  </div>
</template>
