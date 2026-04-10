"use client"

import Link from "next/link"
import { useParams } from "next/navigation"
import React from "react"

/**
 * Use this component to create a localized `<Link />` that persists the current country code in the url,
 * without having to explicitly pass it as a prop.
 */
const LocalizedClientLink = ({
  children,
  href,
  countryCode: explicitCountryCode,
  ...props
}: {
  children?: React.ReactNode
  href: string
  countryCode?: string
  className?: string
  onClick?: () => void
  passHref?: true
  [x: string]: any
}) => {
  const params = useParams()
  const browserCountryCode =
    typeof window !== "undefined"
      ? window.location.pathname.split("/").filter(Boolean)[0]
      : undefined
  const countryCode =
    typeof explicitCountryCode === "string"
      ? explicitCountryCode
      : typeof params?.countryCode === "string"
        ? params.countryCode
        : browserCountryCode

  const normalizedHref = href.startsWith("/") ? href : `/${href}`
  const localizedHref = countryCode
    ? `/${countryCode}${normalizedHref === "/" ? "" : normalizedHref}`
    : normalizedHref

  return (
    <Link href={localizedHref} {...props}>
      {children}
    </Link>
  )
}

export default LocalizedClientLink
