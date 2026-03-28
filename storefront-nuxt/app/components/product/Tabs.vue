<script setup lang="ts">
defineProps<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  product: any
}>()

const tabs = [
  {
    label: 'Product Information',
    value: 'product-info'
  },
  {
    label: 'Shipping & Returns',
    value: 'shipping'
  }
] as const

const openItems = ref<string[]>([])

function toggleItem(value: string) {
  if (openItems.value.includes(value)) {
    openItems.value = openItems.value.filter(item => item !== value)
    return
  }

  openItems.value = [...openItems.value, value]
}

function isOpen(value: string) {
  return openItems.value.includes(value)
}
</script>

<template>
  <div class="w-full">
    <div
      v-for="tab in tabs"
      :key="tab.value"
      class="border-grey-20 border-t last:border-b py-3"
    >
      <button
        type="button"
        class="px-1 w-full flex items-center justify-between text-left"
        @click="toggleItem(tab.value)"
      >
        <span class="text-ui-fg-subtle text-sm">
          {{ tab.label }}
        </span>
        <span class="relative h-5 w-5 shrink-0">
          <span
            class="bg-gray-500 rounded-full absolute inset-y-[31.75%] left-[48%] right-1/2 w-[1.5px] duration-300"
            :class="isOpen(tab.value) ? 'rotate-90' : ''"
          />
          <span
            class="bg-gray-500 rounded-full absolute inset-x-[31.75%] top-[48%] bottom-1/2 h-[1.5px] duration-300"
            :class="isOpen(tab.value) ? 'rotate-90 left-1/2 right-1/2' : ''"
          />
        </span>
      </button>

      <div
        v-if="isOpen(tab.value)"
        class="px-1"
      >
        <div
          v-if="tab.value === 'product-info'"
          class="text-small-regular py-8"
        >
          <div class="grid grid-cols-2 gap-x-8">
            <div class="flex flex-col gap-y-4">
              <div>
                <span class="font-semibold">Material</span>
                <p>{{ product.material || '-' }}</p>
              </div>
              <div>
                <span class="font-semibold">Country of origin</span>
                <p>{{ product.origin_country || '-' }}</p>
              </div>
              <div>
                <span class="font-semibold">Type</span>
                <p>{{ product.type?.value || '-' }}</p>
              </div>
            </div>
            <div class="flex flex-col gap-y-4">
              <div>
                <span class="font-semibold">Weight</span>
                <p>{{ product.weight ? `${product.weight} g` : '-' }}</p>
              </div>
              <div>
                <span class="font-semibold">Dimensions</span>
                <p>{{ product.length && product.width && product.height ? `${product.length}L x ${product.width}W x ${product.height}H` : '-' }}</p>
              </div>
            </div>
          </div>
        </div>

        <div
          v-else
          class="text-small-regular py-8"
        >
          <div class="grid grid-cols-1 gap-y-8">
            <div class="flex items-start gap-x-2">
              <UIcon
                name="i-lucide-truck"
                class="w-6 h-6 flex-shrink-0"
              />
              <div>
                <span class="font-semibold">Fast delivery</span>
                <p class="max-w-sm">
                  Your package will arrive in 3-5 business days at your pick up location or in the comfort of your home.
                </p>
              </div>
            </div>
            <div class="flex items-start gap-x-2">
              <UIcon
                name="i-lucide-refresh-cw"
                class="w-6 h-6 flex-shrink-0"
              />
              <div>
                <span class="font-semibold">Simple exchanges</span>
                <p class="max-w-sm">
                  Is the fit not quite right? No worries - we'll exchange your product for a new one.
                </p>
              </div>
            </div>
            <div class="flex items-start gap-x-2">
              <UIcon
                name="i-lucide-undo-2"
                class="w-6 h-6 flex-shrink-0"
              />
              <div>
                <span class="font-semibold">Easy returns</span>
                <p class="max-w-sm">
                  Just return your product and we'll refund your money. No questions asked – we'll do our best to make sure your return is hassle-free.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
