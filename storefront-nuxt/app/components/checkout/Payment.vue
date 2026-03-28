<script setup lang="ts">
import { paymentInfoMap } from '~/utils/constants'

const props = defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  availablePaymentMethods: any[]
}>()

const { cart, initiatePaymentSession } = useCart()
const route = useRoute()
const router = useRouter()

const isOpen = computed(() => route.query.step === 'payment')

const selectedId = ref<string | null>(null)
const saving = ref(false)
const error = ref('')

const activeSession = computed(() =>
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  cart.value?.payment_collection?.payment_sessions?.find((s: any) => s.status === 'pending')
)
const paidByGiftcard = computed(() =>
  cart.value?.gift_cards?.length > 0 && cart.value?.total === 0
)
const paymentReady = computed(() =>
  (activeSession.value && (cart.value?.shipping_methods?.length ?? 0) > 0) || paidByGiftcard.value
)

onMounted(() => {
  const session = cart.value?.payment_collection?.payment_sessions?.[0]
  if (session?.provider_id) {
    selectedId.value = session.provider_id
  }
})

async function handleSelect(providerId: string) {
  selectedId.value = providerId
}

async function handleContinue() {
  if (!selectedId.value) return
  saving.value = true
  error.value = ''
  try {
    await initiatePaymentSession(selectedId.value)
    router.push({ query: { step: 'review' } })
  } catch (e: unknown) {
    error.value = e instanceof Error ? e.message : 'Failed to set payment method'
  } finally {
    saving.value = false
  }
}

function getPaymentInfo(providerId: string) {
  return paymentInfoMap[providerId] || { title: providerId, icon: 'lucide:credit-card' }
}

const _selectedMethod = computed(() =>
  props.availablePaymentMethods.find((m: Record<string, unknown>) => m.id === selectedId.value)
)

const _selectedPaymentInfo = computed(() => {
  if (!selectedId.value) return null
  return getPaymentInfo(selectedId.value)
})
</script>

<template>
  <div class="bg-white">
    <div class="flex items-center justify-between mb-6">
      <h2
        :class="[
          'flex flex-row text-3xl-regular gap-x-2 items-baseline',
          { 'opacity-50 pointer-events-none select-none': !isOpen && !paymentReady }
        ]"
      >
        Payment
        <UIcon
          v-if="!isOpen && paymentReady"
          name="i-lucide-check-circle-2"
          class="text-ui-fg-interactive"
        />
      </h2>
      <button
        v-if="!isOpen && paymentReady"
        class="text-ui-fg-interactive text-small-semi"
        @click="router.push({ query: { step: 'payment' } })"
      >
        Edit
      </button>
    </div>

    <div v-if="isOpen">
      <div
        v-if="availablePaymentMethods.length"
      >
        <button
          v-for="method in availablePaymentMethods"
          :key="method.id"
          class="flex items-center justify-between text-small-regular cursor-pointer py-4 border rounded-rounded px-8 mb-2 hover:shadow-borders-interactive-with-active"
          :class="selectedId === method.id ? 'border-ui-border-interactive' : ''"
          @click="handleSelect(method.id)"
        >
          <div class="flex items-center gap-x-3">
            <div
              class="size-4 rounded-full border-2 flex items-center justify-center"
              :class="selectedId === method.id ? 'border-ui-fg-base' : 'border-gray-300'"
            >
              <div
                v-if="selectedId === method.id"
                class="size-2 rounded-full bg-ui-fg-base"
              />
            </div>
            <UIcon
              :name="getPaymentInfo(method.id).icon"
              class="size-5"
            />
            <span class="text-base-regular">{{ getPaymentInfo(method.id).title }}</span>
          </div>
        </button>
      </div>
      <p
        v-else
        class="text-base-regular text-ui-fg-subtle"
      >
        No payment methods available.
      </p>

      <CheckoutErrorMessage :error="error" />

      <UButton
        class="mt-6"
        size="lg"
        :disabled="!selectedId"
        :loading="saving"
        @click="handleContinue"
      >
        {{ selectedId === 'pp_stripe_stripe' && !activeSession ? 'Enter card details' : 'Continue to review' }}
      </UButton>
    </div>

    <div
      v-else-if="cart && paymentReady && activeSession"
      class="flex items-start gap-x-1 w-full"
    >
      <div class="flex flex-col w-1/3">
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Payment method
        </p>
        <p class="txt-medium text-ui-fg-subtle">
          {{ getPaymentInfo(activeSession.provider_id).title }}
        </p>
      </div>
      <div class="flex flex-col w-1/3">
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Payment details
        </p>
        <div class="flex gap-2 txt-medium text-ui-fg-subtle items-center">
          <div class="flex items-center h-7 w-fit p-2 bg-ui-button-neutral-hover rounded-md">
            <UIcon
              :name="getPaymentInfo(selectedId || '').icon"
              class="size-4"
            />
          </div>
          <p>Another step will appear</p>
        </div>
      </div>
    </div>

    <div class="w-full h-px bg-gray-200 mt-8" />
  </div>
</template>
