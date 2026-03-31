<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'
import { convertToLocale } from '~/utils/money'

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { cart, totalItems } = useCart()

const isOpen = ref(false)
const activeTimer = ref<ReturnType<typeof setTimeout> | null>(null)
const prevTotalItems = ref(totalItems.value)

const timedOpen = () => {
  isOpen.value = true
  activeTimer.value = setTimeout(() => {
    isOpen.value = false
  }, 5000)
}

const openAndCancel = () => {
  if (activeTimer.value) clearTimeout(activeTimer.value)
  isOpen.value = true
}

const close = () => {
  isOpen.value = false
}

watch(totalItems, (newVal) => {
  if (newVal !== prevTotalItems.value && !route.path.includes('/cart')) {
    timedOpen()
  }
  prevTotalItems.value = newVal
})

onUnmounted(() => {
  if (activeTimer.value) clearTimeout(activeTimer.value)
})

const subtotal = computed(() => cart.value?.subtotal ?? 0)
const sortedItems = computed<HttpTypes.StoreCartLineItem[]>(() => {
  return [...(cart.value?.items ?? [])].sort((a, b) => {
    return (a.created_at ?? '') > (b.created_at ?? '') ? -1 : 1
  })
})
</script>

<template>
  <div
    class="h-full z-50 relative"
    @mouseenter="openAndCancel"
    @mouseleave="close"
  >
    <NuxtLink
      class="hover:text-ui-fg-base flex gap-2 h-full items-center"
      :to="`/${countryCode}/cart`"
      data-testid="nav-cart-link"
    >
      Cart ({{ totalItems }})
    </NuxtLink>

    <Transition
      enter-active-class="transition ease-out duration-200"
      enter-from-class="opacity-0 translate-y-1"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition ease-in duration-150"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 translate-y-1"
    >
      <div
        v-if="isOpen"
        class="hidden small:block absolute top-[calc(100%+1px)] right-0 bg-white border-x border-b border-gray-200 w-[420px] text-ui-fg-base"
        data-testid="nav-cart-dropdown"
      >
        <div class="p-4 flex items-center justify-center">
          <h3 class="text-large-semi">
            Cart
          </h3>
        </div>

        <template v-if="cart && cart.items?.length">
          <div class="overflow-y-scroll max-h-[402px] px-4 grid grid-cols-1 gap-y-8 no-scrollbar p-px">
            <div
              v-for="item in sortedItems"
              :key="item.id"
              class="grid grid-cols-[122px_1fr] gap-x-4"
              data-testid="cart-item"
            >
              <NuxtLink
                :to="`/${countryCode}/products/${item.product_handle}`"
                class="w-24"
              >
                <ProductThumbnail
                  :thumbnail="item.thumbnail"
                  :images="item.variant?.product?.images"
                  size="square"
                />
              </NuxtLink>
              <div class="flex flex-col justify-between flex-1">
                <div class="flex flex-col flex-1">
                  <div class="flex items-start justify-between">
                    <div class="flex flex-col text-ellipsis whitespace-nowrap mr-4 w-[180px]">
                      <h3 class="text-base-regular overflow-hidden text-ellipsis">
                        <NuxtLink
                          :to="`/${countryCode}/products/${item.product_handle}`"
                          data-testid="product-link"
                        >
                          {{ item.title }}
                        </NuxtLink>
                      </h3>
                      <CommonLineItemOptions
                        :variant="item.variant"
                        data-testid="cart-item-variant"
                      />
                      <span
                        data-testid="cart-item-quantity"
                        :data-value="item.quantity"
                      >
                        Quantity: {{ item.quantity }}
                      </span>
                    </div>
                    <div class="flex justify-end">
                      <CommonLineItemPrice
                        :item="item"
                        style-type="tight"
                        :currency-code="cart.currency_code"
                      />
                    </div>
                  </div>
                </div>
                <CommonDeleteButton
                  :id="item.id"
                  class="mt-1"
                  data-testid="cart-item-remove-button"
                >
                  Remove
                </CommonDeleteButton>
              </div>
            </div>
          </div>

          <div class="p-4 flex flex-col gap-y-4 text-small-regular">
            <div class="flex items-center justify-between">
              <span class="text-ui-fg-base font-semibold">
                Subtotal <span class="font-normal">(excl. taxes)</span>
              </span>
              <span
                class="text-large-semi"
                data-testid="cart-subtotal"
                :data-value="subtotal"
              >
                {{ convertToLocale({ amount: subtotal, currency_code: cart.currency_code }) }}
              </span>
            </div>
            <NuxtLink
              :to="`/${countryCode}/cart`"
              class="w-full"
            >
              <UButton
                class="w-full"
                size="lg"
                data-testid="go-to-cart-button"
              >
                Go to cart
              </UButton>
            </NuxtLink>
          </div>
        </template>

        <template v-else>
          <div class="flex py-16 flex-col gap-y-4 items-center justify-center">
            <div class="bg-gray-900 text-small-regular flex items-center justify-center w-6 h-6 rounded-full text-white">
              <span>0</span>
            </div>
            <span>Your shopping bag is empty.</span>
            <NuxtLink
              :to="`/${countryCode}/store`"
            >
              <UButton @click="close">Explore products</UButton>
            </NuxtLink>
          </div>
        </template>
      </div>
    </Transition>
  </div>
</template>
