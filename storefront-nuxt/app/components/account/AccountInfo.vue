<script setup lang="ts">
const props = withDefaults(defineProps<{
  label: string
  currentInfo?: string
  isSuccess?: boolean
  isError?: boolean
  errorMessage?: string
}>(), {
  currentInfo: '',
  isSuccess: false,
  isError: false,
  errorMessage: 'An error occurred, please try again'
})

const attrs = useAttrs()

const emit = defineEmits<{
  'save': []
  'clear-state': []
}>()

const isEditing = ref(false)

function toggleEdit() {
  emit('clear-state')
  isEditing.value = !isEditing.value
}

function handleSubmit() {
  emit('save')
}

watch(() => props.isSuccess, (isSuccess) => {
  if (isSuccess) {
    isEditing.value = false
  }
})
</script>

<template>
  <div
    v-bind="attrs"
    class="text-small-regular"
  >
    <div class="flex items-end justify-between">
      <div class="flex flex-col">
        <span class="uppercase text-ui-fg-base">{{ label }}</span>
        <div class="flex items-center flex-1 basis-0 justify-end gap-x-4">
          <slot
            v-if="$slots['current-info']"
            name="current-info"
          />
          <span
            v-else
            class="font-semibold"
            data-testid="current-info"
          >
            {{ currentInfo }}
          </span>
        </div>
      </div>
      <UButton
        variant="outline"
        size="sm"
        class="w-[100px] min-h-[25px] py-1"
        :data-active="isEditing"
        data-testid="edit-button"
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
        class="py-4 overflow-visible"
      >
        <form @submit.prevent="handleSubmit">
          <div class="flex flex-col gap-y-2">
            <div>
              <slot />
            </div>
          </div>
          <div class="flex items-center justify-end mt-2">
            <UButton
              type="submit"
              class="w-full small:max-w-[140px]"
              data-testid="save-button"
            >
              Save changes
            </UButton>
          </div>
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
        class="p-2 my-4"
        data-testid="success-message"
      >
        <span>{{ label }} updated succesfully</span>
      </UBadge>
      <UBadge
        v-else-if="isError"
        color="error"
        class="p-2 my-4"
        data-testid="error-message"
      >
        <span>{{ errorMessage }}</span>
      </UBadge>
    </Transition>
  </div>
</template>
