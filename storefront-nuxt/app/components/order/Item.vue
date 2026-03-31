<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  item: HttpTypes.StoreOrderLineItem | HttpTypes.StoreCartLineItem
  currencyCode: string
}>()
</script>

<template>
  <tr
    class="w-full"
    data-testid="product-row"
  >
    <td class="pl-0! p-4 w-24">
      <div class="flex w-16">
        <ProductThumbnail
          :thumbnail="item.thumbnail"
          size="square"
        />
      </div>
    </td>

    <td class="text-left">
      <p
        class="txt-medium-plus text-ui-fg-base"
        data-testid="product-name"
      >
        {{ item.product_title }}
      </p>
      <CommonLineItemOptions
        :variant="item.variant"
        data-testid="product-variant"
      />
    </td>

    <td class="pr-0!">
      <span class="pr-0! flex flex-col items-end h-full justify-center">
        <span class="flex gap-x-1">
          <span class="text-ui-fg-muted">
            <span data-testid="product-quantity">{{ item.quantity }}</span>x
          </span>
          <CommonLineItemUnitPrice
            :item="item"
            style-type="tight"
            :currency-code="currencyCode"
          />
        </span>

        <CommonLineItemPrice
          :item="item"
          style-type="tight"
          :currency-code="currencyCode"
        />
      </span>
    </td>
  </tr>
</template>
