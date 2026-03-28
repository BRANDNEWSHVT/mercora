<script setup lang="ts">
const props = defineProps<{
  id: string
}>()

const { deleteLineItem } = useCart()
const isDeleting = ref(false)

const handleDelete = async () => {
  isDeleting.value = true
  try {
    await deleteLineItem(props.id)
  } catch {
    isDeleting.value = false
  }
}
</script>

<template>
  <div class="flex items-center justify-between text-small-regular">
    <button
      class="flex gap-x-1 text-ui-fg-subtle hover:text-ui-fg-base cursor-pointer"
      @click="handleDelete"
    >
      <UIcon
        v-if="isDeleting"
        name="i-lucide-loader-2"
        class="animate-spin w-4 h-4"
      />
      <UIcon
        v-else
        name="i-lucide-trash-2"
        class="w-4 h-4"
      />
      <span><slot /></span>
    </button>
  </div>
</template>
