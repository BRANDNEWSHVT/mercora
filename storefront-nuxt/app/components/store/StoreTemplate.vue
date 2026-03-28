<script setup lang="ts">
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
    class="flex flex-col small:flex-row small:items-start py-6 content-container"
    data-testid="category-container"
  >
    <StoreRefinementList
      :sort-by="sortBy"
      @set-sort="setSort"
    />
    <div class="flex-1">
      <div class="mb-8 text-2xl-semi">
        <h1 data-testid="store-page-title">All products</h1>
      </div>
      <StorePaginatedProducts
        :sort-by="sortBy"
        :page="page"
        @page-change="setPage"
      />
    </div>
  </div>
</template>
