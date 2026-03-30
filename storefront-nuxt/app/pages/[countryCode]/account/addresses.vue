<script setup lang="ts">
const { customer } = useCustomer()
const route = useRoute()
const { getRegion } = useRegion()
const countryCode = computed(() => route.params.countryCode as string)

const { data: region } = await useAsyncData(
  `account-address-region-${countryCode.value}`,
  () => getRegion(countryCode.value)
)

useSeoMeta({
  title: 'Addresses',
  description: 'View your addresses'
})

if (!region.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Region not found'
  })
}

const regionData = region.value
</script>

<template>
  <div
    v-if="customer && region"
    class="w-full"
    data-testid="addresses-page-wrapper"
  >
    <div class="mb-8 flex flex-col gap-y-4">
      <h1 class="text-2xl-semi">
        Shipping Addresses
      </h1>
      <p class="text-base-regular">
        View and update your shipping addresses, you can add as many as you like.
        Saving your addresses will make them available during checkout.
      </p>
    </div>
    <AccountAddressBook
      :customer="customer"
      :region="regionData"
    />
  </div>
</template>
