import Link from "next/link"
import { Heading } from "@medusajs/ui"
import React from "react"

type HelpProps = {
  countryCode?: string | null
}

const Help = ({ countryCode }: HelpProps) => {
  const helpHref = countryCode ? `/${countryCode}/contact` : "/contact"

  return (
    <div className="mt-6">
      <Heading className="text-base-semi">Need help?</Heading>
      <div className="text-base-regular my-2">
        <ul className="gap-y-2 flex flex-col">
          <li>
            <Link href={helpHref}>Contact</Link>
          </li>
          <li>
            <Link href={helpHref}>Returns & Exchanges</Link>
          </li>
        </ul>
      </div>
    </div>
  )
}

export default Help
