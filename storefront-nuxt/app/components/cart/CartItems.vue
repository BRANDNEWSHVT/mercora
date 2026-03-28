<script setup lang="ts">
const props = defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  items: any[]
  currencyCode: string
}>()

const sortedItems = computed(() => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return [...(props.items || [])].sort((a: any, b: any) => {
    return (a.created_at ?? '') > (b.created_at ?? '') ? -1 : 1
  })
})
</script>

<template>
  <div>
    <div class="pb-3 flex items-center">
      <h1 class="text-[2rem] leading-[2.75rem]">
        Cart
      </h1>
    </div>
    <table class="w-full table-auto text-sm">
      <thead>
        <tr class="text-ui-fg-subtle txt-medium-plus border-b border-ui-border-base">
          <th class="pl-0! text-left py-2 font-medium">Item</th>
          <th class="text-left py-2 font-medium" />
          <th class="text-left py-2 font-medium">Quantity</th>
          <th class="hidden small:table-cell text-left py-2 font-medium">Price</th>
          <th class="pr-0! text-right py-2 font-medium">Total</th>
        </tr>
      </thead>
      <tbody>
        <CartItem
          v-for="item in sortedItems"
          :key="item.id"
          :item="item"
          :currency-code="currencyCode"
          type="full"
        />
      </tbody>
    </table>
  </div>
</template>
