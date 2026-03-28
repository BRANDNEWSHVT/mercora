export function getServerErrorResponse(error: unknown, fallbackStatusCode = 400) {
  const typedError = error as {
    statusCode?: number
    statusMessage?: string
    message?: string
    data?: { message?: string }
  }

  return {
    statusCode: typedError.statusCode ?? fallbackStatusCode,
    message: typedError.data?.message ?? typedError.statusMessage ?? typedError.message ?? String(error)
  }
}
