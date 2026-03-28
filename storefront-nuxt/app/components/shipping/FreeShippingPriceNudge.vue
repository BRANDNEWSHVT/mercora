<script setup lang="ts">
import type { StoreCart, StoreCartShippingOption, StorePrice } from '@medusajs/types'

const props = withDefaults(defineProps<{
  variant?: 'popup' | 'inline'
  cart: StoreCart
  shippingOptions: StoreCartShippingOption[]
}>(), {
  variant: 'inline',
})

const isClosed = ref(false)

function computeTarget(cart: StoreCart, price: StorePrice) {
  const priceRule = (price.price_rules || []).find(
    (pr: any) => pr.attribute === 'item_total'
  )!

  const currentAmount = cart.item_total || 0
  const targetAmount = parseFloat((priceRule as any).value)

  if ((priceRule as any).operator === 'gt') {
    return {
      current_amount: currentAmount,
      target_amount: targetAmount,
      target_reached: currentAmount > targetAmount,
      target_remaining: currentAmount > targetAmount ? 0 : targetAmount + 1 - currentAmount,
      remaining_percentage: (currentAmount / targetAmount) * 100,
    }
  } else if ((priceRule as any).operator === 'gte') {
    return {
      current_amount: currentAmount,
      target_amount: targetAmount,
      target_reached: currentAmount > targetAmount,
      target_remaining: currentAmount > targetAmount ? 0 : targetAmount - currentAmount,
      remaining_percentage: (currentAmount / targetAmount) * 100,
    }
  } else if ((priceRule as any).operator === 'lt') {
    return {
      current_amount: currentAmount,
      target_amount: targetAmount,
      target_reached: targetAmount > currentAmount,
      target_remaining: targetAmount > currentAmount ? 0 : currentAmount + 1 - targetAmount,
      remaining_percentage: (currentAmount / targetAmount) * 100,
    }
  } else if ((priceRule as any).operator === 'lte') {
    return {
      current_amount: currentAmount,
      target_amount: targetAmount,
      target_reached: targetAmount > currentAmount,
      target_remaining: targetAmount > currentAmount ? 0 : currentAmount - targetAmount,
      remaining_percentage: (currentAmount / targetAmount) * 100,
    }
  } else {
    return {
      current_amount: currentAmount,
      target_amount: targetAmount,
      target_reached: currentAmount === targetAmount,
      target_remaining: targetAmount > currentAmount ? 0 : targetAmount - currentAmount,
      remaining_percentage: (currentAmount / targetAmount) * 100,
    }
  }
}

const freeShippingPrice = computed(() => {
  if (!props.cart || !props.shippingOptions?.length) return null

  const prices = props.shippingOptions
    .map((shippingOption: any) => {
      const calculatedPrice = shippingOption.calculated_price
      if (!calculatedPrice) return []

      const validCurrencyPrices = shippingOption.prices.filter(
        (price: any) =>
          price.currency_code === props.cart.currency_code &&
          (price.price_rules || []).some(
            (priceRule: any) => priceRule.attribute === 'item_total'
          )
      )

      return validCurrencyPrices.map((price: any) => ({
        ...price,
        shipping_option_id: shippingOption.id,
        ...computeTarget(props.cart, price),
      }))
    })
    .flat(1)
    .filter(Boolean)
    .find((price: any) => price?.amount === 0)

  return prices || null
})
</script>

<template>
  <template v-if="freeShippingPrice">
    <!-- Inline variant -->
    <div
      v-if="variant === 'inline'"
      class="bg-neutral-100 p-2 rounded-lg border"
    >
      <div class="space-y-1.5">
        <div class="flex justify-between text-xs text-neutral-600">
          <div>
            <div
              v-if="freeShippingPrice.target_reached"
              class="flex items-center gap-1.5"
            >
              <UIcon
                name="i-lucide-check-circle"
                class="text-green-500 inline-block w-4 h-4"
              />
              Free Shipping unlocked!
            </div>
            <span v-else>Unlock Free Shipping</span>
          </div>

          <div
            :class="[
              'visible',
              { 'opacity-0 invisible': freeShippingPrice.target_reached },
            ]"
          >
            Only
            <span class="text-neutral-950">
              {{ convertToLocale({ amount: freeShippingPrice.target_remaining, currency_code: cart.currency_code }) }}
            </span>
            away
          </div>
        </div>
        <div class="flex justify-between gap-1">
          <div
            :class="[
              'bg-linear-to-r from-zinc-400 to-zinc-500 h-1 rounded-full max-w-full duration-500 ease-in-out',
              { 'from-green-400 to-green-500': freeShippingPrice.target_reached },
            ]"
            :style="{ width: `${freeShippingPrice.remaining_percentage}%` }"
          />
          <div class="bg-neutral-300 h-1 rounded-full w-fit grow" />
        </div>
      </div>
    </div>

    <!-- Popup variant -->
    <div
      v-else-if="variant === 'popup'"
      :class="[
        'fixed bottom-5 right-5 flex flex-col items-end gap-2 transition-all duration-500 ease-in-out z-10',
        {
          'opacity-0 invisible delay-1000': freeShippingPrice.target_reached,
          'opacity-0 invisible': isClosed,
          'opacity-100 visible': !freeShippingPrice.target_reached && !isClosed,
        },
      ]"
    >
      <div>
        <UButton
          class="rounded-full bg-neutral-900 shadow-none outline-hidden border-none text-[15px] p-2"
          @click="isClosed = true"
        >
          <UIcon
            name="i-lucide-x"
            class="w-4 h-4"
          />
        </UButton>
      </div>

      <div class="w-[400px] bg-black text-white p-6 rounded-lg">
        <div class="pb-4">
          <div class="space-y-3">
            <div class="flex justify-between text-[15px] text-neutral-400">
              <div>
                <div
                  v-if="freeShippingPrice.target_reached"
                  class="flex items-center gap-1.5"
                >
                  <UIcon
                    name="i-lucide-check-circle"
                    class="text-green-500 inline-block w-4 h-4"
                  />
                  Free Shipping unlocked!
                </div>
                <span v-else>Unlock Free Shipping</span>
              </div>

              <div
                :class="[
                  'visible',
                  { 'opacity-0 invisible': freeShippingPrice.target_reached },
                ]"
              >
                Only
                <span class="text-white">
                  {{ convertToLocale({ amount: freeShippingPrice.target_remaining, currency_code: cart.currency_code }) }}
                </span>
                away
              </div>
            </div>
            <div class="flex justify-between gap-1">
              <div
                :class="[
                  'bg-linear-to-r from-zinc-400 to-zinc-500 h-1.5 rounded-full max-w-full duration-500 ease-in-out',
                  { 'from-green-400 to-green-500': freeShippingPrice.target_reached },
                ]"
                :style="{ width: `${freeShippingPrice.remaining_percentage}%` }"
              />
              <div class="bg-zinc-600 h-1.5 rounded-full w-fit grow" />
            </div>
          </div>
        </div>

        <div class="flex gap-3">
          <NuxtLinkLocale
            to="/cart"
            class="rounded-2xl bg-transparent shadow-none outline-hidden border border-white text-[15px] py-2.5 px-4"
          >
            View cart
          </NuxtLinkLocale>

          <NuxtLinkLocale
            to="/store"
            class="grow rounded-2xl bg-white text-neutral-950 shadow-none outline-hidden border border-white text-[15px] py-2.5 px-4 text-center"
          >
            View products
          </NuxtLinkLocale>
        </div>
      </div>
    </div>
  </template>
</template>
