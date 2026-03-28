<script setup lang="ts">
const { cart, placeOrder } = useCart()
const route = useRoute()
const router = useRouter()
const countryCode = useCountryCode()

const isOpen = computed(() => route.query.step === 'review')
const placing = ref(false)
const error = ref('')

const paidByGiftcard = computed(() =>
  cart.value?.gift_cards?.length > 0 && cart.value?.total === 0
)
const previousStepsCompleted = computed(() =>
  cart.value?.shipping_address
  && (cart.value?.shipping_methods?.length ?? 0) > 0
  && (cart.value?.payment_collection || paidByGiftcard.value)
)

async function handlePlaceOrder() {
  placing.value = true
  error.value = ''
  try {
    const result = await placeOrder()
    if (result?.type === 'order') {
      router.push(`/${countryCode.value}/order/confirmed/${result.order.id}`)
    }
  } catch (e: unknown) {
    error.value = e instanceof Error ? e.message : 'An error occurred placing the order'
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
        size="lg"
        :loading="placing"
        @click="handlePlaceOrder"
      >
        Place order
      </UButton>
    </div>
  </div>
</template>
