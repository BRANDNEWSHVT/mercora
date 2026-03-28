import type { HttpTypes } from '@medusajs/types'

export default defineEventHandler(async (event) => {
  const sdk = useMedusaSdk()
  const query = getQuery(event)

  const { product_categories } = await sdk.client.fetch<{
    product_categories: HttpTypes.StoreProductCategory[]
  }>('/store/product-categories', {
    query: {
      fields: '*category_children, *products, *parent_category, *parent_category.parent_category',
      limit: query.limit || 100,
      ...query
    },
    cache: 'force-cache'
  })

  return product_categories
})
