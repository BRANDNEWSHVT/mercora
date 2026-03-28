export function useCountryCode() {
  const route = useRoute()

  const countryCode = computed(() => {
    return (route.params.countryCode as string) || useRuntimeConfig().public.defaultRegion
  })

  return countryCode
}
