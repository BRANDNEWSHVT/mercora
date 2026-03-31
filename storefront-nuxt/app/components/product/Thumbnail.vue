<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const props = withDefaults(defineProps<{
  thumbnail?: string | null
  images?: HttpTypes.StoreProductImage[] | null
  size?: 'small' | 'medium' | 'large' | 'full' | 'square'
  isFeatured?: boolean
  className?: string
  dataTestid?: string
}>(), {
  size: 'small',
  isFeatured: false
})

const initialImage = computed(() => props.thumbnail || props.images?.[0]?.url)

const aspectClass = computed(() => {
  if (props.size === 'square') return 'aspect-square'
  if (props.isFeatured) return 'aspect-[11/14]'
  return 'aspect-[9/16]'
})

const sizeClasses = computed(() => {
  const classes: Record<string, boolean> = {
    'w-[180px]': props.size === 'small',
    'w-[290px]': props.size === 'medium',
    'w-[440px]': props.size === 'large',
    'w-full': props.size === 'full'
  }
  return [aspectClass.value, ...Object.entries(classes).filter(([, v]) => v).map(([k]) => k)].join(' ')
})
</script>

<template>
  <div
    :class="[
      'relative w-full overflow-hidden p-4 shadow-elevation-card-rest bg-ui-bg-subtle rounded-large group-hover:shadow-elevation-card-hover transition-shadow ease-in-out duration-150',
      sizeClasses,
      className
    ]"
    :data-testid="dataTestid"
  >
    <NuxtImg
      v-if="initialImage"
      :src="initialImage"
      alt="Thumbnail"
      class="absolute inset-0 object-cover object-center w-full h-full"
      :quality="50"
      loading="lazy"
      :draggable="false"
      sizes="(max-width: 576px) 280px, (max-width: 768px) 360px, (max-width: 992px) 480px, 800px"
    />
    <div
      v-else
      class="w-full h-full absolute inset-0 flex items-center justify-center"
    >
      <UIcon
        name="i-lucide-image"
        class="w-8 h-8 text-ui-fg-muted"
      />
    </div>
  </div>
</template>
