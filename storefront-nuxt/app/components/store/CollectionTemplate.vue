<script setup lang="ts">
defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  collection: any
}>()

const route = useRoute()
const router = useRouter()

const sortBy = ref((route.query.sortBy as string) || 'created_at')
const page = ref(Number(route.query.page) || 1)

const setSort = (value: string) => {
  sortBy.value = value
  page.value = 1
  router.push({ query: { ...route.query, sortBy: value, page: '1' } })
}

const setPage = (p: number) => {
  page.value = p
  router.push({ query: { ...route.query, page: String(p) } })
}
</script>

<template>
  <div
    class="content-container py-6"
    data-testid="collection-container"
  >
    <div class="mb-8 text-2xl-semi">
      <h1>
        {{ collection.title }}
      </h1>
    </div>
    <div class="flex flex-col small:flex-row small:items-start">
      <StoreRefinementList
        :sort-by="sortBy"
        @set-sort="setSort"
      />
      <div class="flex-1">
        <StorePaginatedProducts
          :sort-by="sortBy"
          :page="page"
          :collection-id="collection.id"
          @page-change="setPage"
        />
      </div>
    </div>
  </div>
</template>
