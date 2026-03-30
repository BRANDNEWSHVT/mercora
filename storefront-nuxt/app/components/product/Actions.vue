<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

type ProductOptionValue = HttpTypes.StoreProductOptionValue

const props = defineProps<{
  product: HttpTypes.StoreProduct
  region?: HttpTypes.StoreRegion | null
  disabled?: boolean
}>()

const { addToCart } = useCart()

const options = ref<Record<string, string | undefined>>({})
const isAdding = ref(false)

const optionsAsKeymap = (variantOptions?: ProductOptionValue[] | null) => {
  return variantOptions?.reduce((acc: Record<string, string>, varopt) => {
    if (varopt.option_id && varopt.value) {
      acc[varopt.option_id] = varopt.value
    }
    return acc
  }, {})
}

const areOptionsEqual = (
  first: Record<string, string | undefined>,
  second: Record<string, string | undefined>
) => {
  const firstEntries = Object.entries(first).sort(([left], [right]) => left.localeCompare(right))
  const secondEntries = Object.entries(second).sort(([left], [right]) => left.localeCompare(right))

  if (firstEntries.length !== secondEntries.length) {
    return false
  }

  return firstEntries.every(([key, value], index) => {
    const [otherKey, otherValue] = secondEntries[index] ?? []
    return key === otherKey && value === otherValue
  })
}

// Pre-select if only 1 variant
onMounted(() => {
  if (props.product.variants?.length === 1) {
    const [singleVariant] = props.product.variants
    const variantOptions = optionsAsKeymap(singleVariant?.options)
    options.value = variantOptions ?? {}
  }
})

const selectedVariant = computed(() => {
  if (!props.product.variants?.length) return undefined
  return props.product.variants.find((variant) => {
    const variantOptions = optionsAsKeymap(variant.options)
    return areOptionsEqual(variantOptions ?? {}, options.value)
  })
})

const setOptionValue = (optionId: string, value: string) => {
  options.value = { ...options.value, [optionId]: value }
}

const isValidVariant = computed(() => {
  return props.product.variants?.some((variant) => {
    const variantOptions = optionsAsKeymap(variant.options)
    return areOptionsEqual(variantOptions ?? {}, options.value)
  })
})

const inStock = computed(() => {
  if (selectedVariant.value && !selectedVariant.value.manage_inventory) return true
  if (selectedVariant.value?.allow_backorder) return true
  if (selectedVariant.value?.manage_inventory && (selectedVariant.value?.inventory_quantity || 0) > 0) return true
  return false
})

const actionsRef = ref<HTMLElement | null>(null)
const inView = ref(true)

onMounted(() => {
  if (!actionsRef.value) return
  const observer = new IntersectionObserver(
    (entries) => { inView.value = entries[0]?.isIntersecting ?? false },
    { threshold: 0 }
  )
  observer.observe(actionsRef.value)
  onUnmounted(() => observer.disconnect())
})

const handleAddToCart = async () => {
  if (!selectedVariant.value?.id || !props.region?.id) return
  isAdding.value = true
  await addToCart(selectedVariant.value.id, 1, props.region.id)
  isAdding.value = false
}

const buttonText = computed(() => {
  if (!selectedVariant.value && !Object.keys(options.value).length) return 'Select variant'
  if (!inStock.value || !isValidVariant.value) return 'Out of stock'
  return 'Add to cart'
})
</script>

<template>
  <div>
    <div
      ref="actionsRef"
      class="flex flex-col gap-y-2"
    >
      <div>
        <div
          v-if="(product.variants?.length ?? 0) > 1"
          class="flex flex-col gap-y-4"
        >
          <div
            v-for="option in (product.options || [])"
            :key="option.id"
          >
            <ProductOptionSelect
              :option="option"
              :current="options[option.id]"
              :title="option.title ?? ''"
              :disabled="!!disabled || isAdding"
              data-testid="product-options"
              @update="setOptionValue"
            />
          </div>
          <CommonDivider />
        </div>
      </div>

      <ProductPrice
        :product="product"
        :variant="selectedVariant"
      />

      <UButton
        block
        size="lg"
        :disabled="!inStock || !selectedVariant || !!disabled || isAdding || !isValidVariant"
        :loading="isAdding"
        data-testid="add-product-button"
        @click="handleAddToCart"
      >
        {{ buttonText }}
      </UButton>

      <ProductMobileActions
        :product="product"
        :variant="selectedVariant"
        :options="options"
        :in-stock="inStock"
        :is-adding="isAdding"
        :show="!inView"
        :options-disabled="!!disabled || isAdding"
        @update-options="setOptionValue"
        @add-to-cart="handleAddToCart"
      />
    </div>
  </div>
</template>
