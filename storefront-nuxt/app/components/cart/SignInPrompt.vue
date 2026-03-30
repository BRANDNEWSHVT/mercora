<template>
  <div class="flex items-center justify-between gap-6 bg-white">
    <div>
      <h2 class="txt-xlarge text-ui-fg-base">
        Already have an account?
      </h2>
      <p class="txt-medium text-ui-fg-subtle mt-2">
        Sign in for a better experience.
      </p>
    </div>
    <NuxtLinkLocale to="/account">
      <button
        type="button"
        class="inline-flex h-10 items-center justify-center rounded-md border border-ui-border-base px-4 text-sm font-medium text-ui-fg-base transition-colors hover:bg-ui-bg-subtle"
        data-testid="sign-in-button"
      >
        Sign in
      </button>
    </NuxtLinkLocale>
  </div>
</template>
