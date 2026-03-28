<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  customer: HttpTypes.StoreCustomer
}>()

const isSuccess = ref(false)
const isError = ref(false)

function clearState() {
  isSuccess.value = false
  isError.value = false
}
</script>

<template>
  <AccountInfo
    label="Email"
    :current-info="customer.email || 'Add your email'"
    :is-success="isSuccess"
    :is-error="isError"
    error-message="Email update is not currently supported"
    @save="isError = true"
    @clear-state="clearState"
  >
    <UInput
      :model-value="customer.email"
      type="email"
      placeholder="Email"
      disabled
    />
    <p class="text-small-regular text-ui-fg-subtle">
      Email address cannot be changed at this time.
    </p>
  </AccountInfo>
</template>
