<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { convertToLocale } from '~/utils/money'

const props = defineProps<{
  order: HttpTypes.StoreOrder
}>()

const countryCode = useCountryCode()

const itemCount = computed(() =>
  props.order.items?.reduce((sum, item) => sum + item.quantity, 0) ?? 0
)

const firstThreeItems = computed(() =>
  (props.order.items ?? []).slice(0, 3)
)

function formatDate(date: string | Date) {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}
</script>

<template>
  <div class="border border-gray-200 rounded-lg p-4 flex flex-col small:flex-row small:items-center small:justify-between gap-y-4">
    <div class="flex flex-col gap-y-1">
      <div class="flex items-center gap-x-2">
        <h3 class="text-base-semi">
          Order #{{ order.display_id }}
        </h3>
        <span class="text-small-regular text-ui-fg-subtle">
          {{ formatDate(order.created_at) }}
        </span>
      </div>
      <div class="flex items-center gap-x-4 text-small-regular text-ui-fg-subtle">
        <span>
          {{ convertToLocale({ amount: order.total, currency_code: order.currency_code }) }}
        </span>
        <span>{{ itemCount }} {{ itemCount === 1 ? 'item' : 'items' }}</span>
      </div>
    </div>

    <div class="flex items-center gap-x-4">
      <div class="flex -space-x-3">
        <ProductThumbnail
          v-for="item in firstThreeItems"
          :key="item.id"
          :thumbnail="item.thumbnail"
          size="small"
          class="w-12 h-12 rounded border-2 border-white"
        />
      </div>
      <NuxtLink
        :to="`/${countryCode}/account/orders/details/${order.id}`"
        class="text-ui-fg-interactive text-small-semi"
      >
        See details →
      </NuxtLink>
    </div>
  </div>
</template>
