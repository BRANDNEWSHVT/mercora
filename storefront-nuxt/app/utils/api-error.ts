import type { FetchError } from 'ofetch'

type ErrorWithMessage = {
  data?: { message?: string }
  response?: {
    _data?: { message?: string }
    data?: { message?: string }
  }
  statusMessage?: string
  message?: string
}

export function getApiErrorMessage(error: unknown, fallback: string) {
  const fetchError = error as FetchError<{ message?: string }>
  const errorWithMessage = error as ErrorWithMessage

  return fetchError?.data?.message
    || errorWithMessage?.response?._data?.message
    || errorWithMessage?.response?.data?.message
    || errorWithMessage?.statusMessage
    || errorWithMessage?.message
    || fallback
}
