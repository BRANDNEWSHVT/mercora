export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)

  try {
    const token = await sdk.auth.login('customer', 'emailpass', {
      email: body.email,
      password: body.password
    })

    setAuthToken(event, token as string)

    // Transfer cart if exists
    const cartId = getCartId(event)
    if (cartId) {
      const headers = getAuthHeaders(event)
      await sdk.store.cart.transferCart(cartId, {}, headers)
    }

    return { success: true }
  } catch (error: any) {
    throw createError({ statusCode: 401, message: error.toString() })
  }
})
