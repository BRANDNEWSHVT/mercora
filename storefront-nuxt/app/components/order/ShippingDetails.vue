<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { convertToLocale } from '~/utils/money'

const props = defineProps<{
  order: HttpTypes.StoreOrder
}>()

const shippingAddress = computed(() => props.order.shipping_address)

const shippingMethod = computed(() => {
  return props.order.shipping_methods?.[0] ?? null
})
</script>

<template>
  <div>
    <h2 class="text-3xl-regular my-6">
      Delivery
    </h2>
    <div class="flex items-start gap-x-8">
      <div
        class="flex flex-col w-1/3"
        data-testid="shipping-address-summary"
      >
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Shipping Address
        </p>
        <template v-if="shippingAddress">
          <p class="txt-medium text-ui-fg-subtle">
            {{ shippingAddress.first_name }} {{ shippingAddress.last_name }}
          </p>
          <p class="txt-medium text-ui-fg-subtle">
            {{ shippingAddress.address_1 }} {{ shippingAddress.address_2 }}
          </p>
          <p class="txt-medium text-ui-fg-subtle">
            {{ shippingAddress.postal_code }}, {{ shippingAddress.city }}
          </p>
          <p class="txt-medium text-ui-fg-subtle">
            {{ shippingAddress.country_code?.toUpperCase() }}
          </p>
        </template>
      </div>
      <div
        class="flex flex-col w-1/3"
        data-testid="shipping-contact-summary"
      >
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Contact
        </p>
        <p class="txt-medium text-ui-fg-subtle">
          {{ shippingAddress?.phone }}
        </p>
        <p class="txt-medium text-ui-fg-subtle">
          {{ order.email }}
        </p>
      </div>
      <div
        v-if="shippingMethod"
        class="flex flex-col w-1/3"
        data-testid="shipping-method-summary"
      >
        <p class="txt-medium-plus text-ui-fg-base mb-1">
          Method
        </p>
        <p class="txt-medium text-ui-fg-subtle">
          {{ shippingMethod.name }}
          ({{ convertToLocale({ amount: shippingMethod.total ?? 0, currency_code: order.currency_code }) }})
        </p>
      </div>
    </div>
    <CommonDivider class="mt-8" />
  </div>
</template>
