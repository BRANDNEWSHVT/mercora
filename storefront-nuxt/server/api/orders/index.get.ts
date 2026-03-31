import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const query = getQuery(event)
  const headers = getAuthHeaders(event)
  const { id, limit = 10, offset = 0, ...filters } = query

  if (id) {
    const { order } = await sdk.client.fetch<HttpTypes.StoreOrderResponse>(
      `/store/orders/${id}`,
      {
        method: 'GET',
        query: {
          fields: '*payment_collections.payments,*items,*items.metadata,*items.variant,*items.product'
        },
        headers,
        cache: 'no-cache'
      }
    )
    return order
  }

  const { orders } = await sdk.client.fetch<HttpTypes.StoreOrderListResponse>(
    '/store/orders',
    {
      method: 'GET',
      query: {
        limit,
        offset,
        order: '-created_at',
        fields: '*items,+items.metadata,*items.variant,*items.product',
        ...filters
      },
      headers,
      cache: 'no-cache'
    }
  )

  return orders
})
