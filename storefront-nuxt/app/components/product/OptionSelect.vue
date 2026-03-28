<script setup lang="ts">
const props = defineProps<{
  option: any
  current: string | undefined
  title: string
  disabled?: boolean
  dataTestid?: string
}>()

const emit = defineEmits<{
  (e: 'update', optionId: string, value: string): void
}>()

const filteredOptions = computed(() => {
  return (props.option.values ?? []).map((v: any) => v.value)
})
</script>

<template>
  <div class="flex flex-col gap-y-3" :data-testid="dataTestid">
    <span class="text-sm">Select {{ title }}</span>
    <div class="flex flex-wrap justify-between gap-2">
      <button
        v-for="v in filteredOptions"
        :key="v"
        :class="[
          'border-ui-border-base bg-ui-bg-subtle border text-small-regular h-10 rounded-rounded p-2 flex-1',
          v === current ? 'border-ui-border-interactive' : 'hover:shadow-elevation-card-rest transition-shadow ease-in-out duration-150'
        ]"
        :disabled="disabled"
        data-testid="option-button"
        @click="emit('update', option.id, v)"
      >
        {{ v }}
      </button>
    </div>
  </div>
</template>
