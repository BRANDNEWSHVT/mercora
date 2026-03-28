import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const query = getQuery(event)
  const headers = getAuthHeaders(event)

  if (query.id) {
    const { order } = await sdk.client.fetch<HttpTypes.StoreOrderResponse>(
      `/store/orders/${query.id}`,
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
        limit: query.limit || 10,
        offset: query.offset || 0,
        order: '-created_at',
        fields: '*items,+items.metadata,*items.variant,*items.product'
      },
      headers,
      cache: 'no-cache'
    }
  )

  return orders
})
