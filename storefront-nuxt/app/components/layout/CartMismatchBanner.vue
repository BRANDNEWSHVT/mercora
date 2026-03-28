<script setup lang="ts">
import { apiFetch } from '~/utils/api'

defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  customer: any
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  cart: any
}>()

const { fetchCart } = useCart()
const isPending = ref(false)
const actionText = ref('Run transfer again')

const handleSubmit = async () => {
  try {
    isPending.value = true
    actionText.value = 'Transferring..'
    await apiFetch('/api/customer/login', {
      method: 'POST',
      body: { transfer: true }
    })
    await fetchCart()
    actionText.value = 'Transferred'
  } catch {
    actionText.value = 'Run transfer again'
  } finally {
    isPending.value = false
  }
}
</script>

<template>
  <div
    v-if="customer && !cart?.customer_id"
    class="flex items-center justify-center small:p-4 p-2 text-center bg-orange-300 small:gap-2 gap-1 text-sm mt-2 text-orange-800"
  >
    <div class="flex flex-col small:flex-row small:gap-2 gap-1 items-center">
      <span class="flex items-center gap-1">
        <UIcon
          name="i-lucide-alert-circle"
          class="inline w-4 h-4"
        />
        Something went wrong when we tried to transfer your cart
      </span>
      <span>·</span>
      <UButton
        variant="ghost"
        class="hover:bg-transparent active:bg-transparent focus:bg-transparent text-orange-950 p-0"
        :disabled="isPending"
        @click="handleSubmit"
      >
        {{ actionText }}
      </UButton>
    </div>
  </div>
</template>
