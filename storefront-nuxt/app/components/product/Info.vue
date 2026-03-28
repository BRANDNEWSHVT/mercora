<script setup lang="ts">
defineProps<{
  product: any
}>()

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
</script>

<template>
  <div id="product-info">
    <div class="flex flex-col gap-y-4 lg:max-w-[500px] mx-auto">
      <NuxtLink
        v-if="product.collection"
        :to="`/${countryCode}/collections/${product.collection.handle}`"
        class="text-medium text-ui-fg-muted hover:text-ui-fg-subtle"
      >
        {{ product.collection.title }}
      </NuxtLink>
      <h2
        class="text-3xl leading-10 text-ui-fg-base"
        data-testid="product-title"
      >
        {{ product.title }}
      </h2>
      <p
        class="text-medium text-ui-fg-subtle whitespace-pre-line"
        data-testid="product-description"
      >
        {{ product.description }}
      </p>
    </div>
  </div>
</template>
