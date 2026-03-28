<script setup lang="ts">
const route = useRoute()
const countryCode = computed(() => route.params.countryCode as string)
const { regions } = useRegion()

const isOpen = ref(false)

const options = computed(() => {
  if (!regions.value) return []
  return regions.value
    .flatMap((r: any) =>
      (r.countries ?? []).map((c: any) => ({
        country: c.iso_2,
        region: r.id,
        label: c.display_name
      }))
    )
    .sort((a: any, b: any) => (a.label ?? '').localeCompare(b.label ?? ''))
})

interface CountryOption {
  country: string
  region: string
  label: string
}

const current = computed(() => options.value.find((o: CountryOption) => o.country === countryCode.value))

const handleChange = (option: CountryOption) => {
  const currentPath = route.path.split(`/${countryCode.value}`)[1] || ''
  navigateTo(`/${option.country}${currentPath}`)
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
            {{ o.label }}
          </li>
        </ul>
      </Transition>
    </div>
  </div>
</template>
