<script setup lang="ts">
defineProps<{
  class?: string
}>()
</script>

<template>
  <div :class="['h-px w-full border-b border-gray-200 mt-1', $props.class]" />
</template>
