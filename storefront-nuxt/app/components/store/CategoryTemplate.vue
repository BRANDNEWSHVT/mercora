<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import type { SortOptions } from '~/types'

const props = defineProps<{
  category: HttpTypes.StoreProductCategory
  skeletonCount?: number
}>()

const route = useRoute()
const router = useRouter()

const sortBy = computed<SortOptions>(() => (route.query.sortBy as SortOptions) || 'created_at')
const page = computed(() => Number(route.query.page) || 1)

const setSort = (value: SortOptions) => {
  router.push({ query: { ...route.query, sortBy: value } })
}

const setPage = (p: number) => {
  router.push({ query: { ...route.query, page: String(p) } })
}

const parents = computed(() => {
  const items: HttpTypes.StoreProductCategory[] = []
  let current = props.category?.parent_category

  while (current) {
    items.push(current)
    current = current.parent_category
  }

  return items
})
</script>

<template>
  <div
    class="flex flex-col small:flex-row small:items-start py-6 content-container"
    data-testid="category-container"
  >
    <StoreRefinementList
      :sort-by="sortBy"
      data-testid="sort-by-container"
      @set-sort="setSort"
    />
    <div class="w-full">
      <div class="flex flex-row mb-8 text-2xl-semi gap-4">
        <span
          v-for="parent in parents"
          :key="parent.id"
          class="text-ui-fg-subtle"
        >
          <NuxtLink
            :to="`/${route.params.countryCode}/categories/${parent.handle}`"
            class="mr-4 hover:text-black"
            data-testid="sort-by-link"
          >
            {{ parent.name }}
          </NuxtLink>
          /
        </span>
        <h1 data-testid="category-page-title">
          {{ category.name }}
        </h1>
      </div>
      <div
        v-if="category.description"
        class="mb-8 text-base-regular"
      >
        <p>{{ category.description }}</p>
      </div>
      <div
        v-if="category.category_children?.length"
        class="mb-8 text-base-large"
      >
        <ul class="grid grid-cols-1 gap-2">
          <li
            v-for="child in category.category_children"
            :key="child.id"
          >
            <CommonInteractiveLink :href="`/categories/${child.handle}`">
              {{ child.name }}
            </CommonInteractiveLink>
          </li>
        </ul>
      </div>
      <StorePaginatedProducts
        :sort-by="sortBy"
        :page="page"
        :category-id="category.id"
        :skeleton-count="skeletonCount || 8"
        @page-change="setPage"
      />
    </div>
  </div>
</template>
