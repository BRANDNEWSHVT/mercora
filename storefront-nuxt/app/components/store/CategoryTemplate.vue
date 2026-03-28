<script setup lang="ts">
defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  category: any
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  categories?: any[]
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
    data-testid="category-container"
  >
    <div class="mb-8">
      <h1 class="text-2xl-semi">
        {{ category.name }}
      </h1>
      <p
        v-if="category.description"
        class="text-base-regular text-ui-fg-subtle mt-2"
      >
        {{ category.description }}
      </p>
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
          :category-id="category.id"
          @page-change="setPage"
        />
      </div>
    </div>
  </div>
</template>
