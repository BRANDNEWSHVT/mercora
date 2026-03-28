import type { HttpTypes } from '@medusajs/types'

export default defineNuxtRouteMiddleware(async (to) => {
  // Skip for API routes and static assets
  if (to.path.startsWith('/api') || to.path.includes('.')) {
    return
  }

  const config = useRuntimeConfig()
  const defaultRegion = config.public.defaultRegion || 'us'

  // If at root, redirect to default country
  if (to.path === '/') {
    return navigateTo(`/${defaultRegion}`, { redirectCode: 307 })
  }

  // Check if URL has a valid country code as first segment
  const segments = to.path.split('/').filter(Boolean)
  const urlCountryCode = segments[0]?.toLowerCase()

  if (!urlCountryCode) {
    return navigateTo(`/${defaultRegion}`, { redirectCode: 307 })
  }

  // Fetch regions to validate the country code
  try {
    const regions = await $fetch<HttpTypes.StoreRegion[]>('/api/regions')
    const validCountries = new Set<string>()

    regions.forEach((region) => {
      region.countries?.forEach((c) => {
        if (c.iso_2) validCountries.add(c.iso_2)
      })
    })

    // If the URL has a valid country code, allow navigation
    if (validCountries.has(urlCountryCode)) {
      return
    }

    // If not valid, redirect with default country code prepended
    if (validCountries.has(defaultRegion)) {
      return navigateTo(`/${defaultRegion}${to.path}`, { redirectCode: 307 })
    }

    // Use first available country
    const firstCountry = validCountries.values().next().value
    if (firstCountry) {
      return navigateTo(`/${firstCountry}${to.path}`, { redirectCode: 307 })
    }
  } catch {
    // If we can't fetch regions, just let it through
  }
})
