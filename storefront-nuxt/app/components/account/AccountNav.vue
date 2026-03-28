<script setup lang="ts">
const { customer, logout } = useCustomer()
const route = useRoute()
const countryCode = useCountryCode()

const isOnAccountRoot = computed(() => {
  return route.path === `/${countryCode.value}/account` || route.path === `/${countryCode.value}/account/`
})

interface NavItem {
  label: string
  to: string
  icon: string
}

const navItems: NavItem[] = [
  { label: 'Profile', to: '/account', icon: 'lucide:user' },
  { label: 'Addresses', to: '/account/addresses', icon: 'lucide:map-pin' },
  { label: 'Orders', to: '/account/orders', icon: 'lucide:shopping-bag' }
]

function isActive(itemTo: string) {
  const fullPath = `/${countryCode.value}${itemTo}`
  if (itemTo === '/account') {
    return route.path === fullPath || route.path === `${fullPath}/`
  }
  return route.path.startsWith(fullPath)
}

async function handleLogout() {
  await logout(countryCode.value)
}
</script>

<template>
  <div>
    <!-- Mobile -->
    <div class="small:hidden">
      <div v-if="!isOnAccountRoot">
        <NuxtLink
          :to="`/${countryCode}/account`"
          class="flex items-center gap-x-2 text-small-regular py-2"
        >
          <UIcon
            name="lucide:chevron-left"
            class="size-4"
          />
          <span>Account</span>
        </NuxtLink>
      </div>
      <div v-else>
        <div class="text-xl-semi mb-4 px-8">
          Hello {{ customer?.first_name || 'there' }}
        </div>
        <div class="text-base-regular">
          <ul>
            <li
              v-for="item in navItems"
              :key="item.to"
            >
              <NuxtLink
                :to="`/${countryCode}${item.to}`"
                class="flex items-center justify-between border-b border-gray-200 py-4 px-8"
              >
                <div class="flex items-center gap-x-2">
                  <UIcon
                    :name="item.icon"
                    class="size-5"
                  />
                  <span>{{ item.label }}</span>
                </div>
                <UIcon
                  name="lucide:chevron-right"
                  class="size-4"
                />
              </NuxtLink>
            </li>
            <li>
              <button
                class="flex items-center justify-between border-b border-gray-200 py-4 px-8 w-full"
                @click="handleLogout"
              >
                <div class="flex items-center gap-x-2">
                  <UIcon
                    name="lucide:log-out"
                    class="size-5"
                  />
                  <span>Log out</span>
                </div>
                <UIcon
                  name="lucide:chevron-right"
                  class="size-4"
                />
              </button>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Desktop -->
    <div class="hidden small:block" data-testid="account-nav">
      <div>
        <div class="pb-4">
          <h3 class="text-base-semi">Account</h3>
        </div>
        <div class="text-base-regular">
          <ul class="flex mb-0 justify-start items-start flex-col gap-y-4">
            <li>
              <NuxtLink
                :to="`/${countryCode}/account`"
                class="hover:text-ui-fg-base"
                :class="isActive('/account') ? 'text-ui-fg-base font-semibold' : 'text-ui-fg-subtle'"
                data-testid="overview-link"
              >
                Overview
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                :to="`/${countryCode}/account/profile`"
                class="hover:text-ui-fg-base"
                :class="isActive('/account/profile') ? 'text-ui-fg-base font-semibold' : 'text-ui-fg-subtle'"
                data-testid="profile-link"
              >
                Profile
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                :to="`/${countryCode}/account/addresses`"
                class="hover:text-ui-fg-base"
                :class="isActive('/account/addresses') ? 'text-ui-fg-base font-semibold' : 'text-ui-fg-subtle'"
                data-testid="addresses-link"
              >
                Addresses
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                :to="`/${countryCode}/account/orders`"
                class="hover:text-ui-fg-base"
                :class="isActive('/account/orders') ? 'text-ui-fg-base font-semibold' : 'text-ui-fg-subtle'"
                data-testid="orders-link"
              >
                Orders
              </NuxtLink>
            </li>
            <li class="text-grey-700">
              <button
                type="button"
                data-testid="logout-button"
                @click="handleLogout"
              >
                Log out
              </button>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>
