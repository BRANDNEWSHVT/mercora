<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { getApiErrorMessage } from '~/utils/api-error'
import { isManual, isStripe } from '~/utils/constants'

const { cart, placeOrder } = useCart()
const route = useRoute()
const router = useRouter()
const countryCode = useCountryCode()
const { cardElement, ensureStripe } = useStripePayment()

const isOpen = computed(() => route.query.step === 'review')
const placing = ref(false)
const error = ref('')

type StoreCartWithGiftCards = HttpTypes.StoreCart & {
  gift_cards?: unknown[]
}

const paidByGiftcard = computed(() =>
  ((cart.value as StoreCartWithGiftCards | null)?.gift_cards?.length ?? 0) > 0 && cart.value?.total === 0
)
const previousStepsCompleted = computed(() =>
  cart.value?.shipping_address
  && (cart.value?.shipping_methods?.length ?? 0) > 0
  && (cart.value?.payment_collection || paidByGiftcard.value)
)
const paymentSession = computed(() =>
  cart.value?.payment_collection?.payment_sessions?.find(session => session.status === 'pending')
)
const notReady = computed(() =>
  !cart.value
  || !cart.value.shipping_address
  || !cart.value.billing_address
  || !cart.value.email
  || (cart.value.shipping_methods?.length ?? 0) < 1
)

async function handlePlaceOrder() {
  if (notReady.value || !cart.value) return

  placing.value = true
  error.value = ''
  try {
    if (isStripe(paymentSession.value?.provider_id)) {
      const stripe = await ensureStripe()
      const currentCardElement = cardElement.value
      const clientSecret = paymentSession.value?.data?.client_secret

      if (!stripe || !currentCardElement || !clientSecret) {
        throw new Error('Card details are not ready yet.')
      }

      const { error: stripeError, paymentIntent } = await stripe.confirmCardPayment(String(clientSecret), {
        payment_method: {
          card: currentCardElement,
          billing_details: {
            name: `${cart.value.billing_address?.first_name ?? ''} ${cart.value.billing_address?.last_name ?? ''}`.trim(),
            address: {
              city: cart.value.billing_address?.city ?? undefined,
              country: cart.value.billing_address?.country_code ?? undefined,
              line1: cart.value.billing_address?.address_1 ?? undefined,
              line2: cart.value.billing_address?.address_2 ?? undefined,
              postal_code: cart.value.billing_address?.postal_code ?? undefined,
              state: cart.value.billing_address?.province ?? undefined
            },
            email: cart.value.email,
            phone: cart.value.billing_address?.phone ?? undefined
          }
        }
      })

      const paymentSucceeded = paymentIntent?.status === 'requires_capture' || paymentIntent?.status === 'succeeded'

      if (stripeError && !paymentSucceeded) {
        throw new Error(stripeError.message ?? 'Payment confirmation failed')
      }
    } else if (!isManual(paymentSession.value?.provider_id)) {
      throw new Error('Select a payment method before placing the order.')
    }

    const result = await placeOrder()
    if (result?.type === 'order' && result.order) {
      router.push(`/${result.countryCode ?? countryCode.value}/order/${result.order.id}/confirmed`)
    }
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'An error occurred placing the order')
  } finally {
    placing.value = false
  }
}
</script>

<template>
  <div class="bg-white">
    <div class="flex items-center justify-between mb-6">
      <h2
        :class="[
          'flex flex-row text-3xl-regular gap-x-2 items-baseline',
          { 'opacity-50 pointer-events-none select-none': !isOpen }
        ]"
      >
        Review
      </h2>
    </div>

    <div v-if="isOpen && previousStepsCompleted">
      <div class="txt-medium-plus text-ui-fg-base mb-1">
        By clicking the Place Order button, you confirm that you have read, understand and accept our
        Terms of Use, Terms of Sale and Returns Policy and acknowledge that you have read Medusa Store's
        Privacy Policy.
      </div>

      <CheckoutErrorMessage :error="error" />

      <UButton
        data-testid="submit-order-button"
        :disabled="notReady"
        size="lg"
        :loading="placing"
        @click="handlePlaceOrder"
      >
        Place order
      </UButton>
    </div>
  </div>
</template>
