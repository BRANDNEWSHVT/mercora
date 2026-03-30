<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const route = useRoute()
const handle = computed(() => route.params.handle as string)

const { data: collection } = await useAsyncData(
  `collection-${handle.value}`,
  async (): Promise<HttpTypes.StoreCollection | null> => {
    const collections = await $fetch<HttpTypes.StoreCollection[]>('/api/collections', {
      query: {
        handle: handle.value,
        fields: '*products'
      }
    })

    return collections[0] ?? null
  }
)

if (!collection.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Collection not found'
  })
}

useSeoMeta({
  title: () => collection.value ? `${collection.value.title} | Medusa Store` : 'Collection | Medusa Store',
  description: () => collection.value ? `${collection.value.title} collection` : undefined
})
</script>

<template>
  <StoreCollectionTemplate
    v-if="collection"
    :collection="collection"
  />
  <div
    v-else
    class="flex items-center justify-center min-h-[50vh]"
  >
    <UIcon
      name="i-lucide-loader-2"
      class="animate-spin w-8 h-8"
    />
  </div>
</template>
