<script setup lang="ts">
import type { HttpTypes } from '@medusajs/types'

interface CountryOption {
  country: string
  region: string
  label: string
}

const emit = defineEmits<{
  (e: 'openChange', value: boolean): void
}>()

const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { regions, fetchRegions, getRegion } = useRegion()
const { cart, fetchCart, updateCart } = useCart()

const isOpen = ref(false)

const options = computed<CountryOption[]>(() => {
  if (!regions.value) return []
  return regions.value
    .flatMap((r: HttpTypes.StoreRegion) =>
      (r.countries ?? []).map(c => ({
        country: c.iso_2,
        region: r.id,
        label: c.display_name
      }))
    )
    .filter((option): option is CountryOption => Boolean(option.country && option.label))
    .sort((a, b) => (a.label ?? '').localeCompare(b.label ?? ''))
})

const current = computed(() => options.value.find((o: CountryOption) => o.country === countryCode.value))

watch(isOpen, (value) => {
  emit('openChange', value)
})

onMounted(async () => {
  if (!regions.value.length) {
    await fetchRegions()
  }
})

const flagEmoji = (value: string) => {
  return value
    .toUpperCase()
    .replace(/./g, char => String.fromCodePoint(127397 + char.charCodeAt(0)))
}

const handleChange = async (option: CountryOption) => {
  const currentPrefix = `/${countryCode.value}`
  const currentPath = route.fullPath.startsWith(currentPrefix)
    ? route.fullPath.slice(currentPrefix.length)
    : route.fullPath
  const existingCart = cart.value ?? await fetchCart()
  const nextRegion = await getRegion(option.country)

  if (existingCart?.id && nextRegion?.id) {
    await updateCart({ region_id: nextRegion.id })
  }

  navigateTo(`/${option.country}${currentPath || ''}`)
  isOpen.value = false
}
</script>

<template>
  <div>
    <button
      class="py-1 w-full"
      @click="isOpen = !isOpen"
    >
      <div class="txt-compact-small flex items-start gap-x-2">
        <span>Shipping to:</span>
        <span
          v-if="current"
          class="txt-compact-small flex items-center gap-x-2"
        >
          <span>{{ flagEmoji(current.country) }}</span>
          {{ current.label }}
        </span>
      </div>
    </button>
    <div class="flex relative w-full min-w-[320px]">
      <Transition
        leave-active-class="transition ease-in duration-150"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <ul
          v-if="isOpen"
          class="absolute -bottom-[calc(100%-36px)] left-0 xsmall:left-auto xsmall:right-0 max-h-[442px] overflow-y-scroll z-[900] bg-white drop-shadow-md text-small-regular uppercase text-black no-scrollbar rounded-rounded w-full"
        >
          <li
            v-for="o in options"
            :key="o.country"
            class="py-2 hover:bg-gray-200 px-3 cursor-pointer flex items-center gap-x-2"
            @click="handleChange(o)"
          >
            <span>{{ flagEmoji(o.country) }}</span>
            {{ o.label }}
          </li>
        </ul>
      </Transition>
    </div>
  </div>
</template>
