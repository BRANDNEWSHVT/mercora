<script setup lang="ts">
const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
</script>

<template>
  <div class="flex items-center justify-between bg-white">
    <div>
      <h2 class="txt-xlarge">
        Already have an account?
      </h2>
      <p class="txt-medium text-ui-fg-subtle mt-2">
        Sign in for a better experience.
      </p>
    </div>
    <NuxtLink :to="`/${countryCode}/account`">
      <UButton
        variant="outline"
        class="h-10"
        data-testid="sign-in-button"
      >
        Sign in
      </UButton>
    </NuxtLink>
  </div>
</template>
