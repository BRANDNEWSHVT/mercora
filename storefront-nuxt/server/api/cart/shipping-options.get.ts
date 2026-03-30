import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)
  const cartId = getCartId(event)
  if (!cartId) {
    return []
  }

  const { shipping_options } = await sdk.client.fetch<{
    shipping_options: HttpTypes.StoreCartShippingOption[]
  }>('/store/shipping-options', {
    query: {
      cart_id: cartId,
      fields: '+service_zone.fulfllment_set.type,*service_zone.fulfillment_set.location.address'
    },
    headers,
    cache: 'force-cache'
  })

  return shipping_options
})
