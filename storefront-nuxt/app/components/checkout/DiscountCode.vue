<script setup lang="ts">
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
    error.value = e instanceof Error ? e.message : 'Failed to apply promotion code'
  } finally {
    applying.value = false
  }
}

async function handleRemove(codeToRemove: string) {
  try {
    await applyPromotions(appliedCodes.value.filter(c => c !== codeToRemove))
  } catch {
    // Silently fail
  }
}
</script>

<template>
  <div>
    <button
      class="text-ui-fg-interactive text-small-semi flex items-center gap-x-1"
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
          class="flex items-center gap-x-2"
          @submit.prevent="handleApply"
        >
          <UInput
            v-model="code"
            placeholder="Enter code"
            size="sm"
            class="flex-1"
          />
          <UButton
            type="submit"
            size="sm"
            variant="outline"
            :loading="applying"
          >
            Apply
          </UButton>
        </form>
        <p
          v-if="error"
          class="text-rose-500 text-small-regular mt-1"
        >
          {{ error }}
        </p>
      </div>
    </Transition>

    <div
      v-if="appliedCodes.length"
      class="flex flex-wrap gap-2 mt-3"
    >
      <UBadge
        v-for="c in appliedCodes"
        :key="c"
        color="primary"
        variant="subtle"
        class="flex items-center gap-x-1"
      >
        {{ c }}
        <button @click="handleRemove(c)">
          <UIcon
            name="lucide:x"
            class="size-3"
          />
        </button>
      </UBadge>
    </div>
  </div>
</template>
