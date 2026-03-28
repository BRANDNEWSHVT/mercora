import type { H3Event } from 'h3'

export function getAuthHeaders(event: H3Event): { authorization: string } | Record<string, never> {
  const token = getCookie(event, '_medusa_jwt')
  if (!token) return {}
  return { authorization: `Bearer ${token}` }
}

export function getCartId(event: H3Event): string | undefined {
  return getCookie(event, '_medusa_cart_id')
}

export function setCartId(event: H3Event, cartId: string) {
  setCookie(event, '_medusa_cart_id', cartId, {
    maxAge: 60 * 60 * 24 * 7,
    httpOnly: true,
    sameSite: 'strict',
    secure: process.env.NODE_ENV === 'production'
  })
}

export function removeCartId(event: H3Event) {
  deleteCookie(event, '_medusa_cart_id')
}

export function setAuthToken(event: H3Event, token: string) {
  setCookie(event, '_medusa_jwt', token, {
    maxAge: 60 * 60 * 24 * 7,
    httpOnly: true,
    sameSite: 'strict',
    secure: process.env.NODE_ENV === 'production'
  })
}

export function removeAuthToken(event: H3Event) {
  deleteCookie(event, '_medusa_jwt')
}

export function getCacheId(event: H3Event): string {
  let cacheId = getCookie(event, '_medusa_cache_id')
  if (!cacheId) {
    cacheId = crypto.randomUUID()
    setCookie(event, '_medusa_cache_id', cacheId, {
      maxAge: 60 * 60 * 24
    })
  }
  return cacheId
}
