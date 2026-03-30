<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import compareAddresses from '~/utils/compare-addresses'
import { getApiErrorMessage } from '~/utils/api-error'

const { cart, updateCart } = useCart()
const { customer } = useCustomer()
const route = useRoute()
const router = useRouter()

const isOpen = computed(() => route.query.step === 'address')

const sameAsBilling = ref(true)
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

const regionCountries = computed(() => cart.value?.region?.countries ?? [])
const countriesInRegion = computed(() => regionCountries.value.map(country => country.iso_2))
const addressesInRegion = computed(() =>
  (customer.value?.addresses ?? []).filter(address =>
    !!address.country_code && countriesInRegion.value.includes(address.country_code)
  )
)
const sameAsBillingSummary = computed(() => {
  if (!cart.value?.shipping_address || !cart.value?.billing_address) {
    return true
  }

  return compareAddresses(cart.value.shipping_address, cart.value.billing_address)
})

function setShippingAddress(address?: HttpTypes.StoreCartAddress, email?: string) {
  if (address) {
    shipping.first_name = address.first_name || ''
    shipping.last_name = address.last_name || ''
    shipping.company = address.company || ''
    shipping.address_1 = address.address_1 || ''
    shipping.address_2 = address.address_2 || ''
    shipping.postal_code = address.postal_code || ''
    shipping.city = address.city || ''
    shipping.province = address.province || ''
    shipping.country_code = address.country_code || ''
    shipping.phone = address.phone || ''
  }

  if (email) {
    shipping.email = email
  }
}

function setBillingAddress(address?: HttpTypes.StoreCartAddress) {
  if (address) {
    billing.first_name = address.first_name || ''
    billing.last_name = address.last_name || ''
    billing.company = address.company || ''
    billing.address_1 = address.address_1 || ''
    billing.address_2 = address.address_2 || ''
    billing.postal_code = address.postal_code || ''
    billing.city = address.city || ''
    billing.province = address.province || ''
    billing.country_code = address.country_code || ''
    billing.phone = address.phone || ''
    return
  }

  billing.first_name = ''
  billing.last_name = ''
  billing.company = ''
  billing.address_1 = ''
  billing.address_2 = ''
  billing.postal_code = ''
  billing.city = ''
  billing.province = ''
  billing.country_code = ''
  billing.phone = ''
}

function useSavedAddress(address: HttpTypes.StoreCustomerAddress) {
  selectedSavedAddress.value = address.id
  setShippingAddress(address as HttpTypes.StoreCartAddress)
}

watch(() => cart.value, (nextCart) => {
  sameAsBilling.value = nextCart?.shipping_address && nextCart?.billing_address
    ? compareAddresses(nextCart.shipping_address, nextCart.billing_address)
    : true

  if (nextCart?.shipping_address) {
    setShippingAddress(nextCart.shipping_address, nextCart.email || customer.value?.email || '')
  } else {
    setShippingAddress(undefined, customer.value?.email || '')
    shipping.country_code = regionCountries.value[0]?.iso_2 || ''
  }

  if (nextCart?.billing_address) {
    setBillingAddress(nextCart.billing_address)
  } else {
    setBillingAddress()
    billing.country_code = regionCountries.value[0]?.iso_2 || ''
  }

  const selectedAddress = addressesInRegion.value.find(address =>
    nextCart?.shipping_address && compareAddresses(address, nextCart.shipping_address)
  )

  selectedSavedAddress.value = selectedAddress?.id ?? null
}, { immediate: true })

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

    const billingAddress = sameAsBilling.value
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
  } catch (nextError: unknown) {
    error.value = getApiErrorMessage(nextError, 'Failed to update address')
  } finally {
    saving.value = false
  }
}
</script>

