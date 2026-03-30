import type { HttpTypes } from '@medusajs/types'

export function isSimpleProduct(product: HttpTypes.StoreProduct): boolean {
  return product.options?.length === 1 && product.options[0]?.values?.length === 1
}
