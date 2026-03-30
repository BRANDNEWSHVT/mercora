<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const route = useRoute()
const categorySegments = computed<string[]>(() => {
  const cat = route.params.category
  if (Array.isArray(cat)) {
    return cat.map(segment => String(segment))
  }

  return cat ? [String(cat)] : []
})
const categoryHandle = computed(() => categorySegments.value.join('/'))

const { data: category } = await useAsyncData(
  `category-${categoryHandle.value}`,
  async (): Promise<HttpTypes.StoreProductCategory | null> => {
    const categories = await $fetch<HttpTypes.StoreProductCategory[]>('/api/categories', {
      query: { handle: categoryHandle.value }
    })

    return categories.find(item => item.handle === categoryHandle.value) ?? categories[0] ?? null
  }
)

if (!category.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Category not found'
  })
}

useSeoMeta({
  title: () => category.value ? `${category.value.name} | Medusa Store` : 'Category | Medusa Store',
  description: () => category.value?.description ?? `${category.value?.name ?? 'Category'} category.`
})
</script>

<template>
  <StoreCategoryTemplate
    v-if="category"
    :category="category"
    :skeleton-count="category.products?.length || 8"
  />
  <div
    v-else
    class="flex items-center justify-center min-h-[50vh]"
  >
    <UIcon
      name="i-lucide-loader-2"
      class="animate-spin w-8 h-8"
    />
  </div>
</template>
