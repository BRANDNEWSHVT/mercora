export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)
  const headers = getAuthHeaders(event)

  const { customer } = await sdk.store.customer.update(body, {}, headers)
  return customer
})
