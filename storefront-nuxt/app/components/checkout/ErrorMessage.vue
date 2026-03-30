<script setup lang="ts">
defineProps<{
  error?: string | null
}>()

const attrs = useAttrs()
</script>

<template>
  <div
    v-if="error"
    v-bind="attrs"
    class="pt-2 text-rose-500 text-small-regular"
  >
    <span>{{ error }}</span>
  </div>
</template>
