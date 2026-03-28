function isEmpty(value: unknown): boolean {
  return value === undefined || value === null || value === ''
}

type ConvertToLocaleParams = {
  amount: number
  currency_code: string
  minimumFractionDigits?: number
  maximumFractionDigits?: number
  locale?: string
}

export function convertToLocale({
  amount,
  currency_code,
  minimumFractionDigits,
  maximumFractionDigits,
  locale = 'en-US'
}: ConvertToLocaleParams): string {
  return currency_code && !isEmpty(currency_code)
    ? new Intl.NumberFormat(locale, {
        style: 'currency',
        currency: currency_code,
        minimumFractionDigits,
        maximumFractionDigits
      }).format(amount)
    : amount.toString()
}
