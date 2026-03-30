<script setup lang="ts">
import type { FetchError } from 'ofetch'
import { apiFetch } from '~/utils/api'

const route = useRoute()
const orderId = computed(() => route.params.id as string)
const token = computed(() => route.params.token as string)

const pending = ref(true)
const result = ref<{ success: boolean, error?: string } | null>(null)

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
        action: 'accept'
      }
    })
    result.value = { success: true }
  } catch (error: unknown) {
    result.value = { success: false, error: getErrorMessage(error) }
  } finally {
    pending.value = false
  }
})
</script>

<template>
  <div class="flex flex-col gap-y-4 items-start w-2/5 mx-auto mt-10 mb-20">
    <OrderTransferImage />
    <div class="flex flex-col gap-y-6">
      <template v-if="pending">
        <div class="flex items-center justify-center py-10">
          <UIcon
            name="i-lucide-loader-2"
            class="animate-spin w-8 h-8"
          />
        </div>
      </template>
      <template v-else-if="result?.success">
        <h1 class="text-xl text-zinc-900">
          Order transfered!
        </h1>
        <p class="text-zinc-600">
          Order {{ orderId }} has been successfully transfered to the new owner.
        </p>
      </template>
      <template v-else>
        <p class="text-zinc-600">
          There was an error accepting the transfer. Please try again.
        </p>
        <p
          v-if="result?.error"
          class="text-red-500"
        >
          Error message: {{ result.error }}
        </p>
      </template>
    </div>
  </div>
</template>
