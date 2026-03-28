<script setup lang="ts">
defineProps<{
  href: string
}>()

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
</script>

<template>
  <NuxtLink
    class="flex gap-x-1 items-center group"
    :to="`/${countryCode}${href}`"
  >
    <span class="text-ui-fg-interactive"><slot /></span>
    <UIcon
      name="i-lucide-arrow-up-right"
      class="group-hover:rotate-45 ease-in-out duration-150 w-4 h-4"
      style="color: var(--color-ui-fg-interactive)"
    />
  </NuxtLink>
</template>
