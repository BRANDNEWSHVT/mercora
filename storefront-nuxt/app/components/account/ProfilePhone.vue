<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = defineProps<{
  customer: HttpTypes.StoreCustomer
}>()

const { updateCustomer } = useCustomer()

const phone = ref(props.customer.phone || '')
const isSuccess = ref(false)
const isError = ref(false)
const errorMessage = ref('')

watch(() => props.customer, (c) => {
  phone.value = c.phone || ''
})

const currentInfo = computed(() => props.customer.phone || 'Add your phone number')

async function handleSave() {
  isSuccess.value = false
  isError.value = false
  try {
    await updateCustomer({ phone: phone.value })
    isSuccess.value = true
  } catch (e: unknown) {
    isError.value = true
    errorMessage.value = e instanceof Error ? e.message : 'Failed to update phone'
  }
}

function clearState() {
  isSuccess.value = false
  isError.value = false
  errorMessage.value = ''
  phone.value = props.customer.phone || ''
}
</script>

<template>
  <AccountInfo
    label="Phone"
    :current-info="currentInfo"
    :is-success="isSuccess"
    :is-error="isError"
    :error-message="errorMessage"
    @save="handleSave"
    @clear-state="clearState"
  >
    <UInput
      v-model="phone"
      type="tel"
      placeholder="Phone number"
    />
  </AccountInfo>
</template>
