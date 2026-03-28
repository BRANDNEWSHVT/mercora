<script setup lang="ts">
defineProps<{
  price: {
    price_type?: string
    original_price?: string
    calculated_price?: string
  }
}>()
</script>

<template>
  <span
    v-if="price.price_type === 'sale'"
    class="line-through text-ui-fg-muted"
    data-testid="original-price"
  >
    {{ price.original_price }}
  </span>
  <span
    :class="['text-ui-fg-muted', price.price_type === 'sale' ? 'text-ui-fg-interactive' : '']"
    data-testid="price"
  >
    {{ price.calculated_price }}
  </span>
</template>
