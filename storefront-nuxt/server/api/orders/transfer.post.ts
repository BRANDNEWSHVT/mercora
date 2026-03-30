export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)
  const body = await readBody<{
    id?: string
    token?: string
    action?: 'accept' | 'decline'
    order_id?: string
  }>(event)

  const { id, token, action } = body

  if (body.order_id) {
    const { order } = await sdk.store.order.requestTransfer(
      body.order_id,
      {},
      {
        fields: 'id,email'
      },
      headers
    )

    return order
  }

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
