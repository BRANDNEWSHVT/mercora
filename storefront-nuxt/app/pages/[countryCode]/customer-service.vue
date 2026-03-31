<script setup lang="ts">
useSeoMeta({
  title: 'Customer Service',
  description: 'Answers for shipping, returns, exchanges, and account support.'
})
</script>

<template>
  <div class="content-container py-12">
    <div class="mx-auto flex max-w-4xl flex-col gap-8 rounded-2xl border border-gray-200 bg-white px-6 py-8 small:px-10">
      <div class="space-y-3">
        <p class="text-sm font-medium uppercase tracking-[0.2em] text-ui-fg-subtle">
          Help center
        </p>
        <h1 class="text-3xl-semi">
          Customer service
        </h1>
        <p class="text-base-regular text-ui-fg-subtle">
          Find the quickest path for shipping questions, return requests, and account issues.
        </p>
      </div>

      <div class="grid gap-4 small:grid-cols-3">
        <div class="rounded-xl border border-gray-200 px-5 py-4">
          <h2 class="text-large-semi">
            Shipping
          </h2>
          <p class="mt-2 text-sm text-ui-fg-subtle">
            Review your delivery status in your account order history.
          </p>
        </div>
        <div class="rounded-xl border border-gray-200 px-5 py-4">
          <h2 class="text-large-semi">
            Returns
          </h2>
          <p class="mt-2 text-sm text-ui-fg-subtle">
            Contact support with the order number and item details for next steps.
          </p>
        </div>
        <div class="rounded-xl border border-gray-200 px-5 py-4">
          <h2 class="text-large-semi">
            Account
          </h2>
          <p class="mt-2 text-sm text-ui-fg-subtle">
            Update profile, addresses, and order ownership from your account area.
          </p>
        </div>
      </div>

      <div class="flex flex-col gap-3 small:flex-row">
        <NuxtLinkLocale to="/contact">
          <UButton size="lg">
            Contact support
          </UButton>
        </NuxtLinkLocale>
        <NuxtLinkLocale to="/account">
          <UButton
            size="lg"
            color="neutral"
            variant="outline"
          >
            Go to account
          </UButton>
        </NuxtLinkLocale>
      </div>
    </div>
  </div>
</template>
