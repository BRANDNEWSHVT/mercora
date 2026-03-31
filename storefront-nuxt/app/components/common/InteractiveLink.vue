<script setup lang="ts">
defineProps<{
  href: string
}>()
</script>

<template>
  <NuxtLinkLocale
    class="flex gap-x-1 items-center group"
    :to="href"
  >
    <span class="text-ui-fg-interactive"><slot /></span>
    <UIcon
      name="i-lucide-arrow-up-right"
      class="group-hover:rotate-45 ease-in-out duration-150 w-4 h-4"
      style="color: var(--color-ui-fg-interactive)"
    />
  </NuxtLinkLocale>
</template>
