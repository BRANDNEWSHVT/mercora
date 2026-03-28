import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)
  const cartId = getCartId(event)

  const { shipping_options } = await sdk.client.fetch<{
    shipping_options: HttpTypes.StoreCartShippingOption[]
  }>('/store/shipping-options', {
    query: { cart_id: cartId },
    headers,
    cache: 'force-cache'
  })

  return shipping_options
})
