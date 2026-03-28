import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const query = getQuery(event)

  const queryParams: Record<string, any> = {
    limit: query.limit || 100,
    offset: query.offset || 0,
    ...query
  }

  const { collections } = await sdk.client.fetch<{
    collections: HttpTypes.StoreCollection[]
  }>('/store/collections', {
    query: queryParams,
    cache: 'force-cache'
  })

  return collections
})
