<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)

const { data: collectionsData } = useAsyncData('footer-collections', () =>
  $fetch<HttpTypes.StoreCollection[]>('/api/collections', { query: { fields: '*products' } })
)
const { data: categoriesData } = useAsyncData('footer-categories', () =>
  $fetch<HttpTypes.StoreProductCategory[]>('/api/categories')
)

const collections = computed(() => collectionsData.value ?? [])
const categories = computed(() => categoriesData.value ?? [])
</script>

<template>
  <footer class="border-t border-ui-border-base w-full">
    <div class="content-container flex flex-col w-full">
      <div class="flex flex-col gap-y-6 xsmall:flex-row items-start justify-between py-40">
        <div>
          <NuxtLink
            :to="`/${countryCode}`"
            class="txt-compact-xlarge-plus text-ui-fg-subtle hover:text-ui-fg-base uppercase"
          >
            Medusa Store
          </NuxtLink>
        </div>
        <div class="text-small-regular gap-10 medium:gap-x-16 grid grid-cols-2 small:grid-cols-3">
          <!-- Categories -->
          <div
            v-if="categories.length"
            class="flex flex-col gap-y-2"
          >
            <span class="txt-small-plus text-ui-fg-base">Categories</span>
            <ul
              class="grid grid-cols-1 gap-2"
              data-testid="footer-categories"
            >
              <template
                v-for="c in categories.slice(0, 6)"
                :key="c.id"
              >
                <li
                  v-if="!c.parent_category"
                  class="flex flex-col gap-2 text-ui-fg-subtle txt-small"
                >
                  <NuxtLink
                    :class="[
                      'hover:text-ui-fg-base',
                      c.category_children?.length ? 'txt-small-plus' : ''
                    ]"
                    :to="`/${countryCode}/categories/${c.handle}`"
                    data-testid="category-link"
                  >
                    {{ c.name }}
                  </NuxtLink>
                  <ul
                    v-if="c.category_children?.length"
                    class="grid grid-cols-1 ml-3 gap-2"
                  >
                    <li
                      v-for="child in c.category_children"
                      :key="child.id"
                    >
                      <NuxtLink
                        class="hover:text-ui-fg-base"
                        :to="`/${countryCode}/categories/${child.handle}`"
                        data-testid="category-link"
                      >
                        {{ child.name }}
                      </NuxtLink>
                    </li>
                  </ul>
                </li>
              </template>
            </ul>
          </div>

          <!-- Collections -->
          <div
            v-if="collections.length"
            class="flex flex-col gap-y-2"
          >
            <span class="txt-small-plus text-ui-fg-base">Collections</span>
            <ul
              :class="[
                'grid grid-cols-1 gap-2 text-ui-fg-subtle txt-small',
                collections.length > 3 ? 'grid-cols-2' : ''
              ]"
            >
              <li
                v-for="c in collections.slice(0, 6)"
                :key="c.id"
              >
                <NuxtLink
                  class="hover:text-ui-fg-base"
                  :to="`/${countryCode}/collections/${c.handle}`"
                >
                  {{ c.title }}
                </NuxtLink>
              </li>
            </ul>
          </div>

          <!-- Medusa Links -->
          <div class="flex flex-col gap-y-2">
            <span class="txt-small-plus text-ui-fg-base">Medusa</span>
            <ul class="grid grid-cols-1 gap-y-2 text-ui-fg-subtle txt-small">
              <li>
                <a
                  href="https://github.com/medusajs"
                  target="_blank"
                  rel="noreferrer"
                  class="hover:text-ui-fg-base"
                >GitHub</a>
              </li>
              <li>
                <a
                  href="https://docs.medusajs.com"
                  target="_blank"
                  rel="noreferrer"
                  class="hover:text-ui-fg-base"
                >Documentation</a>
              </li>
              <li>
                <a
                  href="https://github.com/medusajs/nextjs-starter-medusa"
                  target="_blank"
                  rel="noreferrer"
                  class="hover:text-ui-fg-base"
                >Source code</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="flex w-full mb-16 justify-between text-ui-fg-muted">
        <p class="txt-compact-small">
          © {{ new Date().getFullYear() }} Medusa Store. All rights reserved.
        </p>
        <LayoutMedusaCta />
      </div>
    </div>
  </footer>
</template>
