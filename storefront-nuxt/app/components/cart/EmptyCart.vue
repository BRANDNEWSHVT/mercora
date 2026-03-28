<script setup lang="ts">
</script>

<template>
  <div
    class="flex flex-col justify-center items-start py-48 px-2"
    data-testid="empty-cart-message"
  >
    <h1 class="flex flex-row text-3xl-regular gap-x-2 items-baseline">
      Cart
    </h1>
    <p class="text-base-regular mt-4 mb-6 max-w-lg">
      You don't have anything in your cart. Let's change that, use the link
      below to start browsing our products.
    </p>
    <CommonInteractiveLink href="/store">
      Explore products
    </CommonInteractiveLink>
  </div>
</template>
