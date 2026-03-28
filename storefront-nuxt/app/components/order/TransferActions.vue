<script setup lang="ts">
import { apiFetch } from '~/utils/api'
import { getApiErrorMessage } from '~/utils/api-error'

defineProps<{
  id: string
  token: string
}>()

const status = ref<'idle' | 'accepting' | 'declining' | 'success' | 'error'>('idle')
const message = ref('')

async function handleAccept(id: string, token: string) {
  status.value = 'accepting'
  message.value = ''
  try {
    await apiFetch('/api/orders/transfer', {
      method: 'POST',
      body: { id, token, action: 'accept' }
    })
    status.value = 'success'
    message.value = 'Order transfer accepted successfully.'
  } catch (e: unknown) {
    status.value = 'error'
    message.value = getApiErrorMessage(e, 'Failed to accept transfer')
  }
}

async function handleDecline(id: string, token: string) {
  status.value = 'declining'
  message.value = ''
  try {
    await apiFetch('/api/orders/transfer', {
      method: 'POST',
      body: { id, token, action: 'decline' }
    })
    status.value = 'success'
    message.value = 'Order transfer declined.'
  } catch (e: unknown) {
    status.value = 'error'
    message.value = getApiErrorMessage(e, 'Failed to decline transfer')
  }
}
</script>

<template>
  <div class="flex flex-col gap-y-4">
    <div
      v-if="status === 'idle' || status === 'accepting' || status === 'declining'"
      class="flex items-center gap-x-3"
    >
      <UButton
        :loading="status === 'accepting'"
        :disabled="status === 'declining'"
        @click="handleAccept(id, token)"
      >
        Accept transfer
      </UButton>
      <UButton
        variant="outline"
        :loading="status === 'declining'"
        :disabled="status === 'accepting'"
        @click="handleDecline(id, token)"
      >
        Decline
      </UButton>
    </div>
    <p
      v-if="message"
      class="text-small-regular"
      :class="status === 'error' ? 'text-rose-500' : 'text-green-600'"
    >
      {{ message }}
    </p>
  </div>
</template>
