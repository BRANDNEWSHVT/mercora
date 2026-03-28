import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)

  if (!headers.authorization) return null

  try {
    const { customer } = await sdk.client.fetch<{ customer: HttpTypes.StoreCustomer }>(
      '/store/customers/me',
      {
        method: 'GET',
        query: { fields: '*orders' },
        headers,
        cache: 'force-cache'
      }
    )
    return customer
  } catch {
    return null
  }
})
