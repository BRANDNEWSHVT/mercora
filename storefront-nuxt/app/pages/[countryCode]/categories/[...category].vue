<script setup lang="ts">
const route = useRoute()
const categoryHandle = computed(() => {
  const cat = route.params.category
  return Array.isArray(cat) ? cat[cat.length - 1] : cat
})

const { data: category } = await useAsyncData(
  `category-${categoryHandle.value}`,
  async () => {
    const res = await $fetch('/api/categories', { query: { handle: categoryHandle.value } })
    const cats = (res as any).product_categories ?? []
    return cats.find((c: any) => c.handle === categoryHandle.value) ?? cats[0] ?? null
  }
)

useSeoMeta({
  title: () => category.value ? `${category.value.name} | Medusa Store` : 'Category',
  description: () => category.value?.description || '',
})
</script>

<template>
  <StoreCategoryTemplate v-if="category" :category="category" />
  <div v-else class="flex items-center justify-center min-h-[50vh]">
    <UIcon name="i-lucide-loader-2" class="animate-spin w-8 h-8" />
  </div>
</template>
