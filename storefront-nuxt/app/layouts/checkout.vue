<script setup lang="ts">
const route = useRoute()
const countryCode = route.params.countryCode as string
</script>

<template>
  <div class="relative bg-white min-h-screen">
    <div class="h-16 bg-white border-b">
      <nav class="content-container flex items-center justify-between h-full">
        <NuxtLink
          :to="`/${countryCode}`"
          class="txt-compact-xlarge-plus text-ui-fg-subtle hover:text-ui-fg-base uppercase"
        >
          Medusa Store
        </NuxtLink>
      </nav>
    </div>
    <div class="relative">
      <slot />
    </div>
  </div>
</template>
