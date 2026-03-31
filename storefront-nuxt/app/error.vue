<script setup lang="ts">
const props = defineProps<{
  error: {
    statusCode?: number
    statusMessage?: string
    message?: string
  }
}>()

const route = useRoute()
const config = useRuntimeConfig()

const countryCode = computed(() => {
  const routeCountryCode = route.params.countryCode

  if (typeof routeCountryCode === 'string' && routeCountryCode.length > 0) {
    return routeCountryCode
  }

  return config.public.defaultRegion || 'us'
})

const title = computed(() => {
  return props.error.statusCode === 404 ? 'Page not found' : 'Something went wrong'
})

const description = computed(() => {
  if (props.error.statusCode === 404) {
    return 'The page you requested is unavailable or may have moved.'
  }

  return props.error.statusMessage || props.error.message || 'An unexpected error interrupted this page.'
})

const handleHome = () => clearError({ redirect: `/${countryCode.value}` })
const handleStore = () => clearError({ redirect: `/${countryCode.value}/store` })
</script>

<template>
  <div class="content-container flex min-h-[70vh] items-center justify-center py-16">
    <div class="mx-auto flex max-w-2xl flex-col items-center rounded-2xl border border-gray-200 bg-white px-8 py-10 text-center shadow-sm">
      <p class="text-sm font-medium uppercase tracking-[0.2em] text-ui-fg-subtle">
        {{ error.statusCode || 500 }}
      </p>
      <h1 class="mt-4 text-3xl-semi text-ui-fg-base">
        {{ title }}
      </h1>
      <p class="mt-3 max-w-xl text-base-regular text-ui-fg-subtle">
        {{ description }}
      </p>
      <div class="mt-8 flex flex-col gap-3 small:flex-row">
        <UButton
          size="lg"
          @click="handleHome"
        >
          Return home
        </UButton>
        <UButton
          size="lg"
          color="neutral"
          variant="outline"
          @click="handleStore"
        >
          Browse store
        </UButton>
      </div>
    </div>
  </div>
</template>
