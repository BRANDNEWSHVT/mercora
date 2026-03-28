import type { HttpTypes } from '@medusajs/types'

export function useCart() {
  const cart = useState<HttpTypes.StoreCart | null>('cart', () => null)
  const loading = useState('cart-loading', () => false)

  const fetchCart = async () => {
    loading.value = true
    try {
      const data = await $fetch<HttpTypes.StoreCart | null>('/api/cart')
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
      await $fetch('/api/cart/add-item', {
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
      await $fetch('/api/cart/update-item', {
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
      await $fetch('/api/cart/delete-item', {
        method: 'POST',
        body: { line_id: lineId }
      })
      await fetchCart()
    } finally {
      loading.value = false
    }
  }

  const updateCart = async (data: any) => {
    loading.value = true
    try {
      await $fetch('/api/cart/update', {
        method: 'POST',
        body: data
      })
      await fetchCart()
    } finally {
      loading.value = false
    }
  }

  const applyPromotions = async (codes: string[]) => {
    await $fetch('/api/cart/promotions', {
      method: 'POST',
      body: { codes }
    })
    await fetchCart()
  }

  const setShippingMethod = async (optionId: string, cartId?: string) => {
    await $fetch('/api/cart/shipping-method', {
      method: 'POST',
      body: { option_id: optionId, cart_id: cartId }
    })
    await fetchCart()
  }

  const placeOrder = async () => {
    const result = await $fetch<any>('/api/cart/complete', {
      method: 'POST'
    })
    if (result.type === 'order') {
      cart.value = null
    }
    return result
  }

  const initiatePaymentSession = async (providerId: string) => {
    await $fetch('/api/cart/payment-session', {
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
    return await $fetch<Record<string, unknown>[]>('/api/cart/shipping-options')
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
