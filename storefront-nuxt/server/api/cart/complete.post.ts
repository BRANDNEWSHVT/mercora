export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)
  const cartId = getCartId(event)

  if (!cartId) throw createError({ statusCode: 400, message: 'No cart found' })

  const cartRes = await sdk.store.cart.complete(cartId, {}, headers)

  if (cartRes?.type === 'order') {
    removeCartId(event)
    const countryCode = cartRes.order.shipping_address?.country_code?.toLowerCase()
    return { type: 'order', order: cartRes.order, countryCode }
  }

  return { type: 'cart', cart: cartRes.cart }
})
