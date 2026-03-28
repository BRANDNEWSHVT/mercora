import type { HttpTypes } from '@medusajs/types'

const regionMap = new Map<string, HttpTypes.StoreRegion>()

export function useRegion() {
  const regions = useState<HttpTypes.StoreRegion[]>('regions', () => [])

  const fetchRegions = async () => {
    if (regions.value.length > 0) return regions.value
    const data = await $fetch<HttpTypes.StoreRegion[]>('/api/regions')
    regions.value = data
    buildRegionMap(data)
    return data
  }

  const buildRegionMap = (regionsList: HttpTypes.StoreRegion[]) => {
    regionMap.clear()
    regionsList.forEach((region) => {
      region.countries?.forEach((c) => {
        regionMap.set(c.iso_2 ?? '', region)
      })
    })
  }

  const getRegion = async (countryCode: string): Promise<HttpTypes.StoreRegion | null> => {
    if (regionMap.has(countryCode)) {
      return regionMap.get(countryCode) || null
    }

    const allRegions = await fetchRegions()
    buildRegionMap(allRegions)
    return regionMap.get(countryCode) || null
  }

  return {
    regions,
    fetchRegions,
    getRegion
  }
}
