<script setup lang="ts">
const oldPassword = ref('')
const newPassword = ref('')
const confirmPassword = ref('')
const isSuccess = ref(false)
const isError = ref(false)
const errorMessage = ref('')

function handleSave() {
  isSuccess.value = false
  isError.value = true
  errorMessage.value = 'Password update is not implemented'
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
    data-testid="account-password-editor"
    @save="handleSave"
    @clear-state="clearState"
  >
    <div class="grid grid-cols-2 gap-4">
      <UInput
        v-model="oldPassword"
        type="password"
        placeholder="Old password"
        required
        data-testid="old-password-input"
      />
      <UInput
        v-model="newPassword"
        type="password"
        placeholder="New password"
        required
        data-testid="new-password-input"
      />
      <UInput
        v-model="confirmPassword"
        type="password"
        placeholder="Confirm password"
        required
        data-testid="confirm-password-input"
      />
    </div>
  </AccountInfo>
</template>
