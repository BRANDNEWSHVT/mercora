<script setup lang="ts">
import { convertToLocale } from '~/utils/money'
import { getApiErrorMessage } from '~/utils/api-error'

const { cart, applyPromotions } = useCart()

const isOpen = ref(false)
const code = ref('')
const applying = ref(false)
const error = ref('')

type Promotion = {
  id: string
  code?: string | null
  is_automatic?: boolean
  application_method?: {
    type?: string
    value?: number
    currency_code?: string
  } | null
}

const promotions = computed<Promotion[]>(() => {
  return (cart.value?.promotions ?? []) as Promotion[]
})

const promotionCodes = computed(() =>
  promotions.value
    .map(promotion => promotion.code)
    .filter((value): value is string => !!value)
)

async function handleApply() {
  const nextCode = code.value.trim()
  if (!nextCode) {
    return
  }

  applying.value = true
  error.value = ''

  try {
    await applyPromotions([...promotionCodes.value, nextCode])
    code.value = ''
  } catch (nextError: unknown) {
    error.value = getApiErrorMessage(nextError, 'Failed to apply promotion code')
  } finally {
    applying.value = false
  }
}

async function handleRemove(codeToRemove: string) {
  error.value = ''

  try {
    await applyPromotions(promotionCodes.value.filter(code => code !== codeToRemove))
  } catch (nextError: unknown) {
    error.value = getApiErrorMessage(nextError, 'Failed to remove promotion code')
  }
}
</script>

<template>
  <div class="w-full bg-white flex flex-col">
    <div class="txt-medium">
      <form
        class="w-full mb-5"
        @submit.prevent="handleApply"
      >
        <div class="my-2 flex gap-x-1 items-center">
          <button
            type="button"
            class="txt-medium text-ui-fg-interactive hover:text-ui-fg-interactive-hover"
            data-testid="add-discount-button"
            @click="isOpen = !isOpen"
          >
            Add Promotion Code(s)
          </button>
        </div>

        <div v-if="isOpen">
          <div class="flex w-full gap-x-2">
            <input
              id="promotion-input"
              v-model="code"
              class="size-full h-10 rounded-md border border-ui-border-base px-3 text-sm"
              data-testid="discount-input"
              type="text"
            >
            <UButton
              type="submit"
              variant="outline"
              :loading="applying"
              data-testid="discount-apply-button"
            >
              Apply
            </UButton>
          </div>

          <CheckoutErrorMessage
            :error="error"
            data-testid="discount-error-message"
          />
        </div>
      </form>

      <div
        v-if="promotions.length > 0"
        class="w-full flex items-center"
      >
        <div class="flex flex-col w-full">
          <h3 class="txt-medium mb-2">
            Promotion(s) applied:
          </h3>

          <div
            v-for="promotion in promotions"
            :key="promotion.id"
            class="mb-2 flex w-full max-w-full items-center justify-between"
            data-testid="discount-row"
          >
            <p class="txt-small-plus flex w-4/5 items-baseline gap-x-1 pr-1">
              <span
                class="truncate"
                data-testid="discount-code"
              >
                <UBadge
                  :color="promotion.is_automatic ? 'success' : 'neutral'"
                  size="sm"
                >
                  {{ promotion.code }}
                </UBadge>
                (
                <template
                  v-if="promotion.application_method?.value !== undefined && promotion.application_method.currency_code"
                >
                  {{
                    promotion.application_method.type === 'percentage'
                      ? `${promotion.application_method.value}%`
                      : convertToLocale({
                        amount: promotion.application_method.value,
                        currency_code: promotion.application_method.currency_code
                      })
                  }}
                </template>
                )
              </span>
            </p>
            <button
              v-if="!promotion.is_automatic && promotion.code"
              type="button"
              class="flex items-center"
              data-testid="remove-discount-button"
              @click="handleRemove(promotion.code)"
            >
              <UIcon
                name="i-lucide-trash-2"
                class="size-4"
              />
              <span class="sr-only">
                Remove discount code from order
              </span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
