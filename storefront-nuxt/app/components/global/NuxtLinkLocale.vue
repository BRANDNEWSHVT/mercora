<script setup lang="ts">
const props = defineProps<{
  to: string
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

const localizedTo = computed(() => {
  if (!props.to) {
    return `/${countryCode.value}`
  }

  if (/^(https?:)?\/\//.test(props.to) || props.to.startsWith('#')) {
    return props.to
  }

  if (props.to.startsWith(`/${countryCode.value}`)) {
    return props.to
  }

  if (props.to.startsWith('/')) {
    return `/${countryCode.value}${props.to}`
  }

  return `/${countryCode.value}/${props.to}`
})
</script>

<template>
  <NuxtLink :to="localizedTo">
    <slot />
  </NuxtLink>
</template>
