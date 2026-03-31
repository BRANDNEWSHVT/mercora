<script setup lang="ts">
useSeoMeta({
  title: 'Contact',
  description: 'Get in touch with the Mercora support team.'
})
</script>

<template>
  <div class="content-container py-12">
    <div class="mx-auto flex max-w-3xl flex-col gap-8 rounded-2xl border border-gray-200 bg-white px-6 py-8 small:px-10">
      <div class="space-y-3">
        <p class="text-sm font-medium uppercase tracking-[0.2em] text-ui-fg-subtle">
          Support
        </p>
        <h1 class="text-3xl-semi">
          Contact us
        </h1>
        <p class="text-base-regular text-ui-fg-subtle">
          Need help with an order, delivery, or return? Reach out and we will point you in the right direction.
        </p>
      </div>

      <div class="grid gap-4 small:grid-cols-2">
        <div class="rounded-xl border border-gray-200 px-5 py-4">
          <h2 class="text-large-semi">
            Email
          </h2>
          <p class="mt-2 text-sm text-ui-fg-subtle">
            support@mercora.local
          </p>
        </div>
        <div class="rounded-xl border border-gray-200 px-5 py-4">
          <h2 class="text-large-semi">
            Response time
          </h2>
          <p class="mt-2 text-sm text-ui-fg-subtle">
            Usually within one business day.
          </p>
        </div>
      </div>

      <div class="rounded-xl border border-gray-200 bg-gray-50 px-5 py-4">
        <h2 class="text-large-semi">
          Returns and exchanges
        </h2>
        <p class="mt-2 text-sm text-ui-fg-subtle">
          Include your order number and the item details so we can help faster.
        </p>
      </div>

      <div class="flex flex-col gap-3 small:flex-row">
        <NuxtLinkLocale to="/customer-service">
          <UButton size="lg">
            Visit customer service
          </UButton>
        </NuxtLinkLocale>
        <NuxtLinkLocale to="/account/orders">
          <UButton
            size="lg"
            color="neutral"
            variant="outline"
          >
            View your orders
          </UButton>
        </NuxtLinkLocale>
      </div>
    </div>
  </div>
</template>
