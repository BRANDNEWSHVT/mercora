<script setup lang="ts">
const { sortBy } = defineProps<{
  sortBy: string
}>()

const emit = defineEmits<{
  (e: 'setSort', value: string): void
}>()

const sortOptions = [
  { label: 'Latest Arrivals', value: 'created_at' },
  { label: 'Price: Low -> High', value: 'price_asc' },
  { label: 'Price: High -> Low', value: 'price_desc' }
]
</script>

<template>
  <div
    class="flex small:flex-col gap-12 py-4 mb-8 small:px-0 pl-6 small:min-w-[250px] small:ml-[1.675rem]"
  >
    <div class="flex gap-x-3 flex-col gap-y-3">
      <span class="txt-compact-small text-ui-fg-muted font-medium">
        Sort by
      </span>
      <div data-testid="sort-container">
        <div
          v-for="option in sortOptions"
          :key="option.value"
        >
          <button
            type="button"
            class="txt-compact-small text-ui-fg-subtle hover:text-ui-fg-base hover:cursor-pointer transition-colors"
            :class="option.value === sortBy ? 'text-ui-fg-base' : ''"
            data-testid="radio-label"
            :data-active="option.value === sortBy"
            @click="emit('setSort', option.value)"
          >
            {{ option.label }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
