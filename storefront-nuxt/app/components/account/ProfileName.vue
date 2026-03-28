<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

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
  const name = `${props.customer.first_name || ''} ${props.customer.last_name || ''}`.trim()
  return name || 'Add your name'
})

async function handleSave() {
  isSuccess.value = false
  isError.value = false
  try {
    await updateCustomer({ first_name: firstName.value, last_name: lastName.value })
    isSuccess.value = true
  } catch (e: unknown) {
    isError.value = true
    errorMessage.value = e instanceof Error ? e.message : 'Failed to update name'
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
    @save="handleSave"
    @clear-state="clearState"
  >
    <div class="grid grid-cols-2 gap-4">
      <UInput
        v-model="firstName"
        placeholder="First name"
        required
      />
      <UInput
        v-model="lastName"
        placeholder="Last name"
        required
      />
    </div>
  </AccountInfo>
</template>
