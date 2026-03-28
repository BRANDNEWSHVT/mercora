<script setup lang="ts">
const { customer } = useCustomer()

useSeoMeta({
  title: 'Addresses | Medusa Store',
  description: 'View your addresses',
})
</script>

<template>
  <div v-if="customer" class="w-full" data-testid="addresses-page-wrapper">
    <div class="mb-8 flex flex-col gap-y-4">
      <h1 class="text-2xl-semi">Shipping Addresses</h1>
      <p class="text-base-regular">
        View and update your shipping addresses, you can add as many as you like.
        Saving your addresses will make them available during checkout.
      </p>
    </div>
    <AccountAddressBook :customer="customer" />
  </div>
</template>
