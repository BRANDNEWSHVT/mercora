<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

defineProps<{
  collections: HttpTypes.StoreCollection[]
  region: HttpTypes.StoreRegion
}>()
</script>

<template>
  <li
    v-for="collection in collections"
    :key="collection.id"
  >
    <Suspense>
      <HomeProductRail
        :collection="collection"
        :region="region"
      />
    </Suspense>
  </li>
</template>
