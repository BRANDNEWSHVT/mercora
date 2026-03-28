import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'

const regionMap = new Map<string, HttpTypes.StoreRegion>()
let regionsRequest: Promise<HttpTypes.StoreRegion[]> | null = null

export function useRegion() {
  const regions = useState<HttpTypes.StoreRegion[]>('regions', () => [])

  const fetchRegions = async () => {
    if (regions.value.length > 0) {
      buildRegionMap(regions.value)
      return regions.value
    }

    if (!regionsRequest) {
      regionsRequest = apiFetch<HttpTypes.StoreRegion[]>('/api/regions')
    }

    const data = await regionsRequest
    regions.value = data
    buildRegionMap(data)
    regionsRequest = null
    return data
  }

  const buildRegionMap = (regionsList: HttpTypes.StoreRegion[]) => {
    regionMap.clear()
    regionsList.forEach((region) => {
      region.countries?.forEach((c) => {
        regionMap.set(c.iso_2?.toLowerCase() ?? '', region)
      })
    })
  }

  const getRegion = async (countryCode: string): Promise<HttpTypes.StoreRegion | null> => {
    const normalizedCountryCode = countryCode.toLowerCase()

    if (regionMap.has(normalizedCountryCode)) {
      return regionMap.get(normalizedCountryCode) || null
    }

    const allRegions = await fetchRegions()
    buildRegionMap(allRegions)
    return regionMap.get(normalizedCountryCode) || null
  }

  return {
    regions,
    fetchRegions,
    getRegion
  }
}
