<script setup lang="ts">
import { convertToLocale } from '~/utils/money'
import { getApiErrorMessage } from '~/utils/api-error'

const PICKUP_OPTION_ON = '__PICKUP_ON'
const PICKUP_OPTION_OFF = '__PICKUP_OFF'

interface ShippingMethod {
  id: string
  name: string
  amount: number
  price_type?: 'flat' | 'calculated' | string
  insufficient_inventory?: boolean
  service_zone?: {
    fulfillment_set?: {
      type?: string
    }
  }
}

const props = defineProps<{
  availableShippingMethods: ShippingMethod[]
}>()

const { cart, setShippingMethod } = useCart()
const route = useRoute()
const router = useRouter()

const isOpen = computed(() => route.query.step === 'delivery')

const selectedId = ref<string | null>(null)
const saving = ref(false)
const error = ref('')
const showPickupOptions = ref(PICKUP_OPTION_OFF)
const calculatedPricesMap = ref<Record<string, number>>({})
const isLoadingPrices = ref(true)

const shippingMethods = computed(() =>
  props.availableShippingMethods?.filter(method => method.service_zone?.fulfillment_set?.type !== 'pickup') || []
)

const pickupMethods = computed(() =>
  props.availableShippingMethods?.filter(method => method.service_zone?.fulfillment_set?.type === 'pickup') || []
)

const hasPickupOptions = computed(() => !!pickupMethods.value.length)

const currencyCode = computed(() => cart.value?.currency_code || 'usd')

function formatAddress(address: Record<string, string | undefined> | null | undefined) {
  if (!address) return ''
  let ret = ''
  if (address.address_1) ret += ` ${address.address_1}`
  if (address.address_2) ret += `, ${address.address_2}`
  if (address.postal_code) ret += `, ${address.postal_code} ${address.city}`
  if (address.country_code) ret += `, ${address.country_code.toUpperCase()}`
  return ret
}

onMounted(() => {
  const currentMethod = cart.value?.shipping_methods?.at(-1)
  if (currentMethod?.shipping_option_id) {
    selectedId.value = currentMethod.shipping_option_id
  }

  if (pickupMethods.value.find(method => method.id === selectedId.value)) {
    showPickupOptions.value = PICKUP_OPTION_ON
  }

  isLoadingPrices.value = false
})

async function handleSetShippingMethod(id: string, variant: 'shipping' | 'pickup') {
  error.value = ''

  if (variant === 'pickup') {
    showPickupOptions.value = PICKUP_OPTION_ON
  } else {
    showPickupOptions.value = PICKUP_OPTION_OFF
  }

  const previousId = selectedId.value
  selectedId.value = id
  saving.value = true

  try {
    await setShippingMethod(id, cart.value?.id)
  } catch (e: unknown) {
    selectedId.value = previousId
    error.value = getApiErrorMessage(e, 'Failed to set shipping method')
  } finally {
    saving.value = false
  }
}

function handlePickupToggle() {
  const firstAvailable = pickupMethods.value.find(
    option => !option.insufficient_inventory
  )
  if (firstAvailable) {
    handleSetShippingMethod(firstAvailable.id, 'pickup')
  }
}

