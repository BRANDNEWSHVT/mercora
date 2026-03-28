export function apiFetch<T>(
  url: string,
  options?: Parameters<typeof $fetch<T>>[1]
) {
  const requestFetch = import.meta.server ? useRequestFetch() : $fetch

  return requestFetch<T>(url, options)
}
