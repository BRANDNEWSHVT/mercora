import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const query = getQuery(event)
  const headers = getAuthHeaders(event)

  const result = await sdk.client.fetch<{ products: HttpTypes.StoreProduct[], count: number }>(
    '/store/products',
    {
      method: 'GET',
      query: {
        limit: query.limit || 12,
        offset: query.offset || 0,
        region_id: query.region_id,
        fields: '*variants.calculated_price,+variants.inventory_quantity,+metadata,+tags',
        ...Object.fromEntries(
          Object.entries(query).filter(([k]) => !['limit', 'offset', 'region_id', 'fields'].includes(k))
        )
      },
      headers,
      cache: 'force-cache'
    }
  )

  return result
})
