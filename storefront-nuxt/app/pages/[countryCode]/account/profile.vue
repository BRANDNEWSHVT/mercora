<script setup lang="ts">
const { customer } = useCustomer()
const { regions } = useRegion()

useSeoMeta({
  title: 'Profile | Medusa Store',
  description: 'View and edit your profile.',
})
</script>

<template>
  <div v-if="customer" class="w-full" data-testid="profile-page-wrapper">
    <div class="mb-8 flex flex-col gap-y-4">
      <h1 class="text-2xl-semi">Profile</h1>
      <p class="text-base-regular">
        View and update your profile information, including your name, email, and phone number.
        You can also update your billing address, or change your password.
      </p>
    </div>
    <div class="flex flex-col gap-y-8 w-full">
      <AccountProfileName :customer="customer" />
      <div class="w-full h-px bg-gray-200" />
      <AccountProfileEmail :customer="customer" />
      <div class="w-full h-px bg-gray-200" />
      <AccountProfilePhone :customer="customer" />
      <div class="w-full h-px bg-gray-200" />
      <AccountProfileBillingAddress />
    </div>
  </div>
  <div v-else class="flex items-center justify-center min-h-[50vh]">
    <UIcon name="i-lucide-loader-2" class="animate-spin w-8 h-8" />
  </div>
</template>
