<script setup lang="ts">
const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
</script>

<template>
  <div class="sticky top-0 inset-x-0 z-50 group">
    <header class="relative h-16 mx-auto border-b duration-200 bg-white border-ui-border-base">
      <nav class="content-container txt-xsmall-plus text-ui-fg-subtle flex items-center justify-between w-full h-full text-small-regular">
        <div class="flex-1 basis-0 h-full flex items-center">
          <div class="h-full">
            <LayoutSideMenu />
          </div>
        </div>

        <div class="flex items-center h-full">
          <NuxtLink
            :to="`/${countryCode}`"
            class="txt-compact-xlarge-plus hover:text-ui-fg-base uppercase"
            data-testid="nav-store-link"
          >
            Medusa Store
          </NuxtLink>
        </div>

        <div class="flex items-center gap-x-6 h-full flex-1 basis-0 justify-end">
          <div class="hidden small:flex items-center gap-x-6 h-full">
            <NuxtLink
              class="hover:text-ui-fg-base"
              :to="`/${countryCode}/account`"
              data-testid="nav-account-link"
            >
              Account
            </NuxtLink>
          </div>
          <LayoutCartDropdown />
        </div>
      </nav>
    </header>
  </div>
</template>
