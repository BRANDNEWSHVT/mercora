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
  }

  await sdk.store.cart.createLineItem(
    cartId,
    { variant_id: body.variant_id, quantity: body.quantity },
    {},
    headers
  )

  return { success: true }
})
