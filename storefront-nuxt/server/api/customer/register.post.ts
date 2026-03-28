export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)

  try {
    const token = await sdk.auth.register('customer', 'emailpass', {
      email: body.email,
      password: body.password
    })

    setAuthToken(event, token as string)

    const headers = getAuthHeaders(event)
    await sdk.store.customer.create({
      email: body.email,
      first_name: body.first_name,
      last_name: body.last_name,
      phone: body.phone
    }, {}, headers)

    const loginToken = await sdk.auth.login('customer', 'emailpass', {
      email: body.email,
      password: body.password
    })

    setAuthToken(event, loginToken as string)

    // Transfer cart if exists
    const cartId = getCartId(event)
    if (cartId) {
      const newHeaders = getAuthHeaders(event)
      await sdk.store.cart.transferCart(cartId, {}, newHeaders)
    }

    return { success: true }
  } catch (error: any) {
    throw createError({ statusCode: 400, message: error.toString() })
  }
})
