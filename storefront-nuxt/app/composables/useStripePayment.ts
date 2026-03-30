import { loadStripe, type Stripe, type StripeCardElement, type StripeElements, type StripeElementsOptions } from '@stripe/stripe-js'

let stripePromise: Promise<Stripe | null> | null = null

export function useStripePayment() {
  const config = useRuntimeConfig()

  const stripe = useState<Stripe | null>('stripe-payment:stripe', () => null)
  const elements = useState<StripeElements | null>('stripe-payment:elements', () => null)
  const cardElement = useState<StripeCardElement | null>('stripe-payment:card', () => null)
  const clientSecret = useState<string | null>('stripe-payment:client-secret', () => null)
  const cardBrand = useState<string | null>('stripe-payment:card-brand', () => null)
  const cardComplete = useState('stripe-payment:card-complete', () => false)
  const cardError = useState<string | null>('stripe-payment:card-error', () => null)

  const ensureStripe = async () => {
    if (!config.public.stripeKey) {
      return null
    }

    if (!stripePromise) {
      stripePromise = loadStripe(config.public.stripeKey)
    }

    stripe.value = await stripePromise
    return stripe.value
  }

  const resetCard = () => {
    if (cardElement.value) {
      cardElement.value.unmount()
      cardElement.value.destroy()
    }

    cardElement.value = null
    elements.value = null
    clientSecret.value = null
    cardBrand.value = null
    cardComplete.value = false
    cardError.value = null
  }

  const mountCard = async (mountTarget: HTMLElement, nextClientSecret: string) => {
    const stripeInstance = await ensureStripe()

    if (!stripeInstance) {
      cardError.value = 'Stripe is not configured.'
      return false
    }

    if (cardElement.value && clientSecret.value === nextClientSecret) {
      cardElement.value.unmount()
      cardElement.value.mount(mountTarget)
      return true
    }

    resetCard()

    const options: StripeElementsOptions = { clientSecret: nextClientSecret }
    elements.value = stripeInstance.elements(options)
    clientSecret.value = nextClientSecret

    const nextCardElement = elements.value.create('card', {
      style: {
        base: {
          'fontFamily': 'Inter, sans-serif',
          'color': '#424270',
          '::placeholder': {
            color: 'rgb(107 114 128)'
          }
        }
      },
      classes: {
        base: 'pt-3 pb-1 block w-full h-11 px-4 mt-0 bg-ui-bg-field border rounded-md appearance-none focus:outline-hidden focus:ring-0 focus:shadow-borders-interactive-with-active border-ui-border-base hover:bg-ui-bg-field-hover transition-all duration-300 ease-in-out'
      }
    })

    nextCardElement.on('change', (event) => {
      cardBrand.value = event.brand
        ? event.brand.charAt(0).toUpperCase() + event.brand.slice(1)
        : null
      cardError.value = event.error?.message ?? null
      cardComplete.value = event.complete
    })

    nextCardElement.mount(mountTarget)
    cardElement.value = nextCardElement

    return true
  }

  return {
    stripe,
    elements,
    cardElement,
    cardBrand,
    cardComplete,
    cardError,
    clientSecret,
    ensureStripe,
    mountCard,
    resetCard
  }
}
