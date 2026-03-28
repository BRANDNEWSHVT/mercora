<script setup lang="ts">
const oldPassword = ref('')
const newPassword = ref('')
const confirmPassword = ref('')
const isSuccess = ref(false)
const isError = ref(false)
const errorMessage = ref('')

function handleSave() {
  isSuccess.value = false
  isError.value = false

  if (newPassword.value !== confirmPassword.value) {
    isError.value = true
    errorMessage.value = 'New passwords do not match'
    return
  }

  // Password update not yet implemented in the Medusa store API
  isError.value = true
  errorMessage.value = 'Password update is not currently supported'
}

function clearState() {
  isSuccess.value = false
  isError.value = false
  errorMessage.value = ''
  oldPassword.value = ''
  newPassword.value = ''
  confirmPassword.value = ''
}
</script>

<template>
  <AccountInfo
    label="Password"
    current-info="The password is not shown for security reasons"
    :is-success="isSuccess"
    :is-error="isError"
    :error-message="errorMessage"
    @save="handleSave"
    @clear-state="clearState"
  >
    <div class="flex flex-col gap-y-4">
      <UInput
        v-model="oldPassword"
        type="password"
        placeholder="Old password"
        required
      />
      <UInput
        v-model="newPassword"
        type="password"
        placeholder="New password"
        required
      />
      <UInput
        v-model="confirmPassword"
        type="password"
        placeholder="Confirm password"
        required
      />
    </div>
  </AccountInfo>
</template>
