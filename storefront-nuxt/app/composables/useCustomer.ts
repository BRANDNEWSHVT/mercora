import type { HttpTypes } from '@medusajs/types'
import { apiFetch } from '~/utils/api'

export function useCustomer() {
  const customer = useState<HttpTypes.StoreCustomer | null>('customer', () => null)
  const loading = useState('customer-loading', () => false)

  const fetchCustomer = async () => {
    loading.value = true
    try {
      const data = await apiFetch<HttpTypes.StoreCustomer | null>('/api/customer/me')
      customer.value = data
    } catch {
      customer.value = null
    } finally {
      loading.value = false
    }
    return customer.value
  }

  const login = async (email: string, password: string) => {
    await apiFetch('/api/customer/login', {
      method: 'POST',
      body: { email, password }
    })
    await fetchCustomer()
  }

  const register = async (data: {
    email: string
    password: string
    first_name: string
    last_name: string
    phone?: string
  }) => {
    await apiFetch('/api/customer/register', {
      method: 'POST',
      body: data
    })
    await fetchCustomer()
  }

  const logout = async (countryCode: string) => {
    await apiFetch('/api/customer/logout', { method: 'POST' })
    customer.value = null
    navigateTo(`/${countryCode}/account`)
  }

  const updateCustomer = async (body: Record<string, unknown>) => {
    const updated = await apiFetch('/api/customer/update', {
      method: 'POST',
      body
    })
    await fetchCustomer()
    return updated
  }

  const isLoggedIn = computed(() => !!customer.value)

  return {
    customer,
    loading,
    isLoggedIn,
    fetchCustomer,
    login,
    register,
    logout,
    updateCustomer
  }
}
