<script setup lang="ts">
const route = useRoute()
const handle = computed(() => route.params.handle as string)

const { data: collection } = await useAsyncData(
  `collection-${handle.value}`,
  async () => {
    const res = await $fetch('/api/collections', { query: { handle: handle.value } })
    return (res as any).collections?.[0] ?? null
  }
)

useSeoMeta({
  title: () => collection.value ? `${collection.value.title} | Medusa Store` : 'Collection',
  description: () => collection.value ? `${collection.value.title} collection` : '',
})
</script>

<template>
  <StoreCollectionTemplate v-if="collection" :collection="collection" />
  <div v-else class="flex items-center justify-center min-h-[50vh]">
    <UIcon name="i-lucide-loader-2" class="animate-spin w-8 h-8" />
  </div>
</template>
