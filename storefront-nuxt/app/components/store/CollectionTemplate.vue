<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import type { SortOptions } from '~/types'

const props = defineProps<{
  collection: HttpTypes.StoreCollection
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
</script>

<template>
  <div
    class="flex flex-col small:flex-row small:items-start py-6 content-container"
  >
    <StoreRefinementList
      :sort-by="sortBy"
      @set-sort="setSort"
    />
    <div class="w-full">
      <div class="mb-8 text-2xl-semi">
        <h1>
          {{ collection.title }}
        </h1>
      </div>
      <StorePaginatedProducts
        :sort-by="sortBy"
        :page="page"
        :collection-id="collection.id"
        :skeleton-count="props.collection.products?.length || 8"
        @page-change="setPage"
      />
    </div>
  </div>
</template>