<template>
  <div class="bg-white">
    <div class="flex flex-row items-center justify-between mb-6">
      <h2 class="flex flex-row text-3xl-regular gap-x-2 items-baseline">
        Shipping Address
        <UIcon
          v-if="!isOpen && cart?.shipping_address"
          name="i-lucide-check-circle-2"
        />
      </h2>
      <button
        v-if="!isOpen && cart?.shipping_address"
        class="text-ui-fg-interactive hover:text-ui-fg-interactive-hover"
        data-testid="edit-address-button"
        @click="router.push({ query: { step: 'address' } })"
      >
        Edit
      </button>
    </div>

    <form
      v-if="isOpen"
      @submit.prevent="handleSubmit"
    >
      <div class="pb-8">
        <div
          v-if="customer && addressesInRegion.length > 0"
          class="mb-6 flex flex-col gap-y-4 rounded-rounded border border-ui-border-base p-5"
        >
          <p class="text-small-regular">
            {{ `Hi ${customer.first_name}, do you want to use one of your saved addresses?` }}
          </p>
          <div
            class="grid grid-cols-1 gap-2"
            data-testid="shipping-address-options"
          >
            <button
              v-for="address in addressesInRegion"
              :key="address.id"
              type="button"
              class="flex items-start gap-x-4 rounded-rounded border px-4 py-[10px] text-left"
              data-testid="shipping-address-option"
              :class="selectedSavedAddress === address.id ? 'border-ui-border-interactive' : 'border-ui-border-base'"
              @click="useSavedAddress(address)"
            >
              <div
                class="mt-1 size-4 rounded-full border-2 flex items-center justify-center"
                :class="selectedSavedAddress === address.id ? 'border-ui-fg-base' : 'border-gray-300'"
                data-testid="shipping-address-radio"
              >
                <div
                  v-if="selectedSavedAddress === address.id"
                  class="size-2 rounded-full bg-ui-fg-base"
                />
              </div>
              <div class="flex flex-col">
                <span class="text-left text-base-semi">
                  {{ address.first_name }} {{ address.last_name }}
                </span>
                <span
                  v-if="address.company"
                  class="text-small-regular text-ui-fg-base"
                >
                  {{ address.company }}
                </span>
                <div class="mt-2 flex flex-col text-left text-base-regular">
                  <span>
                    {{ address.address_1 }}<span v-if="address.address_2">, {{ address.address_2 }}</span>
                  </span>
                  <span>
                    {{ address.postal_code }}, {{ address.city }}
                  </span>
                  <span>
                    {{ address.province ? `${address.province}, ` : '' }}{{ address.country_code?.toUpperCase() }}
                  </span>
                </div>
              </div>
            </button>
          </div>
        </div>

        <div class="grid grid-cols-2 gap-4">
          <UInput
            v-model="shipping.first_name"
            autocomplete="given-name"
            required
            data-testid="shipping-first-name-input"
            placeholder="First name"
          />
          <UInput
            v-model="shipping.last_name"
            autocomplete="family-name"
            required
            data-testid="shipping-last-name-input"
            placeholder="Last name"
          />
          <UInput
            v-model="shipping.address_1"
            autocomplete="address-line1"
            required
            data-testid="shipping-address-input"
            placeholder="Address"
          />
          <UInput
            v-model="shipping.company"
            autocomplete="organization"
            data-testid="shipping-company-input"
            placeholder="Company"
          />
          <UInput
            v-model="shipping.postal_code"
            autocomplete="postal-code"
            required
            data-testid="shipping-postal-code-input"
            placeholder="Postal code"
          />
          <UInput
            v-model="shipping.city"
            autocomplete="address-level2"
            required
            data-testid="shipping-city-input"
            placeholder="City"
          />
          <select
            v-model="shipping.country_code"
            autocomplete="country"
            required
            data-testid="shipping-country-select"
            class="flex h-10 w-full rounded-md border border-ui-border-base bg-ui-bg-field px-3 py-2 text-sm"
          >
            <option
              v-for="country in regionCountries"
              :key="country.iso_2"
              :value="country.iso_2"
            >
              {{ country.display_name }}
            </option>
          </select>
          <UInput
            v-model="shipping.province"
            autocomplete="address-level1"
            data-testid="shipping-province-input"
            placeholder="State / Province"
          />
        </div>

        <div class="my-8">
          <label class="flex items-center gap-x-2">
            <input
              v-model="sameAsBilling"
              type="checkbox"
              data-testid="billing-address-checkbox"
            >
            <span class="text-small-regular">Billing address same as shipping address</span>
          </label>
        </div>

        <div
          v-if="!sameAsBilling"
          class="pb-2 pt-8"
        >
          <h2 class="text-3xl-regular gap-x-4 pb-6">
            Billing address
          </h2>
          <div class="grid grid-cols-2 gap-4">
            <UInput
              v-model="billing.first_name"
              autocomplete="given-name"
              required
              data-testid="billing-first-name-input"
              placeholder="First name"
            />
            <UInput
              v-model="billing.last_name"
              autocomplete="family-name"
              required
              data-testid="billing-last-name-input"
              placeholder="Last name"
            />
            <UInput
              v-model="billing.address_1"
              autocomplete="address-line1"
              required
              data-testid="billing-address-input"
              placeholder="Address"
            />
            <UInput
              v-model="billing.company"
              autocomplete="organization"
              data-testid="billing-company-input"
              placeholder="Company"
            />
            <UInput
              v-model="billing.postal_code"
              autocomplete="postal-code"
              required
              data-testid="billing-postal-input"
              placeholder="Postal code"
            />
            <UInput
              v-model="billing.city"
              autocomplete="address-level2"
              data-testid="billing-city-input"
              placeholder="City"
            />
            <select
              v-model="billing.country_code"
              autocomplete="country"
              required
              data-testid="billing-country-select"
              class="flex h-10 w-full rounded-md border border-ui-border-base bg-ui-bg-field px-3 py-2 text-sm"
            >
              <option
                v-for="country in regionCountries"
                :key="country.iso_2"
                :value="country.iso_2"
              >
                {{ country.display_name }}
              </option>
            </select>
            <UInput
              v-model="billing.province"
              autocomplete="address-level1"
              data-testid="billing-province-input"
              placeholder="State / Province"
            />
            <UInput
              v-model="billing.phone"
              autocomplete="tel"
              data-testid="billing-phone-input"
              placeholder="Phone"
            />
          </div>
        </div>

        <div class="mb-4 mt-4 grid grid-cols-2 gap-4">
          <UInput
            v-model="shipping.email"
            autocomplete="email"
            required
            type="email"
            data-testid="shipping-email-input"
            placeholder="Email"
          />
          <UInput
            v-model="shipping.phone"
            autocomplete="tel"
            data-testid="shipping-phone-input"
            placeholder="Phone"
          />
        </div>

        <UButton
          class="mt-6"
          data-testid="submit-address-button"
          size="lg"
          type="submit"
          :loading="saving"
        >
          Continue to delivery
        </UButton>
        <CheckoutErrorMessage
          :error="error"
          data-testid="address-error-message"
        />
      </div>
    </form>

    <div
      v-else
      class="text-small-regular"
    >
      <div v-if="cart?.shipping_address">
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
                {{ cart.shipping_address.first_name }} {{ cart.shipping_address.last_name }}
              </p>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart.shipping_address.address_1 }} {{ cart.shipping_address.address_2 }}
              </p>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart.shipping_address.postal_code }}, {{ cart.shipping_address.city }}
              </p>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart.shipping_address.country_code?.toUpperCase() }}
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
                {{ cart.shipping_address.phone }}
              </p>
              <p class="txt-medium text-ui-fg-subtle">
                {{ cart.email }}
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
                v-if="sameAsBillingSummary"
                class="txt-medium text-ui-fg-subtle"
              >
                Billing- and delivery address are the same.
              </p>
              <template v-else>
                <p class="txt-medium text-ui-fg-subtle">
                  {{ cart.billing_address?.first_name }} {{ cart.billing_address?.last_name }}
                </p>
                <p class="txt-medium text-ui-fg-subtle">
                  {{ cart.billing_address?.address_1 }} {{ cart.billing_address?.address_2 }}
                </p>
                <p class="txt-medium text-ui-fg-subtle">
                  {{ cart.billing_address?.postal_code }}, {{ cart.billing_address?.city }}
                </p>
                <p class="txt-medium text-ui-fg-subtle">
                  {{ cart.billing_address?.country_code?.toUpperCase() }}
                </p>
              </template>
            </div>
          </div>
        </div>
      </div>
      <div v-else>
        <UIcon
          name="i-lucide-loader-2"
          class="animate-spin"
        />
      </div>
    </div>

    <CommonDivider class="mt-8" />
  </div>
</template>
