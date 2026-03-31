const ADDRESS_FIELDS = [
  'first_name',
  'last_name',
  'address_1',
  'company',
  'postal_code',
  'city',
  'country_code',
  'province',
  'phone'
] as const

function pickAddressFields(address: unknown): Record<string, unknown> {
  if (!address || typeof address !== 'object' || Array.isArray(address)) {
    return {}
  }

  const record = address as Record<string, unknown>

  return ADDRESS_FIELDS.reduce<Record<string, unknown>>((picked, field) => {
    if (field in record) {
      picked[field] = record[field]
    }

    return picked
  }, {})
}

export default function compareAddresses(address1: unknown, address2: unknown): boolean {
  const left = pickAddressFields(address1)
  const right = pickAddressFields(address2)
  const leftKeys = Object.keys(left)
  const rightKeys = Object.keys(right)

  if (leftKeys.length !== rightKeys.length) {
    return false
  }

  return leftKeys.every(key => left[key] === right[key])
}
