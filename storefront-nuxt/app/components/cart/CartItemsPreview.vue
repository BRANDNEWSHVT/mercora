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

const hasOverflow = computed(() => sortedItems.value.length > 4)
</script>

<template>
  <div
    :class="{
      'pl-px overflow-y-scroll overflow-x-hidden no-scrollbar max-h-[420px]': hasOverflow
    }"
  >
    <table class="w-full table-auto text-sm">
      <tbody>
        <CartItem
          v-for="item in sortedItems"
          :key="item.id"
          :item="item"
          :currency-code="currencyCode"
          type="preview"
        />
      </tbody>
    </table>
  </div>
</template>
