<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { getApiErrorMessage } from '~/utils/api-error'

const { customer, fetchCustomer } = useCustomer()
const { regions } = useRegion()

const billingAddress = computed(() =>
  customer.value?.addresses?.find(addr => addr.is_default_billing)
)

const firstName = ref('')
const lastName = ref('')
const company = ref('')
const address1 = ref('')
const address2 = ref('')
const postalCode = ref('')
const city = ref('')
const province = ref('')
const countryCode = ref('')
const phone = ref('')

type RegionOption = {
  value: string
  label: string
}

const regionOptions = computed<RegionOption[]>(() => {
  const regionList = (regions.value as HttpTypes.StoreRegion[] | null) ?? []

  return regionList.flatMap(region =>
    (region.countries ?? [])
      .filter(country => country.iso_2 && country.display_name)
      .map(country => ({
        value: country.iso_2 as string,
        label: country.display_name as string
      }))
  )
})

const billingCountryLabel = computed(() => {
  const address = billingAddress.value
  if (!address) {
    return ''
  }

  return regionOptions.value.find(country => country.value === address.country_code)?.label
    || address.country_code?.toUpperCase()
    || ''
})

watch(billingAddress, (addr) => {
  if (addr) {
    firstName.value = addr.first_name || ''
    lastName.value = addr.last_name || ''
    company.value = addr.company || ''
    address1.value = addr.address_1 || ''
    address2.value = addr.address_2 || ''
    postalCode.value = addr.postal_code || ''
    city.value = addr.city || ''
    province.value = addr.province || ''
    countryCode.value = addr.country_code || ''
    phone.value = addr.phone || ''
    return
  }

  firstName.value = ''
  lastName.value = ''
  company.value = ''
  address1.value = ''
  address2.value = ''
  postalCode.value = ''
  city.value = ''
  province.value = ''
  countryCode.value = ''
  phone.value = ''
}, { immediate: true })

const isSuccess = ref(false)
const isError = ref(false)
const errorMessage = ref('')

async function handleSave() {
  isError.value = false
  isSuccess.value = false
  errorMessage.value = ''

  try {
    const address = {
      first_name: firstName.value,
      last_name: lastName.value,
      company: company.value,
      address_1: address1.value,
      address_2: address2.value,
      postal_code: postalCode.value,
      city: city.value,
      province: province.value,
      country_code: countryCode.value,
      phone: phone.value,
      is_default_billing: true,
      is_default_shipping: false
    } as Record<string, unknown>

    const body: Record<string, unknown> = { address }

    if (billingAddress.value?.id) {
      body.addressId = billingAddress.value.id
      body.action = 'update'
    } else {
      body.action = 'create'
    }

    await $fetch('/api/customer/address', {
      method: 'POST',
      body
    })

    await fetchCustomer()
    isSuccess.value = true
  } catch (error: unknown) {
    isError.value = true
    errorMessage.value = getApiErrorMessage(error, 'Failed to update billing address')
  }
}

function clearState() {
  isSuccess.value = false
  isError.value = false
  errorMessage.value = ''

  const addr = billingAddress.value
  firstName.value = addr?.first_name || ''
  lastName.value = addr?.last_name || ''
  company.value = addr?.company || ''
  address1.value = addr?.address_1 || ''
  address2.value = addr?.address_2 || ''
  postalCode.value = addr?.postal_code || ''
  city.value = addr?.city || ''
  province.value = addr?.province || ''
  countryCode.value = addr?.country_code || ''
  phone.value = addr?.phone || ''
}
</script>

<template>
  <AccountInfo
    label="Billing address"
    current-info=""
    :is-success="isSuccess"
    :is-error="isError"
    :error-message="errorMessage"
    data-testid="account-billing-address-editor"
    @save="handleSave"
    @clear-state="clearState"
  >
    <template #current-info>
      <div
        v-if="billingAddress"
        class="flex flex-col font-semibold"
        data-testid="current-info"
      >
        <span>
          {{ billingAddress.first_name }} {{ billingAddress.last_name }}
        </span>
        <span>{{ billingAddress.company }}</span>
        <span>
          {{ billingAddress.address_1 }}<span v-if="billingAddress.address_2">, {{ billingAddress.address_2 }}</span>
        </span>
        <span>
          {{ billingAddress.postal_code }}, {{ billingAddress.city }}
        </span>
        <span>
          {{ billingCountryLabel }}
        </span>
      </div>
      <span
        v-else
        class="font-semibold"
        data-testid="current-info"
      >
        No billing address
      </span>
    </template>

    <div class="grid grid-cols-1 gap-y-2">
      <div class="grid grid-cols-2 gap-x-2">
        <UInput
          v-model="firstName"
          placeholder="First name"
          size="lg"
          required
          data-testid="billing-first-name-input"
        />
        <UInput
          v-model="lastName"
          placeholder="Last name"
          size="lg"
          required
          data-testid="billing-last-name-input"
        />
      </div>
      <UInput
        v-model="company"
        placeholder="Company"
        size="lg"
        data-testid="billing-company-input"
      />
      <UInput
        v-model="address1"
        placeholder="Address"
        size="lg"
        required
        data-testid="billing-address-1-input"
      />
      <UInput
        v-model="address2"
        placeholder="Apartment, suite, etc."
        size="lg"
        data-testid="billing-address-2-input"
      />
      <div class="grid grid-cols-[144px_1fr] gap-x-2">
        <UInput
          v-model="postalCode"
          placeholder="Postal code"
          size="lg"
          required
          data-testid="billing-postcal-code-input"
        />
        <UInput
          v-model="city"
          placeholder="City"
          size="lg"
          required
          data-testid="billing-city-input"
        />
      </div>
      <UInput
        v-model="province"
        placeholder="Province"
        size="lg"
        data-testid="billing-province-input"
      />
      <select
        v-model="countryCode"
        class="flex h-10 w-full rounded-md border border-ui-border-base bg-ui-bg-field px-3 py-2 text-sm"
        required
        data-testid="billing-country-code-select"
      >
        <option value="">
          -
        </option>
        <option
          v-for="option in regionOptions"
          :key="option.value"
          :value="option.value"
        >
          {{ option.label }}
        </option>
      </select>
      <UInput
        v-model="phone"
        placeholder="Phone"
        size="lg"
        data-testid="billing-phone-input"
      />
    </div>
  </AccountInfo>
</template>
