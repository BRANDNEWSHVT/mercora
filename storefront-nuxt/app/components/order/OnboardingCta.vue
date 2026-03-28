<script setup lang="ts">
const props = defineProps<{
  orderId: string
}>()

const onboardingCookie = useCookie('_medusa_onboarding')

function completeSetup() {
  onboardingCookie.value = 'false'
  navigateTo(`http://localhost:7001/a/orders/${props.orderId}`, {
    external: true
  })
}
</script>

<template>
  <div class="max-w-4xl h-full bg-ui-bg-subtle w-full">
    <div class="flex flex-col gap-y-4 p-4 md:items-center">
      <p class="text-ui-fg-base text-xl">
        Your test order was successfully created! 🎉
      </p>
      <p class="text-ui-fg-subtle text-small-regular">
        You can now complete setting up your store in the admin.
      </p>
      <UButton
        class="w-fit"
        @click="completeSetup"
      >
        Complete setup in admin
      </UButton>
    </div>
  </div>
</template>
