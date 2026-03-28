import Medusa from '@medusajs/js-sdk'

let _sdk: Medusa | null = null

export function useMedusaSdk() {
  if (_sdk) return _sdk

  const config = useRuntimeConfig()

  _sdk = new Medusa({
    baseUrl: config.medusaBackendUrl,
    debug: process.env.NODE_ENV === 'development',
    publishableKey: config.medusaPublishableKey
  })

  return _sdk
}
