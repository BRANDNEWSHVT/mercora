export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const body = await readBody(event)
  const headers = getAuthHeaders(event)

  if (body.action === 'create') {
    const { customer } = await sdk.store.customer.createAddress(body.address, {}, headers)
    return customer
  }

  if (body.action === 'update') {
    await sdk.store.customer.updateAddress(body.addressId, body.address, {}, headers)
    return { success: true }
  }

  if (body.action === 'delete') {
    await sdk.store.customer.deleteAddress(body.addressId, headers)
    return { success: true }
  }

  throw createError({ statusCode: 400, message: 'Invalid action' })
})
