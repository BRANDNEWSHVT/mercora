export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)
  const headers = getAuthHeaders(event)

  const resp = await sdk.store.payment.initiatePaymentSession(
    body.cart,
    body.data,
    {},
    headers
  )

  return resp
})
