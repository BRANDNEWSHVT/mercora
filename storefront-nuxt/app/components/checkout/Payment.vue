<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { isStripe, paymentInfoMap } from '~/utils/constants'
import { getApiErrorMessage } from '~/utils/api-error'

const props = defineProps<{
  availablePaymentMethods: HttpTypes.StorePaymentProvider[]
}>()

const { cart, initiatePaymentSession } = useCart()
const route = useRoute()
const router = useRouter()
const { cardBrand, cardComplete, cardError, mountCard, resetCard } = useStripePayment()

const isOpen = computed(() => route.query.step === 'payment')
const isLoading = ref(false)
const error = ref('')
const cardMountRef = ref<HTMLElement | null>(null)
const selectedPaymentMethod = ref('')

type StoreCartWithGiftCards = HttpTypes.StoreCart & {
  gift_cards?: unknown[]
}

const activeSession = computed(() =>
  cart.value?.payment_collection?.payment_sessions?.find(session => session.status === 'pending')
)
const paidByGiftcard = computed(() =>
  ((cart.value as StoreCartWithGiftCards | null)?.gift_cards?.length ?? 0) > 0 && cart.value?.total === 0
)
const paymentReady = computed(() =>
  (activeSession.value && (cart.value?.shipping_methods?.length ?? 0) > 0) || paidByGiftcard.value
)
const selectedIsStripe = computed(() => isStripe(selectedPaymentMethod.value || undefined))

watch(() => activeSession.value?.provider_id, (providerId) => {
  if (providerId) {
    selectedPaymentMethod.value = providerId
  }
}, { immediate: true })

function getPaymentInfo(providerId: string) {
  return paymentInfoMap[providerId] || { title: providerId, icon: 'lucide:credit-card' }
}

async function setPaymentMethod(method: string) {
  error.value = ''
  selectedPaymentMethod.value = method

  if (!isStripe(method)) {
    resetCard()
    return
  }

  try {
    await initiatePaymentSession(method)
  } catch (nextError: unknown) {
    error.value = getApiErrorMessage(nextError, 'Failed to initialize Stripe')
  }
}

async function handleSubmit() {
  if (!selectedPaymentMethod.value) {
    return
  }

  isLoading.value = true

  try {
    const hasMatchingSession = activeSession.value?.provider_id === selectedPaymentMethod.value

    if (!hasMatchingSession) {
      await initiatePaymentSession(selectedPaymentMethod.value)
    }

    router.push({ query: { step: 'review' } })
  } catch (nextError: unknown) {
    error.value = getApiErrorMessage(nextError, 'Failed to set payment method')
  } finally {
    isLoading.value = false
  }
}

function handleEdit() {
  router.push({ query: { step: 'payment' } })
}

watch(
  () => [selectedPaymentMethod.value, activeSession.value?.data?.client_secret, isOpen.value] as const,
  async ([providerId, secret, open]) => {
    if (!open || !providerId || !secret || !isStripe(providerId) || !cardMountRef.value) {
      return
    }

    await nextTick()

    if (cardMountRef.value) {
      await mountCard(cardMountRef.value, String(secret))
    }
  }
)

watch(cardError, (nextError) => {
  if (nextError) {
    error.value = nextError
  }
})

watch(isOpen, () => {
  error.value = ''
})
</script>

<template>
  <div class="bg-white">
    <div class="flex flex-row items-center justify-between mb-6">
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
        class="text-ui-fg-interactive hover:text-ui-fg-interactive-hover"
        data-testid="edit-payment-button"
        @click="handleEdit"
      >
        Edit
      </button>
    </div>

    <div v-if="isOpen">
      <div v-if="!paidByGiftcard && props.availablePaymentMethods.length">
        <button
          v-for="method in props.availablePaymentMethods"
          :key="method.id"
          type="button"
          class="flex flex-col gap-y-2 text-small-regular cursor-pointer py-4 border rounded-rounded px-8 mb-2 hover:shadow-borders-interactive-with-active w-full text-left"
          :class="selectedPaymentMethod === method.id ? 'border-ui-border-interactive' : ''"
          @click="setPaymentMethod(method.id)"
        >
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-x-4">
              <div
                class="size-4 rounded-full border-2 flex items-center justify-center"
                :class="selectedPaymentMethod === method.id ? 'border-ui-fg-base' : 'border-gray-300'"
              >
                <div
                  v-if="selectedPaymentMethod === method.id"
                  class="size-2 rounded-full bg-ui-fg-base"
                />
              </div>
              <span class="text-base-regular">
                {{ getPaymentInfo(method.id).title }}
              </span>
            </div>
            <UIcon
              :name="getPaymentInfo(method.id).icon"
              class="size-5"
            />
          </div>

          <div
            v-if="selectedPaymentMethod === method.id && isStripe(method.id)"
            class="my-4 transition-all duration-150 ease-in-out"
          >
            <p class="txt-medium-plus text-ui-fg-base mb-1">
              Enter your card details:
            </p>
            <div ref="cardMountRef" />
          </div>
        </button>
      </div>

      <div
        v-if="paidByGiftcard"
        class="flex flex-col w-1/3"
      >
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Payment method
        </p>
        <p
          class="txt-medium text-ui-fg-subtle"
          data-testid="payment-method-summary"
        >
          Gift card
        </p>
      </div>

      <p
        v-if="!paidByGiftcard && !props.availablePaymentMethods.length"
        class="text-base-regular text-ui-fg-subtle"
      >
        No payment methods available.
      </p>

      <CheckoutErrorMessage
        :error="error"
        data-testid="payment-method-error-message"
      />

      <UButton
        class="mt-6"
        data-testid="submit-payment-button"
        :disabled="(selectedIsStripe && !cardComplete) || (!selectedPaymentMethod && !paidByGiftcard)"
        :loading="isLoading"
        size="lg"
        @click="handleSubmit"
      >
        Continue to review
      </UButton>
    </div>

    <div v-else>
      <div
        v-if="cart && paymentReady && activeSession"
        class="flex items-start gap-x-1 w-full"
      >
        <div class="flex flex-col w-1/3">
          <p class="txt-medium-plus text-ui-fg-base mb-1">
            Payment method
          </p>
          <p
            class="txt-medium text-ui-fg-subtle"
            data-testid="payment-method-summary"
          >
            {{ getPaymentInfo(activeSession.provider_id).title }}
          </p>
        </div>
        <div class="flex flex-col w-1/3">
          <p class="txt-medium-plus text-ui-fg-base mb-1">
            Payment details
          </p>
          <div
            class="flex gap-2 txt-medium text-ui-fg-subtle items-center"
            data-testid="payment-details-summary"
          >
            <div class="flex items-center h-7 w-fit rounded-md bg-ui-button-neutral-hover p-2">
              <UIcon
                :name="getPaymentInfo(selectedPaymentMethod).icon"
                class="size-4"
              />
            </div>
            <p>
              {{ selectedIsStripe && cardBrand ? cardBrand : 'Another step will appear' }}
            </p>
          </div>
        </div>
      </div>
      <div
        v-else-if="paidByGiftcard"
        class="flex flex-col w-1/3"
      >
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Payment method
        </p>
        <p
          class="txt-medium text-ui-fg-subtle"
          data-testid="payment-method-summary"
        >
          Gift card
        </p>
      </div>
    </div>

    <CommonDivider class="mt-8" />
  </div>
</template>
