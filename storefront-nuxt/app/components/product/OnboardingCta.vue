<script setup lang="ts">
const onboardingCookie = useCookie('_medusa_onboarding')

const isOnboarding = computed(() => onboardingCookie.value === 'true')
</script>

<template>
  <div
    v-if="isOnboarding"
    class="max-w-4xl h-full bg-ui-bg-subtle w-full p-8"
  >
    <div class="flex flex-col gap-y-4">
      <p class="text-ui-fg-base text-xl">
        Your demo product was successfully created! 🎉
      </p>
      <p class="text-ui-fg-subtle text-small-regular">
        You can now continue setting up your store in the admin.
      </p>
      <a
        href="http://localhost:7001/a/orders?onboarding_step=create_order_nextjs"
      >
        <UButton class="w-full">
          Continue setup in admin
        </UButton>
      </a>
    </div>
  </div>
</template>
