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
    const address = { ...form }

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
  const parts = [
    address.address_1,
    address.address_2,
    [address.city, address.province, address.postal_code].filter(Boolean).join(', '),
    address.country_code?.toUpperCase()
  ]
  return parts.filter(Boolean).join(', ')
}
</script>

<template>
  <div>
    <div class="flex items-center justify-between mb-6">
      <h2 class="text-xl-semi">
        Shipping Addresses
      </h2>
      <UButton
        size="sm"
        @click="openAdd"
      >
        <UIcon
          name="lucide:plus"
          class="size-4 mr-1"
        />
        Add address
      </UButton>
    </div>

    <div
      v-if="customer.addresses?.length"
      class="grid grid-cols-1 small:grid-cols-2 gap-4"
    >
      <div
        v-for="address in customer.addresses"
        :key="address.id"
        class="border border-gray-200 rounded-lg p-5 flex flex-col gap-y-2"
      >
        <div class="flex items-start justify-between">
          <p class="text-base-semi">
            {{ address.first_name }} {{ address.last_name }}
          </p>
        </div>
        <p
          v-if="address.company"
          class="text-small-regular text-ui-fg-subtle"
        >
          {{ address.company }}
        </p>
        <p class="text-small-regular text-ui-fg-subtle">
          {{ formatAddress(address) }}
        </p>
        <p
          v-if="address.phone"
          class="text-small-regular text-ui-fg-subtle"
        >
          {{ address.phone }}
        </p>
        <div class="flex items-center gap-x-2 mt-2">
          <UButton
            variant="outline"
            size="xs"
            @click="openEdit(address)"
          >
            Edit
          </UButton>
          <UButton
            variant="outline"
            color="error"
            size="xs"
            @click="handleDelete(address.id)"
          >
            Delete
          </UButton>
        </div>
      </div>
    </div>
    <p
      v-else
      class="text-base-regular text-ui-fg-subtle"
    >
      No saved addresses.
    </p>

    <ClientOnly>
      <UModal v-model:open="showModal">
        <template #content>
          <div class="p-6">
            <h3 class="text-large-semi mb-4">
              {{ editingAddress ? 'Edit address' : 'Add new address' }}
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
                />
                <UInput
                  v-model="form.last_name"
                  placeholder="Last name"
                  required
                />
              </div>
              <UInput
                v-model="form.company"
                placeholder="Company (optional)"
              />
              <UInput
                v-model="form.address_1"
                placeholder="Address"
                required
              />
              <UInput
                v-model="form.address_2"
                placeholder="Apartment, suite, etc. (optional)"
              />
              <div class="grid grid-cols-2 gap-3">
                <UInput
                  v-model="form.postal_code"
                  placeholder="Postal code"
                  required
                />
                <UInput
                  v-model="form.city"
                  placeholder="City"
                  required
                />
              </div>
              <UInput
                v-model="form.province"
                placeholder="State / Province"
              />
              <select
                v-model="form.country_code"
                class="w-full border border-gray-300 rounded-md px-3 py-2 text-sm"
                required
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
                type="tel"
                placeholder="Phone (optional)"
              />
              <p
                v-if="error"
                class="text-rose-500 text-small-regular"
              >
                {{ error }}
              </p>
              <div class="flex justify-end gap-x-2 mt-4">
                <UButton
                  variant="outline"
                  @click="showModal = false"
                >
                  Cancel
                </UButton>
                <UButton
                  type="submit"
                  :loading="saving"
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
