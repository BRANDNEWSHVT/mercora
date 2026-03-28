<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import compareAddresses from '~/utils/compare-addresses'
import { getApiErrorMessage } from '~/utils/api-error'

const { cart, updateCart } = useCart()
const { customer } = useCustomer()
const route = useRoute()
const router = useRouter()
const countryCode = useCountryCode()

const isOpen = computed(() => route.query.step === 'address')

const sameAsShipping = ref(
  cart.value?.shipping_address && cart.value?.billing_address
    ? compareAddresses(cart.value.shipping_address, cart.value.billing_address)
    : true
)
const saving = ref(false)
const error = ref('')

const selectedSavedAddress = ref<string | null>(null)

const shipping = reactive({
  email: '',
  first_name: '',
  last_name: '',
  company: '',
  address_1: '',
  address_2: '',
  postal_code: '',
  city: '',
  province: '',
  country_code: '',
  phone: ''
})

const billing = reactive({
  first_name: '',
  last_name: '',
  company: '',
  address_1: '',
  address_2: '',
  postal_code: '',
  city: '',
  province: '',
  country_code: '',
  phone: ''
})

// Populate from cart or customer
onMounted(() => {
  const sa = cart.value?.shipping_address
  if (sa) {
    shipping.first_name = sa.first_name || ''
    shipping.last_name = sa.last_name || ''
    shipping.company = sa.company || ''
    shipping.address_1 = sa.address_1 || ''
    shipping.address_2 = sa.address_2 || ''
    shipping.postal_code = sa.postal_code || ''
    shipping.city = sa.city || ''
    shipping.province = sa.province || ''
    shipping.country_code = sa.country_code || countryCode.value
    shipping.phone = sa.phone || ''
  } else {
    shipping.country_code = countryCode.value
  }
  shipping.email = cart.value?.email || customer.value?.email || ''
})

function useSavedAddress(address: HttpTypes.StoreCustomerAddress) {
  selectedSavedAddress.value = address.id
  shipping.first_name = address.first_name || ''
  shipping.last_name = address.last_name || ''
  shipping.company = address.company || ''
  shipping.address_1 = address.address_1 || ''
  shipping.address_2 = address.address_2 || ''
  shipping.postal_code = address.postal_code || ''
  shipping.city = address.city || ''
  shipping.province = address.province || ''
  shipping.country_code = address.country_code || countryCode.value
  shipping.phone = address.phone || ''
}

async function handleSubmit() {
  saving.value = true
  error.value = ''
  try {
    const shippingAddress = {
      first_name: shipping.first_name,
      last_name: shipping.last_name,
      company: shipping.company,
      address_1: shipping.address_1,
      address_2: shipping.address_2,
      postal_code: shipping.postal_code,
      city: shipping.city,
      province: shipping.province,
      country_code: shipping.country_code,
      phone: shipping.phone
    }

    const billingAddress = sameAsShipping.value
      ? shippingAddress
      : {
          first_name: billing.first_name,
          last_name: billing.last_name,
          company: billing.company,
          address_1: billing.address_1,
          address_2: billing.address_2,
          postal_code: billing.postal_code,
          city: billing.city,
          province: billing.province,
          country_code: billing.country_code,
          phone: billing.phone
        }

    await updateCart({
      shipping_address: shippingAddress,
      billing_address: billingAddress,
      email: shipping.email
    })
    router.push({ query: { step: 'delivery' } })
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'Failed to update address')
  } finally {
    saving.value = false
  }
}

const completedSummary = computed(() => {
  const sa = cart.value?.shipping_address
  if (!sa) return null
  return {
    name: `${sa.first_name || ''} ${sa.last_name || ''}`.trim(),
    address: [sa.address_1, sa.address_2, sa.city, sa.province, sa.postal_code, sa.country_code?.toUpperCase()].filter(Boolean).join(', '),
    email: cart.value?.email
  }
})
</script>

