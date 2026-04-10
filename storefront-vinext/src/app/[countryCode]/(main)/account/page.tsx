import { Metadata } from "next"

import Overview from "@modules/account/components/overview"
import LoginTemplate from "@modules/account/templates/login-template"
import { retrieveCustomer } from "@lib/data/customer"
import { listOrders } from "@lib/data/orders"

export const metadata: Metadata = {
  title: "Account",
  description: "Overview of your account activity.",
}

export default async function AccountPage(props: {
  params: Promise<{ countryCode: string }>
}) {
  const params = await props.params
  const customer = await retrieveCustomer().catch(() => null)

  if (!customer) {
    return <LoginTemplate />
  }

  const orders = (await listOrders().catch(() => null)) || null

  return (
    <Overview
      customer={customer}
      orders={orders}
      countryCode={params.countryCode}
    />
  )
}
