const ADDRESS_FIELDS = [
  'first_name',
  'last_name',
  'address_1',
  'company',
  'postal_code',
  'city',
  'country_code',
  'province',
  'phone',
] as const

export default function compareAddresses(address1: any, address2: any): boolean {
  if (!address1 || !address2) return false

  return ADDRESS_FIELDS.every(
    (field) => (address1[field] ?? '') === (address2[field] ?? '')
  )
}
