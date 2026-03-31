<template>
  <div class="h-[75vh] w-full border-b border-ui-border-base relative bg-ui-bg-subtle">
    <div class="absolute inset-0 z-10 flex flex-col justify-center items-center text-center small:p-32 gap-6">
      <span>
        <h1 class="text-3xl leading-10 text-ui-fg-base font-normal">
          Ecommerce Starter Template
        </h1>
        <h2 class="text-3xl leading-10 text-ui-fg-subtle font-normal">
          Powered by Medusa, Nuxt, and Vue
        </h2>
      </span>
      <a
        href="https://github.com/medusajs/nextjs-starter-medusa"
        target="_blank"
      >
        <UButton variant="soft">
          View on GitHub
          <UIcon
            name="i-simple-icons-github"
            class="w-4 h-4 ml-2"
          />
        </UButton>
      </a>
    </div>
  </div>
</template>
