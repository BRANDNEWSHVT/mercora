<script setup lang="ts">
const props = defineProps<{
  id: string
}>()

const { deleteLineItem } = useCart()
const isDeleting = ref(false)

const handleDelete = async () => {
  if (isDeleting.value) return
  isDeleting.value = true
  try {
    await deleteLineItem(props.id)
  } catch {
    // Keep local failure silent but restore the control.
  } finally {
    isDeleting.value = false
  }
}
</script>

<template>
  <div class="flex items-center justify-between text-small-regular">
    <button
      type="button"
      class="flex items-center text-ui-fg-subtle transition-colors hover:text-ui-fg-base disabled:cursor-not-allowed"
      :disabled="isDeleting"
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
      <span class="sr-only"><slot>Delete item</slot></span>
    </button>
  </div>
</template>
