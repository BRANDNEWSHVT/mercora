import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'

export function useCart() {
  const cart = useState<HttpTypes.StoreCart | null>('cart', () => null)
  const loading = useState('cart-loading', () => false)

  const fetchCart = async () => {
    loading.value = true
    try {
      const data = await apiFetch<HttpTypes.StoreCart | null>('/api/cart')
      cart.value = data
    } catch {
      cart.value = null
    } finally {
      loading.value = false
    }
    return cart.value
  }

  const addToCart = async (variantId: string, quantity: number, regionId: string) => {
    loading.value = true
    try {
      await apiFetch('/api/cart/add-item', {
        method: 'POST',
        body: { variant_id: variantId, quantity, region_id: regionId }
      })
      await fetchCart()
    } finally {
      loading.value = false
    }
  }

  const updateLineItem = async (lineId: string, quantity: number) => {
    loading.value = true
    try {
      await apiFetch('/api/cart/update-item', {
        method: 'POST',
        body: { line_id: lineId, quantity }
      })
      await fetchCart()
    } finally {
      loading.value = false
    }
  }

  const deleteLineItem = async (lineId: string) => {
    loading.value = true
    try {
      await apiFetch('/api/cart/delete-item', {
        method: 'POST',
        body: { line_id: lineId }
      })
      await fetchCart()
    } finally {
      loading.value = false
    }
  }

  const updateCart = async (data: Record<string, unknown>) => {
    loading.value = true
    try {
      await apiFetch('/api/cart/update', {
        method: 'POST',
        body: data
      })
      await fetchCart()
    } finally {
      loading.value = false
    }
  }

  const applyPromotions = async (codes: string[]) => {
    await apiFetch('/api/cart/promotions', {
      method: 'POST',
      body: { codes }
    })
    await fetchCart()
  }

  const setShippingMethod = async (optionId: string, cartId?: string) => {
    await apiFetch('/api/cart/shipping-method', {
      method: 'POST',
      body: { option_id: optionId, cart_id: cartId }
    })
    await fetchCart()
  }

  const placeOrder = async () => {
    const result = await apiFetch<{
      type: 'order' | 'cart'
      order?: HttpTypes.StoreOrder
      cart?: HttpTypes.StoreCart
      countryCode?: string
    }>('/api/cart/complete', {
      method: 'POST'
    })
    if (result.type === 'order') {
      cart.value = null
    }
    return result
  }

  const initiatePaymentSession = async (providerId: string) => {
    await apiFetch('/api/cart/payment-session', {
      method: 'POST',
      body: {
        cart: { id: cart.value?.id },
        data: { provider_id: providerId }
      }
    })
    await fetchCart()
  }

  const fetchShippingOptions = async () => {
    if (!cart.value?.id) return []
    return await apiFetch<Record<string, unknown>[]>('/api/cart/shipping-options')
  }

  const totalItems = computed(() => {
    return cart.value?.items?.reduce((acc, item) => acc + item.quantity, 0) || 0
  })

  return {
    cart,
    loading,
    totalItems,
    fetchCart,
    addToCart,
    updateLineItem,
    deleteLineItem,
    updateCart,
    applyPromotions,
    setShippingMethod,
    placeOrder,
    initiatePaymentSession,
    fetchShippingOptions
  }
}