<template>
  <div class="bg-white">
    <div class="flex items-center justify-between mb-6">
      <h2 class="flex flex-row text-3xl-regular gap-x-2 items-baseline">
        Shipping Address
        <UIcon
          v-if="!isOpen && completedSummary"
          name="i-lucide-check-circle-2"
          class="text-ui-fg-interactive"
        />
      </h2>
      <button
        v-if="!isOpen && completedSummary"
        class="text-ui-fg-interactive text-small-semi"
        @click="router.push({ query: { step: 'address' } })"
      >
        Edit
      </button>
    </div>

    <div v-if="isOpen">
      <!-- Saved addresses for logged-in customers -->
      <div
        v-if="customer?.addresses?.length"
        class="mb-6"
      >
        <p class="text-small-semi mb-2">
          Saved addresses
        </p>
        <div class="grid grid-cols-1 small:grid-cols-2 gap-2">
          <button
            v-for="addr in customer.addresses"
            :key="addr.id"
            class="border rounded-lg p-3 text-left text-small-regular transition-colors"
            :class="selectedSavedAddress === addr.id ? 'border-ui-fg-base' : 'border-gray-200 hover:border-gray-300'"
            @click="useSavedAddress(addr)"
          >
            <p class="font-semibold">
              {{ addr.first_name }} {{ addr.last_name }}
            </p>
            <p class="text-ui-fg-subtle">
              {{ addr.address_1 }}, {{ addr.city }}
            </p>
          </button>
        </div>
      </div>

      <form @submit.prevent="handleSubmit">
        <div class="flex flex-col gap-y-4">
          <UInput
            v-model="shipping.email"
            type="email"
            placeholder="Email"
            required
          />
          <div class="grid grid-cols-2 gap-4">
            <UInput
              v-model="shipping.first_name"
              placeholder="First name"
              required
            />
            <UInput
              v-model="shipping.last_name"
              placeholder="Last name"
              required
            />
          </div>
          <UInput
            v-model="shipping.company"
            placeholder="Company (optional)"
          />
          <UInput
            v-model="shipping.address_1"
            placeholder="Address"
            required
          />
          <UInput
            v-model="shipping.address_2"
            placeholder="Apartment, suite, etc. (optional)"
          />
          <div class="grid grid-cols-2 gap-4">
            <UInput
              v-model="shipping.postal_code"
              placeholder="Postal code"
              required
            />
            <UInput
              v-model="shipping.city"
              placeholder="City"
              required
            />
          </div>
          <UInput
            v-model="shipping.province"
            placeholder="State / Province"
          />
          <UInput
            v-model="shipping.country_code"
            placeholder="Country code"
            required
          />
          <UInput
            v-model="shipping.phone"
            type="tel"
            placeholder="Phone (optional)"
          />

          <label class="flex items-center gap-x-2 mt-2">
            <input
              v-model="sameAsShipping"
              type="checkbox"
              class="rounded border-gray-300"
            >
            <span class="text-small-regular">Billing address same as shipping</span>
          </label>

          <template v-if="!sameAsShipping">
            <CommonDivider class="my-2" />
            <h3 class="text-3xl-regular">
              Billing address
            </h3>
            <div class="grid grid-cols-2 gap-4">
              <UInput
                v-model="billing.first_name"
                placeholder="First name"
                required
              />
              <UInput
                v-model="billing.last_name"
                placeholder="Last name"
                required
              />
            </div>
            <UInput
              v-model="billing.company"
              placeholder="Company (optional)"
            />
            <UInput
              v-model="billing.address_1"
              placeholder="Address"
              required
            />
            <UInput
              v-model="billing.address_2"
              placeholder="Apartment, suite, etc. (optional)"
            />
            <div class="grid grid-cols-2 gap-4">
              <UInput
                v-model="billing.postal_code"
                placeholder="Postal code"
                required
              />
              <UInput
                v-model="billing.city"
                placeholder="City"
                required
              />
            </div>
            <UInput
              v-model="billing.province"
              placeholder="State / Province"
            />
            <UInput
              v-model="billing.country_code"
              placeholder="Country code"
              required
            />
            <UInput
              v-model="billing.phone"
              type="tel"
              placeholder="Phone (optional)"
            />
          </template>
        </div>

        <CheckoutErrorMessage :error="error" />

        <UButton
          type="submit"
          class="mt-6"
          size="lg"
          :loading="saving"
        >
          Continue to delivery
        </UButton>
      </form>
    </div>

    <div
      v-else-if="completedSummary"
      class="text-small-regular"
    >
      <div class="flex items-start gap-x-8">
        <div class="flex items-start gap-x-1 w-full">
          <div
            class="flex flex-col w-1/3"
            data-testid="shipping-address-summary"
          >
            <p class="txt-medium-plus text-ui-fg-base mb-1">
              Shipping Address
            </p>
            <p class="txt-medium text-ui-fg-subtle">
              {{ cart?.shipping_address?.first_name }} {{ cart?.shipping_address?.last_name }}
            </p>
            <p class="txt-medium text-ui-fg-subtle">
              {{ cart?.shipping_address?.address_1 }} {{ cart?.shipping_address?.address_2 }}
            </p>
            <p class="txt-medium text-ui-fg-subtle">
              {{ cart?.shipping_address?.postal_code }}, {{ cart?.shipping_address?.city }}
            </p>
            <p class="txt-medium text-ui-fg-subtle">
              {{ cart?.shipping_address?.country_code?.toUpperCase() }}
            </p>
          </div>
          <div
            class="flex flex-col w-1/3"
            data-testid="shipping-contact-summary"
          >
            <p class="txt-medium-plus text-ui-fg-base mb-1">
              Contact
            </p>
            <p class="txt-medium text-ui-fg-subtle">
              {{ cart?.shipping_address?.phone }}
            </p>
            <p class="txt-medium text-ui-fg-subtle">
              {{ cart?.email }}
            </p>
          </div>
          <div
            class="flex flex-col w-1/3"
            data-testid="billing-address-summary"
          >
            <p class="txt-medium-plus text-ui-fg-base mb-1">
              Billing Address
            </p>
            <p
              v-if="sameAsShipping"
              class="txt-medium text-ui-fg-subtle"
            >
              Billing- and delivery address are the same.
            </p>
            <template v-else>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart?.billing_address?.first_name }} {{ cart?.billing_address?.last_name }}
              </p>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart?.billing_address?.address_1 }} {{ cart?.billing_address?.address_2 }}
              </p>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart?.billing_address?.postal_code }}, {{ cart?.billing_address?.city }}
              </p>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart?.billing_address?.country_code?.toUpperCase() }}
              </p>
            </template>
          </div>
        </div>
      </div>
    </div>

    <div class="w-full h-px bg-gray-200 mt-8" />
  </div>
</template>