async function handleContinue() {
  router.push({ query: { step: 'payment' } })
}

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
          { 'opacity-50 pointer-events-none select-none': !isOpen && (cart?.shipping_methods?.length ?? 0) === 0 }
        ]"
      >
        Delivery
        <UIcon
          v-if="!isOpen && (cart?.shipping_methods?.length ?? 0) > 0"
          name="i-lucide-check-circle-2"
          class="text-ui-fg-interactive"
        />
      </h2>
      <button
        v-if="!isOpen && cart?.shipping_address && cart?.billing_address && cart?.email"
        class="text-ui-fg-interactive hover:text-ui-fg-interactive-hover"
        data-testid="edit-delivery-button"
        @click="router.push({ query: { step: 'delivery' } })"
      >
        Edit
      </button>
    </div>

    <template v-if="isOpen">
      <div class="grid">
        <div class="flex flex-col">
          <span class="font-medium txt-medium text-ui-fg-base">Shipping method</span>
          <span class="mb-4 text-ui-fg-muted txt-medium">How would you like your order delivered</span>
        </div>
        <div data-testid="delivery-options-container">
          <div class="pb-8 md:pt-0 pt-2">
            <!-- Pickup toggle option -->
            <button
              v-if="hasPickupOptions"
              data-testid="delivery-option-radio"
              :class="[
                'flex items-center justify-between text-small-regular cursor-pointer py-4 border rounded-rounded px-8 mb-2 hover:shadow-borders-interactive-with-active w-full text-left',
                { 'border-ui-border-interactive': showPickupOptions === PICKUP_OPTION_ON }
              ]"
              @click="handlePickupToggle"
            >
              <div class="flex items-center gap-x-4">
                <div
                  class="size-4 rounded-full border-2 flex items-center justify-center"
                  :class="showPickupOptions === PICKUP_OPTION_ON ? 'border-ui-fg-base' : 'border-gray-300'"
                >
                  <div
                    v-if="showPickupOptions === PICKUP_OPTION_ON"
                    class="size-2 rounded-full bg-ui-fg-base"
                  />
                </div>
                <span class="text-base-regular">Pick up your order</span>
              </div>
              <span class="justify-self-end text-ui-fg-base">-</span>
            </button>

            <!-- Regular shipping options -->
            <button
              v-for="option in shippingMethods"
              :key="option.id"
              data-testid="delivery-option-radio"
              :disabled="option.price_type === 'calculated' && !isLoadingPrices && typeof calculatedPricesMap[option.id] !== 'number'"
              :class="[
                'flex items-center justify-between text-small-regular cursor-pointer py-4 border rounded-rounded px-8 mb-2 hover:shadow-borders-interactive-with-active w-full text-left',
                {
                  'border-ui-border-interactive': option.id === selectedId,
                  'hover:shadow-none cursor-not-allowed': option.price_type === 'calculated' && !isLoadingPrices && typeof calculatedPricesMap[option.id] !== 'number'
                }
              ]"
              @click="handleSetShippingMethod(option.id, 'shipping')"
            >
              <div class="flex items-center gap-x-4">
                <div
                  class="size-4 rounded-full border-2 flex items-center justify-center"
                  :class="option.id === selectedId ? 'border-ui-fg-base' : 'border-gray-300'"
                >
                  <div
                    v-if="option.id === selectedId"
                    class="size-2 rounded-full bg-ui-fg-base"
                  />
                </div>
                <span class="text-base-regular">{{ option.name }}</span>
              </div>
              <span class="justify-self-end text-ui-fg-base">
                <template v-if="option.price_type === 'flat'">
                  {{ convertToLocale({ amount: option.amount, currency_code: currencyCode }) }}
                </template>
                <template v-else-if="calculatedPricesMap[option.id]">
                  {{ convertToLocale({ amount: calculatedPricesMap[option.id], currency_code: currencyCode }) }}
                </template>
                <template v-else-if="isLoadingPrices">
                  <UIcon
                    name="i-lucide-loader-2"
                    class="animate-spin"
                  />
                </template>
                <template v-else>-</template>
              </span>
            </button>
          </div>
        </div>
      </div>

      <!-- Pickup store selection -->
      <div
        v-if="showPickupOptions === PICKUP_OPTION_ON"
        class="grid"
      >
        <div class="flex flex-col">
          <span class="font-medium txt-medium text-ui-fg-base">Store</span>
          <span class="mb-4 text-ui-fg-muted txt-medium">Choose a store near you</span>
        </div>
        <div data-testid="delivery-options-container">
          <div class="pb-8 md:pt-0 pt-2">
            <button
              v-for="option in pickupMethods"
              :key="option.id"
              data-testid="delivery-option-radio"
              :disabled="option.insufficient_inventory"
              :class="[
                'flex items-center justify-between text-small-regular cursor-pointer py-4 border rounded-rounded px-8 mb-2 hover:shadow-borders-interactive-with-active w-full text-left',
                {
                  'border-ui-border-interactive': option.id === selectedId,
                  'hover:shadow-none cursor-not-allowed': option.insufficient_inventory
                }
              ]"
              @click="handleSetShippingMethod(option.id, 'pickup')"
            >
              <div class="flex items-start gap-x-4">
                <div
                  class="size-4 rounded-full border-2 flex items-center justify-center mt-0.5"
                  :class="option.id === selectedId ? 'border-ui-fg-base' : 'border-gray-300'"
                >
                  <div
                    v-if="option.id === selectedId"
                    class="size-2 rounded-full bg-ui-fg-base"
                  />
                </div>
                <div class="flex flex-col">
                  <span class="text-base-regular">{{ option.name }}</span>
                  <span class="text-base-regular text-ui-fg-muted">
                    {{ formatAddress(option.service_zone?.fulfillment_set?.location?.address) }}
                  </span>
                </div>
              </div>
              <span class="justify-self-end text-ui-fg-base">
                {{ convertToLocale({ amount: option.amount, currency_code: currencyCode }) }}
              </span>
            </button>
          </div>
        </div>
      </div>

      <div>
        <CheckoutErrorMessage :error="error" />
        <UButton
          class="mt-6"
          size="lg"
          :disabled="!cart?.shipping_methods?.length"
          :loading="saving"
          data-testid="submit-delivery-option-button"
          @click="handleContinue"
        >
          Continue to payment
        </UButton>
      </div>
    </template>

    <div
      v-else
      class="text-small-regular"
    >
      <div
        v-if="cart && (cart.shipping_methods?.length ?? 0) > 0"
        class="flex flex-col w-1/3"
      >
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Method
        </p>
        <p class="txt-medium text-ui-fg-subtle">
          {{ cart.shipping_methods?.at(-1)?.name }}
          {{ convertToLocale({ amount: cart.shipping_methods?.at(-1)?.amount, currency_code: cart.currency_code }) }}
        </p>
      </div>
    </div>

    <div class="w-full h-px bg-gray-200 mt-8" />
  </div>
</template>
