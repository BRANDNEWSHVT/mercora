<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'
import { getApiErrorMessage } from '~/utils/api-error'

const props = defineProps<{
  customer: HttpTypes.StoreCustomer
  region: HttpTypes.StoreRegion
}>()

const { fetchCustomer } = useCustomer()

const showModal = ref(false)
const editingAddress = ref<HttpTypes.StoreCustomerAddress | null>(null)
const saving = ref(false)
const error = ref('')

const form = reactive({
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

const countries = computed(() => props.region?.countries ?? [])
const addresses = computed(() => props.customer.addresses ?? [])

function resetForm() {
  form.first_name = ''
  form.last_name = ''
  form.company = ''
  form.address_1 = ''
  form.address_2 = ''
  form.postal_code = ''
  form.city = ''
  form.province = ''
  form.country_code = ''
  form.phone = ''
}

function openAdd() {
  editingAddress.value = null
  resetForm()
  error.value = ''
  showModal.value = true
}

function openEdit(address: HttpTypes.StoreCustomerAddress) {
  editingAddress.value = address
  form.first_name = address.first_name || ''
  form.last_name = address.last_name || ''
  form.company = address.company || ''
  form.address_1 = address.address_1 || ''
  form.address_2 = address.address_2 || ''
  form.postal_code = address.postal_code || ''
  form.city = address.city || ''
  form.province = address.province || ''
  form.country_code = address.country_code || ''
  form.phone = address.phone || ''
  error.value = ''
  showModal.value = true
}

async function handleSave() {
  saving.value = true
  error.value = ''

  try {
    const address = {
      ...form,
      is_default_shipping: !editingAddress.value && addresses.value.length === 0
    }

    if (editingAddress.value) {
      await apiFetch('/api/customer/address', {
        method: 'POST',
        body: { action: 'update', addressId: editingAddress.value.id, address }
      })
    } else {
      await apiFetch('/api/customer/address', {
        method: 'POST',
        body: { action: 'create', address }
      })
    }
    await fetchCustomer()
    showModal.value = false
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'Failed to save address')
  } finally {
    saving.value = false
  }
}

async function handleDelete(addressId: string) {
  try {
    await apiFetch('/api/customer/address', {
      method: 'POST',
      body: { action: 'delete', addressId }
    })
    await fetchCustomer()
  } catch (e: unknown) {
    error.value = getApiErrorMessage(e, 'Failed to delete address')
  }
}

function formatAddress(address: HttpTypes.StoreCustomerAddress) {
  return [address.address_1, address.address_2].filter(Boolean).join(', ')
}
</script>

<template>
  <div class="w-full">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-4 flex-1 mt-4">
      <div
        class="border border-ui-border-base rounded-rounded p-5 min-h-[220px] h-full w-full flex flex-col justify-between"
      >
        <button
          class="h-full w-full flex flex-col justify-between text-left"
          data-testid="add-address-button"
          @click="openAdd"
        >
          <span class="text-base-semi">New address</span>
          <UIcon
            name="i-lucide-plus"
            class="size-5"
          />
        </button>
      </div>

      <div
        v-for="address in addresses"
        :key="address.id"
        class="border rounded-rounded p-5 min-h-[220px] h-full w-full flex flex-col justify-between transition-colors"
        data-testid="address-container"
      >
        <div class="flex flex-col">
          <p
            class="text-left text-base-semi"
            data-testid="address-name"
          >
            {{ address.first_name }} {{ address.last_name }}
          </p>
          <p
            v-if="address.company"
            class="txt-compact-small text-ui-fg-base"
            data-testid="address-company"
          >
            {{ address.company }}
          </p>
          <p class="flex flex-col text-left text-base-regular mt-2">
            <span data-testid="address-address">
              {{ formatAddress(address) }}
            </span>
            <span data-testid="address-postal-city">
              {{ address.postal_code }}, {{ address.city }}
            </span>
            <span data-testid="address-province-country">
              {{ address.province ? `${address.province}, ` : '' }}{{ address.country_code?.toUpperCase() }}
            </span>
          </p>
        </div>
        <div class="flex items-center gap-x-4">
          <button
            class="text-small-regular text-ui-fg-base flex items-center gap-x-2"
            data-testid="address-edit-button"
            @click="openEdit(address)"
          >
            <UIcon
              name="i-lucide-pencil"
              class="size-4"
            />
            Edit
          </button>
          <button
            class="text-small-regular text-ui-fg-base flex items-center gap-x-2"
            data-testid="address-delete-button"
            @click="handleDelete(address.id)"
          >
            <UIcon
              name="i-lucide-trash-2"
              class="size-4"
            />
            Remove
          </button>
        </div>
      </div>
    </div>

    <ClientOnly>
      <UModal v-model:open="showModal">
        <template #content>
          <div
            class="p-6"
            :data-testid="editingAddress ? 'edit-address-modal' : 'add-address-modal'"
          >
            <h3 class="text-large-semi mb-4">
              {{ editingAddress ? 'Edit address' : 'Add address' }}
            </h3>
            <form
              class="flex flex-col gap-y-3"
              @submit.prevent="handleSave"
            >
              <div class="grid grid-cols-2 gap-3">
                <UInput
                  v-model="form.first_name"
                  placeholder="First name"
                  required
                  autocomplete="given-name"
                  data-testid="first-name-input"
                />
                <UInput
                  v-model="form.last_name"
                  placeholder="Last name"
                  required
                  autocomplete="family-name"
                  data-testid="last-name-input"
                />
              </div>
              <UInput
                v-model="form.company"
                placeholder="Company"
                autocomplete="organization"
                data-testid="company-input"
              />
              <UInput
                v-model="form.address_1"
                placeholder="Address"
                required
                autocomplete="address-line1"
                data-testid="address-1-input"
              />
              <UInput
                v-model="form.address_2"
                placeholder="Apartment, suite, etc."
                autocomplete="address-line2"
                data-testid="address-2-input"
              />
              <div class="grid grid-cols-2 gap-3">
                <UInput
                  v-model="form.postal_code"
                  placeholder="Postal code"
                  required
                  autocomplete="postal-code"
                  data-testid="postal-code-input"
                />
                <UInput
                  v-model="form.city"
                  placeholder="City"
                  required
                  autocomplete="locality"
                  data-testid="city-input"
                />
              </div>
              <UInput
                v-model="form.province"
                placeholder="Province / State"
                autocomplete="address-level1"
                data-testid="state-input"
              />
              <select
                v-model="form.country_code"
                class="w-full border border-gray-300 rounded-md px-3 py-2 text-sm"
                required
                autocomplete="country"
                data-testid="country-select"
              >
                <option
                  value=""
                  disabled
                >
                  Country
                </option>
                <option
                  v-for="country in countries"
                  :key="country.iso_2"
                  :value="country.iso_2"
                >
                  {{ country.display_name }}
                </option>
              </select>
              <UInput
                v-model="form.phone"
                placeholder="Phone"
                autocomplete="tel"
                data-testid="phone-input"
              />
              <p
                v-if="error"
                class="text-rose-500 text-small-regular"
                data-testid="address-error"
              >
                {{ error }}
              </p>
              <div class="flex justify-end gap-x-2 mt-4">
                <UButton
                  type="button"
                  variant="outline"
                  data-testid="cancel-button"
                  @click="showModal = false"
                >
                  Cancel
                </UButton>
                <UButton
                  type="submit"
                  :loading="saving"
                  data-testid="save-button"
                >
                  Save
                </UButton>
              </div>
            </form>
          </div>
        </template>
      </UModal>
    </ClientOnly>
  </div>
</template>
