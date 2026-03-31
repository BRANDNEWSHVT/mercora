<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { sortProducts } from '~/utils/sort-products'
import type { SortOptions } from '~/types'

const props = withDefaults(defineProps<{
  sortBy?: SortOptions
  page?: number
  collectionId?: string
  categoryId?: string
  productsPerPage?: number
  skeletonCount?: number
}>(), {
  sortBy: 'created_at',
  page: 1,
  productsPerPage: 12,
  skeletonCount: 8
})

const emit = defineEmits<{
  (e: 'pageChange', page: number): void
}>()

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { getRegion } = useRegion()
const skeletonItems = computed(() =>
  Array.from({ length: props.skeletonCount }, (_, index) => index)
)

const queryKey = computed(() => {
  return `products-${props.sortBy}-${props.page}-${props.collectionId || ''}-${props.categoryId || ''}-${countryCode.value}`
})

const { data, pending } = useAsyncData(
  queryKey,
  async (): Promise<{ products: HttpTypes.StoreProduct[], count: number }> => {
    const region = await getRegion(countryCode.value)
    if (!region) return { products: [], count: 0 }

    const query: Record<string, string | number | string[]> = {
      region_id: region.id,
      fields: '*variants.calculated_price',
      limit: 100,
      offset: 0
    }

    if (props.collectionId) query.collection_id = [props.collectionId]
    if (props.categoryId) query.category_id = [props.categoryId]
    if (props.sortBy === 'created_at') query.order = 'created_at'

    const response = await $fetch<{ products: HttpTypes.StoreProduct[], count: number }>('/api/products', { query })
    const sortedProducts = sortProducts(response.products ?? [], props.sortBy)
    const start = (props.page - 1) * props.productsPerPage
    const end = start + props.productsPerPage

    return {
      products: sortedProducts.slice(start, end),
      count: response.count ?? 0
    }
  },
  { watch: [queryKey] }
)

const products = computed(() => data.value?.products ?? [])
const totalCount = computed(() => data.value?.count ?? 0)
const totalPages = computed(() => Math.ceil(totalCount.value / props.productsPerPage))

const visiblePages = computed(() => {
  const pageNumbers: Array<number | string> = []

  const arrayRange = (start: number, stop: number) =>
    Array.from({ length: stop - start + 1 }, (_, index) => start + index)

  if (totalPages.value <= 7) {
    pageNumbers.push(...arrayRange(1, totalPages.value))
  } else if (props.page <= 4) {
    pageNumbers.push(...arrayRange(1, 5), 'ellipsis-1', totalPages.value)
  } else if (props.page >= totalPages.value - 3) {
    pageNumbers.push(1, 'ellipsis-2', ...arrayRange(totalPages.value - 4, totalPages.value))
  } else {
    pageNumbers.push(1, 'ellipsis-3', ...arrayRange(props.page - 1, props.page + 1), 'ellipsis-4', totalPages.value)
  }

  return pageNumbers
})
</script>

<template>
  <div>
    <ul
      v-if="pending"
      class="grid grid-cols-2 w-full small:grid-cols-3 medium:grid-cols-4 gap-x-6 gap-y-8 flex-1"
      data-testid="products-list-loader"
    >
      <li
        v-for="item in skeletonItems"
        :key="item"
      >
        <div class="flex flex-col gap-y-4">
          <div class="aspect-[11/14] w-full rounded-md bg-ui-bg-subtle animate-pulse" />
          <div class="space-y-2">
            <div class="h-4 w-3/4 rounded bg-ui-bg-subtle animate-pulse" />
            <div class="h-4 w-1/3 rounded bg-ui-bg-subtle animate-pulse" />
          </div>
        </div>
      </li>
    </ul>
    <ul
      v-else
      class="grid grid-cols-2 w-full small:grid-cols-3 medium:grid-cols-4 gap-x-6 gap-y-8"
      data-testid="products-list"
    >
      <li
        v-for="product in products"
        :key="product.id"
      >
        <ProductPreview :product="product" />
      </li>
    </ul>
    <div
      v-if="products.length === 0 && !pending"
      class="py-16 text-center text-ui-fg-subtle"
    >
      No products found.
    </div>
    <div
      v-if="totalPages > 1"
      class="flex justify-center w-full mt-12"
      data-testid="product-pagination"
    >
      <div class="flex gap-3 items-end">
        <template
          v-for="item in visiblePages"
          :key="item"
        >
          <span
            v-if="typeof item !== 'number'"
            class="txt-xlarge-plus text-ui-fg-muted items-center cursor-default"
          >
            ...
          </span>
          <button
            v-else
            type="button"
            class="txt-xlarge-plus text-ui-fg-muted"
            :class="item === page ? 'text-ui-fg-base hover:text-ui-fg-subtle' : ''"
            :disabled="item === page"
            @click="emit('pageChange', item)"
          >
            {{ item }}
          </button>
        </template>
      </div>
    </div>
  </div>
</template>
