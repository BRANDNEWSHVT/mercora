import {
  MedusaRequest,
  MedusaResponse,
} from "@medusajs/framework/http"
import { z } from "zod"
import { PostAdminCreateBrand } from "./validators"
import {
  createBrandWorkflow,
} from "../../../workflows/create-brand"

export const GET = async (
  req: MedusaRequest,
  res: MedusaResponse
) => {
  const query = req.scope.resolve("query")

  const limit = parseInt(req.query.limit as string) || 10
  const offset = parseInt(req.query.offset as string) || 0

  const {
    data: brands,
    metadata: { count, take, skip } = {},
  } = await query.graph({
    entity: "brand",
    fields: ["*", "products.*"],
    pagination: {
      skip: offset,
      take: limit,
    },
  })

  res.json({
    brands,
    count,
    limit: take,
    offset: skip,
  })
}

export const POST = async (
  req: MedusaRequest,
  res: MedusaResponse
) => {
  const validatedBody = PostAdminCreateBrand.safeParse(req.body)

  if (!validatedBody.success) {
    return res.status(400).json({
      errors: validatedBody.error.errors.map((err) => ({
        field: err.path.join("."),
        message: err.message,
      })),
    })
  }

  const { result } = await createBrandWorkflow(req.scope)
    .run({
      input: validatedBody.data,
    })

  res.json({ brand: result })
}
