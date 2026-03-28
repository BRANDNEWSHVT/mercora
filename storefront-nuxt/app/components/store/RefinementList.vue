<script setup lang="ts">
const props = defineProps<{
  sortBy: string
}>()

const emit = defineEmits<{
  (e: 'setSort', value: string): void
}>()

const sortOptions = [
  { label: 'Latest Arrivals', value: 'created_at' },
  { label: 'Price: Low → High', value: 'price_asc' },
  { label: 'Price: High → Low', value: 'price_desc' }
]

const items = computed(() =>
  sortOptions.map(o => ({
    label: o.label,
    click: () => emit('setSort', o.value)
  }))
)

const currentLabel = computed(() => {
  return sortOptions.find(o => o.value === props.sortBy)?.label || 'Latest Arrivals'
})
</script>

<template>
  <div
    class="flex small:items-center gap-4 small:gap-8"
    data-testid="sort-container"
  >
    <ClientOnly>
      <UDropdownMenu :items="[items]">
        <UButton
          variant="ghost"
          trailing-icon="i-lucide-chevron-down"
        >
          Sort by: {{ currentLabel }}
        </UButton>
      </UDropdownMenu>
      <template #fallback>
        <UButton
          variant="ghost"
          trailing-icon="i-lucide-chevron-down"
        >
          Sort by: {{ currentLabel }}
        </UButton>
      </template>
    </ClientOnly>
  </div>
</template>
