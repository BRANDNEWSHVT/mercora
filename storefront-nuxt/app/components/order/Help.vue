<script setup lang="ts">
const countryCode = useCountryCode()
</script>

<template>
  <div class="border border-gray-200 rounded-lg p-6">
    <h3 class="text-base-semi mb-2">
      Need help?
    </h3>
    <div class="flex flex-col gap-y-2 text-small-regular text-ui-fg-subtle">
      <NuxtLink
        :to="`/${countryCode}/contact`"
        class="flex items-center gap-x-2 hover:text-ui-fg-base transition-colors"
      >
        <UIcon
          name="lucide:headphones"
          class="size-4"
        />
        <span>Contact</span>
      </NuxtLink>
      <NuxtLink
        :to="`/${countryCode}/content/returns`"
        class="flex items-center gap-x-2 hover:text-ui-fg-base transition-colors"
      >
        <UIcon
          name="lucide:package"
          class="size-4"
        />
        <span>Returns &amp; Exchanges</span>
      </NuxtLink>
    </div>
  </div>
</template>
