export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()

  try {
    await sdk.auth.logout()
  } catch {
    // ignore
  }

  removeAuthToken(event)
  removeCartId(event)

  return { success: true }
})
