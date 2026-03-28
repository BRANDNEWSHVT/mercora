<script setup lang="ts">
import { getApiErrorMessage } from '~/utils/api-error'

const { cart, applyPromotions } = useCart()

const showInput = ref(false)
const code = ref('')
const applying = ref(false)
const error = ref('')

const appliedCodes = computed(() => {
  const promos = cart.value?.promotions || []
  return promos.map((p: any) => p.code).filter(Boolean) as string[] // eslint-disable-line @typescript-eslint/no-explicit-any
})

async function handleApply() {
  if (!code.value.trim()) return
  applying.value = true
  error.value = ''
  try {
    await applyPromotions([...appliedCodes.value, code.value.trim()])
    code.value = ''
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'Failed to apply promotion code')
  } finally {
    applying.value = false
  }
}

async function handleRemove(codeToRemove: string) {
  try {
    await applyPromotions(appliedCodes.value.filter(c => c !== codeToRemove))
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'Failed to remove promotion code')
  }
}
</script>

<template>
  <div class="w-full bg-white flex flex-col">
    <button
      class="text-ui-fg-interactive txt-medium flex items-center gap-x-1 hover:text-ui-fg-interactive-hover"
      data-testid="add-discount-button"
      @click="showInput = !showInput"
    >
      <UIcon
        :name="showInput ? 'lucide:minus' : 'lucide:plus'"
        class="size-4"
      />
      <span>{{ showInput ? 'Hide' : 'Add' }} Promotion Code(s)</span>
    </button>

    <Transition
      enter-active-class="transition duration-200 ease-out"
      enter-from-class="opacity-0 -translate-y-1"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-150 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 -translate-y-1"
    >
      <div
        v-if="showInput"
        class="mt-3"
      >
        <form
          class="flex w-full gap-x-2"
          @submit.prevent="handleApply"
        >
          <input
            v-model="code"
            type="text"
            placeholder="Enter code"
            class="h-10 w-full rounded-md border border-ui-border-base px-3 text-sm text-ui-fg-base outline-hidden transition-colors placeholder:text-ui-fg-subtle focus:border-ui-fg-base"
            data-testid="discount-input"
          >
          <button
            type="submit"
            class="inline-flex h-10 items-center justify-center rounded-md border border-ui-border-base px-4 text-sm font-medium text-ui-fg-base transition-colors hover:bg-ui-bg-subtle disabled:cursor-not-allowed disabled:opacity-50"
            :disabled="applying"
            data-testid="discount-apply-button"
          >
            {{ applying ? 'Applying...' : 'Apply' }}
          </button>
        </form>
        <p
          v-if="error"
          class="text-rose-500 text-small-regular mt-1"
          data-testid="discount-error-message"
        >
          {{ error }}
        </p>
      </div>
    </Transition>

    <div
      v-if="appliedCodes.length"
      class="mt-4 flex flex-col gap-y-2"
    >
      <div
        v-for="c in appliedCodes"
        :key="c"
        class="flex items-center justify-between"
        data-testid="discount-row"
      >
        <span
          class="truncate rounded-md bg-ui-bg-subtle px-2 py-1 text-xs font-medium text-ui-fg-base"
          data-testid="discount-code"
        >
          {{ c }}
        </span>
        <button
          class="flex items-center text-ui-fg-subtle hover:text-ui-fg-base"
          data-testid="remove-discount-button"
          @click="handleRemove(c)"
        >
          <UIcon
            name="lucide:trash-2"
            class="size-4"
          />
          <span class="sr-only">Remove discount code from order</span>
        </button>
      </div>
    </div>
  </div>
</template>
