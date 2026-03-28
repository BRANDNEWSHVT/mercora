export default function medusaError(error: any): never {
  if (error?.response?.data?.message) {
    throw new Error(error.response.data.message)
  }
  throw error
}
