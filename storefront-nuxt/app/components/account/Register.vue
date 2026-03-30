<script setup lang="ts">
import { getApiErrorMessage } from '~/utils/api-error'

const emit = defineEmits<{
  'switch-view': []
}>()

const { register } = useCustomer()

const form = reactive({
  first_name: '',
  last_name: '',
  email: '',
  phone: '',
  password: ''
})
const error = ref('')
const loading = ref(false)

async function handleSubmit() {
  error.value = ''
  loading.value = true
  try {
    await register({
      first_name: form.first_name,
      last_name: form.last_name,
      email: form.email,
      password: form.password,
      phone: form.phone || undefined
    })
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'An error occurred during registration')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div
    class="max-w-sm flex flex-col items-center"
    data-testid="register-page"
  >
    <h1 class="text-large-semi uppercase mb-6">
      Become a Medusa Store Member
    </h1>
    <p class="text-center text-base-regular text-ui-fg-base mb-4">
      Create your Medusa Store Member profile, and get access to an enhanced
      shopping experience.
    </p>
    <form
      class="w-full flex flex-col"
      @submit.prevent="handleSubmit"
    >
      <div class="flex flex-col gap-y-2 w-full">
        <UInput
          v-model="form.first_name"
          placeholder="First name"
          required
          size="lg"
          autocomplete="given-name"
          data-testid="first-name-input"
        />
        <UInput
          v-model="form.last_name"
          placeholder="Last name"
          required
          size="lg"
          autocomplete="family-name"
          data-testid="last-name-input"
        />
        <UInput
          v-model="form.email"
          type="email"
          placeholder="Email"
          required
          size="lg"
          autocomplete="email"
          data-testid="email-input"
        />
        <UInput
          v-model="form.phone"
          type="tel"
          placeholder="Phone"
          size="lg"
          autocomplete="tel"
          data-testid="phone-input"
        />
        <UInput
          v-model="form.password"
          type="password"
          placeholder="Password"
          required
          size="lg"
          autocomplete="new-password"
          data-testid="password-input"
        />
      </div>
      <p
        v-if="error"
        class="text-rose-500 text-small-regular mt-2"
        data-testid="register-error"
      >
        {{ error }}
      </p>
      <span class="text-center text-ui-fg-base text-small-regular mt-6">
        By creating an account, you agree to Medusa Store's{{ ' ' }}
        <NuxtLinkLocale
          to="/content/privacy-policy"
          class="underline"
        >
          Privacy Policy
        </NuxtLinkLocale>{{ ' ' }}
        and{{ ' ' }}
        <NuxtLinkLocale
          to="/content/terms-of-use"
          class="underline"
        >
          Terms of Use
        </NuxtLinkLocale>.
      </span>
      <UButton
        type="submit"
        class="w-full mt-6 text-center"
        size="lg"
        :loading="loading"
        data-testid="register-button"
      >
        Join
      </UButton>
    </form>
    <span class="text-center text-ui-fg-base text-small-regular mt-6">
      Already a member?{{ ' ' }}
      <button
        type="button"
        class="underline"
        @click="emit('switch-view')"
      >
        Sign in
      </button>.
    </span>
  </div>
</template>
