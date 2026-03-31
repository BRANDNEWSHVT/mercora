<script setup lang="ts">
import { apiFetch } from '~/utils/api'
import { getApiErrorMessage } from '~/utils/api-error'

defineProps<{
  id: string
  token: string
}>()

type TransferStatus = 'pending' | 'success' | 'error'

const errorMessage = ref<string | null>(null)
const status = ref<{
  accept: TransferStatus | null
  decline: TransferStatus | null
}>({
  accept: null,
  decline: null
})

async function handleAccept(id: string, token: string) {
  status.value = { accept: 'pending', decline: null }
  errorMessage.value = null
  try {
    await apiFetch('/api/orders/transfer', {
      method: 'POST',
      body: { id, token, action: 'accept' }
    })
    status.value = { accept: 'success', decline: null }
  } catch (e: unknown) {
    errorMessage.value = getApiErrorMessage(e, 'Failed to accept transfer')
    status.value = { accept: 'error', decline: null }
  }
}

async function handleDecline(id: string, token: string) {
  status.value = { accept: null, decline: 'pending' }
  errorMessage.value = null
  try {
    await apiFetch('/api/orders/transfer', {
      method: 'POST',
      body: { id, token, action: 'decline' }
    })
    status.value = { accept: null, decline: 'success' }
  } catch (e: unknown) {
    errorMessage.value = getApiErrorMessage(e, 'Failed to decline transfer')
    status.value = { accept: null, decline: 'error' }
  }
}
</script>

<template>
  <div class="flex flex-col gap-y-4">
    <div
      v-if="status.accept === 'success'"
    >
      <p class="text-emerald-500">
        Order transferred successfully!
      </p>
    </div>
    <div
      v-if="status.decline === 'success'"
    >
      <p class="text-emerald-500">
        Order transfer declined successfully!
      </p>
    </div>
    <div
      v-if="status.accept !== 'success' && status.decline !== 'success'"
      class="flex gap-x-4"
    >
      <UButton
        size="lg"
        :loading="status.accept === 'pending'"
        :disabled="status.accept === 'pending' || status.decline === 'pending'"
        @click="handleAccept(id, token)"
      >
        Accept transfer
      </UButton>
      <UButton
        variant="outline"
        size="lg"
        :loading="status.decline === 'pending'"
        :disabled="status.accept === 'pending' || status.decline === 'pending'"
        @click="handleDecline(id, token)"
      >
        Decline transfer
      </UButton>
    </div>
    <p
      v-if="errorMessage"
      class="text-red-500"
    >
      {{ errorMessage }}
    </p>
  </div>
</template>
