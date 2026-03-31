import { getServerErrorResponse } from '../../utils/errors'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)

  try {
    const headers = getAuthHeaders(event)

    if (headers.authorization) {
      try {
        await sdk.client.fetch('/store/customers/me', {
          method: 'GET',
          headers,
          cache: 'no-cache'
        })

        throw createError({
          statusCode: 409,
          message: 'You are already signed in.'
        })
      } catch (error: unknown) {
        const statusCode = (error as { statusCode?: number })?.statusCode

        if (statusCode === 409) {
          throw error
        }
      }
    }

    const token = await sdk.auth.register('customer', 'emailpass', {
      email: body.email,
      password: body.password
    })
    const registrationHeaders = { authorization: `Bearer ${token}` }

    setAuthToken(event, token as string)

    await sdk.store.customer.create({
      email: body.email,
      first_name: body.first_name,
      last_name: body.last_name,
      phone: body.phone
    }, {}, registrationHeaders)

    const loginToken = await sdk.auth.login('customer', 'emailpass', {
      email: body.email,
      password: body.password
    })
    const loginHeaders = { authorization: `Bearer ${loginToken}` }

    setAuthToken(event, loginToken as string)

    // Transfer cart if exists
    const cartId = getCartId(event)
    if (cartId) {
      await sdk.store.cart.transferCart(cartId, {}, loginHeaders)
    }

    return { success: true }
  } catch (error: unknown) {
    throw createError(getServerErrorResponse(error))
  }
})
