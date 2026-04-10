interface RequestInit {
  next?: {
    revalidate?: number
    tags?: string[]
  }
}

declare module "next" {
  export type { Metadata } from "vinext/shims/metadata"
}

declare module "next/cache" {
  export * from "vinext/shims/cache"
}

declare module "next/headers" {
  export * from "vinext/shims/headers"
}

declare module "next/image" {
  export { default, getImageProps, imageOptimizationUrl } from "vinext/shims/image"
  export type { ImageProps, StaticImageData } from "vinext/shims/image"
}

declare module "next/link" {
  export { default, useLinkStatus } from "vinext/shims/link"
}

declare module "next/navigation" {
  export * from "vinext/shims/navigation"
}

declare module "next/server" {
  export * from "vinext/shims/server"
}
