import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async () => {
  const sdk = useMedusaSdk()
  const { regions } = await sdk.client.fetch<{ regions: HttpTypes.StoreRegion[] }>(
    '/store/regions',
    { method: 'GET', cache: 'force-cache' }
  )
  return regions
})
