import type { HttpTypes } from '@medusajs/types'

export default defineNuxtRouteMiddleware(async (to) => {
  // Skip for API routes and static assets
  if (to.path.startsWith('/api') || to.path.includes('.')) {
    return
  }

  const config = useRuntimeConfig()
  const defaultRegion = (config.public.defaultRegion || 'us').toLowerCase()
  const requestCountryCode = import.meta.server
    ? useRequestHeaders(['x-vercel-ip-country'])['x-vercel-ip-country']?.toLowerCase()
    : undefined

  // Check if URL has a valid country code as first segment
  const segments = to.path.split('/').filter(Boolean)
  const urlCountryCode = segments[0]?.toLowerCase()

  // Fetch regions to validate the country code
  try {
    const regions = await $fetch<HttpTypes.StoreRegion[]>('/api/regions')
    const validCountries = new Set<string>()

    regions.forEach((region) => {
      region.countries?.forEach((c) => {
        if (c.iso_2) validCountries.add(c.iso_2.toLowerCase())
      })
    })

    if (urlCountryCode && validCountries.has(urlCountryCode)) {
      return
    }

    const firstCountry = validCountries.values().next().value
    const countryCode = requestCountryCode && validCountries.has(requestCountryCode)
      ? requestCountryCode
      : validCountries.has(defaultRegion)
        ? defaultRegion
        : firstCountry

    if (countryCode) {
      const queryAndHash = to.fullPath.slice(to.path.length)
      const redirectPath = to.path === '/' ? '' : to.path

      return navigateTo(`/${countryCode}${redirectPath}${queryAndHash}`, {
        redirectCode: 307
      })
    }
  } catch {
    // If we can't fetch regions, just let it through
  }
})
