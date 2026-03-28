export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)
  const headers = getAuthHeaders(event)
  const cartId = getCartId(event)

  if (!cartId) throw createError({ statusCode: 400, message: 'No cart found' })

  await sdk.store.cart.update(cartId, body, {}, headers)

  return { success: true }
})
