<script setup lang="ts">
const { customer } = useCustomer()

const currentView = ref<'sign-in' | 'register'>('sign-in')
</script>

<template>
  <div
    class="flex-1 small:py-12"
    data-testid="account-page"
  >
    <div
      class="flex-1 content-container h-full max-w-5xl mx-auto bg-white flex flex-col"
    >
      <template v-if="customer">
        <div class="grid grid-cols-1 small:grid-cols-[240px_1fr] py-12">
          <div>
            <AccountNav />
          </div>
          <div class="flex-1">
            <NuxtPage />
          </div>
        </div>
      </template>
      <template v-else>
        <div class="w-full flex justify-center px-8 py-8">
          <AccountLogin
            v-if="currentView === 'sign-in'"
            @switch-view="currentView = 'register'"
          />
          <AccountRegister
            v-else
            @switch-view="currentView = 'sign-in'"
          />
        </div>
      </template>
      <div
        class="flex flex-col small:flex-row items-end justify-between small:border-t border-gray-200 py-12 gap-8"
      >
        <div>
          <h3 class="text-xl-semi mb-4">
            Got questions?
          </h3>
          <span class="txt-medium">
            You can find frequently asked questions and answers on our customer
            service page.
          </span>
        </div>
        <div>
          <CommonInteractiveLink href="/customer-service">
            Customer Service
          </CommonInteractiveLink>
        </div>
      </div>
    </div>
  </div>
</template>
