<script setup lang="ts">
defineProps<{
  collections: any[]
  region: any
}>()
</script>

<template>
  <ul>
    <li v-for="collection in collections" :key="collection.id">
      <Suspense>
        <HomeProductRail :collection="collection" :region="region" />
      </Suspense>
    </li>
  </ul>
</template>
