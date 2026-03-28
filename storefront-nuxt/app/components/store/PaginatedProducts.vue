<script setup lang="ts">
const props = withDefaults(defineProps<{
  sortBy?: string
  page?: number
  collectionId?: string
  categoryId?: string
  productsPerPage?: number
}>(), {
  sortBy: 'created_at',
  page: 1,
  productsPerPage: 12
})

const emit = defineEmits<{
  (e: 'pageChange', page: number): void
}>()

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { getRegion } = useRegion()

const queryKey = computed(() => {
  return `products-${props.sortBy}-${props.page}-${props.collectionId || ''}-${props.categoryId || ''}-${countryCode.value}`
})

const { data, pending } = useAsyncData(
  queryKey,
  async () => {
    const region = await getRegion(countryCode.value)
    if (!region) return { products: [], count: 0 }

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const query: Record<string, any> = {
      region_id: region.id,
      fields: '*variants.calculated_price',
      limit: props.productsPerPage,
      offset: (props.page - 1) * props.productsPerPage,
      order: props.sortBy === 'price_asc'
        ? 'variants.calculated_price'
        : props.sortBy === 'price_desc'
          ? '-variants.calculated_price'
          : '-created_at'
    }

    if (props.collectionId) query.collection_id = props.collectionId
    if (props.categoryId) query.category_id = props.categoryId

    return await $fetch('/api/products', { query })
  },
  { watch: [queryKey] }
)

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const products = computed(() => (data.value as any)?.products ?? [])
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const totalCount = computed(() => (data.value as any)?.count ?? 0)
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
