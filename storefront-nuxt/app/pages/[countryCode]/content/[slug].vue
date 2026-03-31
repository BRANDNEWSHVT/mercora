<script setup lang="ts">
const route = useRoute()
const slug = computed(() => route.params.slug as string)

const pages = {
  'privacy-policy': {
    title: 'Privacy Policy',
    description: 'How Mercora uses and protects your account and order data.',
    sections: [
      {
        heading: 'What we collect',
        body: 'We store the contact, shipping, and order information needed to process purchases and support your account.'
      },
      {
        heading: 'How we use it',
        body: 'Your information is used to fulfill orders, send order updates, and resolve support requests.'
      },
      {
        heading: 'Your choices',
        body: 'You can update your profile information and addresses from your account at any time.'
      }
    ]
  },
  'terms-of-use': {
    title: 'Terms of Use',
    description: 'The basic terms that apply when using the Mercora storefront.',
    sections: [
      {
        heading: 'Orders',
        body: 'Orders are subject to product availability, payment approval, and fulfillment constraints for your region.'
      },
      {
        heading: 'Account responsibility',
        body: 'Keep your account information accurate and protect access to your credentials and order history.'
      },
      {
        heading: 'Support',
        body: 'If something goes wrong with an order, contact customer service so we can review the request.'
      }
    ]
  }
} as const

const page = computed(() => pages[slug.value as keyof typeof pages])

if (!page.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Content page not found'
  })
}

useSeoMeta({
  title: () => page.value?.title || 'Content',
  description: () => page.value?.description || ''
})
</script>

<template>
  <div class="content-container py-12">
    <div class="mx-auto flex max-w-3xl flex-col gap-8 rounded-2xl border border-gray-200 bg-white px-6 py-8 small:px-10">
      <div class="space-y-3">
        <p class="text-sm font-medium uppercase tracking-[0.2em] text-ui-fg-subtle">
          Store policy
        </p>
        <h1 class="text-3xl-semi">
          {{ page.title }}
        </h1>
        <p class="text-base-regular text-ui-fg-subtle">
          {{ page.description }}
        </p>
      </div>

      <div class="space-y-6">
        <section
          v-for="section in page.sections"
          :key="section.heading"
          class="rounded-xl border border-gray-200 px-5 py-4"
        >
          <h2 class="text-large-semi">
            {{ section.heading }}
          </h2>
          <p class="mt-2 text-sm text-ui-fg-subtle">
            {{ section.body }}
          </p>
        </section>
      </div>

      <div class="flex flex-col gap-3 small:flex-row">
        <NuxtLinkLocale to="/customer-service">
          <UButton size="lg">
            Customer service
          </UButton>
        </NuxtLinkLocale>
        <NuxtLinkLocale to="/contact">
          <UButton
            size="lg"
            color="neutral"
            variant="outline"
          >
            Contact support
          </UButton>
        </NuxtLinkLocale>
      </div>
    </div>
  </div>
</template>
