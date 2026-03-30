<script setup lang="ts">
import { apiFetch } from '~/utils/api'
import { getApiErrorMessage } from '~/utils/api-error'

interface TransferRequestResult {
  id: string
  email: string
}

const orderId = ref('')
const loading = ref(false)
const error = ref<string | null>(null)
const showSuccess = ref(false)
const successOrder = ref<TransferRequestResult | null>(null)

async function handleSubmit() {
  if (!orderId.value.trim()) return

  loading.value = true
  error.value = null
  showSuccess.value = false

  try {
    const result = await apiFetch<TransferRequestResult>('/api/orders/transfer', {
      method: 'POST',
      body: { order_id: orderId.value }
    })
    successOrder.value = result
    showSuccess.value = true
    orderId.value = ''
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'An error occurred')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="flex flex-col gap-y-4 w-full">
    <div class="grid small:grid-cols-2 items-center gap-x-8 gap-y-4 w-full">
      <div class="flex flex-col gap-y-1">
        <h3 class="text-lg text-neutral-950 font-semibold">
          Order transfers
        </h3>
        <p class="text-base-regular text-neutral-500">
          Can't find the order you are looking for?
          <br> Connect an order to your account.
        </p>
      </div>
      <form
        class="flex flex-col gap-y-1 small:items-end"
        @submit.prevent="handleSubmit"
      >
        <div class="flex flex-col gap-y-2 w-full">
          <UInput
            v-model="orderId"
            class="w-full"
            placeholder="Order ID"
            size="lg"
            data-testid="order-id-input"
          />
          <UButton
            type="submit"
            variant="outline"
            class="w-fit whitespace-nowrap self-end"
            :loading="loading"
            data-testid="transfer-request-button"
          >
            Request transfer
          </UButton>
        </div>
      </form>
    </div>

    <p
      v-if="error"
      class="text-base-regular text-rose-500 text-right"
    >
      {{ error }}
    </p>

    <div
      v-if="showSuccess && successOrder"
      class="flex justify-between p-4 bg-neutral-50 shadow-borders-base w-full self-stretch items-center"
    >
      <div class="flex gap-x-2 items-center">
        <UIcon
          name="i-lucide-check-circle"
          class="w-4 h-4 text-emerald-500"
        />
        <div class="flex flex-col gap-y-1">
          <p class="text-medium-pl text-neutral-950">
            Transfer for order {{ successOrder.id }} requested
          </p>
          <p class="text-base-regular text-neutral-600">
            Transfer request email sent to {{ successOrder.email }}
          </p>
        </div>
      </div>
      <button
        type="button"
        class="h-fit p-1 hover:bg-neutral-100 rounded"
        @click="showSuccess = false"
      >
        <UIcon
          name="i-lucide-x-circle"
          class="w-4 h-4 text-neutral-500"
        />
      </button>
    </div>
  </div>
</template>
