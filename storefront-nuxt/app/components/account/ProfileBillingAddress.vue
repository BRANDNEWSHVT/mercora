<script setup lang="ts">
const { customer, updateCustomer } = useCustomer()
const { regions } = useRegion()

const billingAddress = computed(() =>
  customer.value?.addresses?.find((addr: any) => addr.is_default_billing)
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

const regionOptions = computed(() => {
  return (
    regions.value
      ?.map((region: any) =>
        region.countries?.map((country: any) => ({
          value: country.iso_2,
          label: country.display_name,
        }))
      )
      .flat() || []
  )
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
  }
}, { immediate: true })

const currentInfo = computed(() => {
  if (!billingAddress.value) return 'No billing address'
  const addr = billingAddress.value
  const country = regionOptions.value?.find(
    (c: any) => c.value === addr.country_code
  )?.label || addr.country_code?.toUpperCase()
  return `${addr.first_name} ${addr.last_name}, ${addr.address_1}, ${addr.postal_code} ${addr.city}, ${country}`
})

const isSuccess = ref(false)
const isError = ref(false)
const loading = ref(false)

async function handleSave() {
  loading.value = true
  isError.value = false
  isSuccess.value = false
  try {
    const body: Record<string, any> = {
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
    }

    if (billingAddress.value?.id) {
      body.addressId = billingAddress.value.id
      body.action = 'update'
    } else {
      body.action = 'create'
    }

    await $fetch('/api/customer/address', {
      method: 'POST',
      body,
    })
    isSuccess.value = true
  } catch {
    isError.value = true
  } finally {
    loading.value = false
  }
}

function clearState() {
  isSuccess.value = false
  isError.value = false
}
</script>

<template>
  <AccountAccountInfo
    label="Billing address"
    :current-info="currentInfo"
    :is-success="isSuccess"
    :is-error="isError"
    data-testid="account-billing-address-editor"
    @save="handleSave"
    @clear-state="clearState"
  >
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
    </div>
  </AccountAccountInfo>
</template>
