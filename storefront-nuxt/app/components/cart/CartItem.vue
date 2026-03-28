<script setup lang="ts">
const props = defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  item: any
  currencyCode: string
  type?: 'full' | 'preview'
}>()

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { updateLineItem } = useCart()

const maxQuantity = computed(() => {
  if (props.item.variant?.manage_inventory) {
    return props.item.variant.inventory_quantity ?? 10
  }
  return 10
})

const isUpdating = ref(false)
const error = ref<string | null>(null)

const handleQuantityChange = async (qty: number) => {
  error.value = null
  isUpdating.value = true
  try {
    await updateLineItem(props.item.id, qty)
  } catch (err: any) {
    error.value = err.message
  } finally {
    isUpdating.value = false
  }
}
</script>

<template>
  <tr class="w-full border-b border-ui-border-base" data-testid="product-row">
    <td class="pl-0! p-4 w-24">
      <NuxtLink
        :to="`/${countryCode}/products/${item.product_handle}`"
        :class="['flex', type === 'preview' ? 'w-16' : 'small:w-24 w-12']"
      >
        <ProductThumbnail
          :thumbnail="item.thumbnail"
          :images="item.variant?.product?.images"
          size="square"
        />
      </NuxtLink>
    </td>

    <td class="text-left p-4">
      <span class="txt-medium-plus text-ui-fg-base" data-testid="product-title">
        {{ item.product_title }}
      </span>
      <CommonLineItemOptions :variant="item.variant" data-testid="product-variant" />
    </td>

    <td v-if="type === 'full'" class="p-4">
      <div class="flex gap-2 items-center w-28">
        <CommonDeleteButton :id="item.id" data-testid="product-delete-button" />
        <select
          :value="item.quantity"
          class="w-14 h-10 p-4 border border-ui-border-base rounded-md text-sm bg-white"
          :disabled="isUpdating"
          data-testid="product-select-button"
          @change="handleQuantityChange(Number(($event.target as HTMLSelectElement).value))"
        >
          <option
            v-for="q in Math.min(maxQuantity, 10)"
            :key="q"
            :value="q"
          >
            {{ q }}
          </option>
        </select>
        <svg v-if="isUpdating" class="animate-spin h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
        </svg>
      </div>
      <p v-if="error" class="text-rose-500 text-small-regular mt-1" data-testid="product-error-message">
        {{ error }}
      </p>
    </td>

    <td v-if="type === 'full'" class="hidden small:table-cell p-4">
      <CommonLineItemUnitPrice
        :item="item"
        style-type="tight"
        :currency-code="currencyCode"
      />
    </td>

    <td class="pr-0! p-4">
      <span
        :class="['pr-0!', type === 'preview' ? 'flex flex-col items-end h-full justify-center' : '']"
      >
        <span v-if="type === 'preview'" class="flex gap-x-1">
          <span class="text-ui-fg-muted">{{ item.quantity }}x </span>
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
