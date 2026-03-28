<script setup lang="ts">
const emit = defineEmits<{
  'switch-view': []
}>()

const { login } = useCustomer()

const email = ref('')
const password = ref('')
const error = ref('')
const loading = ref(false)

async function handleSubmit() {
  error.value = ''
  loading.value = true
  try {
    await login(email.value, password.value)
  } catch (e: unknown) {
    error.value = e instanceof Error ? e.message : 'Invalid email or password'
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="max-w-sm w-full flex flex-col items-center">
    <h1 class="text-large-semi uppercase mb-6">
      Welcome back
    </h1>
    <p class="text-center text-base-regular text-ui-fg-base mb-8">
      Sign in to access an enhanced shopping experience.
    </p>
    <form
      class="w-full"
      @submit.prevent="handleSubmit"
    >
      <div class="flex flex-col gap-y-4 w-full">
        <UInput
          v-model="email"
          type="email"
          placeholder="Email"
          required
          size="lg"
        />
        <UInput
          v-model="password"
          type="password"
          placeholder="Password"
          required
          size="lg"
        />
      </div>
      <p
        v-if="error"
        class="text-rose-500 text-small-regular mt-2"
      >
        {{ error }}
      </p>
      <UButton
        type="submit"
        class="w-full mt-6"
        size="lg"
        :loading="loading"
      >
        Sign in
      </UButton>
    </form>
    <span class="text-center text-ui-fg-base text-small-regular mt-6">
      Not a member?
      <button
        class="underline"
        @click="emit('switch-view')"
      >
        Join us
      </button>
    </span>
  </div>
</template>
