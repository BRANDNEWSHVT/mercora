import { getBaseURL } from "@lib/util/env"
import { Metadata } from "next"
import { Outfit } from "next/font/google"
import "styles/globals.css"

const outfit = Outfit({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-sans",
})

export const metadata: Metadata = {
  metadataBase: new URL(getBaseURL()),
}

export default function RootLayout(props: { children: React.ReactNode }) {
  return (
    <html lang="en" data-mode="light" className={outfit.variable}>
      <body className="bg-ui-bg-base text-ui-fg-base font-sans antialiased">
        <main className="relative">{props.children}</main>
      </body>
    </html>
  )
}
