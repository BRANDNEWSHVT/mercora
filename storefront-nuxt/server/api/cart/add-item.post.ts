import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)
  const headers = getAuthHeaders(event)
  let cartId = getCartId(event)

  if (!cartId) {
    const { cart } = await sdk.store.cart.create(
      { region_id: body.region_id },
      {},
      headers
    )
    setCartId(event, cart.id)
    cartId = cart.id
  } else if (body.region_id) {
    const { cart } = await sdk.client.fetch<HttpTypes.StoreCartResponse>(
      `/store/carts/${cartId}`,
      {
        method: 'GET',
        headers,
        cache: 'no-cache'
      }
    )

    if (cart.region_id !== body.region_id) {
      await sdk.store.cart.update(
        cartId,
        { region_id: body.region_id },
        {},
        headers
      )
    }
  }

  await sdk.store.cart.createLineItem(
    cartId,
    { variant_id: body.variant_id, quantity: body.quantity },
    {},
    headers
  )

  return { success: true }
})
