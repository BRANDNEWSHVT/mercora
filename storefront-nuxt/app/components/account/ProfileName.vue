<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { getApiErrorMessage } from '~/utils/api-error'

const props = defineProps<{
  customer: HttpTypes.StoreCustomer
}>()

const { updateCustomer } = useCustomer()

const firstName = ref(props.customer.first_name || '')
const lastName = ref(props.customer.last_name || '')
const isSuccess = ref(false)
const isError = ref(false)
const errorMessage = ref('')

watch(() => props.customer, (c) => {
  firstName.value = c.first_name || ''
  lastName.value = c.last_name || ''
})

const currentInfo = computed(() => {
  return `${props.customer.first_name || ''} ${props.customer.last_name || ''}`.trim()
})

async function handleSave() {
  isSuccess.value = false
  isError.value = false
  try {
    await updateCustomer({ first_name: firstName.value, last_name: lastName.value })
    isSuccess.value = true
  } catch (e: unknown) {
    isError.value = true
    errorMessage.value = getApiErrorMessage(e, 'Failed to update name')
  }
}

function clearState() {
  isSuccess.value = false
  isError.value = false
  errorMessage.value = ''
  firstName.value = props.customer.first_name || ''
  lastName.value = props.customer.last_name || ''
}
</script>

<template>
  <AccountInfo
    label="Name"
    :current-info="currentInfo"
    :is-success="isSuccess"
    :is-error="isError"
    :error-message="errorMessage"
    data-testid="account-name-editor"
    @save="handleSave"
    @clear-state="clearState"
  >
    <div class="grid grid-cols-2 gap-x-4">
      <UInput
        v-model="firstName"
        placeholder="First name"
        required
        data-testid="first-name-input"
      />
      <UInput
        v-model="lastName"
        placeholder="Last name"
        required
        data-testid="last-name-input"
      />
    </div>
  </AccountInfo>
</template>
