<script setup lang="ts">
defineProps<{
  images: any[]
}>()
</script>

<template>
  <div class="flex items-start relative">
    <div class="flex flex-col flex-1 small:mx-16 gap-y-4">
      <div
        v-for="(image, index) in images"
        :key="image.id"
        class="relative aspect-[29/34] w-full overflow-hidden bg-ui-bg-subtle rounded-rounded"
        :id="image.id"
      >
        <NuxtImg
          v-if="image.url"
          :src="image.url"
          :alt="`Product image ${index + 1}`"
          class="absolute inset-0 rounded-rounded object-cover w-full h-full"
          :loading="index <= 2 ? 'eager' : 'lazy'"
          sizes="(max-width: 576px) 280px, (max-width: 768px) 360px, (max-width: 992px) 480px, 800px"
        />
      </div>
    </div>
  </div>
</template>
