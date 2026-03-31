import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const { regionId } = getQuery(event)
  if (!regionId) return []

  const sdk = useMedusaSdk()
  const headers = getAuthHeaders(event)
  const { payment_providers } = await sdk.client.fetch<{
    payment_providers: HttpTypes.StorePaymentProvider[]
  }>('/store/payment-providers', {
    method: 'GET',
    query: { region_id: regionId as string },
    headers,
    cache: 'force-cache'
  })

  return payment_providers.sort((a, b) => {
    return a.id > b.id ? 1 : -1
  })
})
