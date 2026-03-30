import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)
  const cartId = getCartId(event)
  const body = await readBody<{
    option_id?: string
    data?: Record<string, unknown>
  }>(event)

  if (!cartId) {
    throw createError({ statusCode: 400, message: 'No cart found' })
  }

  if (!body.option_id) {
    throw createError({ statusCode: 400, message: 'No shipping option provided' })
  }

  const payload: {
    cart_id: string
    data?: Record<string, unknown>
  } = { cart_id: cartId }

  if (body.data) {
    payload.data = body.data
  }

  const { shipping_option } = await sdk.client.fetch<{
    shipping_option: HttpTypes.StoreCartShippingOption
  }>(`/store/shipping-options/${body.option_id}/calculate`, {
    method: 'POST',
    body: payload,
    headers,
    cache: 'no-cache'
  })

  return shipping_option
})
