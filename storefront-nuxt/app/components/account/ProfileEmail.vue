<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = defineProps<{
  customer: HttpTypes.StoreCustomer
}>()

const email = ref(props.customer.email || '')
const isSuccess = ref(false)
const isError = ref(false)
const errorMessage = ref('')

watch(() => props.customer, (customer) => {
  email.value = customer.email || ''
})

function handleSave() {
  isSuccess.value = true
  isError.value = false
  errorMessage.value = ''
}

function clearState() {
  isSuccess.value = false
  isError.value = false
  errorMessage.value = ''
  email.value = props.customer.email || ''
}
</script>

<template>
  <AccountInfo
    label="Email"
    :current-info="`${props.customer.email}`"
    :is-success="isSuccess"
    :is-error="isError"
    :error-message="errorMessage"
    data-testid="account-email-editor"
    @save="handleSave"
    @clear-state="clearState"
  >
    <UInput
      v-model="email"
      type="email"
      placeholder="Email"
      required
      data-testid="email-input"
    />
  </AccountInfo>
</template>
