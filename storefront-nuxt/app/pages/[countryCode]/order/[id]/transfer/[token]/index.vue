<script setup lang="ts">
const route = useRoute()
const orderId = computed(() => route.params.id as string)
const token = computed(() => route.params.token as string)
</script>

<template>
  <div class="flex flex-col gap-y-4 items-start w-2/5 mx-auto mt-10 mb-20">
    <OrderTransferImage />
    <div class="flex flex-col gap-y-6">
      <h1 class="text-xl text-zinc-900">
        Transfer request for order {{ orderId }}
      </h1>
      <p class="text-zinc-600">
        You've received a request to transfer ownership of your order ({{ orderId }}).
        If you agree to this request, you can approve the transfer by clicking
        the button below.
      </p>
      <div class="w-full h-px bg-zinc-200" />
      <p class="text-zinc-600">
        If you accept, the new owner will take over all responsibilities and
        permissions associated with this order.
      </p>
      <p class="text-zinc-600">
        If you do not recognize this request or wish to retain ownership, no
        further action is required.
      </p>
      <div class="w-full h-px bg-zinc-200" />
      <div class="flex gap-x-4">
        <NuxtLink :to="`/${route.params.countryCode}/order/${orderId}/transfer/${token}/accept`">
          <UButton>Accept Transfer</UButton>
        </NuxtLink>
        <NuxtLink :to="`/${route.params.countryCode}/order/${orderId}/transfer/${token}/decline`">
          <UButton variant="outline">
            Decline Transfer
          </UButton>
        </NuxtLink>
      </div>
    </div>
  </div>
</template>
