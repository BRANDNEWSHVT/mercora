<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { convertToLocale } from '~/utils/money'

const props = defineProps<{
  order: HttpTypes.StoreOrder
}>()

const numberOfLines = computed(() =>
  props.order.items?.reduce((sum, item) => sum + item.quantity, 0) ?? 0
)

const numberOfProducts = computed(() =>
  props.order.items?.length ?? 0
)

const firstThreeItems = computed(() =>
  (props.order.items ?? []).slice(0, 3)
)

function formatDate(date: string | Date) {
  return new Date(date).toDateString()
}
</script>

<template>
  <div
    class="bg-white flex flex-col"
    data-testid="order-card"
  >
    <div class="uppercase text-large-semi mb-1">
      #
      <span data-testid="order-display-id">
        {{ order.display_id }}
      </span>
    </div>
    <div class="flex items-center divide-x divide-gray-200 text-small-regular text-ui-fg-base">
      <span
        class="pr-2"
        data-testid="order-created-at"
      >
        {{ formatDate(order.created_at) }}
      </span>
      <span
        class="px-2"
        data-testid="order-amount"
      >
        {{ convertToLocale({ amount: order.total, currency_code: order.currency_code }) }}
      </span>
      <span class="pl-2">
        {{ numberOfLines }} {{ numberOfLines > 1 ? 'items' : 'item' }}
      </span>
    </div>
    <div class="grid grid-cols-2 small:grid-cols-4 gap-4 my-4">
      <div
        v-for="item in firstThreeItems"
        :key="item.id"
        class="flex flex-col gap-y-2"
        data-testid="order-item"
      >
        <ProductThumbnail
          :thumbnail="item.thumbnail"
          :images="[]"
          size="full"
        />
        <div class="flex items-center text-small-regular text-ui-fg-base">
          <span
            class="text-ui-fg-base font-semibold"
            data-testid="item-title"
          >
            {{ item.title }}
          </span>
          <span class="ml-2">x</span>
          <span data-testid="item-quantity">{{ item.quantity }}</span>
        </div>
      </div>
      <div
        v-if="numberOfProducts > 4"
        class="w-full h-full flex flex-col items-center justify-center"
      >
        <span class="text-small-regular text-ui-fg-base">
          + {{ numberOfLines - 4 }}
        </span>
        <span class="text-small-regular text-ui-fg-base">more</span>
      </div>
    </div>
    <div class="flex justify-end">
      <NuxtLinkLocale :to="`/account/orders/details/${order.id}`">
        <UButton
          data-testid="order-details-link"
          variant="outline"
        >
          See details
        </UButton>
      </NuxtLinkLocale>
    </div>
  </div>
</template>
