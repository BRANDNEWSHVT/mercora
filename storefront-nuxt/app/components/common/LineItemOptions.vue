<script setup lang="ts">
defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  variant: any
}>()
</script>

<template>
  <p class="inline-block txt-medium text-ui-fg-subtle w-full overflow-hidden text-ellipsis">
    Variant: {{ variant?.title }}
  </p>
</template>
