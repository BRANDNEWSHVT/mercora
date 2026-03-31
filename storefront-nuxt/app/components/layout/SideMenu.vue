<script setup lang="ts">
const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const isOpen = ref(false)
const isCountrySelectOpen = ref(false)
const { regions } = useRegion()

const menuItems = [
  { name: 'Home', href: '/' },
  { name: 'Store', href: '/store' },
  { name: 'Account', href: '/account' },
  { name: 'Cart', href: '/cart' }
]
</script>

<template>
  <div class="h-full">
    <div class="flex items-center h-full">
      <button
        data-testid="nav-menu-button"
        class="relative h-full flex items-center transition-all ease-out duration-200 focus:outline-none hover:text-ui-fg-base"
        @click="isOpen = true"
      >
        Menu
      </button>
    </div>

    <ClientOnly>
      <USlideover
        v-model:open="isOpen"
        side="left"
        :ui="{ content: 'small:max-w-md w-full' }"
      >
        <template #content>
          <div
            data-testid="nav-menu-popup"
            class="flex flex-col h-full bg-[rgba(3,7,18,0.5)] backdrop-blur-2xl justify-between p-6 text-white"
          >
            <div class="flex justify-end">
              <button
                data-testid="close-menu-button"
                @click="isOpen = false"
              >
                <UIcon
                  name="i-lucide-x"
                  class="w-6 h-6"
                />
              </button>
            </div>
            <ul class="flex flex-col gap-6 items-start justify-start">
              <li
                v-for="item in menuItems"
                :key="item.name"
              >
                <NuxtLink
                  :to="`/${countryCode}${item.href}`"
                  class="text-3xl leading-10 hover:text-ui-fg-disabled"
                  :data-testid="`${item.name.toLowerCase()}-link`"
                  @click="isOpen = false"
                >
                  {{ item.name }}
                </NuxtLink>
              </li>
            </ul>
            <div class="flex flex-col gap-y-6">
              <div
                class="flex justify-between items-center"
              >
                <LayoutCountrySelect @open-change="isCountrySelectOpen = $event" />
                <UIcon
                  v-if="regions?.length"
                  name="i-lucide-arrow-right"
                  :class="['w-5 h-5 transition-transform duration-150', isCountrySelectOpen ? '-rotate-90' : '']"
                />
              </div>
              <p class="flex justify-between txt-compact-small">
                © {{ new Date().getFullYear() }} Medusa Store. All rights reserved.
              </p>
            </div>
          </div>
        </template>
      </USlideover>
    </ClientOnly>
  </div>
</template>
