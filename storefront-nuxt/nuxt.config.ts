// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: [
    '@nuxt/eslint',
    '@nuxt/ui',
    '@nuxt/image'
  ],

  devtools: { enabled: true },

  css: ['~/assets/css/main.css'],

  runtimeConfig: {
    medusaBackendUrl: process.env.MEDUSA_BACKEND_URL || 'http://localhost:9000',
    medusaPublishableKey: process.env.NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY || '',
    public: {
      baseUrl: process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000',
      defaultRegion: process.env.NEXT_PUBLIC_DEFAULT_REGION || 'us',
      stripeKey: process.env.NEXT_PUBLIC_STRIPE_KEY || '',
      medusaPublishableKey: process.env.NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY || ''
    }
  },

  routeRules: {
    '/': { redirect: `/${process.env.NEXT_PUBLIC_DEFAULT_REGION || 'us'}` }
  },

  compatibilityDate: '2025-01-15',

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'never',
        braceStyle: '1tbs'
      }
    }
  },

  image: {
    domains: [
      'localhost',
      'medusa-public-images.s3.eu-west-1.amazonaws.com',
      'medusa-server-testing.s3.amazonaws.com',
      'medusa-server-testing.s3.us-east-1.amazonaws.com'
    ]
  }
})
