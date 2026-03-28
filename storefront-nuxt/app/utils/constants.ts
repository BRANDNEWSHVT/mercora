export const paymentInfoMap: Record<string, { title: string, icon: string }> = {
  'pp_stripe_stripe': { title: 'Credit card', icon: 'lucide:credit-card' },
  'pp_stripe-ideal_stripe': { title: 'iDeal', icon: 'lucide:credit-card' },
  'pp_stripe-bancontact_stripe': { title: 'Bancontact', icon: 'lucide:credit-card' },
  'pp_paypal_paypal': { title: 'PayPal', icon: 'simple-icons:paypal' },
  'pp_system_default': { title: 'Manual Payment', icon: 'lucide:credit-card' }
}

export const isStripe = (providerId?: string) => providerId?.startsWith('pp_stripe_')
export const isPaypal = (providerId?: string) => providerId?.startsWith('pp_paypal')
export const isManual = (providerId?: string) => providerId?.startsWith('pp_system_default')

export const noDivisionCurrencies = [
  'krw', 'jpy', 'vnd', 'clp', 'pyg', 'xaf', 'xof', 'bif', 'djf',
  'gnf', 'kmf', 'mga', 'rwf', 'xpf', 'htg', 'vuv', 'xag', 'xdr', 'xau'
]
