<script setup lang="ts">
defineProps<{
  modelValue: string | number
  placeholder?: string
  disabled?: boolean
}>()

defineEmits<{
  (e: 'update:modelValue' | 'change', value: string): void
}>()
</script>

<template>
  <div class="relative flex items-center rounded-md border border-ui-border-base bg-white text-ui-fg-base txt-compact-small">
    <select
      :value="String(modelValue)"
      :disabled="disabled"
      class="h-10 w-14 appearance-none border-none bg-transparent px-3 pr-8 text-sm outline-hidden disabled:cursor-not-allowed"
      @change="
        (event) => {
          const value = (event.target as HTMLSelectElement).value
          $emit('update:modelValue', value)
          $emit('change', value)
        }
      "
    >
      <option
        v-if="placeholder"
        disabled
        value=""
      >
        {{ placeholder }}
      </option>
      <slot />
    </select>
    <span class="pointer-events-none absolute right-2 text-ui-fg-subtle">
      <UIcon
        name="i-lucide-chevron-down"
        class="w-4 h-4"
      />
    </span>
  </div>
</template>
