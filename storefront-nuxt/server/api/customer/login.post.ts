const getErrorResponse = (error: unknown) => ({
  statusCode: (error as { statusCode?: number })?.statusCode ?? 401,
  message: (error as { message?: string })?.message ?? String(error)
})

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody<{
    email?: string
    password?: string
    transfer?: boolean
  }>(event)

  try {
    if (body.transfer) {
      const cartId = getCartId(event)
      const headers = getAuthHeaders(event)

      if (!cartId || !headers.authorization) {
        throw createError({
          statusCode: 400,
          message: 'Missing customer session or cart context'
        })
      }

      await sdk.store.cart.transferCart(cartId, {}, headers)

      return { success: true }
    }

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
  } catch (error: unknown) {
    throw createError(getErrorResponse(error))
  }
})
