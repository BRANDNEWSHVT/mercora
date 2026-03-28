<script setup lang="ts">
import { getProductPrice } from '~/utils/get-product-price'
import { isSimpleProduct } from '~/utils/product'

const props = defineProps<{
  product: any
  variant?: any
  options: Record<string, string | undefined>
  inStock?: boolean
  isAdding?: boolean
  show: boolean
  optionsDisabled: boolean
}>()

const emit = defineEmits<{
  (e: 'updateOptions', optionId: string, value: string): void
  (e: 'addToCart'): void
}>()

const isModalOpen = ref(false)

const price = computed(() => {
  return getProductPrice({
    product: props.product,
    variantId: props.variant?.id,
  })
})

const selectedPrice = computed(() => {
  if (!price.value) return null
  return price.value.variantPrice || price.value.cheapestPrice || null
})

const isSimple = computed(() => isSimpleProduct(props.product))
</script>

<template>
  <div>
    <!-- Fixed bottom bar -->
    <div :class="['lg:hidden inset-x-0 bottom-0 fixed', !show ? 'pointer-events-none' : '']">
      <Transition
        enter-active-class="ease-in-out duration-300"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="ease-in duration-300"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div
          v-if="show"
          class="bg-white flex flex-col gap-y-3 justify-center items-center text-large-regular p-4 h-full w-full border-t border-gray-200"
          data-testid="mobile-actions"
        >
          <div class="flex items-center gap-x-2">
            <span data-testid="mobile-title">{{ product.title }}</span>
            <span>—</span>
            <div v-if="selectedPrice" class="flex items-end gap-x-2 text-ui-fg-base">
              <p v-if="selectedPrice.price_type === 'sale'">
                <span class="line-through text-small-regular">{{ selectedPrice.original_price }}</span>
              </p>
              <span :class="selectedPrice.price_type === 'sale' ? 'text-ui-fg-interactive' : ''">
                {{ selectedPrice.calculated_price }}
              </span>
            </div>
          </div>
          <div :class="['grid w-full gap-x-4', isSimple ? 'grid-cols-1' : 'grid-cols-2']">
            <UButton
              v-if="!isSimple"
              variant="outline"
              block
              data-testid="mobile-actions-button"
              @click="isModalOpen = true"
            >
              <div class="flex items-center justify-between w-full">
                <span>{{ variant ? Object.values(options).join(' / ') : 'Select Options' }}</span>
                <UIcon name="i-lucide-chevron-down" class="w-4 h-4" />
              </div>
            </UButton>
            <UButton
              block
              :disabled="!inStock || !variant"
              :loading="isAdding"
              data-testid="mobile-cart-button"
              @click="emit('addToCart')"
            >
              {{ !variant ? 'Select variant' : !inStock ? 'Out of stock' : 'Add to cart' }}
            </UButton>
          </div>
        </div>
      </Transition>
    </div>

    <!-- Options modal -->
    <ClientOnly>
      <UModal v-model:open="isModalOpen">
        <template #content>
          <div class="bg-white px-6 py-12">
            <div v-if="(product.variants?.length ?? 0) > 1" class="flex flex-col gap-y-6">
              <div v-for="option in (product.options || [])" :key="option.id">
                <ProductOptionSelect
                  :option="option"
                  :current="options[option.id]"
                  :title="option.title ?? ''"
                  :disabled="optionsDisabled"
                  @update="(optId, val) => emit('updateOptions', optId, val)"
                />
              </div>
            </div>
          </div>
        </template>
      </UModal>
    </ClientOnly>
  </div>
</template>
