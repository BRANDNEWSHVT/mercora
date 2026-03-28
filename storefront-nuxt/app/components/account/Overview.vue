<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'
import { convertToLocale } from '~/utils/money'

const { customer } = useCustomer()

const orders = ref<HttpTypes.StoreOrder[]>([])

onMounted(async () => {
  try {
    const data = await apiFetch<HttpTypes.StoreOrder[]>('/api/orders', { query: { limit: 5 } })
    orders.value = data || []
  } catch {
    orders.value = []
  }
})

function getProfileCompletion(c: HttpTypes.StoreCustomer | null): number {
  if (!c) return 0
  let count = 0
  if (c.email) count++
  if (c.first_name && c.last_name) count++
  if (c.phone) count++
  if (c.addresses?.find(addr => addr.is_default_billing)) count++
  return (count / 4) * 100
}

const addressCount = computed(() => customer.value?.addresses?.length ?? 0)
</script>

<template>
  <div data-testid="overview-page-wrapper">
    <div class="hidden small:block">
      <div class="text-xl-semi flex justify-between items-center mb-4">
        <span
          data-testid="welcome-message"
          :data-value="customer?.first_name"
        >
          Hello {{ customer?.first_name }}
        </span>
        <span class="text-small-regular text-ui-fg-base">
          Signed in as:{{ " " }}
          <span
            class="font-semibold"
            data-testid="customer-email"
            :data-value="customer?.email"
          >
            {{ customer?.email }}
          </span>
        </span>
      </div>
      <div class="flex flex-col py-8 border-t border-gray-200">
        <div class="flex flex-col gap-y-4 h-full col-span-1 row-span-2 flex-1">
          <div class="flex items-start gap-x-16 mb-6">
            <div class="flex flex-col gap-y-4">
              <h3 class="text-large-semi">
                Profile
              </h3>
              <div class="flex items-end gap-x-2">
                <span
                  class="text-3xl-semi leading-none"
                  data-testid="customer-profile-completion"
                  :data-value="getProfileCompletion(customer ?? null)"
                >
                  {{ getProfileCompletion(customer ?? null) }}%
                </span>
                <span class="uppercase text-base-regular text-ui-fg-subtle">
                  Completed
                </span>
              </div>
            </div>

            <div class="flex flex-col gap-y-4">
              <h3 class="text-large-semi">
                Addresses
              </h3>
              <div class="flex items-end gap-x-2">
                <span
                  class="text-3xl-semi leading-none"
                  data-testid="addresses-count"
                  :data-value="addressCount"
                >
                  {{ addressCount }}
                </span>
                <span class="uppercase text-base-regular text-ui-fg-subtle">
                  Saved
                </span>
              </div>
            </div>
          </div>

          <div class="flex flex-col gap-y-4">
            <div class="flex items-center gap-x-2">
              <h3 class="text-large-semi">
                Recent orders
              </h3>
            </div>
            <ul
              class="flex flex-col gap-y-4"
              data-testid="orders-wrapper"
            >
              <template v-if="orders && orders.length > 0">
                <li
                  v-for="order in orders.slice(0, 5)"
                  :key="order.id"
                  data-testid="order-wrapper"
                  :data-value="order.id"
                >
                  <NuxtLinkLocale :to="`/account/orders/details/${order.id}`">
                    <div class="bg-gray-50 flex justify-between items-center p-4">
                      <div class="grid grid-cols-3 grid-rows-2 text-small-regular gap-x-4 flex-1">
                        <span class="font-semibold">Date placed</span>
                        <span class="font-semibold">Order number</span>
                        <span class="font-semibold">Total amount</span>
                        <span data-testid="order-created-date">
                          {{ new Date(order.created_at).toDateString() }}
                        </span>
                        <span
                          data-testid="order-id"
                          :data-value="order.display_id"
                        >
                          #{{ order.display_id }}
                        </span>
                        <span data-testid="order-amount">
                          {{ convertToLocale({ amount: order.total, currency_code: order.currency_code }) }}
                        </span>
                      </div>
                      <button
                        class="flex items-center justify-between"
                        data-testid="open-order-button"
                      >
                        <span class="sr-only">Go to order #{{ order.display_id }}</span>
                        <UIcon
                          name="i-lucide-chevron-down"
                          class="-rotate-90 size-4"
                        />
                      </button>
                    </div>
                  </NuxtLinkLocale>
                </li>
              </template>
              <span
                v-else
                data-testid="no-orders-message"
              >No recent orders</span>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
