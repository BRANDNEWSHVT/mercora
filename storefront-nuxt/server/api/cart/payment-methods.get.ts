import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const { regionId } = getQuery(event)
  if (!regionId) return []

  const sdk = useMedusaSdk()
  const { payment_providers } = await sdk.client.fetch<{
    payment_providers: HttpTypes.StorePaymentProvider[]
  }>('/store/payment-providers', {
    query: { region_id: regionId as string }
  })

  return payment_providers
})
