<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { convertToLocale } from '~/utils/money'
import { paymentInfoMap, isStripe } from '~/utils/constants'

const props = defineProps<{
  order: HttpTypes.StoreOrder
}>()

const payment = computed(() => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const collections = (props.order as any).payment_collections
  if (!collections?.length) return null
  const payments = collections[0]?.payments
  return payments?.[0] ?? null
})

const paymentInfo = computed(() => {
  if (!payment.value?.provider_id) return { title: 'Payment', icon: 'lucide:credit-card' }
  return paymentInfoMap[payment.value.provider_id] || { title: payment.value.provider_id, icon: 'lucide:credit-card' }
})

const amountPaid = computed(() => {
  if (!payment.value) return null
  return convertToLocale({
    amount: payment.value.amount ?? props.order.total ?? 0,
    currency_code: payment.value.currency_code || props.order.currency_code
  })
})
</script>

<template>
  <div>
    <h2 class="text-3xl-regular my-6">
      Payment
    </h2>
    <div v-if="payment">
      <div class="flex items-start gap-x-1 w-full">
        <div class="flex flex-col w-1/3">
          <p class="txt-medium-plus text-ui-fg-base mb-1">
            Payment method
          </p>
          <p
            class="txt-medium text-ui-fg-subtle"
            data-testid="payment-method"
          >
            {{ paymentInfo.title }}
          </p>
        </div>
        <div class="flex flex-col w-2/3">
          <p class="txt-medium-plus text-ui-fg-base mb-1">
            Payment details
          </p>
          <div class="flex gap-2 txt-medium text-ui-fg-subtle items-center">
            <div class="flex items-center h-7 w-fit p-2 bg-ui-button-neutral-hover">
              <UIcon
                :name="paymentInfo.icon"
                class="size-5"
              />
            </div>
            <p data-testid="payment-amount">
              <template v-if="isStripe(payment.provider_id) && payment.data?.card_last4">
                **** **** **** {{ payment.data.card_last4 }}
              </template>
              <template v-else>
                {{ amountPaid }} paid at {{ new Date(payment.created_at ?? '').toLocaleString() }}
              </template>
            </p>
          </div>
        </div>
      </div>
    </div>
    <CommonDivider class="mt-8" />
  </div>
</template>
