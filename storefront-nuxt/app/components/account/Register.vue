<script setup lang="ts">
const emit = defineEmits<{
  'switch-view': []
}>()

const { register } = useCustomer()
const countryCode = useCountryCode()

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
    error.value = e instanceof Error ? e.message : 'An error occurred during registration'
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="max-w-sm flex flex-col items-center">
    <h1 class="text-large-semi uppercase mb-6">
      Become a Member
    </h1>
    <p class="text-center text-base-regular text-ui-fg-base mb-4">
      Create your profile, and get access to an enhanced shopping experience.
    </p>
    <form
      class="w-full flex flex-col"
      @submit.prevent="handleSubmit"
    >
      <div class="flex flex-col gap-y-4 w-full">
        <UInput
          v-model="form.first_name"
          placeholder="First name"
          required
          size="lg"
        />
        <UInput
          v-model="form.last_name"
          placeholder="Last name"
          required
          size="lg"
        />
        <UInput
          v-model="form.email"
          type="email"
          placeholder="Email"
          required
          size="lg"
        />
        <UInput
          v-model="form.phone"
          type="tel"
          placeholder="Phone"
          size="lg"
        />
        <UInput
          v-model="form.password"
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
      <span class="text-center text-ui-fg-base text-small-regular mt-6">
        By creating an account, you agree to our
        <NuxtLink
          :to="`/${countryCode}/content/privacy-policy`"
          class="underline"
        >
          Privacy Policy
        </NuxtLink>
        and
        <NuxtLink
          :to="`/${countryCode}/content/terms-of-use`"
          class="underline"
        >
          Terms of Use
        </NuxtLink>.
      </span>
      <UButton
        type="submit"
        class="w-full mt-6"
        size="lg"
        :loading="loading"
      >
        Join
      </UButton>
    </form>
    <span class="text-center text-ui-fg-base text-small-regular mt-6">
      Already a member?
      <button
        class="underline"
        @click="emit('switch-view')"
      >
        Sign in
      </button>
    </span>
  </div>
</template>
