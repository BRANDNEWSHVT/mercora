import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const cartId = getCartId(event)
  const headers = getAuthHeaders(event)

  if (!cartId) return null

  try {
    const { cart } = await sdk.client.fetch<HttpTypes.StoreCartResponse>(
      `/store/carts/${cartId}`,
      {
        method: 'GET',
        query: {
          fields: '*items, *region, *items.product, *items.variant, *items.thumbnail, *items.metadata, +items.total, *promotions, +shipping_methods.name'
        },
        headers,
        cache: 'force-cache'
      }
    )
    return cart
  } catch {
    return null
  }
})
