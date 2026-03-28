<script setup lang="ts">
import type { FetchError } from 'ofetch'
import { apiFetch } from '~/utils/api'

const route = useRoute()
const orderId = computed(() => route.params.id as string)
const token = computed(() => route.params.token as string)

const result = ref<{ success: boolean, error?: string }>({ success: false })

const getErrorMessage = (error: unknown) => {
  return (error as FetchError)?.data?.message
    || (error as Error)?.message
    || 'Unknown error'
}

onMounted(async () => {
  try {
    await apiFetch('/api/orders/transfer', {
      method: 'POST',
      body: {
        id: orderId.value,
        token: token.value,
        action: 'decline'
      }
    })
    result.value = { success: true }
  } catch (error: unknown) {
    result.value = { success: false, error: getErrorMessage(error) }
  }
})
</script>

<template>
  <div class="flex flex-col gap-y-4 items-start w-2/5 mx-auto mt-10 mb-20">
    <OrderTransferImage />
    <div class="flex flex-col gap-y-6">
      <template v-if="result.success">
        <h1 class="text-xl text-zinc-900">
          Order transfer declined!
        </h1>
        <p class="text-zinc-600">
          Transfer of order {{ orderId }} has been successfully declined.
        </p>
      </template>
      <template v-else>
        <p class="text-zinc-600">
          There was an error declining the transfer. Please try again.
        </p>
        <p
          v-if="result.error"
          class="text-red-500"
        >
          Error message: {{ result.error }}
        </p>
      </template>
    </div>
  </div>
</template>
