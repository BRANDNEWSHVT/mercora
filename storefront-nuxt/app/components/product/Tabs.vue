<script setup lang="ts">
const props = defineProps<{
  product: any
}>()

const items = computed(() => [
  {
    label: 'Product Information',
    value: 'product-info',
  },
  {
    label: 'Shipping & Returns',
    value: 'shipping',
  },
])
</script>

<template>
  <div class="w-full">
    <ClientOnly>
      <UAccordion :items="items" multiple>
        <template #product-info>
          <div class="text-small-regular py-8">
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
        </template>

        <template #shipping>
          <div class="text-small-regular py-8">
            <div class="grid grid-cols-1 gap-y-8">
              <div class="flex items-start gap-x-2">
                <UIcon name="i-lucide-truck" class="w-6 h-6 flex-shrink-0" />
                <div>
                  <span class="font-semibold">Fast delivery</span>
                  <p class="max-w-sm">Your package will arrive in 3-5 business days at your pick up location or in the comfort of your home.</p>
                </div>
              </div>
              <div class="flex items-start gap-x-2">
                <UIcon name="i-lucide-refresh-cw" class="w-6 h-6 flex-shrink-0" />
                <div>
                  <span class="font-semibold">Simple exchanges</span>
                  <p class="max-w-sm">Is the fit not quite right? No worries - we'll exchange your product for a new one.</p>
                </div>
              </div>
              <div class="flex items-start gap-x-2">
                <UIcon name="i-lucide-undo-2" class="w-6 h-6 flex-shrink-0" />
                <div>
                  <span class="font-semibold">Easy returns</span>
                  <p class="max-w-sm">Just return your product and we'll refund your money. No questions asked – we'll do our best to make sure your return is hassle-free.</p>
                </div>
              </div>
            </div>
          </div>
        </template>
      </UAccordion>
      <template #fallback>
        <div class="text-small-regular">
          <div v-for="item in items" :key="item.value" class="border-b border-gray-200 py-2">
            <span class="font-semibold">{{ item.label }}</span>
          </div>
        </div>
      </template>
    </ClientOnly>
  </div>
</template>
