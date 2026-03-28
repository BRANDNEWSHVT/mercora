<script setup lang="ts">
defineProps<{
  label: string
  currentInfo: string
  isSuccess: boolean
  isError: boolean
  errorMessage?: string
}>()

const emit = defineEmits<{
  'save': []
  'clear-state': []
}>()

const isEditing = ref(false)

function toggleEdit() {
  isEditing.value = !isEditing.value
  if (!isEditing.value) {
    emit('clear-state')
  }
}

function handleSubmit() {
  emit('save')
}
</script>

<template>
  <div class="text-small-regular">
    <div class="flex items-end justify-between">
      <div class="flex flex-col">
        <span class="uppercase text-ui-fg-base">{{ label }}</span>
        <div class="flex items-center gap-x-2 mt-1">
          <span
            v-if="!isEditing"
            class="text-ui-fg-subtle"
          >{{ currentInfo }}</span>
        </div>
      </div>
      <UButton
        variant="ghost"
        :color="isEditing ? 'neutral' : 'primary'"
        size="sm"
        @click="toggleEdit"
      >
        {{ isEditing ? 'Cancel' : 'Edit' }}
      </UButton>
    </div>

    <Transition
      enter-active-class="transition duration-200 ease-out"
      enter-from-class="opacity-0 -translate-y-1"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-150 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 -translate-y-1"
    >
      <div
        v-if="isEditing"
        class="mt-4"
      >
        <form @submit.prevent="handleSubmit">
          <div class="flex flex-col gap-y-4">
            <slot />
          </div>
          <UButton
            type="submit"
            class="mt-4"
            size="sm"
          >
            Save changes
          </UButton>
        </form>
      </div>
    </Transition>

    <Transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <UBadge
        v-if="isSuccess"
        color="success"
        class="mt-2"
      >
        Updated successfully
      </UBadge>
      <UBadge
        v-else-if="isError"
        color="error"
        class="mt-2"
      >
        {{ errorMessage || 'An error occurred' }}
      </UBadge>
    </Transition>
  </div>
</template>
