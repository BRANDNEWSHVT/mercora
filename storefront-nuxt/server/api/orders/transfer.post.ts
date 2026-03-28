export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)
  const body = await readBody(event)

  const { id, token, action } = body

  if (action === 'accept') {
    await sdk.client.fetch(`/store/orders/${id}/transfer/accept`, {
      method: 'POST',
      body: { token },
      headers
    })
    return { success: true }
  }

  if (action === 'decline') {
    await sdk.client.fetch(`/store/orders/${id}/transfer/decline`, {
      method: 'POST',
      body: { token },
      headers
    })
    return { success: true }
  }

  throw createError({ statusCode: 400, message: 'Invalid action' })
})
