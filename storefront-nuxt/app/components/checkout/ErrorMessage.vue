<script setup lang="ts">
defineProps<{
  error?: string | null
}>()
</script>

<template>
  <div
    v-if="error"
    class="pt-2 text-rose-500 text-small-regular"
  >
    <span>{{ error }}</span>
  </div>
</template>
