/*
 Navicat Premium Dump SQL

 Source Server         : Docker
 Source Server Type    : PostgreSQL
 Source Server Version : 120022 (120022)
 Source Host           : localhost:5432
 Source Catalog        : medusa_devmerch
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120022 (120022)
 File Encoding         : 65001

 Date: 29/08/2025 17:07:33
*/


-- ----------------------------
-- Type structure for claim_reason_enum
-- ----------------------------
DROP TYPE IF EXISTS "public"."claim_reason_enum";
CREATE TYPE "public"."claim_reason_enum" AS ENUM (
  'missing_item',
  'wrong_item',
  'production_failure',
  'other'
);
ALTER TYPE "public"."claim_reason_enum" OWNER TO "postgres";

-- ----------------------------
-- Type structure for order_claim_type_enum
-- ----------------------------
DROP TYPE IF EXISTS "public"."order_claim_type_enum";
CREATE TYPE "public"."order_claim_type_enum" AS ENUM (
  'refund',
  'replace'
);
ALTER TYPE "public"."order_claim_type_enum" OWNER TO "postgres";

-- ----------------------------
-- Type structure for order_status_enum
-- ----------------------------
DROP TYPE IF EXISTS "public"."order_status_enum";
CREATE TYPE "public"."order_status_enum" AS ENUM (
  'pending',
  'completed',
  'draft',
  'archived',
  'canceled',
  'requires_action'
);
ALTER TYPE "public"."order_status_enum" OWNER TO "postgres";

-- ----------------------------
-- Type structure for return_status_enum
-- ----------------------------
DROP TYPE IF EXISTS "public"."return_status_enum";
CREATE TYPE "public"."return_status_enum" AS ENUM (
  'open',
  'requested',
  'received',
  'partially_received',
  'canceled'
);
ALTER TYPE "public"."return_status_enum" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for link_module_migrations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."link_module_migrations_id_seq";
CREATE SEQUENCE "public"."link_module_migrations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."link_module_migrations_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for mikro_orm_migrations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."mikro_orm_migrations_id_seq";
CREATE SEQUENCE "public"."mikro_orm_migrations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."mikro_orm_migrations_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for order_change_action_ordering_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."order_change_action_ordering_seq";
CREATE SEQUENCE "public"."order_change_action_ordering_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."order_change_action_ordering_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for order_claim_display_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."order_claim_display_id_seq";
CREATE SEQUENCE "public"."order_claim_display_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."order_claim_display_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for order_display_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."order_display_id_seq";
CREATE SEQUENCE "public"."order_display_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."order_display_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for order_exchange_display_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."order_exchange_display_id_seq";
CREATE SEQUENCE "public"."order_exchange_display_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."order_exchange_display_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for return_display_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."return_display_id_seq";
CREATE SEQUENCE "public"."return_display_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."return_display_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for script_migrations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."script_migrations_id_seq";
CREATE SEQUENCE "public"."script_migrations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."script_migrations_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Table structure for account_holder
-- ----------------------------
DROP TABLE IF EXISTS "public"."account_holder";
CREATE TABLE "public"."account_holder" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "external_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "email" text COLLATE "pg_catalog"."default",
  "data" jsonb NOT NULL DEFAULT '{}'::jsonb,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."account_holder" OWNER TO "postgres";

-- ----------------------------
-- Records of account_holder
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for api_key
-- ----------------------------
DROP TABLE IF EXISTS "public"."api_key";
CREATE TABLE "public"."api_key" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "token" text COLLATE "pg_catalog"."default" NOT NULL,
  "salt" text COLLATE "pg_catalog"."default" NOT NULL,
  "redacted" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "last_used_at" timestamptz(6),
  "created_by" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "revoked_by" text COLLATE "pg_catalog"."default",
  "revoked_at" timestamptz(6),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."api_key" OWNER TO "postgres";

-- ----------------------------
-- Records of api_key
-- ----------------------------
BEGIN;
INSERT INTO "public"."api_key" ("id", "token", "salt", "redacted", "title", "type", "last_used_at", "created_by", "created_at", "revoked_by", "revoked_at", "updated_at", "deleted_at") VALUES ('apk_01K0DQNR524GW4VFN0CYPT9DHB', 'pk_fd557f02f0e90969cff1644a00d57beb5101e31a084ad0ce919c2c8a4f0322c2', '', 'pk_fd5***2c2', 'Webshop', 'publishable', NULL, '', '2025-07-18 03:01:34.498+00', NULL, NULL, '2025-07-18 03:01:34.498+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for application_method_buy_rules
-- ----------------------------
DROP TABLE IF EXISTS "public"."application_method_buy_rules";
CREATE TABLE "public"."application_method_buy_rules" (
  "application_method_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "promotion_rule_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."application_method_buy_rules" OWNER TO "postgres";

-- ----------------------------
-- Records of application_method_buy_rules
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for application_method_target_rules
-- ----------------------------
DROP TABLE IF EXISTS "public"."application_method_target_rules";
CREATE TABLE "public"."application_method_target_rules" (
  "application_method_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "promotion_rule_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."application_method_target_rules" OWNER TO "postgres";

-- ----------------------------
-- Records of application_method_target_rules
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_identity
-- ----------------------------
DROP TABLE IF EXISTS "public"."auth_identity";
CREATE TABLE "public"."auth_identity" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "app_metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."auth_identity" OWNER TO "postgres";

-- ----------------------------
-- Records of auth_identity
-- ----------------------------
BEGIN;
INSERT INTO "public"."auth_identity" ("id", "app_metadata", "created_at", "updated_at", "deleted_at") VALUES ('authid_01K0DQTQBAP2VATK818YG970GH', '{"user_id": "user_01K0DQTQ8DKZ8PHEZFREPTS5SN"}', '2025-07-18 03:04:17.514+00', '2025-07-18 03:04:17.527+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS "public"."brand";
CREATE TABLE "public"."brand" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."brand" OWNER TO "postgres";

-- ----------------------------
-- Records of brand
-- ----------------------------
BEGIN;
INSERT INTO "public"."brand" ("id", "name", "created_at", "updated_at", "deleted_at") VALUES ('01K3T7N63AW9QF91WMV43FZXK1', 'Acme', '2025-08-29 06:18:51.882+00', '2025-08-29 06:18:51.882+00', NULL);
INSERT INTO "public"."brand" ("id", "name", "created_at", "updated_at", "deleted_at") VALUES ('01K3TH0WAM0MJGT97J3JZ95KFT', 'Medusa', '2025-08-29 09:02:32.277+00', '2025-08-29 09:02:32.277+00', NULL);
INSERT INTO "public"."brand" ("id", "name", "created_at", "updated_at", "deleted_at") VALUES ('01K3TMD83E17DRCEGZ4676YD7B', 'Torch', '2025-08-29 10:01:43.279+00', '2025-08-29 10:01:43.279+00', NULL);
INSERT INTO "public"."brand" ("id", "name", "created_at", "updated_at", "deleted_at") VALUES ('01K3TMES12SJBAHXKST7MNFFCR', 'Consina', '2025-08-29 10:02:33.378+00', '2025-08-29 10:02:33.378+00', NULL);
INSERT INTO "public"."brand" ("id", "name", "created_at", "updated_at", "deleted_at") VALUES ('01K3TMG2DWSQVPSE3RSQKFY9XN', 'The North Face', '2025-08-29 10:03:15.772+00', '2025-08-29 10:03:15.772+00', NULL);
INSERT INTO "public"."brand" ("id", "name", "created_at", "updated_at", "deleted_at") VALUES ('01K3TMH1D7M1KMTWCY904F4KE4', 'Eiger', '2025-08-29 10:03:47.495+00', '2025-08-29 10:03:47.495+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for capture
-- ----------------------------
DROP TABLE IF EXISTS "public"."capture";
CREATE TABLE "public"."capture" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "payment_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "created_by" text COLLATE "pg_catalog"."default",
  "metadata" jsonb
)
;
ALTER TABLE "public"."capture" OWNER TO "postgres";

-- ----------------------------
-- Records of capture
-- ----------------------------
BEGIN;
INSERT INTO "public"."capture" ("id", "amount", "raw_amount", "payment_id", "created_at", "updated_at", "deleted_at", "created_by", "metadata") VALUES ('capt_01K38B6YBD1DZ246KFY5R70NQZ', 290000, '{"value": "290000", "precision": 20}', 'pay_01K38B666YHMYFNN1XNB33B719', '2025-08-22 07:34:39.725+00', '2025-08-22 07:34:39.725+00', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart";
CREATE TABLE "public"."cart" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "region_id" text COLLATE "pg_catalog"."default",
  "customer_id" text COLLATE "pg_catalog"."default",
  "sales_channel_id" text COLLATE "pg_catalog"."default",
  "email" text COLLATE "pg_catalog"."default",
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "shipping_address_id" text COLLATE "pg_catalog"."default",
  "billing_address_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "completed_at" timestamptz(6)
)
;
ALTER TABLE "public"."cart" OWNER TO "postgres";

-- ----------------------------
-- Records of cart
-- ----------------------------
BEGIN;
INSERT INTO "public"."cart" ("id", "region_id", "customer_id", "sales_channel_id", "email", "currency_code", "shipping_address_id", "billing_address_id", "metadata", "created_at", "updated_at", "deleted_at", "completed_at") VALUES ('cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'reg_01K33FFDX0M838JWM069761552', 'cus_01K38AJPD0KBWRW4Y2EHBQWFW4', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'alrocha@gmail.com', 'idr', 'caaddr_01K38AJWQ93BNJWGYPYHQWS89M', 'caaddr_01K38AJWQ9AG394J43MNSJ4BG0', NULL, '2025-08-20 09:27:27.574+00', '2025-08-22 07:34:14.957+00', NULL, '2025-08-22 07:34:14.935+00');
COMMIT;

-- ----------------------------
-- Table structure for cart_address
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_address";
CREATE TABLE "public"."cart_address" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "customer_id" text COLLATE "pg_catalog"."default",
  "company" text COLLATE "pg_catalog"."default",
  "first_name" text COLLATE "pg_catalog"."default",
  "last_name" text COLLATE "pg_catalog"."default",
  "address_1" text COLLATE "pg_catalog"."default",
  "address_2" text COLLATE "pg_catalog"."default",
  "city" text COLLATE "pg_catalog"."default",
  "country_code" text COLLATE "pg_catalog"."default",
  "province" text COLLATE "pg_catalog"."default",
  "postal_code" text COLLATE "pg_catalog"."default",
  "phone" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."cart_address" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_address
-- ----------------------------
BEGIN;
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K33FVJNYXKH1DEB6S3A1BN62', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'id', NULL, NULL, NULL, NULL, '2025-08-20 10:19:38.047+00', '2025-08-20 10:19:38.047+00', NULL);
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K33GCGFSM78FDE806XS177BD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'id', NULL, NULL, NULL, NULL, '2025-08-20 10:28:52.857+00', '2025-08-20 10:28:52.857+00', NULL);
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K33GJ9GE1QQWYKY2BPS90HSM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'us', NULL, NULL, NULL, NULL, '2025-08-20 10:32:02.318+00', '2025-08-20 10:32:02.318+00', NULL);
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K38AHEFVX8MX125BPV2KJRMG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'id', NULL, NULL, NULL, NULL, '2025-08-22 07:22:55.356+00', '2025-08-22 07:22:55.356+00', NULL);
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K38AJPDMAH73FAGG7X6CZMRE', NULL, '', 'Al Rocha', 'Cabrerra', 'Jl. Simponi No. 21', '', 'Bandung', 'id', 'Jawa Barat', '40264', '', NULL, '2025-08-22 07:23:36.244+00', '2025-08-22 07:23:36.244+00', NULL);
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K38AJPDMTE5FX0JCZ4P9G5H1', NULL, '', 'Al Rocha', 'Cabrerra', 'Jl. Simponi No. 21', '', 'Bandung', 'id', 'Jawa Barat', '40264', '', NULL, '2025-08-22 07:23:36.244+00', '2025-08-22 07:23:36.244+00', NULL);
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K38AJWQ9AG394J43MNSJ4BG0', NULL, '', 'Al Rocha', 'Cabrerra', 'Jl. Simponi No. 21', '', 'Bandung', 'id', 'Jawa Barat', '40264', '', NULL, '2025-08-22 07:23:42.697+00', '2025-08-22 07:23:42.697+00', NULL);
INSERT INTO "public"."cart_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('caaddr_01K38AJWQ93BNJWGYPYHQWS89M', NULL, '', 'Al Rocha', 'Cabrerra', 'Jl. Simponi No. 21', '', 'Bandung', 'id', 'Jawa Barat', '40264', '', NULL, '2025-08-22 07:23:42.697+00', '2025-08-22 07:23:42.697+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for cart_line_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_line_item";
CREATE TABLE "public"."cart_line_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "cart_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "subtitle" text COLLATE "pg_catalog"."default",
  "thumbnail" text COLLATE "pg_catalog"."default",
  "quantity" int4 NOT NULL,
  "variant_id" text COLLATE "pg_catalog"."default",
  "product_id" text COLLATE "pg_catalog"."default",
  "product_title" text COLLATE "pg_catalog"."default",
  "product_description" text COLLATE "pg_catalog"."default",
  "product_subtitle" text COLLATE "pg_catalog"."default",
  "product_type" text COLLATE "pg_catalog"."default",
  "product_collection" text COLLATE "pg_catalog"."default",
  "product_handle" text COLLATE "pg_catalog"."default",
  "variant_sku" text COLLATE "pg_catalog"."default",
  "variant_barcode" text COLLATE "pg_catalog"."default",
  "variant_title" text COLLATE "pg_catalog"."default",
  "variant_option_values" jsonb,
  "requires_shipping" bool NOT NULL DEFAULT true,
  "is_discountable" bool NOT NULL DEFAULT true,
  "is_tax_inclusive" bool NOT NULL DEFAULT false,
  "compare_at_unit_price" numeric,
  "raw_compare_at_unit_price" jsonb,
  "unit_price" numeric NOT NULL,
  "raw_unit_price" jsonb NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "product_type_id" text COLLATE "pg_catalog"."default",
  "is_custom_price" bool NOT NULL DEFAULT false,
  "is_giftcard" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "public"."cart_line_item" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_line_item
-- ----------------------------
BEGIN;
INSERT INTO "public"."cart_line_item" ("id", "cart_id", "title", "subtitle", "thumbnail", "quantity", "variant_id", "product_id", "product_title", "product_description", "product_subtitle", "product_type", "product_collection", "product_handle", "variant_sku", "variant_barcode", "variant_title", "variant_option_values", "requires_shipping", "is_discountable", "is_tax_inclusive", "compare_at_unit_price", "raw_compare_at_unit_price", "unit_price", "raw_unit_price", "metadata", "created_at", "updated_at", "deleted_at", "product_type_id", "is_custom_price", "is_giftcard") VALUES ('cali_01K33CW1RG825MP86Q28ZCA8K8', 'cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'Medusa Sweatshirt', 'S', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png', 1, 'variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'prod_01K0DQNR60DXF0084R3YNQHSXJ', 'Medusa Sweatshirt', 'Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.', NULL, NULL, NULL, 'sweatshirt', 'SWEATSHIRT-S', NULL, 'S', NULL, 't', 't', 'f', NULL, NULL, 10, '{"value": "10", "precision": 20}', '{}', '2025-08-20 09:27:27.76+00', '2025-08-20 09:27:40.999+00', '2025-08-20 09:27:40.998+00', NULL, 'f', 'f');
INSERT INTO "public"."cart_line_item" ("id", "cart_id", "title", "subtitle", "thumbnail", "quantity", "variant_id", "product_id", "product_title", "product_description", "product_subtitle", "product_type", "product_collection", "product_handle", "variant_sku", "variant_barcode", "variant_title", "variant_option_values", "requires_shipping", "is_discountable", "is_tax_inclusive", "compare_at_unit_price", "raw_compare_at_unit_price", "unit_price", "raw_unit_price", "metadata", "created_at", "updated_at", "deleted_at", "product_type_id", "is_custom_price", "is_giftcard") VALUES ('cali_01K33GF460RP1302PQESS09SJW', 'cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'Medusa T-Shirt', 'M / Black', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png', 1, 'variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT', 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', 'Medusa T-Shirt', 'Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.', NULL, NULL, NULL, 't-shirt', 'SHIRT-M-BLACK', NULL, 'M / Black', NULL, 't', 't', 'f', NULL, NULL, 15, '{"value": "15", "precision": 20}', '{}', '2025-08-20 10:30:18.56+00', '2025-08-20 10:33:29.693+00', '2025-08-20 10:33:29.693+00', NULL, 'f', 'f');
INSERT INTO "public"."cart_line_item" ("id", "cart_id", "title", "subtitle", "thumbnail", "quantity", "variant_id", "product_id", "product_title", "product_description", "product_subtitle", "product_type", "product_collection", "product_handle", "variant_sku", "variant_barcode", "variant_title", "variant_option_values", "requires_shipping", "is_discountable", "is_tax_inclusive", "compare_at_unit_price", "raw_compare_at_unit_price", "unit_price", "raw_unit_price", "metadata", "created_at", "updated_at", "deleted_at", "product_type_id", "is_custom_price", "is_giftcard") VALUES ('cali_01K33EWQD7JBQ19VJB49B13JDN', 'cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'Medusa Sweatshirt', 'S', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png', 1, 'variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'prod_01K0DQNR60DXF0084R3YNQHSXJ', 'Medusa Sweatshirt', 'Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.', NULL, NULL, NULL, 'sweatshirt', 'SWEATSHIRT-S', NULL, 'S', NULL, 't', 't', 'f', NULL, NULL, 15, '{"value": "15", "precision": 20}', '{}', '2025-08-20 10:02:47.079+00', '2025-08-20 10:33:30.582+00', '2025-08-20 10:33:30.581+00', NULL, 'f', 'f');
INSERT INTO "public"."cart_line_item" ("id", "cart_id", "title", "subtitle", "thumbnail", "quantity", "variant_id", "product_id", "product_title", "product_description", "product_subtitle", "product_type", "product_collection", "product_handle", "variant_sku", "variant_barcode", "variant_title", "variant_option_values", "requires_shipping", "is_discountable", "is_tax_inclusive", "compare_at_unit_price", "raw_compare_at_unit_price", "unit_price", "raw_unit_price", "metadata", "created_at", "updated_at", "deleted_at", "product_type_id", "is_custom_price", "is_giftcard") VALUES ('cali_01K38AHEQK3EB43FYNVAX46ZQD', 'cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'Medusa Sweatshirt', 'S', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png', 1, 'variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'prod_01K0DQNR60DXF0084R3YNQHSXJ', 'Medusa Sweatshirt', 'Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.', NULL, NULL, NULL, 'sweatshirt', 'SWEATSHIRT-S', NULL, 'S', NULL, 't', 't', 'f', NULL, NULL, 240000, '{"value": "240000", "precision": 20}', '{}', '2025-08-22 07:22:55.603+00', '2025-08-22 07:22:55.603+00', NULL, NULL, 'f', 'f');
COMMIT;

-- ----------------------------
-- Table structure for cart_line_item_adjustment
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_line_item_adjustment";
CREATE TABLE "public"."cart_line_item_adjustment" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "promotion_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default",
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "item_id" text COLLATE "pg_catalog"."default",
  "is_tax_inclusive" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "public"."cart_line_item_adjustment" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_line_item_adjustment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cart_line_item_tax_line
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_line_item_tax_line";
CREATE TABLE "public"."cart_line_item_tax_line" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "tax_rate_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "rate" float4 NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "item_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."cart_line_item_tax_line" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_line_item_tax_line
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cart_payment_collection
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_payment_collection";
CREATE TABLE "public"."cart_payment_collection" (
  "cart_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "payment_collection_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."cart_payment_collection" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_payment_collection
-- ----------------------------
BEGIN;
INSERT INTO "public"."cart_payment_collection" ("cart_id", "payment_collection_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'pay_col_01K38B5ZBK6GQS7AKVQNS5APWX', 'capaycol_01K38B5ZBXJN726FYKKA3HD9KY', '2025-08-22 07:34:07.997673+00', '2025-08-22 07:34:07.997673+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for cart_promotion
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_promotion";
CREATE TABLE "public"."cart_promotion" (
  "cart_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "promotion_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."cart_promotion" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_promotion
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cart_shipping_method
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_shipping_method";
CREATE TABLE "public"."cart_shipping_method" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "cart_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" jsonb,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "is_tax_inclusive" bool NOT NULL DEFAULT false,
  "shipping_option_id" text COLLATE "pg_catalog"."default",
  "data" jsonb,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."cart_shipping_method" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_shipping_method
-- ----------------------------
BEGIN;
INSERT INTO "public"."cart_shipping_method" ("id", "cart_id", "name", "description", "amount", "raw_amount", "is_tax_inclusive", "shipping_option_id", "data", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('casm_01K38B52B0WA60A1XTF4FDZ13Z', 'cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'Fixed Manual', NULL, 50000, '{"value": "50000", "precision": 20}', 'f', 'so_01K38B4T1FCQDKK7TT2MPC8DCG', '{}', NULL, '2025-08-22 07:33:38.272+00', '2025-08-22 07:33:38.272+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for cart_shipping_method_adjustment
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_shipping_method_adjustment";
CREATE TABLE "public"."cart_shipping_method_adjustment" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "promotion_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default",
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "shipping_method_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."cart_shipping_method_adjustment" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_shipping_method_adjustment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cart_shipping_method_tax_line
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart_shipping_method_tax_line";
CREATE TABLE "public"."cart_shipping_method_tax_line" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "tax_rate_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "rate" float4 NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "shipping_method_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."cart_shipping_method_tax_line" OWNER TO "postgres";

-- ----------------------------
-- Records of cart_shipping_method_tax_line
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for credit_line
-- ----------------------------
DROP TABLE IF EXISTS "public"."credit_line";
CREATE TABLE "public"."credit_line" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "cart_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "reference" text COLLATE "pg_catalog"."default",
  "reference_id" text COLLATE "pg_catalog"."default",
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."credit_line" OWNER TO "postgres";

-- ----------------------------
-- Records of credit_line
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for currency
-- ----------------------------
DROP TABLE IF EXISTS "public"."currency";
CREATE TABLE "public"."currency" (
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "symbol" text COLLATE "pg_catalog"."default" NOT NULL,
  "symbol_native" text COLLATE "pg_catalog"."default" NOT NULL,
  "decimal_digits" int4 NOT NULL DEFAULT 0,
  "rounding" numeric NOT NULL DEFAULT 0,
  "raw_rounding" jsonb NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."currency" OWNER TO "postgres";

-- ----------------------------
-- Records of currency
-- ----------------------------
BEGIN;
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('usd', '$', '$', 2, 0, '{"value": "0", "precision": 20}', 'US Dollar', '2025-07-18 03:01:30.344+00', '2025-07-18 03:01:30.344+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('cad', 'CA$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Canadian Dollar', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('eur', '€', '€', 2, 0, '{"value": "0", "precision": 20}', 'Euro', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('aed', 'AED', 'د.إ.‏', 2, 0, '{"value": "0", "precision": 20}', 'United Arab Emirates Dirham', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('afn', 'Af', '؋', 0, 0, '{"value": "0", "precision": 20}', 'Afghan Afghani', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('all', 'ALL', 'Lek', 0, 0, '{"value": "0", "precision": 20}', 'Albanian Lek', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('amd', 'AMD', 'դր.', 0, 0, '{"value": "0", "precision": 20}', 'Armenian Dram', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ars', 'AR$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Argentine Peso', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('aud', 'AU$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Australian Dollar', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('azn', 'man.', 'ман.', 2, 0, '{"value": "0", "precision": 20}', 'Azerbaijani Manat', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bam', 'KM', 'KM', 2, 0, '{"value": "0", "precision": 20}', 'Bosnia-Herzegovina Convertible Mark', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bdt', 'Tk', '৳', 2, 0, '{"value": "0", "precision": 20}', 'Bangladeshi Taka', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bgn', 'BGN', 'лв.', 2, 0, '{"value": "0", "precision": 20}', 'Bulgarian Lev', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bhd', 'BD', 'د.ب.‏', 3, 0, '{"value": "0", "precision": 20}', 'Bahraini Dinar', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bif', 'FBu', 'FBu', 0, 0, '{"value": "0", "precision": 20}', 'Burundian Franc', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bnd', 'BN$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Brunei Dollar', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bob', 'Bs', 'Bs', 2, 0, '{"value": "0", "precision": 20}', 'Bolivian Boliviano', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('brl', 'R$', 'R$', 2, 0, '{"value": "0", "precision": 20}', 'Brazilian Real', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bwp', 'BWP', 'P', 2, 0, '{"value": "0", "precision": 20}', 'Botswanan Pula', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('byn', 'Br', 'руб.', 2, 0, '{"value": "0", "precision": 20}', 'Belarusian Ruble', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('bzd', 'BZ$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Belize Dollar', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('cdf', 'CDF', 'FrCD', 2, 0, '{"value": "0", "precision": 20}', 'Congolese Franc', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('chf', 'CHF', 'CHF', 2, 0.05, '{"value": "0.05", "precision": 20}', 'Swiss Franc', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('clp', 'CL$', '$', 0, 0, '{"value": "0", "precision": 20}', 'Chilean Peso', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('cny', 'CN¥', 'CN¥', 2, 0, '{"value": "0", "precision": 20}', 'Chinese Yuan', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('cop', 'CO$', '$', 0, 0, '{"value": "0", "precision": 20}', 'Colombian Peso', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('crc', '₡', '₡', 0, 0, '{"value": "0", "precision": 20}', 'Costa Rican Colón', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('cve', 'CV$', 'CV$', 2, 0, '{"value": "0", "precision": 20}', 'Cape Verdean Escudo', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('czk', 'Kč', 'Kč', 2, 0, '{"value": "0", "precision": 20}', 'Czech Republic Koruna', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('djf', 'Fdj', 'Fdj', 0, 0, '{"value": "0", "precision": 20}', 'Djiboutian Franc', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('dkk', 'Dkr', 'kr', 2, 0, '{"value": "0", "precision": 20}', 'Danish Krone', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('dop', 'RD$', 'RD$', 2, 0, '{"value": "0", "precision": 20}', 'Dominican Peso', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('dzd', 'DA', 'د.ج.‏', 2, 0, '{"value": "0", "precision": 20}', 'Algerian Dinar', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('eek', 'Ekr', 'kr', 2, 0, '{"value": "0", "precision": 20}', 'Estonian Kroon', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('egp', 'EGP', 'ج.م.‏', 2, 0, '{"value": "0", "precision": 20}', 'Egyptian Pound', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ern', 'Nfk', 'Nfk', 2, 0, '{"value": "0", "precision": 20}', 'Eritrean Nakfa', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('etb', 'Br', 'Br', 2, 0, '{"value": "0", "precision": 20}', 'Ethiopian Birr', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('gbp', '£', '£', 2, 0, '{"value": "0", "precision": 20}', 'British Pound Sterling', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('gel', 'GEL', 'GEL', 2, 0, '{"value": "0", "precision": 20}', 'Georgian Lari', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ghs', 'GH₵', 'GH₵', 2, 0, '{"value": "0", "precision": 20}', 'Ghanaian Cedi', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('gnf', 'FG', 'FG', 0, 0, '{"value": "0", "precision": 20}', 'Guinean Franc', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('gtq', 'GTQ', 'Q', 2, 0, '{"value": "0", "precision": 20}', 'Guatemalan Quetzal', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('hkd', 'HK$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Hong Kong Dollar', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('hnl', 'HNL', 'L', 2, 0, '{"value": "0", "precision": 20}', 'Honduran Lempira', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('hrk', 'kn', 'kn', 2, 0, '{"value": "0", "precision": 20}', 'Croatian Kuna', '2025-07-18 03:01:30.345+00', '2025-07-18 03:01:30.345+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('huf', 'Ft', 'Ft', 0, 0, '{"value": "0", "precision": 20}', 'Hungarian Forint', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('idr', 'Rp', 'Rp', 0, 0, '{"value": "0", "precision": 20}', 'Indonesian Rupiah', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ils', '₪', '₪', 2, 0, '{"value": "0", "precision": 20}', 'Israeli New Sheqel', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('inr', 'Rs', '₹', 2, 0, '{"value": "0", "precision": 20}', 'Indian Rupee', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('iqd', 'IQD', 'د.ع.‏', 0, 0, '{"value": "0", "precision": 20}', 'Iraqi Dinar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('irr', 'IRR', '﷼', 0, 0, '{"value": "0", "precision": 20}', 'Iranian Rial', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('isk', 'Ikr', 'kr', 0, 0, '{"value": "0", "precision": 20}', 'Icelandic Króna', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('jmd', 'J$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Jamaican Dollar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('jod', 'JD', 'د.أ.‏', 3, 0, '{"value": "0", "precision": 20}', 'Jordanian Dinar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('jpy', '¥', '￥', 0, 0, '{"value": "0", "precision": 20}', 'Japanese Yen', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('kes', 'Ksh', 'Ksh', 2, 0, '{"value": "0", "precision": 20}', 'Kenyan Shilling', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('khr', 'KHR', '៛', 2, 0, '{"value": "0", "precision": 20}', 'Cambodian Riel', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('kmf', 'CF', 'FC', 0, 0, '{"value": "0", "precision": 20}', 'Comorian Franc', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('krw', '₩', '₩', 0, 0, '{"value": "0", "precision": 20}', 'South Korean Won', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('kwd', 'KD', 'د.ك.‏', 3, 0, '{"value": "0", "precision": 20}', 'Kuwaiti Dinar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('kzt', 'KZT', 'тңг.', 2, 0, '{"value": "0", "precision": 20}', 'Kazakhstani Tenge', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('lbp', 'LB£', 'ل.ل.‏', 0, 0, '{"value": "0", "precision": 20}', 'Lebanese Pound', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('lkr', 'SLRs', 'SL Re', 2, 0, '{"value": "0", "precision": 20}', 'Sri Lankan Rupee', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ltl', 'Lt', 'Lt', 2, 0, '{"value": "0", "precision": 20}', 'Lithuanian Litas', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('lvl', 'Ls', 'Ls', 2, 0, '{"value": "0", "precision": 20}', 'Latvian Lats', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('lyd', 'LD', 'د.ل.‏', 3, 0, '{"value": "0", "precision": 20}', 'Libyan Dinar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mad', 'MAD', 'د.م.‏', 2, 0, '{"value": "0", "precision": 20}', 'Moroccan Dirham', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mdl', 'MDL', 'MDL', 2, 0, '{"value": "0", "precision": 20}', 'Moldovan Leu', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mga', 'MGA', 'MGA', 0, 0, '{"value": "0", "precision": 20}', 'Malagasy Ariary', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mkd', 'MKD', 'MKD', 2, 0, '{"value": "0", "precision": 20}', 'Macedonian Denar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mmk', 'MMK', 'K', 0, 0, '{"value": "0", "precision": 20}', 'Myanma Kyat', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mnt', 'MNT', '₮', 0, 0, '{"value": "0", "precision": 20}', 'Mongolian Tugrig', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mop', 'MOP$', 'MOP$', 2, 0, '{"value": "0", "precision": 20}', 'Macanese Pataca', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mur', 'MURs', 'MURs', 0, 0, '{"value": "0", "precision": 20}', 'Mauritian Rupee', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mxn', 'MX$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Mexican Peso', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('myr', 'RM', 'RM', 2, 0, '{"value": "0", "precision": 20}', 'Malaysian Ringgit', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mzn', 'MTn', 'MTn', 2, 0, '{"value": "0", "precision": 20}', 'Mozambican Metical', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('nad', 'N$', 'N$', 2, 0, '{"value": "0", "precision": 20}', 'Namibian Dollar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ngn', '₦', '₦', 2, 0, '{"value": "0", "precision": 20}', 'Nigerian Naira', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('nio', 'C$', 'C$', 2, 0, '{"value": "0", "precision": 20}', 'Nicaraguan Córdoba', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('nok', 'Nkr', 'kr', 2, 0, '{"value": "0", "precision": 20}', 'Norwegian Krone', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('npr', 'NPRs', 'नेरू', 2, 0, '{"value": "0", "precision": 20}', 'Nepalese Rupee', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('nzd', 'NZ$', '$', 2, 0, '{"value": "0", "precision": 20}', 'New Zealand Dollar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('omr', 'OMR', 'ر.ع.‏', 3, 0, '{"value": "0", "precision": 20}', 'Omani Rial', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('pab', 'B/.', 'B/.', 2, 0, '{"value": "0", "precision": 20}', 'Panamanian Balboa', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('pen', 'S/.', 'S/.', 2, 0, '{"value": "0", "precision": 20}', 'Peruvian Nuevo Sol', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('php', '₱', '₱', 2, 0, '{"value": "0", "precision": 20}', 'Philippine Peso', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('pkr', 'PKRs', '₨', 0, 0, '{"value": "0", "precision": 20}', 'Pakistani Rupee', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('pln', 'zł', 'zł', 2, 0, '{"value": "0", "precision": 20}', 'Polish Zloty', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('pyg', '₲', '₲', 0, 0, '{"value": "0", "precision": 20}', 'Paraguayan Guarani', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('qar', 'QR', 'ر.ق.‏', 2, 0, '{"value": "0", "precision": 20}', 'Qatari Rial', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ron', 'RON', 'RON', 2, 0, '{"value": "0", "precision": 20}', 'Romanian Leu', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('rsd', 'din.', 'дин.', 0, 0, '{"value": "0", "precision": 20}', 'Serbian Dinar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('rub', 'RUB', '₽.', 2, 0, '{"value": "0", "precision": 20}', 'Russian Ruble', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('rwf', 'RWF', 'FR', 0, 0, '{"value": "0", "precision": 20}', 'Rwandan Franc', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('sar', 'SR', 'ر.س.‏', 2, 0, '{"value": "0", "precision": 20}', 'Saudi Riyal', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('sdg', 'SDG', 'SDG', 2, 0, '{"value": "0", "precision": 20}', 'Sudanese Pound', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('sek', 'Skr', 'kr', 2, 0, '{"value": "0", "precision": 20}', 'Swedish Krona', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('sgd', 'S$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Singapore Dollar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('sos', 'Ssh', 'Ssh', 0, 0, '{"value": "0", "precision": 20}', 'Somali Shilling', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('syp', 'SY£', 'ل.س.‏', 0, 0, '{"value": "0", "precision": 20}', 'Syrian Pound', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('thb', '฿', '฿', 2, 0, '{"value": "0", "precision": 20}', 'Thai Baht', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('tnd', 'DT', 'د.ت.‏', 3, 0, '{"value": "0", "precision": 20}', 'Tunisian Dinar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('top', 'T$', 'T$', 2, 0, '{"value": "0", "precision": 20}', 'Tongan Paʻanga', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('try', '₺', '₺', 2, 0, '{"value": "0", "precision": 20}', 'Turkish Lira', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ttd', 'TT$', '$', 2, 0, '{"value": "0", "precision": 20}', 'Trinidad and Tobago Dollar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('twd', 'NT$', 'NT$', 2, 0, '{"value": "0", "precision": 20}', 'New Taiwan Dollar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('tzs', 'TSh', 'TSh', 0, 0, '{"value": "0", "precision": 20}', 'Tanzanian Shilling', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('uah', '₴', '₴', 2, 0, '{"value": "0", "precision": 20}', 'Ukrainian Hryvnia', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('ugx', 'USh', 'USh', 0, 0, '{"value": "0", "precision": 20}', 'Ugandan Shilling', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('uyu', '$U', '$', 2, 0, '{"value": "0", "precision": 20}', 'Uruguayan Peso', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('uzs', 'UZS', 'UZS', 0, 0, '{"value": "0", "precision": 20}', 'Uzbekistan Som', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('vef', 'Bs.F.', 'Bs.F.', 2, 0, '{"value": "0", "precision": 20}', 'Venezuelan Bolívar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('vnd', '₫', '₫', 0, 0, '{"value": "0", "precision": 20}', 'Vietnamese Dong', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('xaf', 'FCFA', 'FCFA', 0, 0, '{"value": "0", "precision": 20}', 'CFA Franc BEAC', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('xof', 'CFA', 'CFA', 0, 0, '{"value": "0", "precision": 20}', 'CFA Franc BCEAO', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('yer', 'YR', 'ر.ي.‏', 0, 0, '{"value": "0", "precision": 20}', 'Yemeni Rial', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('zar', 'R', 'R', 2, 0, '{"value": "0", "precision": 20}', 'South African Rand', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('zmk', 'ZK', 'ZK', 0, 0, '{"value": "0", "precision": 20}', 'Zambian Kwacha', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('zwl', 'ZWL$', 'ZWL$', 0, 0, '{"value": "0", "precision": 20}', 'Zimbabwean Dollar', '2025-07-18 03:01:30.346+00', '2025-07-18 03:01:30.346+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('mwk', 'K', 'K', 2, 0, '{"value": "0", "precision": 20}', 'Malawian Kwacha', '2025-08-29 03:39:02.718+00', '2025-08-29 03:39:02.718+00', NULL);
INSERT INTO "public"."currency" ("code", "symbol", "symbol_native", "decimal_digits", "rounding", "raw_rounding", "name", "created_at", "updated_at", "deleted_at") VALUES ('xpf', '₣', '₣', 0, 0, '{"value": "0", "precision": 20}', 'CFP Franc', '2025-08-29 03:39:02.718+00', '2025-08-29 03:39:02.718+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS "public"."customer";
CREATE TABLE "public"."customer" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "company_name" text COLLATE "pg_catalog"."default",
  "first_name" text COLLATE "pg_catalog"."default",
  "last_name" text COLLATE "pg_catalog"."default",
  "email" text COLLATE "pg_catalog"."default",
  "phone" text COLLATE "pg_catalog"."default",
  "has_account" bool NOT NULL DEFAULT false,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "created_by" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."customer" OWNER TO "postgres";

-- ----------------------------
-- Records of customer
-- ----------------------------
BEGIN;
INSERT INTO "public"."customer" ("id", "company_name", "first_name", "last_name", "email", "phone", "has_account", "metadata", "created_at", "updated_at", "deleted_at", "created_by") VALUES ('cus_01K38AJPD0KBWRW4Y2EHBQWFW4', NULL, NULL, NULL, 'alrocha@gmail.com', NULL, 'f', NULL, '2025-08-22 07:23:36.224+00', '2025-08-22 07:23:36.224+00', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for customer_account_holder
-- ----------------------------
DROP TABLE IF EXISTS "public"."customer_account_holder";
CREATE TABLE "public"."customer_account_holder" (
  "customer_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "account_holder_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."customer_account_holder" OWNER TO "postgres";

-- ----------------------------
-- Records of customer_account_holder
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for customer_address
-- ----------------------------
DROP TABLE IF EXISTS "public"."customer_address";
CREATE TABLE "public"."customer_address" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "customer_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "address_name" text COLLATE "pg_catalog"."default",
  "is_default_shipping" bool NOT NULL DEFAULT false,
  "is_default_billing" bool NOT NULL DEFAULT false,
  "company" text COLLATE "pg_catalog"."default",
  "first_name" text COLLATE "pg_catalog"."default",
  "last_name" text COLLATE "pg_catalog"."default",
  "address_1" text COLLATE "pg_catalog"."default",
  "address_2" text COLLATE "pg_catalog"."default",
  "city" text COLLATE "pg_catalog"."default",
  "country_code" text COLLATE "pg_catalog"."default",
  "province" text COLLATE "pg_catalog"."default",
  "postal_code" text COLLATE "pg_catalog"."default",
  "phone" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."customer_address" OWNER TO "postgres";

-- ----------------------------
-- Records of customer_address
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for customer_group
-- ----------------------------
DROP TABLE IF EXISTS "public"."customer_group";
CREATE TABLE "public"."customer_group" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_by" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."customer_group" OWNER TO "postgres";

-- ----------------------------
-- Records of customer_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for customer_group_customer
-- ----------------------------
DROP TABLE IF EXISTS "public"."customer_group_customer";
CREATE TABLE "public"."customer_group_customer" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "customer_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "customer_group_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "created_by" text COLLATE "pg_catalog"."default",
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."customer_group_customer" OWNER TO "postgres";

-- ----------------------------
-- Records of customer_group_customer
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fulfillment
-- ----------------------------
DROP TABLE IF EXISTS "public"."fulfillment";
CREATE TABLE "public"."fulfillment" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "location_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "packed_at" timestamptz(6),
  "shipped_at" timestamptz(6),
  "delivered_at" timestamptz(6),
  "canceled_at" timestamptz(6),
  "data" jsonb,
  "provider_id" text COLLATE "pg_catalog"."default",
  "shipping_option_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "delivery_address_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "marked_shipped_by" text COLLATE "pg_catalog"."default",
  "created_by" text COLLATE "pg_catalog"."default",
  "requires_shipping" bool NOT NULL DEFAULT true
)
;
ALTER TABLE "public"."fulfillment" OWNER TO "postgres";

-- ----------------------------
-- Records of fulfillment
-- ----------------------------
BEGIN;
INSERT INTO "public"."fulfillment" ("id", "location_id", "packed_at", "shipped_at", "delivered_at", "canceled_at", "data", "provider_id", "shipping_option_id", "metadata", "delivery_address_id", "created_at", "updated_at", "deleted_at", "marked_shipped_by", "created_by", "requires_shipping") VALUES ('ful_01K38B78K3XRCPCKVWN8MY5VV5', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', '2025-08-22 07:34:50.2+00', NULL, '2025-08-22 07:35:00.148+00', NULL, '{}', 'manual_manual', 'so_01K38B4T1FCQDKK7TT2MPC8DCG', NULL, 'fuladdr_01K38B78K3THNCD3W7FT1FXEKK', '2025-08-22 07:34:50.212+00', '2025-08-22 07:35:00.173+00', NULL, NULL, NULL, 't');
COMMIT;

-- ----------------------------
-- Table structure for fulfillment_address
-- ----------------------------
DROP TABLE IF EXISTS "public"."fulfillment_address";
CREATE TABLE "public"."fulfillment_address" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "company" text COLLATE "pg_catalog"."default",
  "first_name" text COLLATE "pg_catalog"."default",
  "last_name" text COLLATE "pg_catalog"."default",
  "address_1" text COLLATE "pg_catalog"."default",
  "address_2" text COLLATE "pg_catalog"."default",
  "city" text COLLATE "pg_catalog"."default",
  "country_code" text COLLATE "pg_catalog"."default",
  "province" text COLLATE "pg_catalog"."default",
  "postal_code" text COLLATE "pg_catalog"."default",
  "phone" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."fulfillment_address" OWNER TO "postgres";

-- ----------------------------
-- Records of fulfillment_address
-- ----------------------------
BEGIN;
INSERT INTO "public"."fulfillment_address" ("id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fuladdr_01K38B78K3THNCD3W7FT1FXEKK', '', 'Al Rocha', 'Cabrerra', 'Jl. Simponi No. 21', '', 'Bandung', 'id', 'Jawa Barat', '40264', '', NULL, '2025-08-22 07:23:42.697+00', '2025-08-22 07:23:42.697+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for fulfillment_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."fulfillment_item";
CREATE TABLE "public"."fulfillment_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "sku" text COLLATE "pg_catalog"."default" NOT NULL,
  "barcode" text COLLATE "pg_catalog"."default" NOT NULL,
  "quantity" numeric NOT NULL,
  "raw_quantity" jsonb NOT NULL,
  "line_item_id" text COLLATE "pg_catalog"."default",
  "inventory_item_id" text COLLATE "pg_catalog"."default",
  "fulfillment_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."fulfillment_item" OWNER TO "postgres";

-- ----------------------------
-- Records of fulfillment_item
-- ----------------------------
BEGIN;
INSERT INTO "public"."fulfillment_item" ("id", "title", "sku", "barcode", "quantity", "raw_quantity", "line_item_id", "inventory_item_id", "fulfillment_id", "created_at", "updated_at", "deleted_at") VALUES ('fulit_01K38B78K21WDDEY6HNNJD1SE4', 'S', 'SWEATSHIRT-S', '', 1, '{"value": "1", "precision": 20}', 'ordli_01K38B662S2GB9JV4A7YRCMK9F', 'iitem_01K0DQNR8HDKZFXMZW258EV36W', 'ful_01K38B78K3XRCPCKVWN8MY5VV5', '2025-08-22 07:34:50.212+00', '2025-08-22 07:34:50.212+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for fulfillment_label
-- ----------------------------
DROP TABLE IF EXISTS "public"."fulfillment_label";
CREATE TABLE "public"."fulfillment_label" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "tracking_number" text COLLATE "pg_catalog"."default" NOT NULL,
  "tracking_url" text COLLATE "pg_catalog"."default" NOT NULL,
  "label_url" text COLLATE "pg_catalog"."default" NOT NULL,
  "fulfillment_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."fulfillment_label" OWNER TO "postgres";

-- ----------------------------
-- Records of fulfillment_label
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fulfillment_provider
-- ----------------------------
DROP TABLE IF EXISTS "public"."fulfillment_provider";
CREATE TABLE "public"."fulfillment_provider" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_enabled" bool NOT NULL DEFAULT true,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."fulfillment_provider" OWNER TO "postgres";

-- ----------------------------
-- Records of fulfillment_provider
-- ----------------------------
BEGIN;
INSERT INTO "public"."fulfillment_provider" ("id", "is_enabled", "created_at", "updated_at", "deleted_at") VALUES ('manual_manual', 't', '2025-07-18 03:01:30.375+00', '2025-07-18 03:01:30.375+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for fulfillment_set
-- ----------------------------
DROP TABLE IF EXISTS "public"."fulfillment_set";
CREATE TABLE "public"."fulfillment_set" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."fulfillment_set" OWNER TO "postgres";

-- ----------------------------
-- Records of fulfillment_set
-- ----------------------------
BEGIN;
INSERT INTO "public"."fulfillment_set" ("id", "name", "type", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fuset_01K0DQNR1A9GSP9NT5MMF387RW', 'European Warehouse delivery', 'shipping', NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."fulfillment_set" ("id", "name", "type", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fuset_01K33F5NGSCZ63W678VJ0MBZ5M', 'Gudang Utama shipping', 'shipping', NULL, '2025-08-20 10:07:40.058+00', '2025-08-20 10:07:40.058+00', NULL);
INSERT INTO "public"."fulfillment_set" ("id", "name", "type", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fuset_01K33F5DKDPKNRQ347TPW1N0E3', 'Gudang Utama pick up', 'pickup', NULL, '2025-08-20 10:07:31.95+00', '2025-08-20 10:25:35.175+00', '2025-08-20 10:25:35.173+00');
COMMIT;

-- ----------------------------
-- Table structure for geo_zone
-- ----------------------------
DROP TABLE IF EXISTS "public"."geo_zone";
CREATE TABLE "public"."geo_zone" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'country'::text,
  "country_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "province_code" text COLLATE "pg_catalog"."default",
  "city" text COLLATE "pg_catalog"."default",
  "service_zone_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "postal_expression" jsonb,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."geo_zone" OWNER TO "postgres";

-- ----------------------------
-- Records of geo_zone
-- ----------------------------
BEGIN;
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K0DQNR1AY080YVJ6VN0X39PM', 'country', 'gb', NULL, NULL, 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', NULL, NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K0DQNR1AY57FJ63P14TS17NZ', 'country', 'de', NULL, NULL, 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', NULL, NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K0DQNR1AV70TDK1MFDMRJW7F', 'country', 'dk', NULL, NULL, 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', NULL, NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K0DQNR1AB69T92A39Q4JRSPH', 'country', 'se', NULL, NULL, 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', NULL, NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K0DQNR1AF68N6DN3Y0DDP9QE', 'country', 'fr', NULL, NULL, 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', NULL, NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K0DQNR1A7GM5K86TK84B9HEE', 'country', 'es', NULL, NULL, 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', NULL, NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K0DQNR1A1PE7R4S7DZDC3AQN', 'country', 'it', NULL, NULL, 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', NULL, NULL, '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."geo_zone" ("id", "type", "country_code", "province_code", "city", "service_zone_id", "postal_expression", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fgz_01K33G5SS6W01XR6T7CKH526W8', 'country', 'id', NULL, NULL, 'serzo_01K33G5SS77RAVYA695YTY8D6R', NULL, NULL, '2025-08-20 10:25:13+00', '2025-08-20 10:25:13+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS "public"."image";
CREATE TABLE "public"."image" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "url" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "rank" int4 NOT NULL DEFAULT 0,
  "product_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."image" OWNER TO "postgres";

-- ----------------------------
-- Records of image
-- ----------------------------
BEGIN;
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR621433HFRB9J3X111J', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR626GHMH9BFRRKT3B4A', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-back.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 1, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR628H9TQKCM37QPMVYP', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-white-front.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 2, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR62EC34DHXPRWWW993V', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-white-back.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 3, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR63JV8DE9084FQ4YT5N', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 0, 'prod_01K0DQNR60DXF0084R3YNQHSXJ');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR63XWZGQDBRW16QAH5S', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-back.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 1, 'prod_01K0DQNR60DXF0084R3YNQHSXJ');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR6372B5AAXE599DR7T2', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 0, 'prod_01K0DQNR60F4HVA8YYA27N3KT3');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR63BV68GW9HKY8Z8D64', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-back.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 1, 'prod_01K0DQNR60F4HVA8YYA27N3KT3');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR6348STTTB0N00EVC90', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 0, 'prod_01K0DQNR60MNDVFQQ4PNFTPRC9');
INSERT INTO "public"."image" ("id", "url", "metadata", "created_at", "updated_at", "deleted_at", "rank", "product_id") VALUES ('img_01K0DQNR63YT8P2FCAHX4X3PPD', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-back.png', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, 1, 'prod_01K0DQNR60MNDVFQQ4PNFTPRC9');
COMMIT;

-- ----------------------------
-- Table structure for inventory_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."inventory_item";
CREATE TABLE "public"."inventory_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "sku" text COLLATE "pg_catalog"."default",
  "origin_country" text COLLATE "pg_catalog"."default",
  "hs_code" text COLLATE "pg_catalog"."default",
  "mid_code" text COLLATE "pg_catalog"."default",
  "material" text COLLATE "pg_catalog"."default",
  "weight" int4,
  "length" int4,
  "height" int4,
  "width" int4,
  "requires_shipping" bool NOT NULL DEFAULT true,
  "description" text COLLATE "pg_catalog"."default",
  "title" text COLLATE "pg_catalog"."default",
  "thumbnail" text COLLATE "pg_catalog"."default",
  "metadata" jsonb
)
;
ALTER TABLE "public"."inventory_item" OWNER TO "postgres";

-- ----------------------------
-- Records of inventory_item
-- ----------------------------
BEGIN;
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HZ8V16J0A12QJSX3Z', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-S-BLACK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'S / Black', 'S / Black', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-S-WHITE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'S / White', 'S / White', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8H6FMW591ZAWE8CC6V', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-M-BLACK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'M / Black', 'M / Black', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HN7FREQ43S7HR4XBJ', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-M-WHITE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'M / White', 'M / White', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8H7TSKNZPDMT9H5CDA', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-L-BLACK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'L / Black', 'L / Black', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HQ5N14ZPE16W32M8A', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-L-WHITE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'L / White', 'L / White', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HDEG38Z3SSC6BTDP2', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-XL-BLACK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'XL / Black', 'XL / Black', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHIRT-XL-WHITE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'XL / White', 'XL / White', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HDKZFXMZW258EV36W', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATSHIRT-S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'S', 'S', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HR59HTB6ERH8DZASY', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATSHIRT-M', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'M', 'M', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HHMNTR22RZE0C3VDE', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATSHIRT-L', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'L', 'L', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATSHIRT-XL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'XL', 'XL', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HEP3A6M8P8RVFT5JG', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATPANTS-S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'S', 'S', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HKWFJWJVHX5SWTADW', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATPANTS-M', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'M', 'M', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8HNDAVZP18NAD0E3XJ', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATPANTS-L', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'L', 'L', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8H473MMSD7EKP3MQK6', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SWEATPANTS-XL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'XL', 'XL', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8J7722RFA36MATZMYN', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHORTS-S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'S', 'S', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8J4CA4D5ADAH6ANXQS', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHORTS-M', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'M', 'M', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8JXCP0JAGSG543T09G', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHORTS-L', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'L', 'L', NULL, NULL);
INSERT INTO "public"."inventory_item" ("id", "created_at", "updated_at", "deleted_at", "sku", "origin_country", "hs_code", "mid_code", "material", "weight", "length", "height", "width", "requires_shipping", "description", "title", "thumbnail", "metadata") VALUES ('iitem_01K0DQNR8J8DJWWBSQX1CNYN0T', '2025-07-18 03:01:34.61+00', '2025-07-18 03:01:34.61+00', NULL, 'SHORTS-XL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', 'XL', 'XL', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for inventory_level
-- ----------------------------
DROP TABLE IF EXISTS "public"."inventory_level";
CREATE TABLE "public"."inventory_level" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "inventory_item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "location_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "stocked_quantity" numeric NOT NULL DEFAULT 0,
  "reserved_quantity" numeric NOT NULL DEFAULT 0,
  "incoming_quantity" numeric NOT NULL DEFAULT 0,
  "metadata" jsonb,
  "raw_stocked_quantity" jsonb,
  "raw_reserved_quantity" jsonb,
  "raw_incoming_quantity" jsonb
)
;
ALTER TABLE "public"."inventory_level" OWNER TO "postgres";

-- ----------------------------
-- Records of inventory_level
-- ----------------------------
BEGIN;
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33F99V1D1PWQPRAH5G0GZ7H', '2025-08-20 10:09:39.169+00', '2025-08-20 10:10:12.078+00', '2025-08-20 10:10:12.075+00', 'iitem_01K0DQNR8H473MMSD7EKP3MQK6', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 0, 0, 0, NULL, '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ0035698Y4WW5GVP1W', '2025-08-20 10:23:35.499+00', '2025-08-20 10:23:35.499+00', NULL, 'iitem_01K0DQNR8H6FMW591ZAWE8CC6V', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ12K39YJ3VEZ2NF6A6', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8H7TSKNZPDMT9H5CDA', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 100, 0, 0, NULL, '{"value": "100", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ176P176NZS257K4DZ', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 250, 0, 0, NULL, '{"value": "250", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ1ZRWJE1886D5WZF92', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HDEG38Z3SSC6BTDP2', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 150, 0, 0, NULL, '{"value": "150", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBQRGA7ZZK8P3BFX4D1', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.549+00', NULL, 'iitem_01K0DQNR8H6FMW591ZAWE8CC6V', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBQTSQX85S2H1MP9H7E', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:55.566+00', NULL, 'iitem_01K0DQNR8H473MMSD7EKP3MQK6', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ1BA6T62801YZDJ4FC', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ1CK1AD061FQANCQDP', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HEP3A6M8P8RVFT5JG', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 320, 0, 0, NULL, '{"value": "320", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ1D7PP5KVTGDQSZX6X', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HHMNTR22RZE0C3VDE', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJAWVNMRK2JQDRD97SB', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HKWFJWJVHX5SWTADW', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJAQ21ZJW2Q9ZD2D6YV', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HN7FREQ43S7HR4XBJ', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 250, 0, 0, NULL, '{"value": "250", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJAX2BC8FB9PCTB453J', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HNDAVZP18NAD0E3XJ', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJAQ2NGD1JG9V1E0ME8', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HQ5N14ZPE16W32M8A', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 150, 0, 0, NULL, '{"value": "150", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJBHM69MD145R1NRH3G', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HR59HTB6ERH8DZASY', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 300, 0, 0, NULL, '{"value": "300", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJBP4DJSX8AWFCJC1DV', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJB70YTMW149NQNJDM1', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8HZ8V16J0A12QJSX3Z', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 300, 0, 0, NULL, '{"value": "300", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJBNP6W4ZBR306HFASG', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8J4CA4D5ADAH6ANXQS', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 225, 0, 0, NULL, '{"value": "225", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJBT3MEWCYPG3H3FRBT', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8J7722RFA36MATZMYN', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJB1TKCZ0QH4D7GSEQY', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8J8DJWWBSQX1CNYN0T', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJBXXZVPZDA80WWEJJT', '2025-08-20 10:23:35.5+00', '2025-08-20 10:23:35.5+00', NULL, 'iitem_01K0DQNR8JXCP0JAGSG543T09G', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 110, 0, 0, NULL, '{"value": "110", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBQVB9S77CB8Z3NARQV', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.549+00', NULL, 'iitem_01K0DQNR8H7TSKNZPDMT9H5CDA', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 300, 0, 0, NULL, '{"value": "300", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBQ69N6B60NQRKHH1ZP', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.549+00', NULL, 'iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBQ7128BJ97NVPMTAYY', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.549+00', NULL, 'iitem_01K0DQNR8HDEG38Z3SSC6BTDP2', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 150, 0, 0, NULL, '{"value": "150", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBQN7FZ6HKMEJS830WP', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.549+00', NULL, 'iitem_01K0DQNR8HDKZFXMZW258EV36W', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 500, 0, 0, NULL, '{"value": "500", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR0M5Y05X85FBBSKTC', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.549+00', NULL, 'iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 225, 0, 0, NULL, '{"value": "225", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR8FDJMBQ14F4NSBFP', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HEP3A6M8P8RVFT5JG', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR003JEANR9Y51XBS7', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.549+00', NULL, 'iitem_01K0DQNR8HHMNTR22RZE0C3VDE', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBRW2G9C1XET1QH4V46', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HKWFJWJVHX5SWTADW', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 150, 0, 0, NULL, '{"value": "150", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR9XMWYH7E87914PCN', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HN7FREQ43S7HR4XBJ', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 500, 0, 0, NULL, '{"value": "500", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR4510NGGY2YYH65B3', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HNDAVZP18NAD0E3XJ', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 300, 0, 0, NULL, '{"value": "300", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBRWNSGDG7ESQM7FZE2', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HQ5N14ZPE16W32M8A', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 500, 0, 0, NULL, '{"value": "500", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBRKNRXNS275AJ10CXG', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HR59HTB6ERH8DZASY', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR391XPS7RZ96993N2', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 210, 0, 0, NULL, '{"value": "210", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR1CP19MWN9D5BGVDG', '2025-07-18 03:01:34.712+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8HZ8V16J0A12QJSX3Z', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 300, 0, 0, NULL, '{"value": "300", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBRAWP5R6H03Q8M7MTP', '2025-07-18 03:01:34.713+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8J4CA4D5ADAH6ANXQS', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBRT02YN89QH288D9JQ', '2025-07-18 03:01:34.713+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8J7722RFA36MATZMYN', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 330, 0, 0, NULL, '{"value": "330", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBRV4PGCP6BYD7QA8P5', '2025-07-18 03:01:34.713+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8J8DJWWBSQX1CNYN0T', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 400, 0, 0, NULL, '{"value": "400", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K0DQNRBR0ZZGKS0K4BFNKZGG', '2025-07-18 03:01:34.713+00', '2025-08-20 10:23:35.55+00', NULL, 'iitem_01K0DQNR8JXCP0JAGSG543T09G', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 150, 0, 0, NULL, '{"value": "150", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G3E4DQZTSJM04YA1FCXB0', '2025-08-20 10:23:55.534+00', '2025-08-20 10:23:55.534+00', NULL, 'iitem_01K0DQNR8H473MMSD7EKP3MQK6', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 200, 0, 0, NULL, '{"value": "200", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
INSERT INTO "public"."inventory_level" ("id", "created_at", "updated_at", "deleted_at", "inventory_item_id", "location_id", "stocked_quantity", "reserved_quantity", "incoming_quantity", "metadata", "raw_stocked_quantity", "raw_reserved_quantity", "raw_incoming_quantity") VALUES ('ilev_01K33G2TJ1X12FP5VZT741J4M6', '2025-08-20 10:23:35.5+00', '2025-08-22 07:34:50.287+00', NULL, 'iitem_01K0DQNR8HDKZFXMZW258EV36W', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 149, 0, 0, NULL, '{"value": "149", "precision": 20}', '{"value": "0", "precision": 20}', '{"value": "0", "precision": 20}');
COMMIT;

-- ----------------------------
-- Table structure for invite
-- ----------------------------
DROP TABLE IF EXISTS "public"."invite";
CREATE TABLE "public"."invite" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "email" text COLLATE "pg_catalog"."default" NOT NULL,
  "accepted" bool NOT NULL DEFAULT false,
  "token" text COLLATE "pg_catalog"."default" NOT NULL,
  "expires_at" timestamptz(6) NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."invite" OWNER TO "postgres";

-- ----------------------------
-- Records of invite
-- ----------------------------
BEGIN;
INSERT INTO "public"."invite" ("id", "email", "accepted", "token", "expires_at", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('invite_01K0DQNP7QJDX2MC6W99GZRW8M', 'admin@medusa-test.com', 'f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Imludml0ZV8wMUswRFFOUDdRSkRYMk1DNlc5OUdaUlc4TSIsImVtYWlsIjoiYWRtaW5AbWVkdXNhLXRlc3QuY29tIiwiaWF0IjoxNzUyODA3NjkyLCJleHAiOjE3NTI4OTQwOTIsImp0aSI6Ijk2MjIxODgyLWNiMzQtNDI4NC1hNjQ4LTU4NDNkYzQ4MTAwNiJ9.Tn8y8Ao5KkVFxwVuWeCyMF4VTeupzOtcUD6Tk_9ZXjI', '2025-07-19 03:01:32.535+00', NULL, '2025-07-18 03:01:32.536+00', '2025-07-18 03:01:32.536+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for link_module_migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."link_module_migrations";
CREATE TABLE "public"."link_module_migrations" (
  "id" int4 NOT NULL DEFAULT nextval('link_module_migrations_id_seq'::regclass),
  "table_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "link_descriptor" jsonb NOT NULL DEFAULT '{}'::jsonb,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."link_module_migrations" OWNER TO "postgres";

-- ----------------------------
-- Records of link_module_migrations
-- ----------------------------
BEGIN;
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (1, 'order_cart', '{"toModel": "cart", "toModule": "cart", "fromModel": "order", "fromModule": "order"}', '2025-07-18 03:01:29.344686');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (2, 'location_fulfillment_provider', '{"toModel": "fulfillment_provider", "toModule": "fulfillment", "fromModel": "location", "fromModule": "stock_location"}', '2025-07-18 03:01:29.344912');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (3, 'cart_promotion', '{"toModel": "promotions", "toModule": "promotion", "fromModel": "cart", "fromModule": "cart"}', '2025-07-18 03:01:29.344939');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (4, 'order_fulfillment', '{"toModel": "fulfillments", "toModule": "fulfillment", "fromModel": "order", "fromModule": "order"}', '2025-07-18 03:01:29.344993');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (5, 'location_fulfillment_set', '{"toModel": "fulfillment_set", "toModule": "fulfillment", "fromModel": "location", "fromModule": "stock_location"}', '2025-07-18 03:01:29.344687');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (6, 'order_payment_collection', '{"toModel": "payment_collection", "toModule": "payment", "fromModel": "order", "fromModule": "order"}', '2025-07-18 03:01:29.345522');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (8, 'order_promotion', '{"toModel": "promotion", "toModule": "promotion", "fromModel": "order", "fromModule": "order"}', '2025-07-18 03:01:29.346219');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (7, 'return_fulfillment', '{"toModel": "fulfillments", "toModule": "fulfillment", "fromModel": "return", "fromModule": "order"}', '2025-07-18 03:01:29.346224');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (10, 'product_variant_inventory_item', '{"toModel": "inventory", "toModule": "inventory", "fromModel": "variant", "fromModule": "product"}', '2025-07-18 03:01:29.347203');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (9, 'product_sales_channel', '{"toModel": "sales_channel", "toModule": "sales_channel", "fromModel": "product", "fromModule": "product"}', '2025-07-18 03:01:29.346784');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (11, 'product_variant_price_set', '{"toModel": "price_set", "toModule": "pricing", "fromModel": "variant", "fromModule": "product"}', '2025-07-18 03:01:29.375379');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (12, 'publishable_api_key_sales_channel', '{"toModel": "sales_channel", "toModule": "sales_channel", "fromModel": "api_key", "fromModule": "api_key"}', '2025-07-18 03:01:29.380166');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (13, 'region_payment_provider', '{"toModel": "payment_provider", "toModule": "payment", "fromModel": "region", "fromModule": "region"}', '2025-07-18 03:01:29.382312');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (14, 'sales_channel_stock_location', '{"toModel": "location", "toModule": "stock_location", "fromModel": "sales_channel", "fromModule": "sales_channel"}', '2025-07-18 03:01:29.383208');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (15, 'product_shipping_profile', '{"toModel": "shipping_profile", "toModule": "fulfillment", "fromModel": "product", "fromModule": "product"}', '2025-07-18 03:01:29.383534');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (16, 'shipping_option_price_set', '{"toModel": "price_set", "toModule": "pricing", "fromModel": "shipping_option", "fromModule": "fulfillment"}', '2025-07-18 03:01:29.383713');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (17, 'customer_account_holder', '{"toModel": "account_holder", "toModule": "payment", "fromModel": "customer", "fromModule": "customer"}', '2025-07-18 03:01:29.383504');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (18, 'cart_payment_collection', '{"toModel": "payment_collection", "toModule": "payment", "fromModel": "cart", "fromModule": "cart"}', '2025-07-18 03:01:29.384017');
INSERT INTO "public"."link_module_migrations" ("id", "table_name", "link_descriptor", "created_at") VALUES (37, 'product_product_brand_brand', '{"toModel": "brand", "toModule": "brand", "fromModel": "product", "fromModule": "product"}', '2025-08-29 03:39:01.664593');
COMMIT;

-- ----------------------------
-- Table structure for location_fulfillment_provider
-- ----------------------------
DROP TABLE IF EXISTS "public"."location_fulfillment_provider";
CREATE TABLE "public"."location_fulfillment_provider" (
  "stock_location_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "fulfillment_provider_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."location_fulfillment_provider" OWNER TO "postgres";

-- ----------------------------
-- Records of location_fulfillment_provider
-- ----------------------------
BEGIN;
INSERT INTO "public"."location_fulfillment_provider" ("stock_location_id", "fulfillment_provider_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 'manual_manual', 'locfp_01K0DQNR0ZTQ0MF1C7F1HAZSCR', '2025-07-18 03:01:34.367267+00', '2025-07-18 03:01:34.367267+00', NULL);
INSERT INTO "public"."location_fulfillment_provider" ("stock_location_id", "fulfillment_provider_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sloc_01K33F59FEB33XCB0DA9WPWN5Z', 'manual_manual', 'locfp_01K33G4ZM07BM6HH4MSHKG8Y4N', '2025-08-20 10:24:46.219524+00', '2025-08-20 10:24:46.219524+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for location_fulfillment_set
-- ----------------------------
DROP TABLE IF EXISTS "public"."location_fulfillment_set";
CREATE TABLE "public"."location_fulfillment_set" (
  "stock_location_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "fulfillment_set_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."location_fulfillment_set" OWNER TO "postgres";

-- ----------------------------
-- Records of location_fulfillment_set
-- ----------------------------
BEGIN;
INSERT INTO "public"."location_fulfillment_set" ("stock_location_id", "fulfillment_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 'fuset_01K0DQNR1A9GSP9NT5MMF387RW', 'locfs_01K0DQNR1WNXPVT1ZPZPAKAX6M', '2025-07-18 03:01:34.39607+00', '2025-07-18 03:01:34.39607+00', NULL);
INSERT INTO "public"."location_fulfillment_set" ("stock_location_id", "fulfillment_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sloc_01K33F59FEB33XCB0DA9WPWN5Z', 'fuset_01K33F5NGSCZ63W678VJ0MBZ5M', 'locfs_01K33F5NHB89CE0KC6MAG8BV3F', '2025-08-20 10:07:40.071277+00', '2025-08-20 10:07:40.071277+00', NULL);
INSERT INTO "public"."location_fulfillment_set" ("stock_location_id", "fulfillment_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sloc_01K33F59FEB33XCB0DA9WPWN5Z', 'fuset_01K33F5DKDPKNRQ347TPW1N0E3', 'locfs_01K33F5DM912QQ2Y522Q5ZBBZC', '2025-08-20 10:07:31.973151+00', '2025-08-20 10:25:35.199+00', '2025-08-20 10:25:35.197+00');
COMMIT;

-- ----------------------------
-- Table structure for mikro_orm_migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."mikro_orm_migrations";
CREATE TABLE "public"."mikro_orm_migrations" (
  "id" int4 NOT NULL DEFAULT nextval('mikro_orm_migrations_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "executed_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."mikro_orm_migrations" OWNER TO "postgres";

-- ----------------------------
-- Records of mikro_orm_migrations
-- ----------------------------
BEGIN;
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (1, 'Migration20240307161216', '2025-07-18 03:01:27.233829+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (2, 'Migration20241210073813', '2025-07-18 03:01:27.233829+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (3, 'Migration20250106142624', '2025-07-18 03:01:27.233829+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (4, 'Migration20250120110820', '2025-07-18 03:01:27.233829+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (5, 'Migration20240307132720', '2025-07-18 03:01:27.288524+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (6, 'Migration20240719123015', '2025-07-18 03:01:27.288524+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (7, 'Migration20241213063611', '2025-07-18 03:01:27.288524+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (8, 'InitialSetup20240401153642', '2025-07-18 03:01:27.362788+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (9, 'Migration20240601111544', '2025-07-18 03:01:27.362788+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (10, 'Migration202408271511', '2025-07-18 03:01:27.362788+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (11, 'Migration20241122120331', '2025-07-18 03:01:27.362788+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (12, 'Migration20241125090957', '2025-07-18 03:01:27.362788+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (13, 'Migration20250411073236', '2025-07-18 03:01:27.362788+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (14, 'Migration20250516081326', '2025-07-18 03:01:27.362788+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (15, 'Migration20230929122253', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (16, 'Migration20240322094407', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (17, 'Migration20240322113359', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (18, 'Migration20240322120125', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (19, 'Migration20240626133555', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (20, 'Migration20240704094505', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (21, 'Migration20241127114534', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (22, 'Migration20241127223829', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (23, 'Migration20241128055359', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (24, 'Migration20241212190401', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (25, 'Migration20250408145122', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (26, 'Migration20250409122219', '2025-07-18 03:01:27.518345+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (27, 'Migration20240227120221', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (28, 'Migration20240617102917', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (29, 'Migration20240624153824', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (30, 'Migration20241211061114', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (31, 'Migration20250113094144', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (32, 'Migration20250120110700', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (33, 'Migration20250226130616', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (34, 'Migration20250508081510', '2025-07-18 03:01:27.698184+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (35, 'Migration20240124154000', '2025-07-18 03:01:27.856392+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (36, 'Migration20240524123112', '2025-07-18 03:01:27.856392+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (37, 'Migration20240602110946', '2025-07-18 03:01:27.856392+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (38, 'Migration20241211074630', '2025-07-18 03:01:27.856392+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (39, 'Migration20240115152146', '2025-07-18 03:01:27.928392+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (40, 'Migration20240222170223', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (41, 'Migration20240831125857', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (42, 'Migration20241106085918', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (43, 'Migration20241205095237', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (44, 'Migration20241216183049', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (45, 'Migration20241218091938', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (46, 'Migration20250120115059', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (47, 'Migration20250212131240', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (48, 'Migration20250326151602', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (49, 'Migration20250508081553', '2025-07-18 03:01:27.950511+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (50, 'Migration20240205173216', '2025-07-18 03:01:28.07752+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (51, 'Migration20240624200006', '2025-07-18 03:01:28.07752+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (52, 'Migration20250120110744', '2025-07-18 03:01:28.07752+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (53, 'InitialSetup20240221144943', '2025-07-18 03:01:28.17994+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (54, 'Migration20240604080145', '2025-07-18 03:01:28.17994+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (55, 'Migration20241205122700', '2025-07-18 03:01:28.17994+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (56, 'InitialSetup20240227075933', '2025-07-18 03:01:28.215727+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (57, 'Migration20240621145944', '2025-07-18 03:01:28.215727+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (58, 'Migration20241206083313', '2025-07-18 03:01:28.215727+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (59, 'Migration20240227090331', '2025-07-18 03:01:28.261553+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (60, 'Migration20240710135844', '2025-07-18 03:01:28.261553+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (61, 'Migration20240924114005', '2025-07-18 03:01:28.261553+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (62, 'Migration20241212052837', '2025-07-18 03:01:28.261553+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (63, 'InitialSetup20240228133303', '2025-07-18 03:01:28.338948+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (64, 'Migration20240624082354', '2025-07-18 03:01:28.338948+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (65, 'Migration20240225134525', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (66, 'Migration20240806072619', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (67, 'Migration20241211151053', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (68, 'Migration20250115160517', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (69, 'Migration20250120110552', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (70, 'Migration20250123122334', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (71, 'Migration20250206105639', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (72, 'Migration20250207132723', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (73, 'Migration20250625084134', '2025-07-18 03:01:28.369738+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (74, 'Migration20240219102530', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (75, 'Migration20240604100512', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (76, 'Migration20240715102100', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (77, 'Migration20240715174100', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (78, 'Migration20240716081800', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (79, 'Migration20240801085921', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (80, 'Migration20240821164505', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (81, 'Migration20240821170920', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (82, 'Migration20240827133639', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (83, 'Migration20240902195921', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (84, 'Migration20240913092514', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (85, 'Migration20240930122627', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (86, 'Migration20241014142943', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (87, 'Migration20241106085223', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (88, 'Migration20241129124827', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (89, 'Migration20241217162224', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (90, 'Migration20250326151554', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (91, 'Migration20250522181137', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (92, 'Migration20250702095353', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (93, 'Migration20250704120229', '2025-07-18 03:01:28.47955+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (94, 'Migration20240205025928', '2025-07-18 03:01:28.708684+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (95, 'Migration20240529080336', '2025-07-18 03:01:28.708684+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (96, 'Migration20241202100304', '2025-07-18 03:01:28.708684+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (97, 'Migration20240214033943', '2025-07-18 03:01:28.779255+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (98, 'Migration20240703095850', '2025-07-18 03:01:28.779255+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (99, 'Migration20241202103352', '2025-07-18 03:01:28.779255+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (100, 'Migration20240311145700_InitialSetupMigration', '2025-07-18 03:01:28.827928+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (101, 'Migration20240821170957', '2025-07-18 03:01:28.827928+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (102, 'Migration20240917161003', '2025-07-18 03:01:28.827928+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (103, 'Migration20241217110416', '2025-07-18 03:01:28.827928+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (104, 'Migration20250113122235', '2025-07-18 03:01:28.827928+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (105, 'Migration20250120115002', '2025-07-18 03:01:28.827928+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (106, 'Migration20240509083918_InitialSetupMigration', '2025-07-18 03:01:28.981998+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (107, 'Migration20240628075401', '2025-07-18 03:01:28.981998+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (108, 'Migration20240830094712', '2025-07-18 03:01:28.981998+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (109, 'Migration20250120110514', '2025-07-18 03:01:28.981998+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (110, 'Migration20231228143900', '2025-07-18 03:01:29.073037+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (111, 'Migration20241206101446', '2025-07-18 03:01:29.073037+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (112, 'Migration20250128174331', '2025-07-18 03:01:29.073037+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (113, 'Migration20250505092459', '2025-07-18 03:01:29.073037+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (114, 'Migration20250717162007', '2025-08-29 03:39:00.936372+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (115, 'Migration20250822130931', '2025-08-29 03:39:01.056774+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (116, 'Migration20250825132614', '2025-08-29 03:39:01.056774+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (117, 'Migration20250819104213', '2025-08-29 03:39:01.157494+00');
INSERT INTO "public"."mikro_orm_migrations" ("id", "name", "executed_at") VALUES (118, 'Migration20250829033855', '2025-08-29 03:39:01.216285+00');
COMMIT;

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS "public"."notification";
CREATE TABLE "public"."notification" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "to" text COLLATE "pg_catalog"."default" NOT NULL,
  "channel" text COLLATE "pg_catalog"."default" NOT NULL,
  "template" text COLLATE "pg_catalog"."default" NOT NULL,
  "data" jsonb,
  "trigger_type" text COLLATE "pg_catalog"."default",
  "resource_id" text COLLATE "pg_catalog"."default",
  "resource_type" text COLLATE "pg_catalog"."default",
  "receiver_id" text COLLATE "pg_catalog"."default",
  "original_notification_id" text COLLATE "pg_catalog"."default",
  "idempotency_key" text COLLATE "pg_catalog"."default",
  "external_id" text COLLATE "pg_catalog"."default",
  "provider_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'pending'::text
)
;
ALTER TABLE "public"."notification" OWNER TO "postgres";

-- ----------------------------
-- Records of notification
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for notification_provider
-- ----------------------------
DROP TABLE IF EXISTS "public"."notification_provider";
CREATE TABLE "public"."notification_provider" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "handle" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_enabled" bool NOT NULL DEFAULT true,
  "channels" text[] COLLATE "pg_catalog"."default" NOT NULL DEFAULT '{}'::text[],
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."notification_provider" OWNER TO "postgres";

-- ----------------------------
-- Records of notification_provider
-- ----------------------------
BEGIN;
INSERT INTO "public"."notification_provider" ("id", "handle", "name", "is_enabled", "channels", "created_at", "updated_at", "deleted_at") VALUES ('local', 'local', 'local', 't', '{feed}', '2025-07-18 03:01:30.375+00', '2025-07-18 03:01:30.375+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS "public"."order";
CREATE TABLE "public"."order" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "region_id" text COLLATE "pg_catalog"."default",
  "display_id" int4 DEFAULT nextval('order_display_id_seq'::regclass),
  "customer_id" text COLLATE "pg_catalog"."default",
  "version" int4 NOT NULL DEFAULT 1,
  "sales_channel_id" text COLLATE "pg_catalog"."default",
  "status" "public"."order_status_enum" NOT NULL DEFAULT 'pending'::order_status_enum,
  "is_draft_order" bool NOT NULL DEFAULT false,
  "email" text COLLATE "pg_catalog"."default",
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "shipping_address_id" text COLLATE "pg_catalog"."default",
  "billing_address_id" text COLLATE "pg_catalog"."default",
  "no_notification" bool,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "canceled_at" timestamptz(6)
)
;
ALTER TABLE "public"."order" OWNER TO "postgres";

-- ----------------------------
-- Records of order
-- ----------------------------
BEGIN;
INSERT INTO "public"."order" ("id", "region_id", "display_id", "customer_id", "version", "sales_channel_id", "status", "is_draft_order", "email", "currency_code", "shipping_address_id", "billing_address_id", "no_notification", "metadata", "created_at", "updated_at", "deleted_at", "canceled_at") VALUES ('order_01K38B662RTMWSDZD5ZQKYWPT2', 'reg_01K33FFDX0M838JWM069761552', 1, 'cus_01K38AJPD0KBWRW4Y2EHBQWFW4', 3, 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'pending', 'f', 'alrocha@gmail.com', 'idr', 'ordaddr_01K38B662N2RWASJYNCQQHPTPY', 'ordaddr_01K38B662NKQCSSRGH0BMYPDG1', 'f', NULL, '2025-08-22 07:34:14.875+00', '2025-08-22 07:35:00.201+00', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_address
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_address";
CREATE TABLE "public"."order_address" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "customer_id" text COLLATE "pg_catalog"."default",
  "company" text COLLATE "pg_catalog"."default",
  "first_name" text COLLATE "pg_catalog"."default",
  "last_name" text COLLATE "pg_catalog"."default",
  "address_1" text COLLATE "pg_catalog"."default",
  "address_2" text COLLATE "pg_catalog"."default",
  "city" text COLLATE "pg_catalog"."default",
  "country_code" text COLLATE "pg_catalog"."default",
  "province" text COLLATE "pg_catalog"."default",
  "postal_code" text COLLATE "pg_catalog"."default",
  "phone" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_address" OWNER TO "postgres";

-- ----------------------------
-- Records of order_address
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ordaddr_01K38B662NKQCSSRGH0BMYPDG1', NULL, '', 'Al Rocha', 'Cabrerra', 'Jl. Simponi No. 21', '', 'Bandung', 'id', 'Jawa Barat', '40264', '', NULL, '2025-08-22 07:23:42.697+00', '2025-08-22 07:23:42.697+00', NULL);
INSERT INTO "public"."order_address" ("id", "customer_id", "company", "first_name", "last_name", "address_1", "address_2", "city", "country_code", "province", "postal_code", "phone", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ordaddr_01K38B662N2RWASJYNCQQHPTPY', NULL, '', 'Al Rocha', 'Cabrerra', 'Jl. Simponi No. 21', '', 'Bandung', 'id', 'Jawa Barat', '40264', '', NULL, '2025-08-22 07:23:42.697+00', '2025-08-22 07:23:42.697+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_cart
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_cart";
CREATE TABLE "public"."order_cart" (
  "order_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "cart_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_cart" OWNER TO "postgres";

-- ----------------------------
-- Records of order_cart
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_cart" ("order_id", "cart_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('order_01K38B662RTMWSDZD5ZQKYWPT2', 'cart_01K33CW1JP7SDSJ6WYD5KJ08X3', 'ordercart_01K38B665HSSV49DZB7GRV7WRG', '2025-08-22 07:34:14.960543+00', '2025-08-22 07:34:14.960543+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_change
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_change";
CREATE TABLE "public"."order_change" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "version" int4 NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'pending'::text,
  "internal_note" text COLLATE "pg_catalog"."default",
  "created_by" text COLLATE "pg_catalog"."default",
  "requested_by" text COLLATE "pg_catalog"."default",
  "requested_at" timestamptz(6),
  "confirmed_by" text COLLATE "pg_catalog"."default",
  "confirmed_at" timestamptz(6),
  "declined_by" text COLLATE "pg_catalog"."default",
  "declined_reason" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "declined_at" timestamptz(6),
  "canceled_by" text COLLATE "pg_catalog"."default",
  "canceled_at" timestamptz(6),
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "change_type" text COLLATE "pg_catalog"."default",
  "deleted_at" timestamptz(6),
  "return_id" text COLLATE "pg_catalog"."default",
  "claim_id" text COLLATE "pg_catalog"."default",
  "exchange_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."order_change" OWNER TO "postgres";

-- ----------------------------
-- Records of order_change
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_change" ("id", "order_id", "version", "description", "status", "internal_note", "created_by", "requested_by", "requested_at", "confirmed_by", "confirmed_at", "declined_by", "declined_reason", "metadata", "declined_at", "canceled_by", "canceled_at", "created_at", "updated_at", "change_type", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordch_01K38B78NAKJC58S982X4CSDVW', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 2, NULL, 'confirmed', NULL, NULL, NULL, NULL, NULL, '2025-08-22 07:34:50.296+00', NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-22 07:34:50.282+00', '2025-08-22 07:34:50.3+00', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."order_change" ("id", "order_id", "version", "description", "status", "internal_note", "created_by", "requested_by", "requested_at", "confirmed_by", "confirmed_at", "declined_by", "declined_reason", "metadata", "declined_at", "canceled_by", "canceled_at", "created_at", "updated_at", "change_type", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordch_01K38B7J9XH86ERHGJAKZZZBVF', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 3, NULL, 'confirmed', NULL, NULL, NULL, NULL, NULL, '2025-08-22 07:35:00.171+00', NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-22 07:35:00.157+00', '2025-08-22 07:35:00.176+00', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_change_action
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_change_action";
CREATE TABLE "public"."order_change_action" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default",
  "version" int4,
  "ordering" int8 NOT NULL DEFAULT nextval('order_change_action_ordering_seq'::regclass),
  "order_change_id" text COLLATE "pg_catalog"."default",
  "reference" text COLLATE "pg_catalog"."default",
  "reference_id" text COLLATE "pg_catalog"."default",
  "action" text COLLATE "pg_catalog"."default" NOT NULL,
  "details" jsonb,
  "amount" numeric,
  "raw_amount" jsonb,
  "internal_note" text COLLATE "pg_catalog"."default",
  "applied" bool NOT NULL DEFAULT false,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "return_id" text COLLATE "pg_catalog"."default",
  "claim_id" text COLLATE "pg_catalog"."default",
  "exchange_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."order_change_action" OWNER TO "postgres";

-- ----------------------------
-- Records of order_change_action
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_change_action" ("id", "order_id", "version", "ordering", "order_change_id", "reference", "reference_id", "action", "details", "amount", "raw_amount", "internal_note", "applied", "created_at", "updated_at", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordchact_01K38B78NA156MGVSFA1AG371D', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 2, 1, 'ordch_01K38B78NAKJC58S982X4CSDVW', 'fulfillment', 'ful_01K38B78K3XRCPCKVWN8MY5VV5', 'FULFILL_ITEM', '{"quantity": 1, "reference_id": "ordli_01K38B662S2GB9JV4A7YRCMK9F"}', NULL, NULL, NULL, 't', '2025-08-22 07:34:50.283+00', '2025-08-22 07:34:50.33+00', NULL, NULL, NULL, NULL);
INSERT INTO "public"."order_change_action" ("id", "order_id", "version", "ordering", "order_change_id", "reference", "reference_id", "action", "details", "amount", "raw_amount", "internal_note", "applied", "created_at", "updated_at", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordchact_01K38B7J9XJ8HXVY27G0K999XJ', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 3, 2, 'ordch_01K38B7J9XH86ERHGJAKZZZBVF', 'fulfillment', 'ful_01K38B78K3XRCPCKVWN8MY5VV5', 'DELIVER_ITEM', '{"quantity": "1", "reference_id": "ordli_01K38B662S2GB9JV4A7YRCMK9F"}', NULL, NULL, NULL, 't', '2025-08-22 07:35:00.158+00', '2025-08-22 07:35:00.202+00', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_claim
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_claim";
CREATE TABLE "public"."order_claim" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "return_id" text COLLATE "pg_catalog"."default",
  "order_version" int4 NOT NULL,
  "display_id" int4 NOT NULL DEFAULT nextval('order_claim_display_id_seq'::regclass),
  "type" "public"."order_claim_type_enum" NOT NULL,
  "no_notification" bool,
  "refund_amount" numeric,
  "raw_refund_amount" jsonb,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "canceled_at" timestamptz(6),
  "created_by" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."order_claim" OWNER TO "postgres";

-- ----------------------------
-- Records of order_claim
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_claim_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_claim_item";
CREATE TABLE "public"."order_claim_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "claim_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_additional_item" bool NOT NULL DEFAULT false,
  "reason" "public"."claim_reason_enum",
  "quantity" numeric NOT NULL,
  "raw_quantity" jsonb NOT NULL,
  "note" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_claim_item" OWNER TO "postgres";

-- ----------------------------
-- Records of order_claim_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_claim_item_image
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_claim_item_image";
CREATE TABLE "public"."order_claim_item_image" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "claim_item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "url" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_claim_item_image" OWNER TO "postgres";

-- ----------------------------
-- Records of order_claim_item_image
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_credit_line
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_credit_line";
CREATE TABLE "public"."order_credit_line" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "reference" text COLLATE "pg_catalog"."default",
  "reference_id" text COLLATE "pg_catalog"."default",
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_credit_line" OWNER TO "postgres";

-- ----------------------------
-- Records of order_credit_line
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_exchange
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_exchange";
CREATE TABLE "public"."order_exchange" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "return_id" text COLLATE "pg_catalog"."default",
  "order_version" int4 NOT NULL,
  "display_id" int4 NOT NULL DEFAULT nextval('order_exchange_display_id_seq'::regclass),
  "no_notification" bool,
  "allow_backorder" bool NOT NULL DEFAULT false,
  "difference_due" numeric,
  "raw_difference_due" jsonb,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "canceled_at" timestamptz(6),
  "created_by" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."order_exchange" OWNER TO "postgres";

-- ----------------------------
-- Records of order_exchange
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_exchange_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_exchange_item";
CREATE TABLE "public"."order_exchange_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "exchange_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "quantity" numeric NOT NULL,
  "raw_quantity" jsonb NOT NULL,
  "note" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_exchange_item" OWNER TO "postgres";

-- ----------------------------
-- Records of order_exchange_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_fulfillment
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_fulfillment";
CREATE TABLE "public"."order_fulfillment" (
  "order_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "fulfillment_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_fulfillment" OWNER TO "postgres";

-- ----------------------------
-- Records of order_fulfillment
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_fulfillment" ("order_id", "fulfillment_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('order_01K38B662RTMWSDZD5ZQKYWPT2', 'ful_01K38B78K3XRCPCKVWN8MY5VV5', 'ordful_01K38B78N0GQPFA1SMJWC911V4', '2025-08-22 07:34:50.271064+00', '2025-08-22 07:34:50.271064+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_item";
CREATE TABLE "public"."order_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "version" int4 NOT NULL,
  "item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "quantity" numeric NOT NULL,
  "raw_quantity" jsonb NOT NULL,
  "fulfilled_quantity" numeric NOT NULL,
  "raw_fulfilled_quantity" jsonb NOT NULL,
  "shipped_quantity" numeric NOT NULL,
  "raw_shipped_quantity" jsonb NOT NULL,
  "return_requested_quantity" numeric NOT NULL,
  "raw_return_requested_quantity" jsonb NOT NULL,
  "return_received_quantity" numeric NOT NULL,
  "raw_return_received_quantity" jsonb NOT NULL,
  "return_dismissed_quantity" numeric NOT NULL,
  "raw_return_dismissed_quantity" jsonb NOT NULL,
  "written_off_quantity" numeric NOT NULL,
  "raw_written_off_quantity" jsonb NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "delivered_quantity" numeric NOT NULL DEFAULT 0,
  "raw_delivered_quantity" jsonb NOT NULL,
  "unit_price" numeric,
  "raw_unit_price" jsonb,
  "compare_at_unit_price" numeric,
  "raw_compare_at_unit_price" jsonb
)
;
ALTER TABLE "public"."order_item" OWNER TO "postgres";

-- ----------------------------
-- Records of order_item
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_item" ("id", "order_id", "version", "item_id", "quantity", "raw_quantity", "fulfilled_quantity", "raw_fulfilled_quantity", "shipped_quantity", "raw_shipped_quantity", "return_requested_quantity", "raw_return_requested_quantity", "return_received_quantity", "raw_return_received_quantity", "return_dismissed_quantity", "raw_return_dismissed_quantity", "written_off_quantity", "raw_written_off_quantity", "metadata", "created_at", "updated_at", "deleted_at", "delivered_quantity", "raw_delivered_quantity", "unit_price", "raw_unit_price", "compare_at_unit_price", "raw_compare_at_unit_price") VALUES ('orditem_01K38B662T4ST80A7TW0SNNYJ7', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 1, 'ordli_01K38B662S2GB9JV4A7YRCMK9F', 1, '{"value": "1", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', NULL, '2025-08-22 07:34:14.875+00', '2025-08-22 07:34:14.875+00', NULL, 0, '{"value": "0", "precision": 20}', NULL, NULL, NULL, NULL);
INSERT INTO "public"."order_item" ("id", "order_id", "version", "item_id", "quantity", "raw_quantity", "fulfilled_quantity", "raw_fulfilled_quantity", "shipped_quantity", "raw_shipped_quantity", "return_requested_quantity", "raw_return_requested_quantity", "return_received_quantity", "raw_return_received_quantity", "return_dismissed_quantity", "raw_return_dismissed_quantity", "written_off_quantity", "raw_written_off_quantity", "metadata", "created_at", "updated_at", "deleted_at", "delivered_quantity", "raw_delivered_quantity", "unit_price", "raw_unit_price", "compare_at_unit_price", "raw_compare_at_unit_price") VALUES ('orditem_01K38B78PJDGVCSKDPK78YMPQ2', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 2, 'ordli_01K38B662S2GB9JV4A7YRCMK9F', 1, '{"value": "1", "precision": 20}', 1, '{"value": "1", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', NULL, '2025-08-22 07:34:50.329+00', '2025-08-22 07:34:50.329+00', NULL, 0, '{"value": "0", "precision": 20}', 240000, '{"value": "240000", "precision": 20}', NULL, NULL);
INSERT INTO "public"."order_item" ("id", "order_id", "version", "item_id", "quantity", "raw_quantity", "fulfilled_quantity", "raw_fulfilled_quantity", "shipped_quantity", "raw_shipped_quantity", "return_requested_quantity", "raw_return_requested_quantity", "return_received_quantity", "raw_return_received_quantity", "return_dismissed_quantity", "raw_return_dismissed_quantity", "written_off_quantity", "raw_written_off_quantity", "metadata", "created_at", "updated_at", "deleted_at", "delivered_quantity", "raw_delivered_quantity", "unit_price", "raw_unit_price", "compare_at_unit_price", "raw_compare_at_unit_price") VALUES ('orditem_01K38B7JB3MQHXZ83RD1BD7DF4', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 3, 'ordli_01K38B662S2GB9JV4A7YRCMK9F', 1, '{"value": "1", "precision": 20}', 1, '{"value": "1", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', 0, '{"value": "0", "precision": 20}', NULL, '2025-08-22 07:35:00.201+00', '2025-08-22 07:35:00.201+00', NULL, 1, '{"value": "1", "precision": 20}', 240000, '{"value": "240000", "precision": 20}', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_line_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_line_item";
CREATE TABLE "public"."order_line_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "totals_id" text COLLATE "pg_catalog"."default",
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "subtitle" text COLLATE "pg_catalog"."default",
  "thumbnail" text COLLATE "pg_catalog"."default",
  "variant_id" text COLLATE "pg_catalog"."default",
  "product_id" text COLLATE "pg_catalog"."default",
  "product_title" text COLLATE "pg_catalog"."default",
  "product_description" text COLLATE "pg_catalog"."default",
  "product_subtitle" text COLLATE "pg_catalog"."default",
  "product_type" text COLLATE "pg_catalog"."default",
  "product_collection" text COLLATE "pg_catalog"."default",
  "product_handle" text COLLATE "pg_catalog"."default",
  "variant_sku" text COLLATE "pg_catalog"."default",
  "variant_barcode" text COLLATE "pg_catalog"."default",
  "variant_title" text COLLATE "pg_catalog"."default",
  "variant_option_values" jsonb,
  "requires_shipping" bool NOT NULL DEFAULT true,
  "is_discountable" bool NOT NULL DEFAULT true,
  "is_tax_inclusive" bool NOT NULL DEFAULT false,
  "compare_at_unit_price" numeric,
  "raw_compare_at_unit_price" jsonb,
  "unit_price" numeric NOT NULL,
  "raw_unit_price" jsonb NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "is_custom_price" bool NOT NULL DEFAULT false,
  "product_type_id" text COLLATE "pg_catalog"."default",
  "is_giftcard" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "public"."order_line_item" OWNER TO "postgres";

-- ----------------------------
-- Records of order_line_item
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_line_item" ("id", "totals_id", "title", "subtitle", "thumbnail", "variant_id", "product_id", "product_title", "product_description", "product_subtitle", "product_type", "product_collection", "product_handle", "variant_sku", "variant_barcode", "variant_title", "variant_option_values", "requires_shipping", "is_discountable", "is_tax_inclusive", "compare_at_unit_price", "raw_compare_at_unit_price", "unit_price", "raw_unit_price", "metadata", "created_at", "updated_at", "deleted_at", "is_custom_price", "product_type_id", "is_giftcard") VALUES ('ordli_01K38B662S2GB9JV4A7YRCMK9F', NULL, 'Medusa Sweatshirt', 'S', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png', 'variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'prod_01K0DQNR60DXF0084R3YNQHSXJ', 'Medusa Sweatshirt', 'Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.', NULL, NULL, NULL, 'sweatshirt', 'SWEATSHIRT-S', NULL, 'S', NULL, 't', 't', 'f', NULL, NULL, 240000, '{"value": "240000", "precision": 20}', '{}', '2025-08-22 07:34:14.875+00', '2025-08-22 07:34:14.875+00', NULL, 'f', NULL, 'f');
COMMIT;

-- ----------------------------
-- Table structure for order_line_item_adjustment
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_line_item_adjustment";
CREATE TABLE "public"."order_line_item_adjustment" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "promotion_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default",
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "deleted_at" timestamptz(6),
  "is_tax_inclusive" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "public"."order_line_item_adjustment" OWNER TO "postgres";

-- ----------------------------
-- Records of order_line_item_adjustment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_line_item_tax_line
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_line_item_tax_line";
CREATE TABLE "public"."order_line_item_tax_line" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "tax_rate_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "rate" numeric NOT NULL,
  "raw_rate" jsonb NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_line_item_tax_line" OWNER TO "postgres";

-- ----------------------------
-- Records of order_line_item_tax_line
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_payment_collection
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_payment_collection";
CREATE TABLE "public"."order_payment_collection" (
  "order_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "payment_collection_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_payment_collection" OWNER TO "postgres";

-- ----------------------------
-- Records of order_payment_collection
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_payment_collection" ("order_id", "payment_collection_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('order_01K38B662RTMWSDZD5ZQKYWPT2', 'pay_col_01K38B5ZBK6GQS7AKVQNS5APWX', 'ordpay_01K38B665JAMR4KKYAGMQ5FA0T', '2025-08-22 07:34:14.960616+00', '2025-08-22 07:34:14.960616+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_promotion
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_promotion";
CREATE TABLE "public"."order_promotion" (
  "order_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "promotion_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_promotion" OWNER TO "postgres";

-- ----------------------------
-- Records of order_promotion
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_shipping
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_shipping";
CREATE TABLE "public"."order_shipping" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "version" int4 NOT NULL,
  "shipping_method_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "return_id" text COLLATE "pg_catalog"."default",
  "claim_id" text COLLATE "pg_catalog"."default",
  "exchange_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."order_shipping" OWNER TO "postgres";

-- ----------------------------
-- Records of order_shipping
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_shipping" ("id", "order_id", "version", "shipping_method_id", "created_at", "updated_at", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordspmv_01K38B662R1KSCH3BZ0YTY95E7', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 1, 'ordsm_01K38B662R30MT96GG0EZQ44HF', '2025-08-22 07:34:14.875+00', '2025-08-22 07:34:14.875+00', NULL, NULL, NULL, NULL);
INSERT INTO "public"."order_shipping" ("id", "order_id", "version", "shipping_method_id", "created_at", "updated_at", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordspmv_01K38B78PK82Y6JB7ASSM8EVJ5', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 2, 'ordsm_01K38B662R30MT96GG0EZQ44HF', '2025-08-22 07:34:14.875+00', '2025-08-22 07:34:14.875+00', NULL, NULL, NULL, NULL);
INSERT INTO "public"."order_shipping" ("id", "order_id", "version", "shipping_method_id", "created_at", "updated_at", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordspmv_01K38B7JB3E6CJ551HMYSAXG7C', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 3, 'ordsm_01K38B662R30MT96GG0EZQ44HF', '2025-08-22 07:34:14.875+00', '2025-08-22 07:34:14.875+00', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_shipping_method
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_shipping_method";
CREATE TABLE "public"."order_shipping_method" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" jsonb,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "is_tax_inclusive" bool NOT NULL DEFAULT false,
  "shipping_option_id" text COLLATE "pg_catalog"."default",
  "data" jsonb,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "is_custom_amount" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "public"."order_shipping_method" OWNER TO "postgres";

-- ----------------------------
-- Records of order_shipping_method
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_shipping_method" ("id", "name", "description", "amount", "raw_amount", "is_tax_inclusive", "shipping_option_id", "data", "metadata", "created_at", "updated_at", "deleted_at", "is_custom_amount") VALUES ('ordsm_01K38B662R30MT96GG0EZQ44HF', 'Fixed Manual', NULL, 50000, '{"value": "50000", "precision": 20}', 'f', 'so_01K38B4T1FCQDKK7TT2MPC8DCG', '{}', NULL, '2025-08-22 07:34:14.875+00', '2025-08-22 07:34:14.875+00', NULL, 'f');
COMMIT;

-- ----------------------------
-- Table structure for order_shipping_method_adjustment
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_shipping_method_adjustment";
CREATE TABLE "public"."order_shipping_method_adjustment" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "promotion_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default",
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "shipping_method_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_shipping_method_adjustment" OWNER TO "postgres";

-- ----------------------------
-- Records of order_shipping_method_adjustment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_shipping_method_tax_line
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_shipping_method_tax_line";
CREATE TABLE "public"."order_shipping_method_tax_line" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "tax_rate_id" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "rate" numeric NOT NULL,
  "raw_rate" jsonb NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "shipping_method_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_shipping_method_tax_line" OWNER TO "postgres";

-- ----------------------------
-- Records of order_shipping_method_tax_line
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_summary
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_summary";
CREATE TABLE "public"."order_summary" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "version" int4 NOT NULL DEFAULT 1,
  "totals" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."order_summary" OWNER TO "postgres";

-- ----------------------------
-- Records of order_summary
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_summary" ("id", "order_id", "version", "totals", "created_at", "updated_at", "deleted_at") VALUES ('ordsum_01K38B662QH8BCMTKHSFE1MBDF', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 1, '{"paid_total": 290000, "raw_paid_total": {"value": "290000", "precision": 20}, "refunded_total": 0, "accounting_total": 290000, "credit_line_total": 0, "transaction_total": 290000, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 290000, "original_order_total": 290000, "raw_accounting_total": {"value": "290000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "290000", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "290000", "precision": 20}, "raw_original_order_total": {"value": "290000", "precision": 20}}', '2025-08-22 07:34:14.875+00', '2025-08-22 07:34:39.851+00', NULL);
INSERT INTO "public"."order_summary" ("id", "order_id", "version", "totals", "created_at", "updated_at", "deleted_at") VALUES ('ordsum_01K38B78PJYJC1N0AC38VP7NP6', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 2, '{"paid_total": 290000, "raw_paid_total": {"value": "290000", "precision": 20}, "refunded_total": 0, "accounting_total": 290000, "credit_line_total": 0, "transaction_total": 290000, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 290000, "original_order_total": 290000, "raw_accounting_total": {"value": "290000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "290000", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "290000", "precision": 20}, "raw_original_order_total": {"value": "290000", "precision": 20}}', '2025-08-22 07:34:50.33+00', '2025-08-22 07:34:50.33+00', NULL);
INSERT INTO "public"."order_summary" ("id", "order_id", "version", "totals", "created_at", "updated_at", "deleted_at") VALUES ('ordsum_01K38B7JB3KRVGMPCCY9N1R51R', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 3, '{"paid_total": 290000, "raw_paid_total": {"value": "290000", "precision": 20}, "refunded_total": 0, "accounting_total": 290000, "credit_line_total": 0, "transaction_total": 290000, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 290000, "original_order_total": 290000, "raw_accounting_total": {"value": "290000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "290000", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "290000", "precision": 20}, "raw_original_order_total": {"value": "290000", "precision": 20}}', '2025-08-22 07:35:00.201+00', '2025-08-22 07:35:00.201+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_transaction
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_transaction";
CREATE TABLE "public"."order_transaction" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "version" int4 NOT NULL DEFAULT 1,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "reference" text COLLATE "pg_catalog"."default",
  "reference_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "return_id" text COLLATE "pg_catalog"."default",
  "claim_id" text COLLATE "pg_catalog"."default",
  "exchange_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."order_transaction" OWNER TO "postgres";

-- ----------------------------
-- Records of order_transaction
-- ----------------------------
BEGIN;
INSERT INTO "public"."order_transaction" ("id", "order_id", "version", "amount", "raw_amount", "currency_code", "reference", "reference_id", "created_at", "updated_at", "deleted_at", "return_id", "claim_id", "exchange_id") VALUES ('ordtrx_01K38B6YE7YQ4SH301T672EPEA', 'order_01K38B662RTMWSDZD5ZQKYWPT2', 1, 290000, '{"value": "290000", "precision": 20}', 'idr', 'capture', 'capt_01K38B6YBD1DZ246KFY5R70NQZ', '2025-08-22 07:34:39.816+00', '2025-08-22 07:34:39.816+00', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS "public"."payment";
CREATE TABLE "public"."payment" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "data" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "captured_at" timestamptz(6),
  "canceled_at" timestamptz(6),
  "payment_collection_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "payment_session_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb
)
;
ALTER TABLE "public"."payment" OWNER TO "postgres";

-- ----------------------------
-- Records of payment
-- ----------------------------
BEGIN;
INSERT INTO "public"."payment" ("id", "amount", "raw_amount", "currency_code", "provider_id", "data", "created_at", "updated_at", "deleted_at", "captured_at", "canceled_at", "payment_collection_id", "payment_session_id", "metadata") VALUES ('pay_01K38B666YHMYFNN1XNB33B719', 290000, '{"value": "290000", "precision": 20}', 'idr', 'pp_system_default', '{}', '2025-08-22 07:34:15.006+00', '2025-08-22 07:34:39.749+00', NULL, '2025-08-22 07:34:39.736+00', NULL, 'pay_col_01K38B5ZBK6GQS7AKVQNS5APWX', 'payses_01K38B5ZCX9ZSHPP1AW6FPEAE2', NULL);
COMMIT;

-- ----------------------------
-- Table structure for payment_collection
-- ----------------------------
DROP TABLE IF EXISTS "public"."payment_collection";
CREATE TABLE "public"."payment_collection" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "authorized_amount" numeric,
  "raw_authorized_amount" jsonb,
  "captured_amount" numeric,
  "raw_captured_amount" jsonb,
  "refunded_amount" numeric,
  "raw_refunded_amount" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "completed_at" timestamptz(6),
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'not_paid'::text,
  "metadata" jsonb
)
;
ALTER TABLE "public"."payment_collection" OWNER TO "postgres";

-- ----------------------------
-- Records of payment_collection
-- ----------------------------
BEGIN;
INSERT INTO "public"."payment_collection" ("id", "currency_code", "amount", "raw_amount", "authorized_amount", "raw_authorized_amount", "captured_amount", "raw_captured_amount", "refunded_amount", "raw_refunded_amount", "created_at", "updated_at", "deleted_at", "completed_at", "status", "metadata") VALUES ('pay_col_01K38B5ZBK6GQS7AKVQNS5APWX', 'idr', 290000, '{"value": "290000", "precision": 20}', 290000, '{"value": "290000", "precision": 20}', 290000, '{"value": "290000", "precision": 20}', 0, '{"value": "0", "precision": 20}', '2025-08-22 07:34:07.987+00', '2025-08-22 07:34:39.784+00', NULL, '2025-08-22 07:34:39.777+00', 'completed', NULL);
COMMIT;

-- ----------------------------
-- Table structure for payment_collection_payment_providers
-- ----------------------------
DROP TABLE IF EXISTS "public"."payment_collection_payment_providers";
CREATE TABLE "public"."payment_collection_payment_providers" (
  "payment_collection_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "payment_provider_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."payment_collection_payment_providers" OWNER TO "postgres";

-- ----------------------------
-- Records of payment_collection_payment_providers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for payment_provider
-- ----------------------------
DROP TABLE IF EXISTS "public"."payment_provider";
CREATE TABLE "public"."payment_provider" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_enabled" bool NOT NULL DEFAULT true,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."payment_provider" OWNER TO "postgres";

-- ----------------------------
-- Records of payment_provider
-- ----------------------------
BEGIN;
INSERT INTO "public"."payment_provider" ("id", "is_enabled", "created_at", "updated_at", "deleted_at") VALUES ('pp_system_default', 't', '2025-07-18 03:01:30.387+00', '2025-07-18 03:01:30.387+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for payment_session
-- ----------------------------
DROP TABLE IF EXISTS "public"."payment_session";
CREATE TABLE "public"."payment_session" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "data" jsonb NOT NULL DEFAULT '{}'::jsonb,
  "context" jsonb,
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'pending'::text,
  "authorized_at" timestamptz(6),
  "payment_collection_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."payment_session" OWNER TO "postgres";

-- ----------------------------
-- Records of payment_session
-- ----------------------------
BEGIN;
INSERT INTO "public"."payment_session" ("id", "currency_code", "amount", "raw_amount", "provider_id", "data", "context", "status", "authorized_at", "payment_collection_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('payses_01K38B5ZCX9ZSHPP1AW6FPEAE2', 'idr', 290000, '{"value": "290000", "precision": 20}', 'pp_system_default', '{}', '{}', 'authorized', '2025-08-22 07:34:15.005+00', 'pay_col_01K38B5ZBK6GQS7AKVQNS5APWX', '{}', '2025-08-22 07:34:08.029+00', '2025-08-22 07:34:15.007+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for price
-- ----------------------------
DROP TABLE IF EXISTS "public"."price";
CREATE TABLE "public"."price" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default",
  "price_set_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "rules_count" int4 DEFAULT 0,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "price_list_id" text COLLATE "pg_catalog"."default",
  "amount" numeric NOT NULL,
  "min_quantity" int4,
  "max_quantity" int4
)
;
ALTER TABLE "public"."price" OWNER TO "postgres";

-- ----------------------------
-- Records of price
-- ----------------------------
BEGIN;
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR38NW0F9SR0W4AFV48J', NULL, 'pset_01K0DQNR397KW016XRAXC77EB2', 'usd', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR3946CYY8VVAJ992AJR', NULL, 'pset_01K0DQNR397KW016XRAXC77EB2', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR3902T367DZWXV3F626', NULL, 'pset_01K0DQNR397KW016XRAXC77EB2', 'eur', '{"value": "10", "precision": 20}', 1, '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR3999223M0QD8DKZ98V', NULL, 'pset_01K0DQNR393J1JRXAJM1KFWD58', 'usd', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR39JQ7794SK2R5EDPMH', NULL, 'pset_01K0DQNR393J1JRXAJM1KFWD58', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR39J4AR25QBP6DYR0GD', NULL, 'pset_01K0DQNR393J1JRXAJM1KFWD58', 'eur', '{"value": "10", "precision": 20}', 1, '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9R3455K2XX65HWD2W9', NULL, 'pset_01K0DQNR9S01R7K62BXDDGWM70', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9Q8YGCKR3A310HXKNQ', NULL, 'pset_01K0DQNR9RFQDS8C039XSSS2FQ', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9R6GJMX4A7V6DNSF8T', NULL, 'pset_01K0DQNR9RFQDS8C039XSSS2FQ', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QEQQ6DH80H0RMTYGP', NULL, 'pset_01K0DQNR9QHKWPASA05WN6GEPF', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QJE1RAYB86GJTETWN', NULL, 'pset_01K0DQNR9QHKWPASA05WN6GEPF', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RD8B15PXY63HS5FE5', NULL, 'pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RX936HVWRT9DQV21G', NULL, 'pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RDAP1AH0VX8688XMD', NULL, 'pset_01K0DQNR9R23H0ZDHTQQ6G3G50', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9R1FWJZV9GVR26BKD1', NULL, 'pset_01K0DQNR9R23H0ZDHTQQ6G3G50', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9R8QE10PRHME0DCZ33', NULL, 'pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RX4E7CATQXG19T0EW', NULL, 'pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RWFBTQ3PEM7NDY50C', NULL, 'pset_01K0DQNR9R7RYE16M414CDW0T7', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RA9HPW0AFAJ7B277Z', NULL, 'pset_01K0DQNR9R7RYE16M414CDW0T7', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9Q2SR5TFMJ39VMD486', NULL, 'pset_01K0DQNR9QX36JXEB5JYQAHKM3', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9Q66D175WPRHND2EGP', NULL, 'pset_01K0DQNR9QX36JXEB5JYQAHKM3', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9PXY9RDMY0T7T00JG9', NULL, 'pset_01K0DQNR9P6KDDEBCQ4JFPF6YG', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QR5YWBXEK7VBKMD29', NULL, 'pset_01K0DQNR9Q4F3AQT23RVWMDMD7', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QP3GY47FCE7VMPG44', NULL, 'pset_01K0DQNR9Q4F3AQT23RVWMDMD7', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QAKF6K5AV55QCPXS2', NULL, 'pset_01K0DQNR9Q3RPKX6ES79KE0YRV', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QZTF12KC12JQ4PTEZ', NULL, 'pset_01K0DQNR9Q3RPKX6ES79KE0YRV', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QF4PPTC0NRVYHHM0P', NULL, 'pset_01K0DQNR9QYY9FA462VKZ3VC6K', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QG9CZ0822MS2ZSYCT', NULL, 'pset_01K0DQNR9QYY9FA462VKZ3VC6K', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9Q1THQB126XMSDR946', NULL, 'pset_01K0DQNR9QP6RB0JSZQ09P4FHN', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QA9EK690PS3A39FV9', NULL, 'pset_01K0DQNR9QP6RB0JSZQ09P4FHN', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9PVPPHP7SYD4W3JZMC', NULL, 'pset_01K0DQNR9PB3DN7FPEWR724T17', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9PT6PM7NK77XTTZ7EA', NULL, 'pset_01K0DQNR9PB3DN7FPEWR724T17', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9PJDA9MQY3XVBV9AWX', NULL, 'pset_01K0DQNR9Q2GT6RYB58AA208RQ', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9PBEAF2ZTY5N70EKWD', NULL, 'pset_01K0DQNR9Q2GT6RYB58AA208RQ', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RR3YNS91DZ04A0DCK', NULL, 'pset_01K0DQNR9RJ93XG4FXSNA23CPF', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9R5PCNFV650MGSE0S6', NULL, 'pset_01K0DQNR9RJ93XG4FXSNA23CPF', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RJHND2NXQ34AJM8JY', NULL, 'pset_01K0DQNR9R701E5WPGBDKM7064', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9R2K4FAMDSE6J9KSRZ', NULL, 'pset_01K0DQNR9R701E5WPGBDKM7064', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RBY5RSSVNA1G33YZC', NULL, 'pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RQWXST33ZSV1G0SB0', NULL, 'pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QH6KPZ693X2KC73E5', NULL, 'pset_01K0DQNR9QZBBNVWDZY1HWABQY', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9QY5892E2YG4729K46', NULL, 'pset_01K0DQNR9QZBBNVWDZY1HWABQY', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FJT4S0R2R22TB8EPBBASJ', NULL, 'pset_01K0DQNR9QZBBNVWDZY1HWABQY', 'idr', '{"value": "240000", "precision": 20}', 0, '2025-08-20 10:14:50.769141+00', '2025-08-20 10:14:50.769141+00', NULL, NULL, 240000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9RAJGWWA08AC3EX446', NULL, 'pset_01K0DQNR9R98D5B7VKRVY907YJ', 'eur', '{"value": "10", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9R2592NDFZNP2W3QZ2', NULL, 'pset_01K0DQNR9R98D5B7VKRVY907YJ', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FKFJFTJW8MPSPXVSGX12W', NULL, 'pset_01K0DQNR9R98D5B7VKRVY907YJ', 'idr', '{"value": "240000", "precision": 20}', 0, '2025-08-20 10:15:12.715151+00', '2025-08-20 10:15:12.715151+00', NULL, NULL, 240000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FKZKAD3MW7V16RXJQWTEX', NULL, 'pset_01K0DQNR9RFQDS8C039XSSS2FQ', 'idr', '{"value": "240000", "precision": 20}', 0, '2025-08-20 10:15:29.124733+00', '2025-08-20 10:15:29.124733+00', NULL, NULL, 240000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FMAG8AJNM6K1X7FS5JGGM', NULL, 'pset_01K0DQNR9QHKWPASA05WN6GEPF', 'idr', '{"value": "240000", "precision": 20}', 0, '2025-08-20 10:15:40.290489+00', '2025-08-20 10:15:40.290489+00', NULL, NULL, 240000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FMRH71NNM0FF8M85ED0NG', NULL, 'pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ', 'idr', '{"value": "220000", "precision": 20}', 0, '2025-08-20 10:15:54.660451+00', '2025-08-20 10:15:54.660451+00', NULL, NULL, 220000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FNHBFMRPDS2S1ASNZ9P3H', NULL, 'pset_01K0DQNR9R23H0ZDHTQQ6G3G50', 'idr', '{"value": "220000", "precision": 20}', 0, '2025-08-20 10:16:20.073383+00', '2025-08-20 10:16:20.073383+00', NULL, NULL, 220000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FNV3R2AR24G214C9Y5W35', NULL, 'pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ', 'idr', '{"value": "220000", "precision": 20}', 0, '2025-08-20 10:16:30.06626+00', '2025-08-20 10:16:30.06626+00', NULL, NULL, 220000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FP3BGK9HH5E8WYS2GPQVF', NULL, 'pset_01K0DQNR9R7RYE16M414CDW0T7', 'idr', '{"value": "220000", "precision": 20}', 0, '2025-08-20 10:16:38.507242+00', '2025-08-20 10:16:38.507242+00', NULL, NULL, 220000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FPTV1W57AY00KTXW3NKBH', NULL, 'pset_01K0DQNR9QX36JXEB5JYQAHKM3', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:17:02.555841+00', '2025-08-20 10:17:02.555841+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9P1QMAYHTGW4N38MQK', NULL, 'pset_01K0DQNR9P6KDDEBCQ4JFPF6YG', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FQH63CSSTN9FYK4QKZ5DS', NULL, 'pset_01K0DQNR9P6KDDEBCQ4JFPF6YG', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:17:25.438086+00', '2025-08-20 10:17:25.438086+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FQVA7TWT82B2JT3R0JA0T', NULL, 'pset_01K0DQNR9Q4F3AQT23RVWMDMD7', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:17:35.809073+00', '2025-08-20 10:17:35.809073+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FR55KRGSACJ5CJANM5ASQ', NULL, 'pset_01K0DQNR9Q3RPKX6ES79KE0YRV', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:17:45.90384+00', '2025-08-20 10:17:45.90384+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FRCQB5E661TTF35D71JVD', NULL, 'pset_01K0DQNR9QYY9FA462VKZ3VC6K', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:17:53.634741+00', '2025-08-20 10:17:53.634741+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FRM63K3D3K33YZ9ZPCNQ3', NULL, 'pset_01K0DQNR9QP6RB0JSZQ09P4FHN', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:18:01.278067+00', '2025-08-20 10:18:01.278067+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FRVMGQEJSF25J2FKEMGSM', NULL, 'pset_01K0DQNR9PB3DN7FPEWR724T17', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:18:08.908934+00', '2025-08-20 10:18:08.908934+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FS364TMBZAFGSX8FDCTVA', NULL, 'pset_01K0DQNR9Q2GT6RYB58AA208RQ', 'idr', '{"value": "150000", "precision": 20}', 0, '2025-08-20 10:18:16.638888+00', '2025-08-20 10:18:16.638888+00', NULL, NULL, 150000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FSDZ7A67V085GQZKKCA5X', NULL, 'pset_01K0DQNR9RJ93XG4FXSNA23CPF', 'idr', '{"value": "100000", "precision": 20}', 0, '2025-08-20 10:18:27.682599+00', '2025-08-20 10:18:27.682599+00', NULL, NULL, 100000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FSP3NYCH8RJYH2493CEYR', NULL, 'pset_01K0DQNR9R701E5WPGBDKM7064', 'idr', '{"value": "100000", "precision": 20}', 0, '2025-08-20 10:18:36.017413+00', '2025-08-20 10:18:36.017413+00', NULL, NULL, 100000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FSWT1GK37GNRFSXRSNSQK', NULL, 'pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7', 'idr', '{"value": "100000", "precision": 20}', 0, '2025-08-20 10:18:42.87799+00', '2025-08-20 10:18:42.87799+00', NULL, NULL, 100000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K0DQNR9SF42GH9J23WZX8417', NULL, 'pset_01K0DQNR9S01R7K62BXDDGWM70', 'usd', '{"value": "15", "precision": 20}', 0, '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL, NULL, 15, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K33FT3TG3Q63M9KA292CAZRZ', NULL, 'pset_01K0DQNR9S01R7K62BXDDGWM70', 'idr', '{"value": "100000", "precision": 20}', 0, '2025-08-20 10:18:50.058744+00', '2025-08-20 10:18:50.058744+00', NULL, NULL, 100000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K38B4T2K59882D4PP6WS7NHP', NULL, 'pset_01K38B4T2MWXPRPPQW8S67AQEV', 'idr', '{"value": "50000", "precision": 20}', 0, '2025-08-22 07:33:29.813+00', '2025-08-22 07:33:29.813+00', NULL, NULL, 50000, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K38B4T2KDS5KGSBK39AGY019', NULL, 'pset_01K38B4T2MWXPRPPQW8S67AQEV', 'eur', '{"value": "10", "precision": 20}', 0, '2025-08-22 07:33:29.814+00', '2025-08-22 07:33:29.814+00', NULL, NULL, 10, NULL, NULL);
INSERT INTO "public"."price" ("id", "title", "price_set_id", "currency_code", "raw_amount", "rules_count", "created_at", "updated_at", "deleted_at", "price_list_id", "amount", "min_quantity", "max_quantity") VALUES ('price_01K38B4T2MJH66TTDMD7VZAB7P', NULL, 'pset_01K38B4T2MWXPRPPQW8S67AQEV', 'usd', '{"value": "15", "precision": 20}', 0, '2025-08-22 07:33:29.814+00', '2025-08-22 07:33:29.814+00', NULL, NULL, 15, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for price_list
-- ----------------------------
DROP TABLE IF EXISTS "public"."price_list";
CREATE TABLE "public"."price_list" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'draft'::text,
  "starts_at" timestamptz(6),
  "ends_at" timestamptz(6),
  "rules_count" int4 DEFAULT 0,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'sale'::text,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."price_list" OWNER TO "postgres";

-- ----------------------------
-- Records of price_list
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for price_list_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."price_list_rule";
CREATE TABLE "public"."price_list_rule" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "price_list_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "value" jsonb,
  "attribute" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text
)
;
ALTER TABLE "public"."price_list_rule" OWNER TO "postgres";

-- ----------------------------
-- Records of price_list_rule
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for price_preference
-- ----------------------------
DROP TABLE IF EXISTS "public"."price_preference";
CREATE TABLE "public"."price_preference" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "attribute" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default",
  "is_tax_inclusive" bool NOT NULL DEFAULT false,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."price_preference" OWNER TO "postgres";

-- ----------------------------
-- Records of price_preference
-- ----------------------------
BEGIN;
INSERT INTO "public"."price_preference" ("id", "attribute", "value", "is_tax_inclusive", "created_at", "updated_at", "deleted_at") VALUES ('prpref_01K0DQNP7EXVSASDZ7PR6B5665', 'currency_code', 'eur', 'f', '2025-07-18 03:01:32.526+00', '2025-07-18 03:01:32.526+00', NULL);
INSERT INTO "public"."price_preference" ("id", "attribute", "value", "is_tax_inclusive", "created_at", "updated_at", "deleted_at") VALUES ('prpref_01K0DQNQYTP8NTQJTM20XGYTW1', 'currency_code', 'usd', 'f', '2025-07-18 03:01:34.298+00', '2025-07-18 03:01:34.298+00', NULL);
INSERT INTO "public"."price_preference" ("id", "attribute", "value", "is_tax_inclusive", "created_at", "updated_at", "deleted_at") VALUES ('prpref_01K0DQNQZQBK1CEH4T8KAHW58C', 'region_id', 'reg_01K0DQNQZ1T2G2043BVM0MJB6C', 'f', '2025-07-18 03:01:34.327+00', '2025-07-18 03:01:34.327+00', NULL);
INSERT INTO "public"."price_preference" ("id", "attribute", "value", "is_tax_inclusive", "created_at", "updated_at", "deleted_at") VALUES ('prpref_01K33F6QVXHBEZMCMQA5GS14VP', 'currency_code', 'idr', 'f', '2025-08-20 10:08:15.229+00', '2025-08-20 10:08:15.229+00', NULL);
INSERT INTO "public"."price_preference" ("id", "attribute", "value", "is_tax_inclusive", "created_at", "updated_at", "deleted_at") VALUES ('prpref_01K33FFDYKHDYVBRKSPF9XC5AH', 'region_id', 'reg_01K33FFDX0M838JWM069761552', 'f', '2025-08-20 10:12:59.987+00', '2025-08-20 10:12:59.987+00', NULL);
INSERT INTO "public"."price_preference" ("id", "attribute", "value", "is_tax_inclusive", "created_at", "updated_at", "deleted_at") VALUES ('prpref_01K33GHTQBHPHKSAM44NH3PWSR', 'region_id', 'reg_01K33GHTP2XF16W0MCZC4B3TWP', 'f', '2025-08-20 10:31:47.179+00', '2025-08-20 10:31:47.179+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for price_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."price_rule";
CREATE TABLE "public"."price_rule" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default" NOT NULL,
  "priority" int4 NOT NULL DEFAULT 0,
  "price_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "attribute" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text,
  "operator" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'eq'::text
)
;
ALTER TABLE "public"."price_rule" OWNER TO "postgres";

-- ----------------------------
-- Records of price_rule
-- ----------------------------
BEGIN;
INSERT INTO "public"."price_rule" ("id", "value", "priority", "price_id", "created_at", "updated_at", "deleted_at", "attribute", "operator") VALUES ('prule_01K0DQNR39418YT5HAGR83QR19', 'reg_01K0DQNQZ1T2G2043BVM0MJB6C', 0, 'price_01K0DQNR3902T367DZWXV3F626', '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, 'region_id', 'eq');
INSERT INTO "public"."price_rule" ("id", "value", "priority", "price_id", "created_at", "updated_at", "deleted_at", "attribute", "operator") VALUES ('prule_01K0DQNR395NYDAXYJE4GEQ0WN', 'reg_01K0DQNQZ1T2G2043BVM0MJB6C', 0, 'price_01K0DQNR39J4AR25QBP6DYR0GD', '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL, 'region_id', 'eq');
COMMIT;

-- ----------------------------
-- Table structure for price_set
-- ----------------------------
DROP TABLE IF EXISTS "public"."price_set";
CREATE TABLE "public"."price_set" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."price_set" OWNER TO "postgres";

-- ----------------------------
-- Records of price_set
-- ----------------------------
BEGIN;
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR397KW016XRAXC77EB2', '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR393J1JRXAJM1KFWD58', '2025-07-18 03:01:34.442+00', '2025-07-18 03:01:34.442+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9QZBBNVWDZY1HWABQY', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9R98D5B7VKRVY907YJ', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9RFQDS8C039XSSS2FQ', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9QHKWPASA05WN6GEPF', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9R23H0ZDHTQQ6G3G50', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9R7RYE16M414CDW0T7', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9QX36JXEB5JYQAHKM3', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9P6KDDEBCQ4JFPF6YG', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9Q4F3AQT23RVWMDMD7', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9Q3RPKX6ES79KE0YRV', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9QYY9FA462VKZ3VC6K', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9QP6RB0JSZQ09P4FHN', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9PB3DN7FPEWR724T17', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9Q2GT6RYB58AA208RQ', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9RJ93XG4FXSNA23CPF', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9R701E5WPGBDKM7064', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K0DQNR9S01R7K62BXDDGWM70', '2025-07-18 03:01:34.649+00', '2025-07-18 03:01:34.649+00', NULL);
INSERT INTO "public"."price_set" ("id", "created_at", "updated_at", "deleted_at") VALUES ('pset_01K38B4T2MWXPRPPQW8S67AQEV', '2025-08-22 07:33:29.813+00', '2025-08-22 07:33:29.813+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS "public"."product";
CREATE TABLE "public"."product" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "handle" text COLLATE "pg_catalog"."default" NOT NULL,
  "subtitle" text COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "is_giftcard" bool NOT NULL DEFAULT false,
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'draft'::text,
  "thumbnail" text COLLATE "pg_catalog"."default",
  "weight" text COLLATE "pg_catalog"."default",
  "length" text COLLATE "pg_catalog"."default",
  "height" text COLLATE "pg_catalog"."default",
  "width" text COLLATE "pg_catalog"."default",
  "origin_country" text COLLATE "pg_catalog"."default",
  "hs_code" text COLLATE "pg_catalog"."default",
  "mid_code" text COLLATE "pg_catalog"."default",
  "material" text COLLATE "pg_catalog"."default",
  "collection_id" text COLLATE "pg_catalog"."default",
  "type_id" text COLLATE "pg_catalog"."default",
  "discountable" bool NOT NULL DEFAULT true,
  "external_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "metadata" jsonb
)
;
ALTER TABLE "public"."product" OWNER TO "postgres";

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
INSERT INTO "public"."product" ("id", "title", "handle", "subtitle", "description", "is_giftcard", "status", "thumbnail", "weight", "length", "height", "width", "origin_country", "hs_code", "mid_code", "material", "collection_id", "type_id", "discountable", "external_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('prod_01K0DQNR60K5B3EZJ3TNWY0X9X', 'Medusa T-Shirt', 't-shirt', NULL, 'Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.', 'f', 'published', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png', '400', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, NULL);
INSERT INTO "public"."product" ("id", "title", "handle", "subtitle", "description", "is_giftcard", "status", "thumbnail", "weight", "length", "height", "width", "origin_country", "hs_code", "mid_code", "material", "collection_id", "type_id", "discountable", "external_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('prod_01K0DQNR60DXF0084R3YNQHSXJ', 'Medusa Sweatshirt', 'sweatshirt', NULL, 'Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.', 'f', 'published', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png', '400', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, NULL);
INSERT INTO "public"."product" ("id", "title", "handle", "subtitle", "description", "is_giftcard", "status", "thumbnail", "weight", "length", "height", "width", "origin_country", "hs_code", "mid_code", "material", "collection_id", "type_id", "discountable", "external_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('prod_01K0DQNR60F4HVA8YYA27N3KT3', 'Medusa Sweatpants', 'sweatpants', NULL, 'Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.', 'f', 'published', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png', '400', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, NULL);
INSERT INTO "public"."product" ("id", "title", "handle", "subtitle", "description", "is_giftcard", "status", "thumbnail", "weight", "length", "height", "width", "origin_country", "hs_code", "mid_code", "material", "collection_id", "type_id", "discountable", "external_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('prod_01K0DQNR60MNDVFQQ4PNFTPRC9', 'Medusa Shorts', 'shorts', NULL, 'Reimagine the feeling of classic shorts. With our cotton shorts, everyday essentials no longer have to be ordinary.', 'f', 'published', 'https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png', '400', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 't', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_category";
CREATE TABLE "public"."product_category" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text,
  "handle" text COLLATE "pg_catalog"."default" NOT NULL,
  "mpath" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_active" bool NOT NULL DEFAULT false,
  "is_internal" bool NOT NULL DEFAULT false,
  "rank" int4 NOT NULL DEFAULT 0,
  "parent_category_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "metadata" jsonb
)
;
ALTER TABLE "public"."product_category" OWNER TO "postgres";

-- ----------------------------
-- Records of product_category
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_category" ("id", "name", "description", "handle", "mpath", "is_active", "is_internal", "rank", "parent_category_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('pcat_01K0DQNR5SWNZRS3R0NNWP9561', 'Shirts', '', 'shirts', 'pcat_01K0DQNR5SWNZRS3R0NNWP9561', 't', 'f', 0, NULL, '2025-07-18 03:01:34.522+00', '2025-07-18 03:01:34.522+00', NULL, NULL);
INSERT INTO "public"."product_category" ("id", "name", "description", "handle", "mpath", "is_active", "is_internal", "rank", "parent_category_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('pcat_01K0DQNR5S1ARSS9BR6ZDAZ0N3', 'Sweatshirts', '', 'sweatshirts', 'pcat_01K0DQNR5S1ARSS9BR6ZDAZ0N3', 't', 'f', 1, NULL, '2025-07-18 03:01:34.522+00', '2025-07-18 03:01:34.522+00', NULL, NULL);
INSERT INTO "public"."product_category" ("id", "name", "description", "handle", "mpath", "is_active", "is_internal", "rank", "parent_category_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('pcat_01K0DQNR5S0X1YGF3PN5G9N9N7', 'Pants', '', 'pants', 'pcat_01K0DQNR5S0X1YGF3PN5G9N9N7', 't', 'f', 2, NULL, '2025-07-18 03:01:34.522+00', '2025-07-18 03:01:34.522+00', NULL, NULL);
INSERT INTO "public"."product_category" ("id", "name", "description", "handle", "mpath", "is_active", "is_internal", "rank", "parent_category_id", "created_at", "updated_at", "deleted_at", "metadata") VALUES ('pcat_01K0DQNR5TDE9XRGST6V35MJ0W', 'Merch', '', 'merch', 'pcat_01K0DQNR5TDE9XRGST6V35MJ0W', 't', 'f', 3, NULL, '2025-07-18 03:01:34.522+00', '2025-07-18 03:01:34.522+00', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_category_product
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_category_product";
CREATE TABLE "public"."product_category_product" (
  "product_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "product_category_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."product_category_product" OWNER TO "postgres";

-- ----------------------------
-- Records of product_category_product
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_category_product" ("product_id", "product_category_id") VALUES ('prod_01K0DQNR60K5B3EZJ3TNWY0X9X', 'pcat_01K0DQNR5SWNZRS3R0NNWP9561');
INSERT INTO "public"."product_category_product" ("product_id", "product_category_id") VALUES ('prod_01K0DQNR60DXF0084R3YNQHSXJ', 'pcat_01K0DQNR5S1ARSS9BR6ZDAZ0N3');
INSERT INTO "public"."product_category_product" ("product_id", "product_category_id") VALUES ('prod_01K0DQNR60F4HVA8YYA27N3KT3', 'pcat_01K0DQNR5S0X1YGF3PN5G9N9N7');
INSERT INTO "public"."product_category_product" ("product_id", "product_category_id") VALUES ('prod_01K0DQNR60MNDVFQQ4PNFTPRC9', 'pcat_01K0DQNR5TDE9XRGST6V35MJ0W');
COMMIT;

-- ----------------------------
-- Table structure for product_collection
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_collection";
CREATE TABLE "public"."product_collection" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "handle" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_collection" OWNER TO "postgres";

-- ----------------------------
-- Records of product_collection
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product_option
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_option";
CREATE TABLE "public"."product_option" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "product_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_option" OWNER TO "postgres";

-- ----------------------------
-- Records of product_option
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_option" ("id", "title", "product_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('opt_01K0DQNR62FFWPFSZPMWPB048H', 'Size', 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option" ("id", "title", "product_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('opt_01K0DQNR62RZVNSQS1ZZETWPFE', 'Color', 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option" ("id", "title", "product_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('opt_01K0DQNR62WSNB29SRBMND3ASZ', 'Size', 'prod_01K0DQNR60DXF0084R3YNQHSXJ', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option" ("id", "title", "product_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('opt_01K0DQNR63S22AR74XGE3G7113', 'Size', 'prod_01K0DQNR60F4HVA8YYA27N3KT3', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option" ("id", "title", "product_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('opt_01K0DQNR63721YM6DBEB7FXXXG', 'Size', 'prod_01K0DQNR60MNDVFQQ4PNFTPRC9', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_option_value
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_option_value";
CREATE TABLE "public"."product_option_value" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default" NOT NULL,
  "option_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_option_value" OWNER TO "postgres";

-- ----------------------------
-- Records of product_option_value
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR61MBCEJ06217PV869R', 'S', 'opt_01K0DQNR62FFWPFSZPMWPB048H', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR61M5K7NW3KBQFVTNSH', 'M', 'opt_01K0DQNR62FFWPFSZPMWPB048H', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR61MC4Y4SQ8ASSWNYXM', 'L', 'opt_01K0DQNR62FFWPFSZPMWPB048H', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR61EKY8M709Q6HKJQVE', 'XL', 'opt_01K0DQNR62FFWPFSZPMWPB048H', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR62F93H3Y49C9THZEPF', 'Black', 'opt_01K0DQNR62RZVNSQS1ZZETWPFE', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR62SPCYRJPS4FBWJB8G', 'White', 'opt_01K0DQNR62RZVNSQS1ZZETWPFE', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR62R9NMQKY0FHCC488K', 'S', 'opt_01K0DQNR62WSNB29SRBMND3ASZ', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR62BWG0RHNMG4JNP0RC', 'M', 'opt_01K0DQNR62WSNB29SRBMND3ASZ', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR62PMGDWDTN3S64XMRV', 'L', 'opt_01K0DQNR62WSNB29SRBMND3ASZ', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR62BTE0T4SB4GRGN9EM', 'XL', 'opt_01K0DQNR62WSNB29SRBMND3ASZ', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR6374H1R8Y5N250F743', 'S', 'opt_01K0DQNR63S22AR74XGE3G7113', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR63Y009YDMZ7KWZ7HMV', 'M', 'opt_01K0DQNR63S22AR74XGE3G7113', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR63Y5V9W3SBXXTWW10F', 'L', 'opt_01K0DQNR63S22AR74XGE3G7113', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR63BSQFGQ921ZDVYYEX', 'XL', 'opt_01K0DQNR63S22AR74XGE3G7113', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR63PPE50V57DFKG5Q7C', 'S', 'opt_01K0DQNR63721YM6DBEB7FXXXG', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR63AC9YA33PXQK2YZQX', 'M', 'opt_01K0DQNR63721YM6DBEB7FXXXG', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR63HSKXHNBC3KFHBD4Q', 'L', 'opt_01K0DQNR63721YM6DBEB7FXXXG', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
INSERT INTO "public"."product_option_value" ("id", "value", "option_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('optval_01K0DQNR63PJJBX7ZNHRQVM784', 'XL', 'opt_01K0DQNR63721YM6DBEB7FXXXG', NULL, '2025-07-18 03:01:34.532+00', '2025-07-18 03:01:34.532+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_product_brand_brand
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_product_brand_brand";
CREATE TABLE "public"."product_product_brand_brand" (
  "product_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "brand_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_product_brand_brand" OWNER TO "postgres";

-- ----------------------------
-- Records of product_product_brand_brand
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product_sales_channel
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_sales_channel";
CREATE TABLE "public"."product_sales_channel" (
  "product_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "sales_channel_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_sales_channel" OWNER TO "postgres";

-- ----------------------------
-- Records of product_sales_channel
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60K5B3EZJ3TNWY0X9X', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'prodsc_01K0DQNR6SP8B247BSJDK3KDX7', '2025-07-18 03:01:34.553046+00', '2025-07-18 03:01:34.553046+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60DXF0084R3YNQHSXJ', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'prodsc_01K0DQNR6S6EVNDC8726M55DNK', '2025-07-18 03:01:34.553046+00', '2025-07-18 03:01:34.553046+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60F4HVA8YYA27N3KT3', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'prodsc_01K0DQNR6TRWVF6TTXFQVHK44A', '2025-07-18 03:01:34.553046+00', '2025-07-18 03:01:34.553046+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60MNDVFQQ4PNFTPRC9', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'prodsc_01K0DQNR6TJBZJ1605526CAPEW', '2025-07-18 03:01:34.553046+00', '2025-07-18 03:01:34.553046+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60DXF0084R3YNQHSXJ', 'sc_01K33F08EMQCJXWNZK1HWXHBHR', 'prodsc_01K33F120GRXA7X41K1KW7N7RB', '2025-08-20 10:05:09.001908+00', '2025-08-20 10:05:09.001908+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60F4HVA8YYA27N3KT3', 'sc_01K33F0SW4Y9DSZQ933X15TGQ6', 'prodsc_01K33F19TYRXX69B921GYKKXKK', '2025-08-20 10:05:17.017037+00', '2025-08-20 10:05:17.017037+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60F4HVA8YYA27N3KT3', 'sc_01K33F08EMQCJXWNZK1HWXHBHR', 'prodsc_01K33G7KZTVAHR5MDNCR1PZGH1', '2025-08-20 10:26:12.613069+00', '2025-08-20 10:26:12.613069+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60K5B3EZJ3TNWY0X9X', 'sc_01K33F08EMQCJXWNZK1HWXHBHR', 'prodsc_01K33G7KZVH8VG81W5FHFT04CE', '2025-08-20 10:26:12.613069+00', '2025-08-20 10:26:12.613069+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60MNDVFQQ4PNFTPRC9', 'sc_01K33F08EMQCJXWNZK1HWXHBHR', 'prodsc_01K33G7KZV0M938S8CRKDQT96Z', '2025-08-20 10:26:12.613069+00', '2025-08-20 10:26:12.613069+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60DXF0084R3YNQHSXJ', 'sc_01K33F0SW4Y9DSZQ933X15TGQ6', 'prodsc_01K33G7YVK01529Y7G1YQ9VZ3W', '2025-08-20 10:26:23.741652+00', '2025-08-20 10:26:23.741652+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60K5B3EZJ3TNWY0X9X', 'sc_01K33F0SW4Y9DSZQ933X15TGQ6', 'prodsc_01K33G7YVKVJR8AZDYZKFT74J4', '2025-08-20 10:26:23.741652+00', '2025-08-20 10:26:23.741652+00', NULL);
INSERT INTO "public"."product_sales_channel" ("product_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60MNDVFQQ4PNFTPRC9', 'sc_01K33F0SW4Y9DSZQ933X15TGQ6', 'prodsc_01K33G7YVK4NPNAXQWP53HZKRP', '2025-08-20 10:26:23.741652+00', '2025-08-20 10:26:23.741652+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_shipping_profile
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_shipping_profile";
CREATE TABLE "public"."product_shipping_profile" (
  "product_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "shipping_profile_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_shipping_profile" OWNER TO "postgres";

-- ----------------------------
-- Records of product_shipping_profile
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_shipping_profile" ("product_id", "shipping_profile_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60K5B3EZJ3TNWY0X9X', 'sp_01K0DQNMKKYJED57XQD63HVRN1', 'prodsp_01K0DQNR74946PN0YE8FGPVQKR', '2025-07-18 03:01:34.564362+00', '2025-07-18 03:01:34.564362+00', NULL);
INSERT INTO "public"."product_shipping_profile" ("product_id", "shipping_profile_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60DXF0084R3YNQHSXJ', 'sp_01K0DQNMKKYJED57XQD63HVRN1', 'prodsp_01K0DQNR754XKCCAS477H1Y301', '2025-07-18 03:01:34.564362+00', '2025-07-18 03:01:34.564362+00', NULL);
INSERT INTO "public"."product_shipping_profile" ("product_id", "shipping_profile_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60F4HVA8YYA27N3KT3', 'sp_01K0DQNMKKYJED57XQD63HVRN1', 'prodsp_01K0DQNR751Y0P8KZ5QSWSXSMJ', '2025-07-18 03:01:34.564362+00', '2025-07-18 03:01:34.564362+00', NULL);
INSERT INTO "public"."product_shipping_profile" ("product_id", "shipping_profile_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('prod_01K0DQNR60MNDVFQQ4PNFTPRC9', 'sp_01K0DQNMKKYJED57XQD63HVRN1', 'prodsp_01K0DQNR754V75M68AE8V1SZ41', '2025-07-18 03:01:34.564362+00', '2025-07-18 03:01:34.564362+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_tag
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_tag";
CREATE TABLE "public"."product_tag" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_tag" OWNER TO "postgres";

-- ----------------------------
-- Records of product_tag
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product_tags
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_tags";
CREATE TABLE "public"."product_tags" (
  "product_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "product_tag_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."product_tags" OWNER TO "postgres";

-- ----------------------------
-- Records of product_tags
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_type";
CREATE TABLE "public"."product_type" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" json,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_type" OWNER TO "postgres";

-- ----------------------------
-- Records of product_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product_variant
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_variant";
CREATE TABLE "public"."product_variant" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "sku" text COLLATE "pg_catalog"."default",
  "barcode" text COLLATE "pg_catalog"."default",
  "ean" text COLLATE "pg_catalog"."default",
  "upc" text COLLATE "pg_catalog"."default",
  "allow_backorder" bool NOT NULL DEFAULT false,
  "manage_inventory" bool NOT NULL DEFAULT true,
  "hs_code" text COLLATE "pg_catalog"."default",
  "origin_country" text COLLATE "pg_catalog"."default",
  "mid_code" text COLLATE "pg_catalog"."default",
  "material" text COLLATE "pg_catalog"."default",
  "weight" int4,
  "length" int4,
  "height" int4,
  "width" int4,
  "metadata" jsonb,
  "variant_rank" int4 DEFAULT 0,
  "product_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_variant" OWNER TO "postgres";

-- ----------------------------
-- Records of product_variant
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'S', 'SWEATSHIRT-S', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60DXF0084R3YNQHSXJ', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SCSPGJ6FPVG45BX2W', 'XL', 'SWEATSHIRT-XL', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60DXF0084R3YNQHSXJ', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SMT3TSXEX9WAF456Z', 'L', 'SWEATSHIRT-L', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60DXF0084R3YNQHSXJ', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SZ25W1AQVFGYCJTDQ', 'M', 'SWEATSHIRT-M', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60DXF0084R3YNQHSXJ', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S4RDJNS5DE6GA5EVW', 'S', 'SWEATPANTS-S', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60F4HVA8YYA27N3KT3', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S4W9GH3SK0YFR9FR4', 'L', 'SWEATPANTS-L', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60F4HVA8YYA27N3KT3', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S5A4N59KAKT2NCT7H', 'XL', 'SWEATPANTS-XL', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60F4HVA8YYA27N3KT3', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SY6H1KQXPA51E5WHC', 'M', 'SWEATPANTS-M', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60F4HVA8YYA27N3KT3', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7R4N5Z66HZ6MXSHTRT', 'XL / Black', 'SHIRT-XL-BLACK', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7R7M74ES9DA7NHJFDD', 'S / Black', 'SHIRT-S-BLACK', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.585+00', '2025-07-18 03:01:34.585+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RHARRCMGM22HSK8PB', 'M / White', 'SHIRT-M-WHITE', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RPMB10TTHA20NJQSN', 'L / Black', 'SHIRT-L-BLACK', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RTYF6JFCGDG5B7HEG', 'L / White', 'SHIRT-L-WHITE', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RWSBGA25N2V40BB83', 'XL / White', 'SHIRT-XL-WHITE', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RXATE0YPVEQBRZB67', 'S / White', 'SHIRT-S-WHITE', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT', 'M / Black', 'SHIRT-M-BLACK', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60K5B3EZJ3TNWY0X9X', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S19WE18DFGYT0645D', 'M', 'SHORTS-M', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60MNDVFQQ4PNFTPRC9', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S8N8KE6BVGYRFWE5H', 'L', 'SHORTS-L', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60MNDVFQQ4PNFTPRC9', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SC08ZVVMA3CXF0RG4', 'S', 'SHORTS-S', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60MNDVFQQ4PNFTPRC9', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
INSERT INTO "public"."product_variant" ("id", "title", "sku", "barcode", "ean", "upc", "allow_backorder", "manage_inventory", "hs_code", "origin_country", "mid_code", "material", "weight", "length", "height", "width", "metadata", "variant_rank", "product_id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SFMX3AQS9EB79MFW8', 'XL', 'SHORTS-XL', NULL, NULL, NULL, 'f', 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'prod_01K0DQNR60MNDVFQQ4PNFTPRC9', '2025-07-18 03:01:34.586+00', '2025-07-18 03:01:34.586+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_variant_inventory_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_variant_inventory_item";
CREATE TABLE "public"."product_variant_inventory_item" (
  "variant_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "inventory_item_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "required_quantity" int4 NOT NULL DEFAULT 1,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_variant_inventory_item" OWNER TO "postgres";

-- ----------------------------
-- Records of product_variant_inventory_item
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7R7M74ES9DA7NHJFDD', 'iitem_01K0DQNR8HZ8V16J0A12QJSX3Z', 'pvitem_01K0DQNR99568M8DGGM29KVXBC', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RXATE0YPVEQBRZB67', 'iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z', 'pvitem_01K0DQNR9AZXH8YKMG3DN1CX00', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT', 'iitem_01K0DQNR8H6FMW591ZAWE8CC6V', 'pvitem_01K0DQNR9AHXBR8KRWHNKSQP8X', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RHARRCMGM22HSK8PB', 'iitem_01K0DQNR8HN7FREQ43S7HR4XBJ', 'pvitem_01K0DQNR9AM0KJRQ06VR3HHTBD', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RPMB10TTHA20NJQSN', 'iitem_01K0DQNR8H7TSKNZPDMT9H5CDA', 'pvitem_01K0DQNR9AR5T1TDEY1Q6JJNEQ', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RTYF6JFCGDG5B7HEG', 'iitem_01K0DQNR8HQ5N14ZPE16W32M8A', 'pvitem_01K0DQNR9A3PPQXMEC8588066K', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7R4N5Z66HZ6MXSHTRT', 'iitem_01K0DQNR8HDEG38Z3SSC6BTDP2', 'pvitem_01K0DQNR9AC4E1QV5X631Y8G3N', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RWSBGA25N2V40BB83', 'iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T', 'pvitem_01K0DQNR9ABGAHFGCS0MJAKPNR', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'iitem_01K0DQNR8HDKZFXMZW258EV36W', 'pvitem_01K0DQNR9AVE14PE672TBDMDXE', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SZ25W1AQVFGYCJTDQ', 'iitem_01K0DQNR8HR59HTB6ERH8DZASY', 'pvitem_01K0DQNR9ARNWN9K9RC2W0G9SP', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SMT3TSXEX9WAF456Z', 'iitem_01K0DQNR8HHMNTR22RZE0C3VDE', 'pvitem_01K0DQNR9ASJZZSBDJFN7W5VE5', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SCSPGJ6FPVG45BX2W', 'iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6', 'pvitem_01K0DQNR9AA8XXXXRKP672NBX7', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S4RDJNS5DE6GA5EVW', 'iitem_01K0DQNR8HEP3A6M8P8RVFT5JG', 'pvitem_01K0DQNR9AB0DHP9TB0EKPZ0KE', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SY6H1KQXPA51E5WHC', 'iitem_01K0DQNR8HKWFJWJVHX5SWTADW', 'pvitem_01K0DQNR9AP34SVK7TZJ82EY58', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S4W9GH3SK0YFR9FR4', 'iitem_01K0DQNR8HNDAVZP18NAD0E3XJ', 'pvitem_01K0DQNR9AVXDQX588KT5Y1SHE', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S5A4N59KAKT2NCT7H', 'iitem_01K0DQNR8H473MMSD7EKP3MQK6', 'pvitem_01K0DQNR9AQPS7V9PB21N2DDFJ', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SC08ZVVMA3CXF0RG4', 'iitem_01K0DQNR8J7722RFA36MATZMYN', 'pvitem_01K0DQNR9A8VM0PSWB1M0X06ZN', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S19WE18DFGYT0645D', 'iitem_01K0DQNR8J4CA4D5ADAH6ANXQS', 'pvitem_01K0DQNR9AT85EP06BYFB0W51Y', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S8N8KE6BVGYRFWE5H', 'iitem_01K0DQNR8JXCP0JAGSG543T09G', 'pvitem_01K0DQNR9ABSA0Y9DFW90HEJT3', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
INSERT INTO "public"."product_variant_inventory_item" ("variant_id", "inventory_item_id", "id", "required_quantity", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SFMX3AQS9EB79MFW8', 'iitem_01K0DQNR8J8DJWWBSQX1CNYN0T', 'pvitem_01K0DQNR9AZ6XW3Z514N19NSNV', 1, '2025-07-18 03:01:34.633299+00', '2025-07-18 03:01:34.633299+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product_variant_option
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_variant_option";
CREATE TABLE "public"."product_variant_option" (
  "variant_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "option_value_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."product_variant_option" OWNER TO "postgres";

-- ----------------------------
-- Records of product_variant_option
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7R7M74ES9DA7NHJFDD', 'optval_01K0DQNR61MBCEJ06217PV869R');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7R7M74ES9DA7NHJFDD', 'optval_01K0DQNR62F93H3Y49C9THZEPF');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RXATE0YPVEQBRZB67', 'optval_01K0DQNR61MBCEJ06217PV869R');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RXATE0YPVEQBRZB67', 'optval_01K0DQNR62SPCYRJPS4FBWJB8G');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT', 'optval_01K0DQNR61M5K7NW3KBQFVTNSH');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT', 'optval_01K0DQNR62F93H3Y49C9THZEPF');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RHARRCMGM22HSK8PB', 'optval_01K0DQNR61M5K7NW3KBQFVTNSH');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RHARRCMGM22HSK8PB', 'optval_01K0DQNR62SPCYRJPS4FBWJB8G');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RPMB10TTHA20NJQSN', 'optval_01K0DQNR61MC4Y4SQ8ASSWNYXM');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RPMB10TTHA20NJQSN', 'optval_01K0DQNR62F93H3Y49C9THZEPF');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RTYF6JFCGDG5B7HEG', 'optval_01K0DQNR61MC4Y4SQ8ASSWNYXM');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RTYF6JFCGDG5B7HEG', 'optval_01K0DQNR62SPCYRJPS4FBWJB8G');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7R4N5Z66HZ6MXSHTRT', 'optval_01K0DQNR61EKY8M709Q6HKJQVE');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7R4N5Z66HZ6MXSHTRT', 'optval_01K0DQNR62F93H3Y49C9THZEPF');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RWSBGA25N2V40BB83', 'optval_01K0DQNR61EKY8M709Q6HKJQVE');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7RWSBGA25N2V40BB83', 'optval_01K0DQNR62SPCYRJPS4FBWJB8G');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'optval_01K0DQNR62R9NMQKY0FHCC488K');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7SZ25W1AQVFGYCJTDQ', 'optval_01K0DQNR62BWG0RHNMG4JNP0RC');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7SMT3TSXEX9WAF456Z', 'optval_01K0DQNR62PMGDWDTN3S64XMRV');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7SCSPGJ6FPVG45BX2W', 'optval_01K0DQNR62BTE0T4SB4GRGN9EM');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7S4RDJNS5DE6GA5EVW', 'optval_01K0DQNR6374H1R8Y5N250F743');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7SY6H1KQXPA51E5WHC', 'optval_01K0DQNR63Y009YDMZ7KWZ7HMV');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7S4W9GH3SK0YFR9FR4', 'optval_01K0DQNR63Y5V9W3SBXXTWW10F');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7S5A4N59KAKT2NCT7H', 'optval_01K0DQNR63BSQFGQ921ZDVYYEX');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7SC08ZVVMA3CXF0RG4', 'optval_01K0DQNR63PPE50V57DFKG5Q7C');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7S19WE18DFGYT0645D', 'optval_01K0DQNR63AC9YA33PXQK2YZQX');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7S8N8KE6BVGYRFWE5H', 'optval_01K0DQNR63HSKXHNBC3KFHBD4Q');
INSERT INTO "public"."product_variant_option" ("variant_id", "option_value_id") VALUES ('variant_01K0DQNR7SFMX3AQS9EB79MFW8', 'optval_01K0DQNR63PJJBX7ZNHRQVM784');
COMMIT;

-- ----------------------------
-- Table structure for product_variant_price_set
-- ----------------------------
DROP TABLE IF EXISTS "public"."product_variant_price_set";
CREATE TABLE "public"."product_variant_price_set" (
  "variant_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "price_set_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."product_variant_price_set" OWNER TO "postgres";

-- ----------------------------
-- Records of product_variant_price_set
-- ----------------------------
BEGIN;
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7R7M74ES9DA7NHJFDD', 'pset_01K0DQNR9P6KDDEBCQ4JFPF6YG', 'pvps_01K0DQNRAK69N2F2WX9S5S81C6', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RXATE0YPVEQBRZB67', 'pset_01K0DQNR9PB3DN7FPEWR724T17', 'pvps_01K0DQNRAKNZRGZZXGP5A6G43Z', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT', 'pset_01K0DQNR9Q2GT6RYB58AA208RQ', 'pvps_01K0DQNRAKZ261DW37RAJ4ZZMQ', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RHARRCMGM22HSK8PB', 'pset_01K0DQNR9Q4F3AQT23RVWMDMD7', 'pvps_01K0DQNRAKB7RBJ7AN901DMGQE', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RPMB10TTHA20NJQSN', 'pset_01K0DQNR9Q3RPKX6ES79KE0YRV', 'pvps_01K0DQNRAKGJBS40FEYA0CGSN1', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RTYF6JFCGDG5B7HEG', 'pset_01K0DQNR9QYY9FA462VKZ3VC6K', 'pvps_01K0DQNRAK1C5QXTXECNHTPR2B', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7R4N5Z66HZ6MXSHTRT', 'pset_01K0DQNR9QX36JXEB5JYQAHKM3', 'pvps_01K0DQNRAKETRK0AM92TQNSKD6', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7RWSBGA25N2V40BB83', 'pset_01K0DQNR9QP6RB0JSZQ09P4FHN', 'pvps_01K0DQNRAK40DKXRQVGSCS9DG0', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S1W0SBA0M5YX93AN7', 'pset_01K0DQNR9QZBBNVWDZY1HWABQY', 'pvps_01K0DQNRAKZNR31FGKR1FWFWB7', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SZ25W1AQVFGYCJTDQ', 'pset_01K0DQNR9QHKWPASA05WN6GEPF', 'pvps_01K0DQNRAK6Z36GNM2WQG6V23F', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SMT3TSXEX9WAF456Z', 'pset_01K0DQNR9RFQDS8C039XSSS2FQ', 'pvps_01K0DQNRAKW9BPPTYKHZ26EFVW', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SCSPGJ6FPVG45BX2W', 'pset_01K0DQNR9R98D5B7VKRVY907YJ', 'pvps_01K0DQNRAK502MWPE122FSHBM7', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S4RDJNS5DE6GA5EVW', 'pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ', 'pvps_01K0DQNRAK82EP89FXCKG2J4R0', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SY6H1KQXPA51E5WHC', 'pset_01K0DQNR9R7RYE16M414CDW0T7', 'pvps_01K0DQNRAKQNMGB6QWDMQGKN80', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S4W9GH3SK0YFR9FR4', 'pset_01K0DQNR9R23H0ZDHTQQ6G3G50', 'pvps_01K0DQNRAK1XGHVRR62ZB417FT', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S5A4N59KAKT2NCT7H', 'pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ', 'pvps_01K0DQNRAMDGTR0H7C7R6FNXJG', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SC08ZVVMA3CXF0RG4', 'pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7', 'pvps_01K0DQNRAM90PFX88TZJQSYZ43', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S19WE18DFGYT0645D', 'pset_01K0DQNR9RJ93XG4FXSNA23CPF', 'pvps_01K0DQNRAMYSYX2D2Q98VR9T1T', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7S8N8KE6BVGYRFWE5H', 'pset_01K0DQNR9R701E5WPGBDKM7064', 'pvps_01K0DQNRAMRXCECNMQB7DC54DC', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
INSERT INTO "public"."product_variant_price_set" ("variant_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('variant_01K0DQNR7SFMX3AQS9EB79MFW8', 'pset_01K0DQNR9S01R7K62BXDDGWM70', 'pvps_01K0DQNRAMA385G7RZES8WHDXC', '2025-07-18 03:01:34.674626+00', '2025-07-18 03:01:34.674626+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for promotion
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion";
CREATE TABLE "public"."promotion" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "campaign_id" text COLLATE "pg_catalog"."default",
  "is_automatic" bool NOT NULL DEFAULT false,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'draft'::text,
  "is_tax_inclusive" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "public"."promotion" OWNER TO "postgres";

-- ----------------------------
-- Records of promotion
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for promotion_application_method
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion_application_method";
CREATE TABLE "public"."promotion_application_method" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" numeric,
  "raw_value" jsonb,
  "max_quantity" int4,
  "apply_to_quantity" int4,
  "buy_rules_min_quantity" int4,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "target_type" text COLLATE "pg_catalog"."default" NOT NULL,
  "allocation" text COLLATE "pg_catalog"."default",
  "promotion_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "currency_code" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."promotion_application_method" OWNER TO "postgres";

-- ----------------------------
-- Records of promotion_application_method
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for promotion_campaign
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion_campaign";
CREATE TABLE "public"."promotion_campaign" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "campaign_identifier" text COLLATE "pg_catalog"."default" NOT NULL,
  "starts_at" timestamptz(6),
  "ends_at" timestamptz(6),
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."promotion_campaign" OWNER TO "postgres";

-- ----------------------------
-- Records of promotion_campaign
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for promotion_campaign_budget
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion_campaign_budget";
CREATE TABLE "public"."promotion_campaign_budget" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "campaign_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "limit" numeric,
  "raw_limit" jsonb,
  "used" numeric NOT NULL DEFAULT 0,
  "raw_used" jsonb NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "currency_code" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."promotion_campaign_budget" OWNER TO "postgres";

-- ----------------------------
-- Records of promotion_campaign_budget
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for promotion_promotion_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion_promotion_rule";
CREATE TABLE "public"."promotion_promotion_rule" (
  "promotion_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "promotion_rule_id" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."promotion_promotion_rule" OWNER TO "postgres";

-- ----------------------------
-- Records of promotion_promotion_rule
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for promotion_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion_rule";
CREATE TABLE "public"."promotion_rule" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "attribute" text COLLATE "pg_catalog"."default" NOT NULL,
  "operator" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."promotion_rule" OWNER TO "postgres";

-- ----------------------------
-- Records of promotion_rule
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for promotion_rule_value
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion_rule_value";
CREATE TABLE "public"."promotion_rule_value" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "promotion_rule_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."promotion_rule_value" OWNER TO "postgres";

-- ----------------------------
-- Records of promotion_rule_value
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for provider_identity
-- ----------------------------
DROP TABLE IF EXISTS "public"."provider_identity";
CREATE TABLE "public"."provider_identity" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "entity_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "provider" text COLLATE "pg_catalog"."default" NOT NULL,
  "auth_identity_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "user_metadata" jsonb,
  "provider_metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."provider_identity" OWNER TO "postgres";

-- ----------------------------
-- Records of provider_identity
-- ----------------------------
BEGIN;
INSERT INTO "public"."provider_identity" ("id", "entity_id", "provider", "auth_identity_id", "user_metadata", "provider_metadata", "created_at", "updated_at", "deleted_at") VALUES ('01K0DQTQB91YFWT37KPMC7WKMT', 'radenadriep@gmail.com', 'emailpass', 'authid_01K0DQTQBAP2VATK818YG970GH', NULL, '{"password": "c2NyeXB0AA8AAAAIAAAAASi22pfmPC2l9V+yEFdVI53RjRElRe9b0IoEVqd2eznyHDgxyS6rcGRMlykpMeMlbcZWMR7aA2yaOF/cqwyTkA1TRbHM/iRWoR1OkrSxCsn8"}', '2025-07-18 03:04:17.514+00', '2025-07-18 03:04:17.514+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for publishable_api_key_sales_channel
-- ----------------------------
DROP TABLE IF EXISTS "public"."publishable_api_key_sales_channel";
CREATE TABLE "public"."publishable_api_key_sales_channel" (
  "publishable_key_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "sales_channel_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."publishable_api_key_sales_channel" OWNER TO "postgres";

-- ----------------------------
-- Records of publishable_api_key_sales_channel
-- ----------------------------
BEGIN;
INSERT INTO "public"."publishable_api_key_sales_channel" ("publishable_key_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('apk_01K0DQNR524GW4VFN0CYPT9DHB', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'pksc_01K0DQNR5G2ZT52ZFDW9MNACWF', '2025-07-18 03:01:34.511951+00', '2025-07-18 03:01:34.511951+00', NULL);
INSERT INTO "public"."publishable_api_key_sales_channel" ("publishable_key_id", "sales_channel_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('apk_01K0DQYC785PQSMC8X6PFYHCHD', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'pksc_01K0DQYQ1KQ82ZSJ6JWQGW24VH', '2025-07-18 03:06:28.28002+00', '2025-07-18 03:24:59.203+00', '2025-07-18 03:24:59.201+00');
COMMIT;

-- ----------------------------
-- Table structure for refund
-- ----------------------------
DROP TABLE IF EXISTS "public"."refund";
CREATE TABLE "public"."refund" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "amount" numeric NOT NULL,
  "raw_amount" jsonb NOT NULL,
  "payment_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "created_by" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "refund_reason_id" text COLLATE "pg_catalog"."default",
  "note" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."refund" OWNER TO "postgres";

-- ----------------------------
-- Records of refund
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for refund_reason
-- ----------------------------
DROP TABLE IF EXISTS "public"."refund_reason";
CREATE TABLE "public"."refund_reason" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "label" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."refund_reason" OWNER TO "postgres";

-- ----------------------------
-- Records of refund_reason
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS "public"."region";
CREATE TABLE "public"."region" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "automatic_taxes" bool NOT NULL DEFAULT true
)
;
ALTER TABLE "public"."region" OWNER TO "postgres";

-- ----------------------------
-- Records of region
-- ----------------------------
BEGIN;
INSERT INTO "public"."region" ("id", "name", "currency_code", "metadata", "created_at", "updated_at", "deleted_at", "automatic_taxes") VALUES ('reg_01K0DQNQZ1T2G2043BVM0MJB6C', 'Europe', 'eur', NULL, '2025-07-18 03:01:34.312+00', '2025-07-18 03:01:34.312+00', NULL, 't');
INSERT INTO "public"."region" ("id", "name", "currency_code", "metadata", "created_at", "updated_at", "deleted_at", "automatic_taxes") VALUES ('reg_01K33FFDX0M838JWM069761552', 'Indonesia', 'idr', NULL, '2025-08-20 10:12:59.954+00', '2025-08-20 10:12:59.954+00', NULL, 't');
INSERT INTO "public"."region" ("id", "name", "currency_code", "metadata", "created_at", "updated_at", "deleted_at", "automatic_taxes") VALUES ('reg_01K33GHTP2XF16W0MCZC4B3TWP', 'US', 'usd', NULL, '2025-08-20 10:31:47.151+00', '2025-08-20 10:31:47.151+00', NULL, 't');
COMMIT;

-- ----------------------------
-- Table structure for region_country
-- ----------------------------
DROP TABLE IF EXISTS "public"."region_country";
CREATE TABLE "public"."region_country" (
  "iso_2" text COLLATE "pg_catalog"."default" NOT NULL,
  "iso_3" text COLLATE "pg_catalog"."default" NOT NULL,
  "num_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "display_name" text COLLATE "pg_catalog"."default" NOT NULL,
  "region_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."region_country" OWNER TO "postgres";

-- ----------------------------
-- Records of region_country
-- ----------------------------
BEGIN;
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('af', 'afg', '004', 'AFGHANISTAN', 'Afghanistan', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('al', 'alb', '008', 'ALBANIA', 'Albania', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('dz', 'dza', '012', 'ALGERIA', 'Algeria', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('as', 'asm', '016', 'AMERICAN SAMOA', 'American Samoa', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ad', 'and', '020', 'ANDORRA', 'Andorra', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ao', 'ago', '024', 'ANGOLA', 'Angola', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ai', 'aia', '660', 'ANGUILLA', 'Anguilla', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('aq', 'ata', '010', 'ANTARCTICA', 'Antarctica', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ag', 'atg', '028', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ar', 'arg', '032', 'ARGENTINA', 'Argentina', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('am', 'arm', '051', 'ARMENIA', 'Armenia', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('aw', 'abw', '533', 'ARUBA', 'Aruba', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('au', 'aus', '036', 'AUSTRALIA', 'Australia', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('at', 'aut', '040', 'AUSTRIA', 'Austria', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('az', 'aze', '031', 'AZERBAIJAN', 'Azerbaijan', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bs', 'bhs', '044', 'BAHAMAS', 'Bahamas', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bh', 'bhr', '048', 'BAHRAIN', 'Bahrain', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bd', 'bgd', '050', 'BANGLADESH', 'Bangladesh', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bb', 'brb', '052', 'BARBADOS', 'Barbados', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('by', 'blr', '112', 'BELARUS', 'Belarus', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('be', 'bel', '056', 'BELGIUM', 'Belgium', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bz', 'blz', '084', 'BELIZE', 'Belize', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bj', 'ben', '204', 'BENIN', 'Benin', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bm', 'bmu', '060', 'BERMUDA', 'Bermuda', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bt', 'btn', '064', 'BHUTAN', 'Bhutan', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bo', 'bol', '068', 'BOLIVIA', 'Bolivia', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bq', 'bes', '535', 'BONAIRE, SINT EUSTATIUS AND SABA', 'Bonaire, Sint Eustatius and Saba', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ba', 'bih', '070', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bw', 'bwa', '072', 'BOTSWANA', 'Botswana', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bv', 'bvd', '074', 'BOUVET ISLAND', 'Bouvet Island', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('br', 'bra', '076', 'BRAZIL', 'Brazil', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('io', 'iot', '086', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bn', 'brn', '096', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bg', 'bgr', '100', 'BULGARIA', 'Bulgaria', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bf', 'bfa', '854', 'BURKINA FASO', 'Burkina Faso', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bi', 'bdi', '108', 'BURUNDI', 'Burundi', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('kh', 'khm', '116', 'CAMBODIA', 'Cambodia', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cm', 'cmr', '120', 'CAMEROON', 'Cameroon', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ca', 'can', '124', 'CANADA', 'Canada', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cv', 'cpv', '132', 'CAPE VERDE', 'Cape Verde', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ky', 'cym', '136', 'CAYMAN ISLANDS', 'Cayman Islands', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cf', 'caf', '140', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('td', 'tcd', '148', 'CHAD', 'Chad', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cl', 'chl', '152', 'CHILE', 'Chile', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cn', 'chn', '156', 'CHINA', 'China', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cx', 'cxr', '162', 'CHRISTMAS ISLAND', 'Christmas Island', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cc', 'cck', '166', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('co', 'col', '170', 'COLOMBIA', 'Colombia', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('km', 'com', '174', 'COMOROS', 'Comoros', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cg', 'cog', '178', 'CONGO', 'Congo', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cd', 'cod', '180', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ck', 'cok', '184', 'COOK ISLANDS', 'Cook Islands', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cr', 'cri', '188', 'COSTA RICA', 'Costa Rica', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ci', 'civ', '384', 'COTE D''IVOIRE', 'Cote D''Ivoire', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('hr', 'hrv', '191', 'CROATIA', 'Croatia', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cu', 'cub', '192', 'CUBA', 'Cuba', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cw', 'cuw', '531', 'CURAÇAO', 'Curaçao', NULL, NULL, '2025-07-18 03:01:30.379+00', '2025-07-18 03:01:30.379+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cy', 'cyp', '196', 'CYPRUS', 'Cyprus', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('cz', 'cze', '203', 'CZECH REPUBLIC', 'Czech Republic', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('dj', 'dji', '262', 'DJIBOUTI', 'Djibouti', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('dm', 'dma', '212', 'DOMINICA', 'Dominica', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('do', 'dom', '214', 'DOMINICAN REPUBLIC', 'Dominican Republic', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ec', 'ecu', '218', 'ECUADOR', 'Ecuador', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('eg', 'egy', '818', 'EGYPT', 'Egypt', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sv', 'slv', '222', 'EL SALVADOR', 'El Salvador', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gq', 'gnq', '226', 'EQUATORIAL GUINEA', 'Equatorial Guinea', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('er', 'eri', '232', 'ERITREA', 'Eritrea', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ee', 'est', '233', 'ESTONIA', 'Estonia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('et', 'eth', '231', 'ETHIOPIA', 'Ethiopia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fk', 'flk', '238', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fo', 'fro', '234', 'FAROE ISLANDS', 'Faroe Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fj', 'fji', '242', 'FIJI', 'Fiji', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fi', 'fin', '246', 'FINLAND', 'Finland', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gf', 'guf', '254', 'FRENCH GUIANA', 'French Guiana', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pf', 'pyf', '258', 'FRENCH POLYNESIA', 'French Polynesia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tf', 'atf', '260', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ga', 'gab', '266', 'GABON', 'Gabon', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gm', 'gmb', '270', 'GAMBIA', 'Gambia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ge', 'geo', '268', 'GEORGIA', 'Georgia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gh', 'gha', '288', 'GHANA', 'Ghana', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gi', 'gib', '292', 'GIBRALTAR', 'Gibraltar', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gr', 'grc', '300', 'GREECE', 'Greece', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gl', 'grl', '304', 'GREENLAND', 'Greenland', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gd', 'grd', '308', 'GRENADA', 'Grenada', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gp', 'glp', '312', 'GUADELOUPE', 'Guadeloupe', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gu', 'gum', '316', 'GUAM', 'Guam', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gt', 'gtm', '320', 'GUATEMALA', 'Guatemala', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gg', 'ggy', '831', 'GUERNSEY', 'Guernsey', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gn', 'gin', '324', 'GUINEA', 'Guinea', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gw', 'gnb', '624', 'GUINEA-BISSAU', 'Guinea-Bissau', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gy', 'guy', '328', 'GUYANA', 'Guyana', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ht', 'hti', '332', 'HAITI', 'Haiti', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('hm', 'hmd', '334', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island And Mcdonald Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('va', 'vat', '336', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('hn', 'hnd', '340', 'HONDURAS', 'Honduras', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('hk', 'hkg', '344', 'HONG KONG', 'Hong Kong', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('hu', 'hun', '348', 'HUNGARY', 'Hungary', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('is', 'isl', '352', 'ICELAND', 'Iceland', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('in', 'ind', '356', 'INDIA', 'India', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ir', 'irn', '364', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('iq', 'irq', '368', 'IRAQ', 'Iraq', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ie', 'irl', '372', 'IRELAND', 'Ireland', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('im', 'imn', '833', 'ISLE OF MAN', 'Isle Of Man', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('il', 'isr', '376', 'ISRAEL', 'Israel', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('jm', 'jam', '388', 'JAMAICA', 'Jamaica', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('jp', 'jpn', '392', 'JAPAN', 'Japan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('je', 'jey', '832', 'JERSEY', 'Jersey', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('jo', 'jor', '400', 'JORDAN', 'Jordan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('kz', 'kaz', '398', 'KAZAKHSTAN', 'Kazakhstan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ke', 'ken', '404', 'KENYA', 'Kenya', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ki', 'kir', '296', 'KIRIBATI', 'Kiribati', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('kp', 'prk', '408', 'KOREA, DEMOCRATIC PEOPLE''S REPUBLIC OF', 'Korea, Democratic People''s Republic of', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('kr', 'kor', '410', 'KOREA, REPUBLIC OF', 'Korea, Republic of', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('xk', 'xkx', '900', 'KOSOVO', 'Kosovo', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('kw', 'kwt', '414', 'KUWAIT', 'Kuwait', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('kg', 'kgz', '417', 'KYRGYZSTAN', 'Kyrgyzstan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('la', 'lao', '418', 'LAO PEOPLE''S DEMOCRATIC REPUBLIC', 'Lao People''s Democratic Republic', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('lv', 'lva', '428', 'LATVIA', 'Latvia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('lb', 'lbn', '422', 'LEBANON', 'Lebanon', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ls', 'lso', '426', 'LESOTHO', 'Lesotho', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('lr', 'lbr', '430', 'LIBERIA', 'Liberia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ly', 'lby', '434', 'LIBYA', 'Libya', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('li', 'lie', '438', 'LIECHTENSTEIN', 'Liechtenstein', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('lt', 'ltu', '440', 'LITHUANIA', 'Lithuania', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('lu', 'lux', '442', 'LUXEMBOURG', 'Luxembourg', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mo', 'mac', '446', 'MACAO', 'Macao', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mg', 'mdg', '450', 'MADAGASCAR', 'Madagascar', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mw', 'mwi', '454', 'MALAWI', 'Malawi', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('my', 'mys', '458', 'MALAYSIA', 'Malaysia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mv', 'mdv', '462', 'MALDIVES', 'Maldives', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ml', 'mli', '466', 'MALI', 'Mali', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mt', 'mlt', '470', 'MALTA', 'Malta', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mh', 'mhl', '584', 'MARSHALL ISLANDS', 'Marshall Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mq', 'mtq', '474', 'MARTINIQUE', 'Martinique', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mr', 'mrt', '478', 'MAURITANIA', 'Mauritania', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mu', 'mus', '480', 'MAURITIUS', 'Mauritius', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('yt', 'myt', '175', 'MAYOTTE', 'Mayotte', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mx', 'mex', '484', 'MEXICO', 'Mexico', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fm', 'fsm', '583', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('md', 'mda', '498', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mc', 'mco', '492', 'MONACO', 'Monaco', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mn', 'mng', '496', 'MONGOLIA', 'Mongolia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('me', 'mne', '499', 'MONTENEGRO', 'Montenegro', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ms', 'msr', '500', 'MONTSERRAT', 'Montserrat', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ma', 'mar', '504', 'MOROCCO', 'Morocco', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mz', 'moz', '508', 'MOZAMBIQUE', 'Mozambique', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mm', 'mmr', '104', 'MYANMAR', 'Myanmar', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('na', 'nam', '516', 'NAMIBIA', 'Namibia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('nr', 'nru', '520', 'NAURU', 'Nauru', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('np', 'npl', '524', 'NEPAL', 'Nepal', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('nl', 'nld', '528', 'NETHERLANDS', 'Netherlands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('nc', 'ncl', '540', 'NEW CALEDONIA', 'New Caledonia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('nz', 'nzl', '554', 'NEW ZEALAND', 'New Zealand', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ni', 'nic', '558', 'NICARAGUA', 'Nicaragua', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ne', 'ner', '562', 'NIGER', 'Niger', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ng', 'nga', '566', 'NIGERIA', 'Nigeria', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('nu', 'niu', '570', 'NIUE', 'Niue', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('nf', 'nfk', '574', 'NORFOLK ISLAND', 'Norfolk Island', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mk', 'mkd', '807', 'NORTH MACEDONIA', 'North Macedonia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mp', 'mnp', '580', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('no', 'nor', '578', 'NORWAY', 'Norway', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('om', 'omn', '512', 'OMAN', 'Oman', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pk', 'pak', '586', 'PAKISTAN', 'Pakistan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pw', 'plw', '585', 'PALAU', 'Palau', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ps', 'pse', '275', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pa', 'pan', '591', 'PANAMA', 'Panama', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pg', 'png', '598', 'PAPUA NEW GUINEA', 'Papua New Guinea', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('py', 'pry', '600', 'PARAGUAY', 'Paraguay', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pe', 'per', '604', 'PERU', 'Peru', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ph', 'phl', '608', 'PHILIPPINES', 'Philippines', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pn', 'pcn', '612', 'PITCAIRN', 'Pitcairn', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pl', 'pol', '616', 'POLAND', 'Poland', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pt', 'prt', '620', 'PORTUGAL', 'Portugal', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pr', 'pri', '630', 'PUERTO RICO', 'Puerto Rico', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('qa', 'qat', '634', 'QATAR', 'Qatar', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('re', 'reu', '638', 'REUNION', 'Reunion', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ro', 'rom', '642', 'ROMANIA', 'Romania', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('id', 'idn', '360', 'INDONESIA', 'Indonesia', 'reg_01K33FFDX0M838JWM069761552', NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:12:59.955+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ru', 'rus', '643', 'RUSSIAN FEDERATION', 'Russian Federation', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('rw', 'rwa', '646', 'RWANDA', 'Rwanda', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('bl', 'blm', '652', 'SAINT BARTHÉLEMY', 'Saint Barthélemy', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sh', 'shn', '654', 'SAINT HELENA', 'Saint Helena', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('kn', 'kna', '659', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('lc', 'lca', '662', 'SAINT LUCIA', 'Saint Lucia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('mf', 'maf', '663', 'SAINT MARTIN (FRENCH PART)', 'Saint Martin (French part)', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('pm', 'spm', '666', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('vc', 'vct', '670', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ws', 'wsm', '882', 'SAMOA', 'Samoa', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sm', 'smr', '674', 'SAN MARINO', 'San Marino', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('st', 'stp', '678', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sa', 'sau', '682', 'SAUDI ARABIA', 'Saudi Arabia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sn', 'sen', '686', 'SENEGAL', 'Senegal', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('rs', 'srb', '688', 'SERBIA', 'Serbia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sc', 'syc', '690', 'SEYCHELLES', 'Seychelles', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sl', 'sle', '694', 'SIERRA LEONE', 'Sierra Leone', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sg', 'sgp', '702', 'SINGAPORE', 'Singapore', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sx', 'sxm', '534', 'SINT MAARTEN', 'Sint Maarten', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sk', 'svk', '703', 'SLOVAKIA', 'Slovakia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('si', 'svn', '705', 'SLOVENIA', 'Slovenia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sb', 'slb', '090', 'SOLOMON ISLANDS', 'Solomon Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('so', 'som', '706', 'SOMALIA', 'Somalia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('za', 'zaf', '710', 'SOUTH AFRICA', 'South Africa', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gs', 'sgs', '239', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ss', 'ssd', '728', 'SOUTH SUDAN', 'South Sudan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('lk', 'lka', '144', 'SRI LANKA', 'Sri Lanka', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sd', 'sdn', '729', 'SUDAN', 'Sudan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sr', 'sur', '740', 'SURINAME', 'Suriname', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sj', 'sjm', '744', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sz', 'swz', '748', 'SWAZILAND', 'Swaziland', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ch', 'che', '756', 'SWITZERLAND', 'Switzerland', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sy', 'syr', '760', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tw', 'twn', '158', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tj', 'tjk', '762', 'TAJIKISTAN', 'Tajikistan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tz', 'tza', '834', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('th', 'tha', '764', 'THAILAND', 'Thailand', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tl', 'tls', '626', 'TIMOR LESTE', 'Timor Leste', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tg', 'tgo', '768', 'TOGO', 'Togo', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tk', 'tkl', '772', 'TOKELAU', 'Tokelau', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('to', 'ton', '776', 'TONGA', 'Tonga', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tt', 'tto', '780', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tn', 'tun', '788', 'TUNISIA', 'Tunisia', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tr', 'tur', '792', 'TURKEY', 'Turkey', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tm', 'tkm', '795', 'TURKMENISTAN', 'Turkmenistan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tc', 'tca', '796', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('tv', 'tuv', '798', 'TUVALU', 'Tuvalu', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ug', 'uga', '800', 'UGANDA', 'Uganda', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ua', 'ukr', '804', 'UKRAINE', 'Ukraine', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ae', 'are', '784', 'UNITED ARAB EMIRATES', 'United Arab Emirates', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('um', 'umi', '581', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('uy', 'ury', '858', 'URUGUAY', 'Uruguay', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('uz', 'uzb', '860', 'UZBEKISTAN', 'Uzbekistan', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('vu', 'vut', '548', 'VANUATU', 'Vanuatu', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-07-18 03:01:30.38+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ve', 'ven', '862', 'VENEZUELA', 'Venezuela', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('vn', 'vnm', '704', 'VIET NAM', 'Viet Nam', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('vg', 'vgb', '092', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('vi', 'vir', '850', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.S.', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('wf', 'wlf', '876', 'WALLIS AND FUTUNA', 'Wallis and Futuna', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('eh', 'esh', '732', 'WESTERN SAHARA', 'Western Sahara', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ye', 'yem', '887', 'YEMEN', 'Yemen', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('zm', 'zmb', '894', 'ZAMBIA', 'Zambia', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('zw', 'zwe', '716', 'ZIMBABWE', 'Zimbabwe', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('ax', 'ala', '248', 'ÅLAND ISLANDS', 'Åland Islands', NULL, NULL, '2025-07-18 03:01:30.381+00', '2025-07-18 03:01:30.381+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('dk', 'dnk', '208', 'DENMARK', 'Denmark', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:27:15.152+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('fr', 'fra', '250', 'FRANCE', 'France', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:27:15.152+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('it', 'ita', '380', 'ITALY', 'Italy', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:27:15.152+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('es', 'esp', '724', 'SPAIN', 'Spain', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:27:15.152+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('se', 'swe', '752', 'SWEDEN', 'Sweden', NULL, NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:27:15.152+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('de', 'deu', '276', 'GERMANY', 'Germany', 'reg_01K0DQNQZ1T2G2043BVM0MJB6C', NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:27:15.17+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('gb', 'gbr', '826', 'UNITED KINGDOM', 'United Kingdom', 'reg_01K0DQNQZ1T2G2043BVM0MJB6C', NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:27:15.17+00', NULL);
INSERT INTO "public"."region_country" ("iso_2", "iso_3", "num_code", "name", "display_name", "region_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('us', 'usa', '840', 'UNITED STATES', 'United States', 'reg_01K33GHTP2XF16W0MCZC4B3TWP', NULL, '2025-07-18 03:01:30.38+00', '2025-08-20 10:31:47.152+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for region_payment_provider
-- ----------------------------
DROP TABLE IF EXISTS "public"."region_payment_provider";
CREATE TABLE "public"."region_payment_provider" (
  "region_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "payment_provider_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."region_payment_provider" OWNER TO "postgres";

-- ----------------------------
-- Records of region_payment_provider
-- ----------------------------
BEGIN;
INSERT INTO "public"."region_payment_provider" ("region_id", "payment_provider_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('reg_01K0DQNQZ1T2G2043BVM0MJB6C', 'pp_system_default', 'regpp_01K0DQNQZVTKTD2V22258EVA26', '2025-07-18 03:01:34.331198+00', '2025-07-18 03:01:34.331198+00', NULL);
INSERT INTO "public"."region_payment_provider" ("region_id", "payment_provider_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('reg_01K33FFDX0M838JWM069761552', 'pp_system_default', 'regpp_01K33FFDYN27ETK10Z430VVTFZ', '2025-08-20 10:12:59.989351+00', '2025-08-20 10:12:59.989351+00', NULL);
INSERT INTO "public"."region_payment_provider" ("region_id", "payment_provider_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('reg_01K33GHTP2XF16W0MCZC4B3TWP', 'pp_system_default', 'regpp_01K33GHTQNXVXBD3A9NW88JNQD', '2025-08-20 10:31:47.185672+00', '2025-08-20 10:31:47.185672+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for reservation_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."reservation_item";
CREATE TABLE "public"."reservation_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "line_item_id" text COLLATE "pg_catalog"."default",
  "location_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "quantity" numeric NOT NULL,
  "external_id" text COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "created_by" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "inventory_item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "allow_backorder" bool DEFAULT false,
  "raw_quantity" jsonb
)
;
ALTER TABLE "public"."reservation_item" OWNER TO "postgres";

-- ----------------------------
-- Records of reservation_item
-- ----------------------------
BEGIN;
INSERT INTO "public"."reservation_item" ("id", "created_at", "updated_at", "deleted_at", "line_item_id", "location_id", "quantity", "external_id", "description", "created_by", "metadata", "inventory_item_id", "allow_backorder", "raw_quantity") VALUES ('resitem_01K38B6656XFYMWJ3S3YZCCKX4', '2025-08-22 07:34:14.952+00', '2025-08-22 07:34:50.287+00', '2025-08-22 07:34:50.279+00', 'ordli_01K38B662S2GB9JV4A7YRCMK9F', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 1, NULL, NULL, NULL, NULL, 'iitem_01K0DQNR8HDKZFXMZW258EV36W', 'f', '{"value": "1", "precision": 20}');
COMMIT;

-- ----------------------------
-- Table structure for return
-- ----------------------------
DROP TABLE IF EXISTS "public"."return";
CREATE TABLE "public"."return" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "order_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "claim_id" text COLLATE "pg_catalog"."default",
  "exchange_id" text COLLATE "pg_catalog"."default",
  "order_version" int4 NOT NULL,
  "display_id" int4 NOT NULL DEFAULT nextval('return_display_id_seq'::regclass),
  "status" "public"."return_status_enum" NOT NULL DEFAULT 'open'::return_status_enum,
  "no_notification" bool,
  "refund_amount" numeric,
  "raw_refund_amount" jsonb,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "received_at" timestamptz(6),
  "canceled_at" timestamptz(6),
  "location_id" text COLLATE "pg_catalog"."default",
  "requested_at" timestamptz(6),
  "created_by" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."return" OWNER TO "postgres";

-- ----------------------------
-- Records of return
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for return_fulfillment
-- ----------------------------
DROP TABLE IF EXISTS "public"."return_fulfillment";
CREATE TABLE "public"."return_fulfillment" (
  "return_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "fulfillment_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."return_fulfillment" OWNER TO "postgres";

-- ----------------------------
-- Records of return_fulfillment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for return_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."return_item";
CREATE TABLE "public"."return_item" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "return_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "reason_id" text COLLATE "pg_catalog"."default",
  "item_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "quantity" numeric NOT NULL,
  "raw_quantity" jsonb NOT NULL,
  "received_quantity" numeric NOT NULL DEFAULT 0,
  "raw_received_quantity" jsonb NOT NULL,
  "note" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "damaged_quantity" numeric NOT NULL DEFAULT 0,
  "raw_damaged_quantity" jsonb NOT NULL
)
;
ALTER TABLE "public"."return_item" OWNER TO "postgres";

-- ----------------------------
-- Records of return_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for return_reason
-- ----------------------------
DROP TABLE IF EXISTS "public"."return_reason";
CREATE TABLE "public"."return_reason" (
  "id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "value" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "label" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "parent_return_reason_id" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."return_reason" OWNER TO "postgres";

-- ----------------------------
-- Records of return_reason
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sales_channel
-- ----------------------------
DROP TABLE IF EXISTS "public"."sales_channel";
CREATE TABLE "public"."sales_channel" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "is_disabled" bool NOT NULL DEFAULT false,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."sales_channel" OWNER TO "postgres";

-- ----------------------------
-- Records of sales_channel
-- ----------------------------
BEGIN;
INSERT INTO "public"."sales_channel" ("id", "name", "description", "is_disabled", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sc_01K33F08EMQCJXWNZK1HWXHBHR', 'Shopee', 'Integrasi ke Shopee', 'f', NULL, '2025-08-20 10:04:42.837+00', '2025-08-20 10:04:42.837+00', NULL);
INSERT INTO "public"."sales_channel" ("id", "name", "description", "is_disabled", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sc_01K33F0SW4Y9DSZQ933X15TGQ6', 'Tiktok', 'Integrasi ke Tiktok', 'f', NULL, '2025-08-20 10:05:00.676+00', '2025-08-20 10:05:00.676+00', NULL);
INSERT INTO "public"."sales_channel" ("id", "name", "description", "is_disabled", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'Website', 'Penjualan di website', 'f', NULL, '2025-07-18 03:01:32.499+00', '2025-08-20 10:26:01.057+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sales_channel_stock_location
-- ----------------------------
DROP TABLE IF EXISTS "public"."sales_channel_stock_location";
CREATE TABLE "public"."sales_channel_stock_location" (
  "sales_channel_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "stock_location_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."sales_channel_stock_location" OWNER TO "postgres";

-- ----------------------------
-- Records of sales_channel_stock_location
-- ----------------------------
BEGIN;
INSERT INTO "public"."sales_channel_stock_location" ("sales_channel_id", "stock_location_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', 'scloc_01K0DQNR4WYYQJPXMS1K4S96HN', '2025-07-18 03:01:34.492314+00', '2025-07-18 03:01:34.492314+00', NULL);
INSERT INTO "public"."sales_channel_stock_location" ("sales_channel_id", "stock_location_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 'scloc_01K33G4TTA7B7S3YD4Z2ZXNPDR', '2025-08-20 10:24:41.301017+00', '2025-08-20 10:24:41.301017+00', NULL);
INSERT INTO "public"."sales_channel_stock_location" ("sales_channel_id", "stock_location_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sc_01K33F08EMQCJXWNZK1HWXHBHR', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 'scloc_01K33G6WF6SKEW4GFZC25JF9VR', '2025-08-20 10:25:48.527157+00', '2025-08-20 10:25:48.527157+00', NULL);
INSERT INTO "public"."sales_channel_stock_location" ("sales_channel_id", "stock_location_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('sc_01K33F0SW4Y9DSZQ933X15TGQ6', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', 'scloc_01K33G6WF8KCVST3QYE6QY38SK', '2025-08-20 10:25:48.527157+00', '2025-08-20 10:25:48.527157+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for script_migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."script_migrations";
CREATE TABLE "public"."script_migrations" (
  "id" int4 NOT NULL DEFAULT nextval('script_migrations_id_seq'::regclass),
  "script_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
  "finished_at" timestamptz(6)
)
;
ALTER TABLE "public"."script_migrations" OWNER TO "postgres";

-- ----------------------------
-- Records of script_migrations
-- ----------------------------
BEGIN;
INSERT INTO "public"."script_migrations" ("id", "script_name", "created_at", "finished_at") VALUES (1, 'migrate-tax-region-provider.js', '2025-07-18 03:01:30.825117+00', '2025-07-18 03:01:30.854212+00');
INSERT INTO "public"."script_migrations" ("id", "script_name", "created_at", "finished_at") VALUES (2, 'migrate-product-shipping-profile.js', '2025-07-18 03:01:30.85776+00', '2025-07-18 03:01:30.872483+00');
COMMIT;

-- ----------------------------
-- Table structure for service_zone
-- ----------------------------
DROP TABLE IF EXISTS "public"."service_zone";
CREATE TABLE "public"."service_zone" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "fulfillment_set_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."service_zone" OWNER TO "postgres";

-- ----------------------------
-- Records of service_zone
-- ----------------------------
BEGIN;
INSERT INTO "public"."service_zone" ("id", "name", "metadata", "fulfillment_set_id", "created_at", "updated_at", "deleted_at") VALUES ('serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', 'Europe', NULL, 'fuset_01K0DQNR1A9GSP9NT5MMF387RW', '2025-07-18 03:01:34.378+00', '2025-07-18 03:01:34.378+00', NULL);
INSERT INTO "public"."service_zone" ("id", "name", "metadata", "fulfillment_set_id", "created_at", "updated_at", "deleted_at") VALUES ('serzo_01K33G5SS77RAVYA695YTY8D6R', 'All Region', NULL, 'fuset_01K33F5NGSCZ63W678VJ0MBZ5M', '2025-08-20 10:25:13+00', '2025-08-20 10:25:13+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for shipping_option
-- ----------------------------
DROP TABLE IF EXISTS "public"."shipping_option";
CREATE TABLE "public"."shipping_option" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "price_type" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'flat'::text,
  "service_zone_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "shipping_profile_id" text COLLATE "pg_catalog"."default",
  "provider_id" text COLLATE "pg_catalog"."default",
  "data" jsonb,
  "metadata" jsonb,
  "shipping_option_type_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."shipping_option" OWNER TO "postgres";

-- ----------------------------
-- Records of shipping_option
-- ----------------------------
BEGIN;
INSERT INTO "public"."shipping_option" ("id", "name", "price_type", "service_zone_id", "shipping_profile_id", "provider_id", "data", "metadata", "shipping_option_type_id", "created_at", "updated_at", "deleted_at") VALUES ('so_01K0DQNR2QDMVGEKRF8BZ3GAPK', 'Standard Shipping', 'flat', 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', 'sp_01K0DQNMKKYJED57XQD63HVRN1', 'manual_manual', NULL, NULL, 'sotype_01K0DQNR2PPPZQ1K3YYZQRFTGF', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option" ("id", "name", "price_type", "service_zone_id", "shipping_profile_id", "provider_id", "data", "metadata", "shipping_option_type_id", "created_at", "updated_at", "deleted_at") VALUES ('so_01K0DQNR2Q89PWCZ1AEQVFW3D0', 'Express Shipping', 'flat', 'serzo_01K0DQNR1AVKJXMKFHSX3K3JX1', 'sp_01K0DQNMKKYJED57XQD63HVRN1', 'manual_manual', NULL, NULL, 'sotype_01K0DQNR2QDYJV6V9J46F3X2XW', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option" ("id", "name", "price_type", "service_zone_id", "shipping_profile_id", "provider_id", "data", "metadata", "shipping_option_type_id", "created_at", "updated_at", "deleted_at") VALUES ('so_01K38B4T1FCQDKK7TT2MPC8DCG', 'Fixed Manual', 'flat', 'serzo_01K33G5SS77RAVYA695YTY8D6R', 'sp_01K0DQNMKKYJED57XQD63HVRN1', 'manual_manual', '{"id": "manual-fulfillment"}', NULL, 'sotype_01K3SYGG262MREJSQ0F86WVA9V', '2025-08-22 07:33:29.776+00', '2025-08-22 07:33:29.776+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for shipping_option_price_set
-- ----------------------------
DROP TABLE IF EXISTS "public"."shipping_option_price_set";
CREATE TABLE "public"."shipping_option_price_set" (
  "shipping_option_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "price_set_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."shipping_option_price_set" OWNER TO "postgres";

-- ----------------------------
-- Records of shipping_option_price_set
-- ----------------------------
BEGIN;
INSERT INTO "public"."shipping_option_price_set" ("shipping_option_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('so_01K0DQNR2QDMVGEKRF8BZ3GAPK', 'pset_01K0DQNR397KW016XRAXC77EB2', 'sops_01K0DQNR4BRB0XA8NTBCF5E50V', '2025-07-18 03:01:34.475001+00', '2025-07-18 03:01:34.475001+00', NULL);
INSERT INTO "public"."shipping_option_price_set" ("shipping_option_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('so_01K0DQNR2Q89PWCZ1AEQVFW3D0', 'pset_01K0DQNR393J1JRXAJM1KFWD58', 'sops_01K0DQNR4BWES8WSJH8ME345HP', '2025-07-18 03:01:34.475001+00', '2025-07-18 03:01:34.475001+00', NULL);
INSERT INTO "public"."shipping_option_price_set" ("shipping_option_id", "price_set_id", "id", "created_at", "updated_at", "deleted_at") VALUES ('so_01K38B4T1FCQDKK7TT2MPC8DCG', 'pset_01K38B4T2MWXPRPPQW8S67AQEV', 'sops_01K38B4T42K1SKZKXW8G2Y1B29', '2025-08-22 07:33:29.857819+00', '2025-08-22 07:33:29.857819+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for shipping_option_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."shipping_option_rule";
CREATE TABLE "public"."shipping_option_rule" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "attribute" text COLLATE "pg_catalog"."default" NOT NULL,
  "operator" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" jsonb,
  "shipping_option_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."shipping_option_rule" OWNER TO "postgres";

-- ----------------------------
-- Records of shipping_option_rule
-- ----------------------------
BEGIN;
INSERT INTO "public"."shipping_option_rule" ("id", "attribute", "operator", "value", "shipping_option_id", "created_at", "updated_at", "deleted_at") VALUES ('sorul_01K0DQNR2PNF85ZT37QGCG3VQD', 'enabled_in_store', 'eq', '"true"', 'so_01K0DQNR2QDMVGEKRF8BZ3GAPK', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option_rule" ("id", "attribute", "operator", "value", "shipping_option_id", "created_at", "updated_at", "deleted_at") VALUES ('sorul_01K0DQNR2QWMGTCXE9YKR10M9C', 'is_return', 'eq', '"false"', 'so_01K0DQNR2QDMVGEKRF8BZ3GAPK', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option_rule" ("id", "attribute", "operator", "value", "shipping_option_id", "created_at", "updated_at", "deleted_at") VALUES ('sorul_01K0DQNR2Q6P1JBSZD10JBQ1EF', 'enabled_in_store', 'eq', '"true"', 'so_01K0DQNR2Q89PWCZ1AEQVFW3D0', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option_rule" ("id", "attribute", "operator", "value", "shipping_option_id", "created_at", "updated_at", "deleted_at") VALUES ('sorul_01K0DQNR2QPAM644BNZ20XG43Y', 'is_return', 'eq', '"false"', 'so_01K0DQNR2Q89PWCZ1AEQVFW3D0', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option_rule" ("id", "attribute", "operator", "value", "shipping_option_id", "created_at", "updated_at", "deleted_at") VALUES ('sorul_01K38B4T1FDQ40DF7V776YKDR4', 'is_return', 'eq', '"false"', 'so_01K38B4T1FCQDKK7TT2MPC8DCG', '2025-08-22 07:33:29.777+00', '2025-08-22 07:33:29.777+00', NULL);
INSERT INTO "public"."shipping_option_rule" ("id", "attribute", "operator", "value", "shipping_option_id", "created_at", "updated_at", "deleted_at") VALUES ('sorul_01K38B4T1FGBQASHXZEW1ZR4TJ', 'enabled_in_store', 'eq', '"true"', 'so_01K38B4T1FCQDKK7TT2MPC8DCG', '2025-08-22 07:33:29.777+00', '2025-08-22 07:33:29.777+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for shipping_option_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."shipping_option_type";
CREATE TABLE "public"."shipping_option_type" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "label" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."shipping_option_type" OWNER TO "postgres";

-- ----------------------------
-- Records of shipping_option_type
-- ----------------------------
BEGIN;
INSERT INTO "public"."shipping_option_type" ("id", "label", "description", "code", "created_at", "updated_at", "deleted_at") VALUES ('sotype_01K0DQNR2PPPZQ1K3YYZQRFTGF', 'Standard', 'Ship in 2-3 days.', 'standard', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option_type" ("id", "label", "description", "code", "created_at", "updated_at", "deleted_at") VALUES ('sotype_01K0DQNR2QDYJV6V9J46F3X2XW', 'Express', 'Ship in 24 hours.', 'express', '2025-07-18 03:01:34.423+00', '2025-07-18 03:01:34.423+00', NULL);
INSERT INTO "public"."shipping_option_type" ("id", "label", "description", "code", "created_at", "updated_at", "deleted_at") VALUES ('sotype_01K3SYGG262MREJSQ0F86WVA9V', 'Default', 'Default shipping option type', 'default', '2025-08-29 03:39:01.056774+00', '2025-08-29 03:39:01.056774+00', NULL);
INSERT INTO "public"."shipping_option_type" ("id", "label", "description", "code", "created_at", "updated_at", "deleted_at") VALUES ('sotype_01K38B4T1EPS42581QEHEHDGJS', 'Type label', 'Type description', 'type-code', '2025-08-22 07:33:29.776+00', '2025-08-22 07:33:29.776+00', '2025-08-29 03:39:01.056774+00');
COMMIT;

-- ----------------------------
-- Table structure for shipping_profile
-- ----------------------------
DROP TABLE IF EXISTS "public"."shipping_profile";
CREATE TABLE "public"."shipping_profile" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."shipping_profile" OWNER TO "postgres";

-- ----------------------------
-- Records of shipping_profile
-- ----------------------------
BEGIN;
INSERT INTO "public"."shipping_profile" ("id", "name", "type", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sp_01K0DQNMKKYJED57XQD63HVRN1', 'Default Shipping Profile', 'default', NULL, '2025-07-18 03:01:30.868+00', '2025-07-18 03:01:30.868+00', NULL);
INSERT INTO "public"."shipping_profile" ("id", "name", "type", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('sp_01K38AVP4T4NGCSERQTTNWK0GP', 'Indonesia', 'all', NULL, '2025-08-22 07:28:30.876+00', '2025-08-22 07:28:30.876+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for stock_location
-- ----------------------------
DROP TABLE IF EXISTS "public"."stock_location";
CREATE TABLE "public"."stock_location" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "address_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb
)
;
ALTER TABLE "public"."stock_location" OWNER TO "postgres";

-- ----------------------------
-- Records of stock_location
-- ----------------------------
BEGIN;
INSERT INTO "public"."stock_location" ("id", "created_at", "updated_at", "deleted_at", "name", "address_id", "metadata") VALUES ('sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB', '2025-07-18 03:01:34.358+00', '2025-07-18 03:01:34.358+00', NULL, 'European Warehouse', 'laddr_01K0DQNR0P4JKWJB622E5FPYJA', NULL);
INSERT INTO "public"."stock_location" ("id", "created_at", "updated_at", "deleted_at", "name", "address_id", "metadata") VALUES ('sloc_01K33F59FEB33XCB0DA9WPWN5Z', '2025-08-20 10:07:27.727+00', '2025-08-20 10:07:27.727+00', NULL, 'Gudang Utama', 'laddr_01K33F59FEZ2HD3PRFEYNRZH5F', NULL);
COMMIT;

-- ----------------------------
-- Table structure for stock_location_address
-- ----------------------------
DROP TABLE IF EXISTS "public"."stock_location_address";
CREATE TABLE "public"."stock_location_address" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "address_1" text COLLATE "pg_catalog"."default" NOT NULL,
  "address_2" text COLLATE "pg_catalog"."default",
  "company" text COLLATE "pg_catalog"."default",
  "city" text COLLATE "pg_catalog"."default",
  "country_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "phone" text COLLATE "pg_catalog"."default",
  "province" text COLLATE "pg_catalog"."default",
  "postal_code" text COLLATE "pg_catalog"."default",
  "metadata" jsonb
)
;
ALTER TABLE "public"."stock_location_address" OWNER TO "postgres";

-- ----------------------------
-- Records of stock_location_address
-- ----------------------------
BEGIN;
INSERT INTO "public"."stock_location_address" ("id", "created_at", "updated_at", "deleted_at", "address_1", "address_2", "company", "city", "country_code", "phone", "province", "postal_code", "metadata") VALUES ('laddr_01K0DQNR0P4JKWJB622E5FPYJA', '2025-07-18 03:01:34.358+00', '2025-07-18 03:01:34.358+00', NULL, '', NULL, NULL, 'Copenhagen', 'DK', NULL, NULL, NULL, NULL);
INSERT INTO "public"."stock_location_address" ("id", "created_at", "updated_at", "deleted_at", "address_1", "address_2", "company", "city", "country_code", "phone", "province", "postal_code", "metadata") VALUES ('laddr_01K33F59FEZ2HD3PRFEYNRZH5F', '2025-08-20 10:07:27.727+00', '2025-08-20 10:07:27.727+00', NULL, 'Jl. Simponi No. 21', '', '', 'Bandung', 'id', '', 'Jawa Barat', '40264', NULL);
COMMIT;

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS "public"."store";
CREATE TABLE "public"."store" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'Medusa Store'::text,
  "default_sales_channel_id" text COLLATE "pg_catalog"."default",
  "default_region_id" text COLLATE "pg_catalog"."default",
  "default_location_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."store" OWNER TO "postgres";

-- ----------------------------
-- Records of store
-- ----------------------------
BEGIN;
INSERT INTO "public"."store" ("id", "name", "default_sales_channel_id", "default_region_id", "default_location_id", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('store_01K0DQNP70B9E7QBGF6CZ0QCYS', 'Medusa Store', 'sc_01K0DQNP6KWXP3R7NJGNA411PQ', 'reg_01K33FFDX0M838JWM069761552', 'sloc_01K33F59FEB33XCB0DA9WPWN5Z', NULL, '2025-07-18 03:01:32.511704+00', '2025-07-18 03:01:32.511704+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for store_currency
-- ----------------------------
DROP TABLE IF EXISTS "public"."store_currency";
CREATE TABLE "public"."store_currency" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "currency_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_default" bool NOT NULL DEFAULT false,
  "store_id" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."store_currency" OWNER TO "postgres";

-- ----------------------------
-- Records of store_currency
-- ----------------------------
BEGIN;
INSERT INTO "public"."store_currency" ("id", "currency_code", "is_default", "store_id", "created_at", "updated_at", "deleted_at") VALUES ('stocur_01K33FFWMTZMH55BTEFPX31GMZ', 'idr', 't', 'store_01K0DQNP70B9E7QBGF6CZ0QCYS', '2025-08-20 10:13:15.028592+00', '2025-08-20 10:13:15.028592+00', NULL);
INSERT INTO "public"."store_currency" ("id", "currency_code", "is_default", "store_id", "created_at", "updated_at", "deleted_at") VALUES ('stocur_01K33FFWMT5YRKPQR4GCGHZC6N', 'eur', 'f', 'store_01K0DQNP70B9E7QBGF6CZ0QCYS', '2025-08-20 10:13:15.028592+00', '2025-08-20 10:13:15.028592+00', NULL);
INSERT INTO "public"."store_currency" ("id", "currency_code", "is_default", "store_id", "created_at", "updated_at", "deleted_at") VALUES ('stocur_01K33FFWMWZFDE8EVTNNX0SBB9', 'usd', 'f', 'store_01K0DQNP70B9E7QBGF6CZ0QCYS', '2025-08-20 10:13:15.028592+00', '2025-08-20 10:13:15.028592+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tax_provider
-- ----------------------------
DROP TABLE IF EXISTS "public"."tax_provider";
CREATE TABLE "public"."tax_provider" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_enabled" bool NOT NULL DEFAULT true,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."tax_provider" OWNER TO "postgres";

-- ----------------------------
-- Records of tax_provider
-- ----------------------------
BEGIN;
INSERT INTO "public"."tax_provider" ("id", "is_enabled", "created_at", "updated_at", "deleted_at") VALUES ('tp_system', 't', '2025-07-18 03:01:30.372+00', '2025-07-18 03:01:30.372+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tax_rate
-- ----------------------------
DROP TABLE IF EXISTS "public"."tax_rate";
CREATE TABLE "public"."tax_rate" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "rate" float4,
  "code" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_default" bool NOT NULL DEFAULT false,
  "is_combinable" bool NOT NULL DEFAULT false,
  "tax_region_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "created_by" text COLLATE "pg_catalog"."default",
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."tax_rate" OWNER TO "postgres";

-- ----------------------------
-- Records of tax_rate
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tax_rate_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."tax_rate_rule";
CREATE TABLE "public"."tax_rate_rule" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "tax_rate_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "reference_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "reference" text COLLATE "pg_catalog"."default" NOT NULL,
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "created_by" text COLLATE "pg_catalog"."default",
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."tax_rate_rule" OWNER TO "postgres";

-- ----------------------------
-- Records of tax_rate_rule
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tax_region
-- ----------------------------
DROP TABLE IF EXISTS "public"."tax_region";
CREATE TABLE "public"."tax_region" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "provider_id" text COLLATE "pg_catalog"."default",
  "country_code" text COLLATE "pg_catalog"."default" NOT NULL,
  "province_code" text COLLATE "pg_catalog"."default",
  "parent_id" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "created_by" text COLLATE "pg_catalog"."default",
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."tax_region" OWNER TO "postgres";

-- ----------------------------
-- Records of tax_region
-- ----------------------------
BEGIN;
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K0DQNR085NBNW8PMMA6JP536', 'tp_system', 'gb', NULL, NULL, NULL, '2025-07-18 03:01:34.344+00', '2025-07-18 03:01:34.344+00', NULL, NULL);
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K0DQNR08QT66TCNF5JC8R7AE', 'tp_system', 'de', NULL, NULL, NULL, '2025-07-18 03:01:34.344+00', '2025-07-18 03:01:34.344+00', NULL, NULL);
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K0DQNR08V0PMMCFQ2X4A1A12', 'tp_system', 'dk', NULL, NULL, NULL, '2025-07-18 03:01:34.344+00', '2025-08-20 10:27:32.623+00', NULL, '2025-08-20 10:27:32.621+00');
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K0DQNR08HGJJVPHVNTMV19KT', 'tp_system', 'es', NULL, NULL, NULL, '2025-07-18 03:01:34.344+00', '2025-08-20 10:27:36.955+00', NULL, '2025-08-20 10:27:36.955+00');
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K0DQNR08V8B0W2EM0DFDCQT7', 'tp_system', 'fr', NULL, NULL, NULL, '2025-07-18 03:01:34.344+00', '2025-08-20 10:27:40.379+00', NULL, '2025-08-20 10:27:40.378+00');
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K0DQNR08HPN3W8T55VQSXXXD', 'tp_system', 'it', NULL, NULL, NULL, '2025-07-18 03:01:34.345+00', '2025-08-20 10:27:44.278+00', NULL, '2025-08-20 10:27:44.278+00');
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K0DQNR08MX7MM870JVK48RM4', 'tp_system', 'se', NULL, NULL, NULL, '2025-07-18 03:01:34.344+00', '2025-08-20 10:27:46.677+00', NULL, '2025-08-20 10:27:46.677+00');
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K33GASJSYTDZC00B0SCCNVWJ', 'tp_system', 'id', NULL, NULL, NULL, '2025-08-20 10:27:56.634+00', '2025-08-20 10:27:56.634+00', 'user_01K0DQTQ8DKZ8PHEZFREPTS5SN', NULL);
INSERT INTO "public"."tax_region" ("id", "provider_id", "country_code", "province_code", "parent_id", "metadata", "created_at", "updated_at", "created_by", "deleted_at") VALUES ('txreg_01K33GKAFW6D5XH4FPWRR77GKS', 'tp_system', 'us', NULL, NULL, NULL, '2025-08-20 10:32:36.093+00', '2025-08-20 10:32:36.093+00', 'user_01K0DQTQ8DKZ8PHEZFREPTS5SN', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS "public"."user";
CREATE TABLE "public"."user" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "first_name" text COLLATE "pg_catalog"."default",
  "last_name" text COLLATE "pg_catalog"."default",
  "email" text COLLATE "pg_catalog"."default" NOT NULL,
  "avatar_url" text COLLATE "pg_catalog"."default",
  "metadata" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."user" OWNER TO "postgres";

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO "public"."user" ("id", "first_name", "last_name", "email", "avatar_url", "metadata", "created_at", "updated_at", "deleted_at") VALUES ('user_01K0DQTQ8DKZ8PHEZFREPTS5SN', 'Adriana', 'Eka Prayudha', 'radenadriep@gmail.com', NULL, NULL, '2025-07-18 03:04:17.421+00', '2025-08-20 09:26:41.462+00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_preference
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_preference";
CREATE TABLE "public"."user_preference" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" text COLLATE "pg_catalog"."default" NOT NULL,
  "key" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" jsonb NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."user_preference" OWNER TO "postgres";

-- ----------------------------
-- Records of user_preference
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for view_configuration
-- ----------------------------
DROP TABLE IF EXISTS "public"."view_configuration";
CREATE TABLE "public"."view_configuration" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL,
  "entity" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default",
  "user_id" text COLLATE "pg_catalog"."default",
  "is_system_default" bool NOT NULL DEFAULT false,
  "configuration" jsonb NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;
ALTER TABLE "public"."view_configuration" OWNER TO "postgres";

-- ----------------------------
-- Records of view_configuration
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for workflow_execution
-- ----------------------------
DROP TABLE IF EXISTS "public"."workflow_execution";
CREATE TABLE "public"."workflow_execution" (
  "id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "workflow_id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "transaction_id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "execution" jsonb,
  "context" jsonb,
  "state" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamp(6),
  "retention_time" int4,
  "run_id" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT '01K0DQNJW4ZB0V3GW9H2031DB9'::text
)
;
ALTER TABLE "public"."workflow_execution" OWNER TO "postgres";

-- ----------------------------
-- Records of workflow_execution
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."link_module_migrations_id_seq"
OWNED BY "public"."link_module_migrations"."id";
SELECT setval('"public"."link_module_migrations_id_seq"', 37, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."mikro_orm_migrations_id_seq"
OWNED BY "public"."mikro_orm_migrations"."id";
SELECT setval('"public"."mikro_orm_migrations_id_seq"', 118, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."order_change_action_ordering_seq"
OWNED BY "public"."order_change_action"."ordering";
SELECT setval('"public"."order_change_action_ordering_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."order_claim_display_id_seq"
OWNED BY "public"."order_claim"."display_id";
SELECT setval('"public"."order_claim_display_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."order_display_id_seq"
OWNED BY "public"."order"."display_id";
SELECT setval('"public"."order_display_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."order_exchange_display_id_seq"
OWNED BY "public"."order_exchange"."display_id";
SELECT setval('"public"."order_exchange_display_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."return_display_id_seq"
OWNED BY "public"."return"."display_id";
SELECT setval('"public"."return_display_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."script_migrations_id_seq"
OWNED BY "public"."script_migrations"."id";
SELECT setval('"public"."script_migrations_id_seq"', 2, true);

-- ----------------------------
-- Indexes structure for table account_holder
-- ----------------------------
CREATE INDEX "IDX_account_holder_deleted_at" ON "public"."account_holder" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_account_holder_provider_id_external_id_unique" ON "public"."account_holder" USING btree (
  "provider_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "external_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table account_holder
-- ----------------------------
ALTER TABLE "public"."account_holder" ADD CONSTRAINT "account_holder_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table api_key
-- ----------------------------
CREATE INDEX "IDX_api_key_deleted_at" ON "public"."api_key" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_api_key_token_unique" ON "public"."api_key" USING btree (
  "token" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_api_key_type" ON "public"."api_key" USING btree (
  "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table api_key
-- ----------------------------
ALTER TABLE "public"."api_key" ADD CONSTRAINT "api_key_type_check" CHECK (type = ANY (ARRAY['publishable'::text, 'secret'::text]));

-- ----------------------------
-- Primary Key structure for table api_key
-- ----------------------------
ALTER TABLE "public"."api_key" ADD CONSTRAINT "api_key_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table application_method_buy_rules
-- ----------------------------
ALTER TABLE "public"."application_method_buy_rules" ADD CONSTRAINT "application_method_buy_rules_pkey" PRIMARY KEY ("application_method_id", "promotion_rule_id");

-- ----------------------------
-- Primary Key structure for table application_method_target_rules
-- ----------------------------
ALTER TABLE "public"."application_method_target_rules" ADD CONSTRAINT "application_method_target_rules_pkey" PRIMARY KEY ("application_method_id", "promotion_rule_id");

-- ----------------------------
-- Indexes structure for table auth_identity
-- ----------------------------
CREATE INDEX "IDX_auth_identity_deleted_at" ON "public"."auth_identity" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table auth_identity
-- ----------------------------
ALTER TABLE "public"."auth_identity" ADD CONSTRAINT "auth_identity_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table brand
-- ----------------------------
CREATE INDEX "IDX_brand_deleted_at" ON "public"."brand" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table brand
-- ----------------------------
ALTER TABLE "public"."brand" ADD CONSTRAINT "brand_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table capture
-- ----------------------------
CREATE INDEX "IDX_capture_deleted_at" ON "public"."capture" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_capture_payment_id" ON "public"."capture" USING btree (
  "payment_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table capture
-- ----------------------------
ALTER TABLE "public"."capture" ADD CONSTRAINT "capture_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart
-- ----------------------------
CREATE INDEX "IDX_cart_billing_address_id" ON "public"."cart" USING btree (
  "billing_address_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND billing_address_id IS NOT NULL;
CREATE INDEX "IDX_cart_currency_code" ON "public"."cart" USING btree (
  "currency_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_cart_customer_id" ON "public"."cart" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND customer_id IS NOT NULL;
CREATE INDEX "IDX_cart_deleted_at" ON "public"."cart" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_cart_region_id" ON "public"."cart" USING btree (
  "region_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND region_id IS NOT NULL;
CREATE INDEX "IDX_cart_sales_channel_id" ON "public"."cart" USING btree (
  "sales_channel_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND sales_channel_id IS NOT NULL;
CREATE INDEX "IDX_cart_shipping_address_id" ON "public"."cart" USING btree (
  "shipping_address_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND shipping_address_id IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table cart
-- ----------------------------
ALTER TABLE "public"."cart" ADD CONSTRAINT "cart_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart_address
-- ----------------------------
CREATE INDEX "IDX_cart_address_deleted_at" ON "public"."cart_address" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table cart_address
-- ----------------------------
ALTER TABLE "public"."cart_address" ADD CONSTRAINT "cart_address_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart_line_item
-- ----------------------------
CREATE INDEX "IDX_cart_line_item_cart_id" ON "public"."cart_line_item" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_cart_line_item_deleted_at" ON "public"."cart_line_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_line_item_cart_id" ON "public"."cart_line_item" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_line_item_product_id" ON "public"."cart_line_item" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND product_id IS NOT NULL;
CREATE INDEX "IDX_line_item_product_type_id" ON "public"."cart_line_item" USING btree (
  "product_type_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND product_type_id IS NOT NULL;
CREATE INDEX "IDX_line_item_variant_id" ON "public"."cart_line_item" USING btree (
  "variant_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND variant_id IS NOT NULL;

-- ----------------------------
-- Checks structure for table cart_line_item
-- ----------------------------
ALTER TABLE "public"."cart_line_item" ADD CONSTRAINT "cart_line_item_unit_price_check" CHECK (unit_price >= 0::numeric);

-- ----------------------------
-- Primary Key structure for table cart_line_item
-- ----------------------------
ALTER TABLE "public"."cart_line_item" ADD CONSTRAINT "cart_line_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart_line_item_adjustment
-- ----------------------------
CREATE INDEX "IDX_adjustment_item_id" ON "public"."cart_line_item_adjustment" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_cart_line_item_adjustment_deleted_at" ON "public"."cart_line_item_adjustment" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_cart_line_item_adjustment_item_id" ON "public"."cart_line_item_adjustment" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_line_item_adjustment_promotion_id" ON "public"."cart_line_item_adjustment" USING btree (
  "promotion_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND promotion_id IS NOT NULL;

-- ----------------------------
-- Checks structure for table cart_line_item_adjustment
-- ----------------------------
ALTER TABLE "public"."cart_line_item_adjustment" ADD CONSTRAINT "cart_line_item_adjustment_check" CHECK (amount >= 0::numeric);

-- ----------------------------
-- Primary Key structure for table cart_line_item_adjustment
-- ----------------------------
ALTER TABLE "public"."cart_line_item_adjustment" ADD CONSTRAINT "cart_line_item_adjustment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart_line_item_tax_line
-- ----------------------------
CREATE INDEX "IDX_cart_line_item_tax_line_deleted_at" ON "public"."cart_line_item_tax_line" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_cart_line_item_tax_line_item_id" ON "public"."cart_line_item_tax_line" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_line_item_tax_line_tax_rate_id" ON "public"."cart_line_item_tax_line" USING btree (
  "tax_rate_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND tax_rate_id IS NOT NULL;
CREATE INDEX "IDX_tax_line_item_id" ON "public"."cart_line_item_tax_line" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table cart_line_item_tax_line
-- ----------------------------
ALTER TABLE "public"."cart_line_item_tax_line" ADD CONSTRAINT "cart_line_item_tax_line_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart_payment_collection
-- ----------------------------
CREATE INDEX "IDX_cart_id_-4a39f6c9" ON "public"."cart_payment_collection" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_deleted_at_-4a39f6c9" ON "public"."cart_payment_collection" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-4a39f6c9" ON "public"."cart_payment_collection" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_payment_collection_id_-4a39f6c9" ON "public"."cart_payment_collection" USING btree (
  "payment_collection_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table cart_payment_collection
-- ----------------------------
ALTER TABLE "public"."cart_payment_collection" ADD CONSTRAINT "cart_payment_collection_pkey" PRIMARY KEY ("cart_id", "payment_collection_id");

-- ----------------------------
-- Indexes structure for table cart_promotion
-- ----------------------------
CREATE INDEX "IDX_cart_id_-a9d4a70b" ON "public"."cart_promotion" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_deleted_at_-a9d4a70b" ON "public"."cart_promotion" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-a9d4a70b" ON "public"."cart_promotion" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_promotion_id_-a9d4a70b" ON "public"."cart_promotion" USING btree (
  "promotion_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table cart_promotion
-- ----------------------------
ALTER TABLE "public"."cart_promotion" ADD CONSTRAINT "cart_promotion_pkey" PRIMARY KEY ("cart_id", "promotion_id");

-- ----------------------------
-- Indexes structure for table cart_shipping_method
-- ----------------------------
CREATE INDEX "IDX_cart_shipping_method_cart_id" ON "public"."cart_shipping_method" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_cart_shipping_method_deleted_at" ON "public"."cart_shipping_method" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_shipping_method_cart_id" ON "public"."cart_shipping_method" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_shipping_method_option_id" ON "public"."cart_shipping_method" USING btree (
  "shipping_option_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND shipping_option_id IS NOT NULL;

-- ----------------------------
-- Checks structure for table cart_shipping_method
-- ----------------------------
ALTER TABLE "public"."cart_shipping_method" ADD CONSTRAINT "cart_shipping_method_check" CHECK (amount >= 0::numeric);

-- ----------------------------
-- Primary Key structure for table cart_shipping_method
-- ----------------------------
ALTER TABLE "public"."cart_shipping_method" ADD CONSTRAINT "cart_shipping_method_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart_shipping_method_adjustment
-- ----------------------------
CREATE INDEX "IDX_adjustment_shipping_method_id" ON "public"."cart_shipping_method_adjustment" USING btree (
  "shipping_method_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_cart_shipping_method_adjustment_deleted_at" ON "public"."cart_shipping_method_adjustment" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_cart_shipping_method_adjustment_shipping_method_id" ON "public"."cart_shipping_method_adjustment" USING btree (
  "shipping_method_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_shipping_method_adjustment_promotion_id" ON "public"."cart_shipping_method_adjustment" USING btree (
  "promotion_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND promotion_id IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table cart_shipping_method_adjustment
-- ----------------------------
ALTER TABLE "public"."cart_shipping_method_adjustment" ADD CONSTRAINT "cart_shipping_method_adjustment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table cart_shipping_method_tax_line
-- ----------------------------
CREATE INDEX "IDX_cart_shipping_method_tax_line_deleted_at" ON "public"."cart_shipping_method_tax_line" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_cart_shipping_method_tax_line_shipping_method_id" ON "public"."cart_shipping_method_tax_line" USING btree (
  "shipping_method_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_shipping_method_tax_line_tax_rate_id" ON "public"."cart_shipping_method_tax_line" USING btree (
  "tax_rate_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND tax_rate_id IS NOT NULL;
CREATE INDEX "IDX_tax_line_shipping_method_id" ON "public"."cart_shipping_method_tax_line" USING btree (
  "shipping_method_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table cart_shipping_method_tax_line
-- ----------------------------
ALTER TABLE "public"."cart_shipping_method_tax_line" ADD CONSTRAINT "cart_shipping_method_tax_line_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table credit_line
-- ----------------------------
CREATE INDEX "IDX_cart_credit_line_reference_reference_id" ON "public"."credit_line" USING btree (
  "reference" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "reference_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_credit_line_cart_id" ON "public"."credit_line" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_credit_line_deleted_at" ON "public"."credit_line" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table credit_line
-- ----------------------------
ALTER TABLE "public"."credit_line" ADD CONSTRAINT "credit_line_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table currency
-- ----------------------------
ALTER TABLE "public"."currency" ADD CONSTRAINT "currency_pkey" PRIMARY KEY ("code");

-- ----------------------------
-- Indexes structure for table customer
-- ----------------------------
CREATE INDEX "IDX_customer_deleted_at" ON "public"."customer" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_customer_email_has_account_unique" ON "public"."customer" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "has_account" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table customer
-- ----------------------------
ALTER TABLE "public"."customer" ADD CONSTRAINT "customer_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table customer_account_holder
-- ----------------------------
CREATE INDEX "IDX_account_holder_id_5cb3a0c0" ON "public"."customer_account_holder" USING btree (
  "account_holder_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_customer_id_5cb3a0c0" ON "public"."customer_account_holder" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_deleted_at_5cb3a0c0" ON "public"."customer_account_holder" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_5cb3a0c0" ON "public"."customer_account_holder" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table customer_account_holder
-- ----------------------------
ALTER TABLE "public"."customer_account_holder" ADD CONSTRAINT "customer_account_holder_pkey" PRIMARY KEY ("customer_id", "account_holder_id");

-- ----------------------------
-- Indexes structure for table customer_address
-- ----------------------------
CREATE INDEX "IDX_customer_address_customer_id" ON "public"."customer_address" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_customer_address_deleted_at" ON "public"."customer_address" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_customer_address_unique_customer_billing" ON "public"."customer_address" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE is_default_billing = true;
CREATE UNIQUE INDEX "IDX_customer_address_unique_customer_shipping" ON "public"."customer_address" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE is_default_shipping = true;

-- ----------------------------
-- Primary Key structure for table customer_address
-- ----------------------------
ALTER TABLE "public"."customer_address" ADD CONSTRAINT "customer_address_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table customer_group
-- ----------------------------
CREATE INDEX "IDX_customer_group_deleted_at" ON "public"."customer_group" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_customer_group_name" ON "public"."customer_group" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_customer_group_name_unique" ON "public"."customer_group" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table customer_group
-- ----------------------------
ALTER TABLE "public"."customer_group" ADD CONSTRAINT "customer_group_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table customer_group_customer
-- ----------------------------
CREATE INDEX "IDX_customer_group_customer_customer_group_id" ON "public"."customer_group_customer" USING btree (
  "customer_group_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_customer_group_customer_customer_id" ON "public"."customer_group_customer" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_customer_group_customer_deleted_at" ON "public"."customer_group_customer" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table customer_group_customer
-- ----------------------------
ALTER TABLE "public"."customer_group_customer" ADD CONSTRAINT "customer_group_customer_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table fulfillment
-- ----------------------------
CREATE INDEX "IDX_fulfillment_deleted_at" ON "public"."fulfillment" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_fulfillment_location_id" ON "public"."fulfillment" USING btree (
  "location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_fulfillment_shipping_option_id" ON "public"."fulfillment" USING btree (
  "shipping_option_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table fulfillment
-- ----------------------------
ALTER TABLE "public"."fulfillment" ADD CONSTRAINT "fulfillment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table fulfillment_address
-- ----------------------------
CREATE INDEX "IDX_fulfillment_address_deleted_at" ON "public"."fulfillment_address" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table fulfillment_address
-- ----------------------------
ALTER TABLE "public"."fulfillment_address" ADD CONSTRAINT "fulfillment_address_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table fulfillment_item
-- ----------------------------
CREATE INDEX "IDX_fulfillment_item_deleted_at" ON "public"."fulfillment_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_fulfillment_item_fulfillment_id" ON "public"."fulfillment_item" USING btree (
  "fulfillment_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_fulfillment_item_inventory_item_id" ON "public"."fulfillment_item" USING btree (
  "inventory_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_fulfillment_item_line_item_id" ON "public"."fulfillment_item" USING btree (
  "line_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table fulfillment_item
-- ----------------------------
ALTER TABLE "public"."fulfillment_item" ADD CONSTRAINT "fulfillment_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table fulfillment_label
-- ----------------------------
CREATE INDEX "IDX_fulfillment_label_deleted_at" ON "public"."fulfillment_label" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_fulfillment_label_fulfillment_id" ON "public"."fulfillment_label" USING btree (
  "fulfillment_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table fulfillment_label
-- ----------------------------
ALTER TABLE "public"."fulfillment_label" ADD CONSTRAINT "fulfillment_label_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table fulfillment_provider
-- ----------------------------
CREATE INDEX "IDX_fulfillment_provider_deleted_at" ON "public"."fulfillment_provider" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table fulfillment_provider
-- ----------------------------
ALTER TABLE "public"."fulfillment_provider" ADD CONSTRAINT "fulfillment_provider_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table fulfillment_set
-- ----------------------------
CREATE INDEX "IDX_fulfillment_set_deleted_at" ON "public"."fulfillment_set" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE UNIQUE INDEX "IDX_fulfillment_set_name_unique" ON "public"."fulfillment_set" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table fulfillment_set
-- ----------------------------
ALTER TABLE "public"."fulfillment_set" ADD CONSTRAINT "fulfillment_set_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table geo_zone
-- ----------------------------
CREATE INDEX "IDX_geo_zone_city" ON "public"."geo_zone" USING btree (
  "city" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND city IS NOT NULL;
CREATE INDEX "IDX_geo_zone_country_code" ON "public"."geo_zone" USING btree (
  "country_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_geo_zone_deleted_at" ON "public"."geo_zone" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_geo_zone_province_code" ON "public"."geo_zone" USING btree (
  "province_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL AND province_code IS NOT NULL;
CREATE INDEX "IDX_geo_zone_service_zone_id" ON "public"."geo_zone" USING btree (
  "service_zone_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table geo_zone
-- ----------------------------
ALTER TABLE "public"."geo_zone" ADD CONSTRAINT "geo_zone_type_check" CHECK (type = ANY (ARRAY['country'::text, 'province'::text, 'city'::text, 'zip'::text]));

-- ----------------------------
-- Primary Key structure for table geo_zone
-- ----------------------------
ALTER TABLE "public"."geo_zone" ADD CONSTRAINT "geo_zone_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table image
-- ----------------------------
CREATE INDEX "IDX_image_deleted_at" ON "public"."image" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_image_product_id" ON "public"."image" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_image_url" ON "public"."image" USING btree (
  "url" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table image
-- ----------------------------
ALTER TABLE "public"."image" ADD CONSTRAINT "image_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table inventory_item
-- ----------------------------
CREATE INDEX "IDX_inventory_item_deleted_at" ON "public"."inventory_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE UNIQUE INDEX "IDX_inventory_item_sku" ON "public"."inventory_item" USING btree (
  "sku" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table inventory_item
-- ----------------------------
ALTER TABLE "public"."inventory_item" ADD CONSTRAINT "inventory_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table inventory_level
-- ----------------------------
CREATE INDEX "IDX_inventory_level_deleted_at" ON "public"."inventory_level" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_inventory_level_inventory_item_id" ON "public"."inventory_level" USING btree (
  "inventory_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_inventory_level_item_location" ON "public"."inventory_level" USING btree (
  "inventory_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_inventory_level_location_id" ON "public"."inventory_level" USING btree (
  "location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_inventory_level_location_id_inventory_item_id" ON "public"."inventory_level" USING btree (
  "inventory_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table inventory_level
-- ----------------------------
ALTER TABLE "public"."inventory_level" ADD CONSTRAINT "inventory_level_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table invite
-- ----------------------------
CREATE INDEX "IDX_invite_deleted_at" ON "public"."invite" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE UNIQUE INDEX "IDX_invite_email_unique" ON "public"."invite" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_invite_token" ON "public"."invite" USING btree (
  "token" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table invite
-- ----------------------------
ALTER TABLE "public"."invite" ADD CONSTRAINT "invite_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table link_module_migrations
-- ----------------------------
ALTER TABLE "public"."link_module_migrations" ADD CONSTRAINT "link_module_migrations_table_name_key" UNIQUE ("table_name");

-- ----------------------------
-- Primary Key structure for table link_module_migrations
-- ----------------------------
ALTER TABLE "public"."link_module_migrations" ADD CONSTRAINT "link_module_migrations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table location_fulfillment_provider
-- ----------------------------
CREATE INDEX "IDX_deleted_at_-1e5992737" ON "public"."location_fulfillment_provider" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_fulfillment_provider_id_-1e5992737" ON "public"."location_fulfillment_provider" USING btree (
  "fulfillment_provider_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-1e5992737" ON "public"."location_fulfillment_provider" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_stock_location_id_-1e5992737" ON "public"."location_fulfillment_provider" USING btree (
  "stock_location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table location_fulfillment_provider
-- ----------------------------
ALTER TABLE "public"."location_fulfillment_provider" ADD CONSTRAINT "location_fulfillment_provider_pkey" PRIMARY KEY ("stock_location_id", "fulfillment_provider_id");

-- ----------------------------
-- Indexes structure for table location_fulfillment_set
-- ----------------------------
CREATE INDEX "IDX_deleted_at_-e88adb96" ON "public"."location_fulfillment_set" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_fulfillment_set_id_-e88adb96" ON "public"."location_fulfillment_set" USING btree (
  "fulfillment_set_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-e88adb96" ON "public"."location_fulfillment_set" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_stock_location_id_-e88adb96" ON "public"."location_fulfillment_set" USING btree (
  "stock_location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table location_fulfillment_set
-- ----------------------------
ALTER TABLE "public"."location_fulfillment_set" ADD CONSTRAINT "location_fulfillment_set_pkey" PRIMARY KEY ("stock_location_id", "fulfillment_set_id");

-- ----------------------------
-- Primary Key structure for table mikro_orm_migrations
-- ----------------------------
ALTER TABLE "public"."mikro_orm_migrations" ADD CONSTRAINT "mikro_orm_migrations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table notification
-- ----------------------------
CREATE INDEX "IDX_notification_deleted_at" ON "public"."notification" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_notification_idempotency_key_unique" ON "public"."notification" USING btree (
  "idempotency_key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_notification_provider_id" ON "public"."notification" USING btree (
  "provider_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_notification_receiver_id" ON "public"."notification" USING btree (
  "receiver_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table notification
-- ----------------------------
ALTER TABLE "public"."notification" ADD CONSTRAINT "notification_status_check" CHECK (status = ANY (ARRAY['pending'::text, 'success'::text, 'failure'::text]));

-- ----------------------------
-- Primary Key structure for table notification
-- ----------------------------
ALTER TABLE "public"."notification" ADD CONSTRAINT "notification_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table notification_provider
-- ----------------------------
CREATE INDEX "IDX_notification_provider_deleted_at" ON "public"."notification_provider" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table notification_provider
-- ----------------------------
ALTER TABLE "public"."notification_provider" ADD CONSTRAINT "notification_provider_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order
-- ----------------------------
CREATE INDEX "IDX_order_billing_address_id" ON "public"."order" USING btree (
  "billing_address_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_currency_code" ON "public"."order" USING btree (
  "currency_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_customer_id" ON "public"."order" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_deleted_at" ON "public"."order" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_display_id" ON "public"."order" USING btree (
  "display_id" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_is_draft_order" ON "public"."order" USING btree (
  "is_draft_order" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_region_id" ON "public"."order" USING btree (
  "region_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_shipping_address_id" ON "public"."order" USING btree (
  "shipping_address_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order
-- ----------------------------
ALTER TABLE "public"."order" ADD CONSTRAINT "order_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_address
-- ----------------------------
CREATE INDEX "IDX_order_address_customer_id" ON "public"."order_address" USING btree (
  "customer_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_address_deleted_at" ON "public"."order_address" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_address
-- ----------------------------
ALTER TABLE "public"."order_address" ADD CONSTRAINT "order_address_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_cart
-- ----------------------------
CREATE INDEX "IDX_cart_id_-71069c16" ON "public"."order_cart" USING btree (
  "cart_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_deleted_at_-71069c16" ON "public"."order_cart" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-71069c16" ON "public"."order_cart" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_id_-71069c16" ON "public"."order_cart" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table order_cart
-- ----------------------------
ALTER TABLE "public"."order_cart" ADD CONSTRAINT "order_cart_pkey" PRIMARY KEY ("order_id", "cart_id");

-- ----------------------------
-- Indexes structure for table order_change
-- ----------------------------
CREATE INDEX "IDX_order_change_change_type" ON "public"."order_change" USING btree (
  "change_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_claim_id" ON "public"."order_change" USING btree (
  "claim_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE claim_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_change_deleted_at" ON "public"."order_change" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_exchange_id" ON "public"."order_change" USING btree (
  "exchange_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE exchange_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_change_order_id" ON "public"."order_change" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_order_id_version" ON "public"."order_change" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "version" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_return_id" ON "public"."order_change" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE return_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_change_status" ON "public"."order_change" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table order_change
-- ----------------------------
ALTER TABLE "public"."order_change" ADD CONSTRAINT "order_change_status_check" CHECK (status = ANY (ARRAY['confirmed'::text, 'declined'::text, 'requested'::text, 'pending'::text, 'canceled'::text]));

-- ----------------------------
-- Primary Key structure for table order_change
-- ----------------------------
ALTER TABLE "public"."order_change" ADD CONSTRAINT "order_change_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_change_action
-- ----------------------------
CREATE INDEX "IDX_order_change_action_claim_id" ON "public"."order_change_action" USING btree (
  "claim_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE claim_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_change_action_deleted_at" ON "public"."order_change_action" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_action_exchange_id" ON "public"."order_change_action" USING btree (
  "exchange_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE exchange_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_change_action_order_change_id" ON "public"."order_change_action" USING btree (
  "order_change_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_action_order_id" ON "public"."order_change_action" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_action_ordering" ON "public"."order_change_action" USING btree (
  "ordering" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_change_action_return_id" ON "public"."order_change_action" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE return_id IS NOT NULL AND deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_change_action
-- ----------------------------
ALTER TABLE "public"."order_change_action" ADD CONSTRAINT "order_change_action_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_claim
-- ----------------------------
CREATE INDEX "IDX_order_claim_deleted_at" ON "public"."order_claim" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_claim_display_id" ON "public"."order_claim" USING btree (
  "display_id" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_claim_order_id" ON "public"."order_claim" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_claim_return_id" ON "public"."order_claim" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE return_id IS NOT NULL AND deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_claim
-- ----------------------------
ALTER TABLE "public"."order_claim" ADD CONSTRAINT "order_claim_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_claim_item
-- ----------------------------
CREATE INDEX "IDX_order_claim_item_claim_id" ON "public"."order_claim_item" USING btree (
  "claim_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_claim_item_deleted_at" ON "public"."order_claim_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_claim_item_item_id" ON "public"."order_claim_item" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_claim_item
-- ----------------------------
ALTER TABLE "public"."order_claim_item" ADD CONSTRAINT "order_claim_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_claim_item_image
-- ----------------------------
CREATE INDEX "IDX_order_claim_item_image_claim_item_id" ON "public"."order_claim_item_image" USING btree (
  "claim_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_order_claim_item_image_deleted_at" ON "public"."order_claim_item_image" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table order_claim_item_image
-- ----------------------------
ALTER TABLE "public"."order_claim_item_image" ADD CONSTRAINT "order_claim_item_image_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_credit_line
-- ----------------------------
CREATE INDEX "IDX_order_credit_line_deleted_at" ON "public"."order_credit_line" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_order_credit_line_order_id" ON "public"."order_credit_line" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table order_credit_line
-- ----------------------------
ALTER TABLE "public"."order_credit_line" ADD CONSTRAINT "order_credit_line_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_exchange
-- ----------------------------
CREATE INDEX "IDX_order_exchange_deleted_at" ON "public"."order_exchange" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_exchange_display_id" ON "public"."order_exchange" USING btree (
  "display_id" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_exchange_order_id" ON "public"."order_exchange" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_exchange_return_id" ON "public"."order_exchange" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE return_id IS NOT NULL AND deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_exchange
-- ----------------------------
ALTER TABLE "public"."order_exchange" ADD CONSTRAINT "order_exchange_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_exchange_item
-- ----------------------------
CREATE INDEX "IDX_order_exchange_item_deleted_at" ON "public"."order_exchange_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_exchange_item_exchange_id" ON "public"."order_exchange_item" USING btree (
  "exchange_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_exchange_item_item_id" ON "public"."order_exchange_item" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_exchange_item
-- ----------------------------
ALTER TABLE "public"."order_exchange_item" ADD CONSTRAINT "order_exchange_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_fulfillment
-- ----------------------------
CREATE INDEX "IDX_deleted_at_-e8d2543e" ON "public"."order_fulfillment" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_fulfillment_id_-e8d2543e" ON "public"."order_fulfillment" USING btree (
  "fulfillment_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-e8d2543e" ON "public"."order_fulfillment" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_id_-e8d2543e" ON "public"."order_fulfillment" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table order_fulfillment
-- ----------------------------
ALTER TABLE "public"."order_fulfillment" ADD CONSTRAINT "order_fulfillment_pkey" PRIMARY KEY ("order_id", "fulfillment_id");

-- ----------------------------
-- Indexes structure for table order_item
-- ----------------------------
CREATE INDEX "IDX_order_item_deleted_at" ON "public"."order_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_order_item_item_id" ON "public"."order_item" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_item_order_id" ON "public"."order_item" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_item_order_id_version" ON "public"."order_item" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "version" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_item
-- ----------------------------
ALTER TABLE "public"."order_item" ADD CONSTRAINT "order_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_line_item
-- ----------------------------
CREATE INDEX "IDX_order_line_item_product_id" ON "public"."order_line_item" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_line_item_variant_id" ON "public"."order_line_item" USING btree (
  "variant_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_line_item
-- ----------------------------
ALTER TABLE "public"."order_line_item" ADD CONSTRAINT "order_line_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_line_item_adjustment
-- ----------------------------
CREATE INDEX "IDX_order_line_item_adjustment_item_id" ON "public"."order_line_item_adjustment" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_line_item_adjustment
-- ----------------------------
ALTER TABLE "public"."order_line_item_adjustment" ADD CONSTRAINT "order_line_item_adjustment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_line_item_tax_line
-- ----------------------------
CREATE INDEX "IDX_order_line_item_tax_line_item_id" ON "public"."order_line_item_tax_line" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_line_item_tax_line
-- ----------------------------
ALTER TABLE "public"."order_line_item_tax_line" ADD CONSTRAINT "order_line_item_tax_line_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_payment_collection
-- ----------------------------
CREATE INDEX "IDX_deleted_at_f42b9949" ON "public"."order_payment_collection" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_f42b9949" ON "public"."order_payment_collection" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_id_f42b9949" ON "public"."order_payment_collection" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_payment_collection_id_f42b9949" ON "public"."order_payment_collection" USING btree (
  "payment_collection_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table order_payment_collection
-- ----------------------------
ALTER TABLE "public"."order_payment_collection" ADD CONSTRAINT "order_payment_collection_pkey" PRIMARY KEY ("order_id", "payment_collection_id");

-- ----------------------------
-- Indexes structure for table order_promotion
-- ----------------------------
CREATE INDEX "IDX_deleted_at_-71518339" ON "public"."order_promotion" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-71518339" ON "public"."order_promotion" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_order_id_-71518339" ON "public"."order_promotion" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_promotion_id_-71518339" ON "public"."order_promotion" USING btree (
  "promotion_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table order_promotion
-- ----------------------------
ALTER TABLE "public"."order_promotion" ADD CONSTRAINT "order_promotion_pkey" PRIMARY KEY ("order_id", "promotion_id");

-- ----------------------------
-- Indexes structure for table order_shipping
-- ----------------------------
CREATE INDEX "IDX_order_shipping_claim_id" ON "public"."order_shipping" USING btree (
  "claim_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE claim_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_shipping_deleted_at" ON "public"."order_shipping" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_order_shipping_exchange_id" ON "public"."order_shipping" USING btree (
  "exchange_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE exchange_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_shipping_item_id" ON "public"."order_shipping" USING btree (
  "shipping_method_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_shipping_order_id" ON "public"."order_shipping" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_shipping_order_id_version" ON "public"."order_shipping" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "version" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_shipping_return_id" ON "public"."order_shipping" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE return_id IS NOT NULL AND deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_shipping
-- ----------------------------
ALTER TABLE "public"."order_shipping" ADD CONSTRAINT "order_shipping_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_shipping_method
-- ----------------------------
CREATE INDEX "IDX_order_shipping_method_shipping_option_id" ON "public"."order_shipping_method" USING btree (
  "shipping_option_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_shipping_method
-- ----------------------------
ALTER TABLE "public"."order_shipping_method" ADD CONSTRAINT "order_shipping_method_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_shipping_method_adjustment
-- ----------------------------
CREATE INDEX "IDX_order_shipping_method_adjustment_shipping_method_id" ON "public"."order_shipping_method_adjustment" USING btree (
  "shipping_method_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_shipping_method_adjustment
-- ----------------------------
ALTER TABLE "public"."order_shipping_method_adjustment" ADD CONSTRAINT "order_shipping_method_adjustment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_shipping_method_tax_line
-- ----------------------------
CREATE INDEX "IDX_order_shipping_method_tax_line_shipping_method_id" ON "public"."order_shipping_method_tax_line" USING btree (
  "shipping_method_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_shipping_method_tax_line
-- ----------------------------
ALTER TABLE "public"."order_shipping_method_tax_line" ADD CONSTRAINT "order_shipping_method_tax_line_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_summary
-- ----------------------------
CREATE INDEX "IDX_order_summary_deleted_at" ON "public"."order_summary" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_order_summary_order_id_version" ON "public"."order_summary" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "version" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_summary
-- ----------------------------
ALTER TABLE "public"."order_summary" ADD CONSTRAINT "order_summary_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_transaction
-- ----------------------------
CREATE INDEX "IDX_order_transaction_claim_id" ON "public"."order_transaction" USING btree (
  "claim_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE claim_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_transaction_currency_code" ON "public"."order_transaction" USING btree (
  "currency_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_transaction_exchange_id" ON "public"."order_transaction" USING btree (
  "exchange_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE exchange_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_order_transaction_order_id_version" ON "public"."order_transaction" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "version" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_transaction_reference_id" ON "public"."order_transaction" USING btree (
  "reference_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_order_transaction_return_id" ON "public"."order_transaction" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE return_id IS NOT NULL AND deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table order_transaction
-- ----------------------------
ALTER TABLE "public"."order_transaction" ADD CONSTRAINT "order_transaction_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table payment
-- ----------------------------
CREATE INDEX "IDX_payment_deleted_at" ON "public"."payment" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_payment_payment_collection_id" ON "public"."payment" USING btree (
  "payment_collection_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_payment_payment_session_id" ON "public"."payment" USING btree (
  "payment_session_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "IDX_payment_payment_session_id_unique" ON "public"."payment" USING btree (
  "payment_session_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_payment_provider_id" ON "public"."payment" USING btree (
  "provider_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table payment
-- ----------------------------
ALTER TABLE "public"."payment" ADD CONSTRAINT "payment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table payment_collection
-- ----------------------------
CREATE INDEX "IDX_payment_collection_deleted_at" ON "public"."payment_collection" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Checks structure for table payment_collection
-- ----------------------------
ALTER TABLE "public"."payment_collection" ADD CONSTRAINT "payment_collection_status_check" CHECK (status = ANY (ARRAY['not_paid'::text, 'awaiting'::text, 'authorized'::text, 'partially_authorized'::text, 'canceled'::text, 'failed'::text, 'partially_captured'::text, 'completed'::text]));

-- ----------------------------
-- Primary Key structure for table payment_collection
-- ----------------------------
ALTER TABLE "public"."payment_collection" ADD CONSTRAINT "payment_collection_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table payment_collection_payment_providers
-- ----------------------------
ALTER TABLE "public"."payment_collection_payment_providers" ADD CONSTRAINT "payment_collection_payment_providers_pkey" PRIMARY KEY ("payment_collection_id", "payment_provider_id");

-- ----------------------------
-- Indexes structure for table payment_provider
-- ----------------------------
CREATE INDEX "IDX_payment_provider_deleted_at" ON "public"."payment_provider" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table payment_provider
-- ----------------------------
ALTER TABLE "public"."payment_provider" ADD CONSTRAINT "payment_provider_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table payment_session
-- ----------------------------
CREATE INDEX "IDX_payment_session_deleted_at" ON "public"."payment_session" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_payment_session_payment_collection_id" ON "public"."payment_session" USING btree (
  "payment_collection_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table payment_session
-- ----------------------------
ALTER TABLE "public"."payment_session" ADD CONSTRAINT "payment_session_status_check" CHECK (status = ANY (ARRAY['authorized'::text, 'captured'::text, 'pending'::text, 'requires_more'::text, 'error'::text, 'canceled'::text]));

-- ----------------------------
-- Primary Key structure for table payment_session
-- ----------------------------
ALTER TABLE "public"."payment_session" ADD CONSTRAINT "payment_session_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table price
-- ----------------------------
CREATE INDEX "IDX_price_currency_code" ON "public"."price" USING btree (
  "currency_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_price_deleted_at" ON "public"."price" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_price_price_list_id" ON "public"."price" USING btree (
  "price_list_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_price_price_set_id" ON "public"."price" USING btree (
  "price_set_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table price
-- ----------------------------
ALTER TABLE "public"."price" ADD CONSTRAINT "price_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table price_list
-- ----------------------------
CREATE INDEX "IDX_price_list_deleted_at" ON "public"."price_list" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Checks structure for table price_list
-- ----------------------------
ALTER TABLE "public"."price_list" ADD CONSTRAINT "price_list_status_check" CHECK (status = ANY (ARRAY['active'::text, 'draft'::text]));
ALTER TABLE "public"."price_list" ADD CONSTRAINT "price_list_type_check" CHECK (type = ANY (ARRAY['sale'::text, 'override'::text]));

-- ----------------------------
-- Primary Key structure for table price_list
-- ----------------------------
ALTER TABLE "public"."price_list" ADD CONSTRAINT "price_list_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table price_list_rule
-- ----------------------------
CREATE INDEX "IDX_price_list_rule_attribute" ON "public"."price_list_rule" USING btree (
  "attribute" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_price_list_rule_deleted_at" ON "public"."price_list_rule" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_price_list_rule_price_list_id" ON "public"."price_list_rule" USING btree (
  "price_list_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table price_list_rule
-- ----------------------------
ALTER TABLE "public"."price_list_rule" ADD CONSTRAINT "price_list_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table price_preference
-- ----------------------------
CREATE UNIQUE INDEX "IDX_price_preference_attribute_value" ON "public"."price_preference" USING btree (
  "attribute" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_price_preference_deleted_at" ON "public"."price_preference" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table price_preference
-- ----------------------------
ALTER TABLE "public"."price_preference" ADD CONSTRAINT "price_preference_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table price_rule
-- ----------------------------
CREATE INDEX "IDX_price_rule_attribute" ON "public"."price_rule" USING btree (
  "attribute" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_price_rule_attribute_value" ON "public"."price_rule" USING btree (
  "attribute" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_price_rule_deleted_at" ON "public"."price_rule" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_price_rule_operator" ON "public"."price_rule" USING btree (
  "operator" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_price_rule_operator_value" ON "public"."price_rule" USING btree (
  "operator" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_price_rule_price_id" ON "public"."price_rule" USING btree (
  "price_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_price_rule_price_id_attribute_operator_unique" ON "public"."price_rule" USING btree (
  "price_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "attribute" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "operator" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table price_rule
-- ----------------------------
ALTER TABLE "public"."price_rule" ADD CONSTRAINT "price_rule_operator_check" CHECK (operator = ANY (ARRAY['gte'::text, 'lte'::text, 'gt'::text, 'lt'::text, 'eq'::text]));

-- ----------------------------
-- Primary Key structure for table price_rule
-- ----------------------------
ALTER TABLE "public"."price_rule" ADD CONSTRAINT "price_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table price_set
-- ----------------------------
CREATE INDEX "IDX_price_set_deleted_at" ON "public"."price_set" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table price_set
-- ----------------------------
ALTER TABLE "public"."price_set" ADD CONSTRAINT "price_set_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product
-- ----------------------------
CREATE INDEX "IDX_product_collection_id" ON "public"."product" USING btree (
  "collection_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_deleted_at" ON "public"."product" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "IDX_product_handle_unique" ON "public"."product" USING btree (
  "handle" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_type_id" ON "public"."product" USING btree (
  "type_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table product
-- ----------------------------
ALTER TABLE "public"."product" ADD CONSTRAINT "product_status_check" CHECK (status = ANY (ARRAY['draft'::text, 'proposed'::text, 'published'::text, 'rejected'::text]));

-- ----------------------------
-- Primary Key structure for table product
-- ----------------------------
ALTER TABLE "public"."product" ADD CONSTRAINT "product_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product_category
-- ----------------------------
CREATE UNIQUE INDEX "IDX_category_handle_unique" ON "public"."product_category" USING btree (
  "handle" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_category_parent_category_id" ON "public"."product_category" USING btree (
  "parent_category_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_category_path" ON "public"."product_category" USING btree (
  "mpath" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table product_category
-- ----------------------------
ALTER TABLE "public"."product_category" ADD CONSTRAINT "product_category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table product_category_product
-- ----------------------------
ALTER TABLE "public"."product_category_product" ADD CONSTRAINT "product_category_product_pkey" PRIMARY KEY ("product_id", "product_category_id");

-- ----------------------------
-- Indexes structure for table product_collection
-- ----------------------------
CREATE UNIQUE INDEX "IDX_collection_handle_unique" ON "public"."product_collection" USING btree (
  "handle" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_category_deleted_at" ON "public"."product_collection" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_product_collection_deleted_at" ON "public"."product_collection" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table product_collection
-- ----------------------------
ALTER TABLE "public"."product_collection" ADD CONSTRAINT "product_collection_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product_option
-- ----------------------------
CREATE UNIQUE INDEX "IDX_option_product_id_title_unique" ON "public"."product_option" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "title" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_option_deleted_at" ON "public"."product_option" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_product_option_product_id" ON "public"."product_option" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table product_option
-- ----------------------------
ALTER TABLE "public"."product_option" ADD CONSTRAINT "product_option_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product_option_value
-- ----------------------------
CREATE UNIQUE INDEX "IDX_option_value_option_id_unique" ON "public"."product_option_value" USING btree (
  "option_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_option_value_deleted_at" ON "public"."product_option_value" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_product_option_value_option_id" ON "public"."product_option_value" USING btree (
  "option_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table product_option_value
-- ----------------------------
ALTER TABLE "public"."product_option_value" ADD CONSTRAINT "product_option_value_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product_product_brand_brand
-- ----------------------------
CREATE INDEX "IDX_brand_id_29c624132" ON "public"."product_product_brand_brand" USING btree (
  "brand_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_deleted_at_29c624132" ON "public"."product_product_brand_brand" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_29c624132" ON "public"."product_product_brand_brand" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_product_id_29c624132" ON "public"."product_product_brand_brand" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table product_product_brand_brand
-- ----------------------------
ALTER TABLE "public"."product_product_brand_brand" ADD CONSTRAINT "product_product_brand_brand_pkey" PRIMARY KEY ("product_id", "brand_id");

-- ----------------------------
-- Indexes structure for table product_sales_channel
-- ----------------------------
CREATE INDEX "IDX_deleted_at_20b454295" ON "public"."product_sales_channel" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_20b454295" ON "public"."product_sales_channel" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_product_id_20b454295" ON "public"."product_sales_channel" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_sales_channel_id_20b454295" ON "public"."product_sales_channel" USING btree (
  "sales_channel_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table product_sales_channel
-- ----------------------------
ALTER TABLE "public"."product_sales_channel" ADD CONSTRAINT "product_sales_channel_pkey" PRIMARY KEY ("product_id", "sales_channel_id");

-- ----------------------------
-- Indexes structure for table product_shipping_profile
-- ----------------------------
CREATE INDEX "IDX_deleted_at_17a262437" ON "public"."product_shipping_profile" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_17a262437" ON "public"."product_shipping_profile" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_product_id_17a262437" ON "public"."product_shipping_profile" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_shipping_profile_id_17a262437" ON "public"."product_shipping_profile" USING btree (
  "shipping_profile_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table product_shipping_profile
-- ----------------------------
ALTER TABLE "public"."product_shipping_profile" ADD CONSTRAINT "product_shipping_profile_pkey" PRIMARY KEY ("product_id", "shipping_profile_id");

-- ----------------------------
-- Indexes structure for table product_tag
-- ----------------------------
CREATE INDEX "IDX_product_tag_deleted_at" ON "public"."product_tag" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "IDX_tag_value_unique" ON "public"."product_tag" USING btree (
  "value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table product_tag
-- ----------------------------
ALTER TABLE "public"."product_tag" ADD CONSTRAINT "product_tag_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table product_tags
-- ----------------------------
ALTER TABLE "public"."product_tags" ADD CONSTRAINT "product_tags_pkey" PRIMARY KEY ("product_id", "product_tag_id");

-- ----------------------------
-- Indexes structure for table product_type
-- ----------------------------
CREATE INDEX "IDX_product_type_deleted_at" ON "public"."product_type" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "IDX_type_value_unique" ON "public"."product_type" USING btree (
  "value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table product_type
-- ----------------------------
ALTER TABLE "public"."product_type" ADD CONSTRAINT "product_type_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product_variant
-- ----------------------------
CREATE UNIQUE INDEX "IDX_product_variant_barcode_unique" ON "public"."product_variant" USING btree (
  "barcode" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_variant_deleted_at" ON "public"."product_variant" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "IDX_product_variant_ean_unique" ON "public"."product_variant" USING btree (
  "ean" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_variant_id_product_id" ON "public"."product_variant" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_product_variant_product_id" ON "public"."product_variant" USING btree (
  "product_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_product_variant_sku_unique" ON "public"."product_variant" USING btree (
  "sku" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_product_variant_upc_unique" ON "public"."product_variant" USING btree (
  "upc" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table product_variant
-- ----------------------------
ALTER TABLE "public"."product_variant" ADD CONSTRAINT "product_variant_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table product_variant_inventory_item
-- ----------------------------
CREATE INDEX "IDX_deleted_at_17b4c4e35" ON "public"."product_variant_inventory_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_17b4c4e35" ON "public"."product_variant_inventory_item" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_inventory_item_id_17b4c4e35" ON "public"."product_variant_inventory_item" USING btree (
  "inventory_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_variant_id_17b4c4e35" ON "public"."product_variant_inventory_item" USING btree (
  "variant_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table product_variant_inventory_item
-- ----------------------------
ALTER TABLE "public"."product_variant_inventory_item" ADD CONSTRAINT "product_variant_inventory_item_pkey" PRIMARY KEY ("variant_id", "inventory_item_id");

-- ----------------------------
-- Primary Key structure for table product_variant_option
-- ----------------------------
ALTER TABLE "public"."product_variant_option" ADD CONSTRAINT "product_variant_option_pkey" PRIMARY KEY ("variant_id", "option_value_id");

-- ----------------------------
-- Indexes structure for table product_variant_price_set
-- ----------------------------
CREATE INDEX "IDX_deleted_at_52b23597" ON "public"."product_variant_price_set" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_52b23597" ON "public"."product_variant_price_set" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_price_set_id_52b23597" ON "public"."product_variant_price_set" USING btree (
  "price_set_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_variant_id_52b23597" ON "public"."product_variant_price_set" USING btree (
  "variant_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table product_variant_price_set
-- ----------------------------
ALTER TABLE "public"."product_variant_price_set" ADD CONSTRAINT "product_variant_price_set_pkey" PRIMARY KEY ("variant_id", "price_set_id");

-- ----------------------------
-- Indexes structure for table promotion
-- ----------------------------
CREATE INDEX "IDX_promotion_campaign_id" ON "public"."promotion" USING btree (
  "campaign_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_promotion_deleted_at" ON "public"."promotion" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_promotion_status" ON "public"."promotion" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_promotion_type" ON "public"."promotion" USING btree (
  "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "IDX_unique_promotion_code" ON "public"."promotion" USING btree (
  "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table promotion
-- ----------------------------
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_status_check" CHECK (status = ANY (ARRAY['draft'::text, 'active'::text, 'inactive'::text]));
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_type_check" CHECK (type = ANY (ARRAY['standard'::text, 'buyget'::text]));

-- ----------------------------
-- Primary Key structure for table promotion
-- ----------------------------
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table promotion_application_method
-- ----------------------------
CREATE INDEX "IDX_application_method_allocation" ON "public"."promotion_application_method" USING btree (
  "allocation" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_application_method_target_type" ON "public"."promotion_application_method" USING btree (
  "target_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_application_method_type" ON "public"."promotion_application_method" USING btree (
  "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_promotion_application_method_currency_code" ON "public"."promotion_application_method" USING btree (
  "currency_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_promotion_application_method_deleted_at" ON "public"."promotion_application_method" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_promotion_application_method_promotion_id_unique" ON "public"."promotion_application_method" USING btree (
  "promotion_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table promotion_application_method
-- ----------------------------
ALTER TABLE "public"."promotion_application_method" ADD CONSTRAINT "promotion_application_method_allocation_check" CHECK (allocation = ANY (ARRAY['each'::text, 'across'::text]));
ALTER TABLE "public"."promotion_application_method" ADD CONSTRAINT "promotion_application_method_target_type_check" CHECK (target_type = ANY (ARRAY['order'::text, 'shipping_methods'::text, 'items'::text]));
ALTER TABLE "public"."promotion_application_method" ADD CONSTRAINT "promotion_application_method_type_check" CHECK (type = ANY (ARRAY['fixed'::text, 'percentage'::text]));

-- ----------------------------
-- Primary Key structure for table promotion_application_method
-- ----------------------------
ALTER TABLE "public"."promotion_application_method" ADD CONSTRAINT "promotion_application_method_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table promotion_campaign
-- ----------------------------
CREATE UNIQUE INDEX "IDX_promotion_campaign_campaign_identifier_unique" ON "public"."promotion_campaign" USING btree (
  "campaign_identifier" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_promotion_campaign_deleted_at" ON "public"."promotion_campaign" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table promotion_campaign
-- ----------------------------
ALTER TABLE "public"."promotion_campaign" ADD CONSTRAINT "promotion_campaign_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table promotion_campaign_budget
-- ----------------------------
CREATE INDEX "IDX_campaign_budget_type" ON "public"."promotion_campaign_budget" USING btree (
  "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "IDX_promotion_campaign_budget_campaign_id_unique" ON "public"."promotion_campaign_budget" USING btree (
  "campaign_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_promotion_campaign_budget_deleted_at" ON "public"."promotion_campaign_budget" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table promotion_campaign_budget
-- ----------------------------
ALTER TABLE "public"."promotion_campaign_budget" ADD CONSTRAINT "promotion_campaign_budget_type_check" CHECK (type = ANY (ARRAY['spend'::text, 'usage'::text]));

-- ----------------------------
-- Primary Key structure for table promotion_campaign_budget
-- ----------------------------
ALTER TABLE "public"."promotion_campaign_budget" ADD CONSTRAINT "promotion_campaign_budget_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table promotion_promotion_rule
-- ----------------------------
ALTER TABLE "public"."promotion_promotion_rule" ADD CONSTRAINT "promotion_promotion_rule_pkey" PRIMARY KEY ("promotion_id", "promotion_rule_id");

-- ----------------------------
-- Indexes structure for table promotion_rule
-- ----------------------------
CREATE INDEX "IDX_promotion_rule_attribute" ON "public"."promotion_rule" USING btree (
  "attribute" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_promotion_rule_deleted_at" ON "public"."promotion_rule" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_promotion_rule_operator" ON "public"."promotion_rule" USING btree (
  "operator" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table promotion_rule
-- ----------------------------
ALTER TABLE "public"."promotion_rule" ADD CONSTRAINT "promotion_rule_operator_check" CHECK (operator = ANY (ARRAY['gte'::text, 'lte'::text, 'gt'::text, 'lt'::text, 'eq'::text, 'ne'::text, 'in'::text]));

-- ----------------------------
-- Primary Key structure for table promotion_rule
-- ----------------------------
ALTER TABLE "public"."promotion_rule" ADD CONSTRAINT "promotion_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table promotion_rule_value
-- ----------------------------
CREATE INDEX "IDX_promotion_rule_value_deleted_at" ON "public"."promotion_rule_value" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_promotion_rule_value_promotion_rule_id" ON "public"."promotion_rule_value" USING btree (
  "promotion_rule_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table promotion_rule_value
-- ----------------------------
ALTER TABLE "public"."promotion_rule_value" ADD CONSTRAINT "promotion_rule_value_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table provider_identity
-- ----------------------------
CREATE INDEX "IDX_provider_identity_auth_identity_id" ON "public"."provider_identity" USING btree (
  "auth_identity_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_provider_identity_deleted_at" ON "public"."provider_identity" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_provider_identity_provider_entity_id" ON "public"."provider_identity" USING btree (
  "entity_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "provider" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table provider_identity
-- ----------------------------
ALTER TABLE "public"."provider_identity" ADD CONSTRAINT "provider_identity_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table publishable_api_key_sales_channel
-- ----------------------------
CREATE INDEX "IDX_deleted_at_-1d67bae40" ON "public"."publishable_api_key_sales_channel" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-1d67bae40" ON "public"."publishable_api_key_sales_channel" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_publishable_key_id_-1d67bae40" ON "public"."publishable_api_key_sales_channel" USING btree (
  "publishable_key_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_sales_channel_id_-1d67bae40" ON "public"."publishable_api_key_sales_channel" USING btree (
  "sales_channel_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table publishable_api_key_sales_channel
-- ----------------------------
ALTER TABLE "public"."publishable_api_key_sales_channel" ADD CONSTRAINT "publishable_api_key_sales_channel_pkey" PRIMARY KEY ("publishable_key_id", "sales_channel_id");

-- ----------------------------
-- Indexes structure for table refund
-- ----------------------------
CREATE INDEX "IDX_refund_deleted_at" ON "public"."refund" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_refund_payment_id" ON "public"."refund" USING btree (
  "payment_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_refund_refund_reason_id" ON "public"."refund" USING btree (
  "refund_reason_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table refund
-- ----------------------------
ALTER TABLE "public"."refund" ADD CONSTRAINT "refund_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table refund_reason
-- ----------------------------
CREATE INDEX "IDX_refund_reason_deleted_at" ON "public"."refund_reason" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table refund_reason
-- ----------------------------
ALTER TABLE "public"."refund_reason" ADD CONSTRAINT "refund_reason_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table region
-- ----------------------------
CREATE INDEX "IDX_region_deleted_at" ON "public"."region" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table region
-- ----------------------------
ALTER TABLE "public"."region" ADD CONSTRAINT "region_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table region_country
-- ----------------------------
CREATE INDEX "IDX_region_country_deleted_at" ON "public"."region_country" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_region_country_region_id" ON "public"."region_country" USING btree (
  "region_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_region_country_region_id_iso_2_unique" ON "public"."region_country" USING btree (
  "region_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "iso_2" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table region_country
-- ----------------------------
ALTER TABLE "public"."region_country" ADD CONSTRAINT "region_country_pkey" PRIMARY KEY ("iso_2");

-- ----------------------------
-- Indexes structure for table region_payment_provider
-- ----------------------------
CREATE INDEX "IDX_deleted_at_1c934dab0" ON "public"."region_payment_provider" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_1c934dab0" ON "public"."region_payment_provider" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_payment_provider_id_1c934dab0" ON "public"."region_payment_provider" USING btree (
  "payment_provider_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_region_id_1c934dab0" ON "public"."region_payment_provider" USING btree (
  "region_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table region_payment_provider
-- ----------------------------
ALTER TABLE "public"."region_payment_provider" ADD CONSTRAINT "region_payment_provider_pkey" PRIMARY KEY ("region_id", "payment_provider_id");

-- ----------------------------
-- Indexes structure for table reservation_item
-- ----------------------------
CREATE INDEX "IDX_reservation_item_deleted_at" ON "public"."reservation_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_reservation_item_inventory_item_id" ON "public"."reservation_item" USING btree (
  "inventory_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_reservation_item_line_item_id" ON "public"."reservation_item" USING btree (
  "line_item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_reservation_item_location_id" ON "public"."reservation_item" USING btree (
  "location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table reservation_item
-- ----------------------------
ALTER TABLE "public"."reservation_item" ADD CONSTRAINT "reservation_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table return
-- ----------------------------
CREATE INDEX "IDX_return_claim_id" ON "public"."return" USING btree (
  "claim_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE claim_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_return_display_id" ON "public"."return" USING btree (
  "display_id" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_return_exchange_id" ON "public"."return" USING btree (
  "exchange_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE exchange_id IS NOT NULL AND deleted_at IS NULL;
CREATE INDEX "IDX_return_order_id" ON "public"."return" USING btree (
  "order_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table return
-- ----------------------------
ALTER TABLE "public"."return" ADD CONSTRAINT "return_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table return_fulfillment
-- ----------------------------
CREATE INDEX "IDX_deleted_at_-31ea43a" ON "public"."return_fulfillment" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_fulfillment_id_-31ea43a" ON "public"."return_fulfillment" USING btree (
  "fulfillment_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_-31ea43a" ON "public"."return_fulfillment" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_return_id_-31ea43a" ON "public"."return_fulfillment" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table return_fulfillment
-- ----------------------------
ALTER TABLE "public"."return_fulfillment" ADD CONSTRAINT "return_fulfillment_pkey" PRIMARY KEY ("return_id", "fulfillment_id");

-- ----------------------------
-- Indexes structure for table return_item
-- ----------------------------
CREATE INDEX "IDX_return_item_deleted_at" ON "public"."return_item" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_return_item_item_id" ON "public"."return_item" USING btree (
  "item_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_return_item_reason_id" ON "public"."return_item" USING btree (
  "reason_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_return_item_return_id" ON "public"."return_item" USING btree (
  "return_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table return_item
-- ----------------------------
ALTER TABLE "public"."return_item" ADD CONSTRAINT "return_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table return_reason
-- ----------------------------
CREATE UNIQUE INDEX "IDX_return_reason_value" ON "public"."return_reason" USING btree (
  "value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table return_reason
-- ----------------------------
ALTER TABLE "public"."return_reason" ADD CONSTRAINT "return_reason_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sales_channel
-- ----------------------------
CREATE INDEX "IDX_sales_channel_deleted_at" ON "public"."sales_channel" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sales_channel
-- ----------------------------
ALTER TABLE "public"."sales_channel" ADD CONSTRAINT "sales_channel_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sales_channel_stock_location
-- ----------------------------
CREATE INDEX "IDX_deleted_at_26d06f470" ON "public"."sales_channel_stock_location" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_26d06f470" ON "public"."sales_channel_stock_location" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_sales_channel_id_26d06f470" ON "public"."sales_channel_stock_location" USING btree (
  "sales_channel_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_stock_location_id_26d06f470" ON "public"."sales_channel_stock_location" USING btree (
  "stock_location_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sales_channel_stock_location
-- ----------------------------
ALTER TABLE "public"."sales_channel_stock_location" ADD CONSTRAINT "sales_channel_stock_location_pkey" PRIMARY KEY ("sales_channel_id", "stock_location_id");

-- ----------------------------
-- Indexes structure for table script_migrations
-- ----------------------------
CREATE UNIQUE INDEX "idx_script_name_unique" ON "public"."script_migrations" USING btree (
  "script_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table script_migrations
-- ----------------------------
ALTER TABLE "public"."script_migrations" ADD CONSTRAINT "script_migrations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table service_zone
-- ----------------------------
CREATE INDEX "IDX_service_zone_deleted_at" ON "public"."service_zone" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_service_zone_fulfillment_set_id" ON "public"."service_zone" USING btree (
  "fulfillment_set_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_service_zone_name_unique" ON "public"."service_zone" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table service_zone
-- ----------------------------
ALTER TABLE "public"."service_zone" ADD CONSTRAINT "service_zone_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table shipping_option
-- ----------------------------
CREATE INDEX "IDX_shipping_option_deleted_at" ON "public"."shipping_option" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_shipping_option_provider_id" ON "public"."shipping_option" USING btree (
  "provider_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_shipping_option_service_zone_id" ON "public"."shipping_option" USING btree (
  "service_zone_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_shipping_option_shipping_profile_id" ON "public"."shipping_option" USING btree (
  "shipping_profile_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table shipping_option
-- ----------------------------
ALTER TABLE "public"."shipping_option" ADD CONSTRAINT "shipping_option_price_type_check" CHECK (price_type = ANY (ARRAY['calculated'::text, 'flat'::text]));

-- ----------------------------
-- Primary Key structure for table shipping_option
-- ----------------------------
ALTER TABLE "public"."shipping_option" ADD CONSTRAINT "shipping_option_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table shipping_option_price_set
-- ----------------------------
CREATE INDEX "IDX_deleted_at_ba32fa9c" ON "public"."shipping_option_price_set" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_id_ba32fa9c" ON "public"."shipping_option_price_set" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_price_set_id_ba32fa9c" ON "public"."shipping_option_price_set" USING btree (
  "price_set_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_shipping_option_id_ba32fa9c" ON "public"."shipping_option_price_set" USING btree (
  "shipping_option_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table shipping_option_price_set
-- ----------------------------
ALTER TABLE "public"."shipping_option_price_set" ADD CONSTRAINT "shipping_option_price_set_pkey" PRIMARY KEY ("shipping_option_id", "price_set_id");

-- ----------------------------
-- Indexes structure for table shipping_option_rule
-- ----------------------------
CREATE INDEX "IDX_shipping_option_rule_deleted_at" ON "public"."shipping_option_rule" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_shipping_option_rule_shipping_option_id" ON "public"."shipping_option_rule" USING btree (
  "shipping_option_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table shipping_option_rule
-- ----------------------------
ALTER TABLE "public"."shipping_option_rule" ADD CONSTRAINT "shipping_option_rule_operator_check" CHECK (operator = ANY (ARRAY['in'::text, 'eq'::text, 'ne'::text, 'gt'::text, 'gte'::text, 'lt'::text, 'lte'::text, 'nin'::text]));

-- ----------------------------
-- Primary Key structure for table shipping_option_rule
-- ----------------------------
ALTER TABLE "public"."shipping_option_rule" ADD CONSTRAINT "shipping_option_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table shipping_option_type
-- ----------------------------
CREATE INDEX "IDX_shipping_option_type_deleted_at" ON "public"."shipping_option_type" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table shipping_option_type
-- ----------------------------
ALTER TABLE "public"."shipping_option_type" ADD CONSTRAINT "shipping_option_type_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table shipping_profile
-- ----------------------------
CREATE INDEX "IDX_shipping_profile_deleted_at" ON "public"."shipping_profile" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE UNIQUE INDEX "IDX_shipping_profile_name_unique" ON "public"."shipping_profile" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table shipping_profile
-- ----------------------------
ALTER TABLE "public"."shipping_profile" ADD CONSTRAINT "shipping_profile_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table stock_location
-- ----------------------------
CREATE UNIQUE INDEX "IDX_stock_location_address_id_unique" ON "public"."stock_location" USING btree (
  "address_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_stock_location_deleted_at" ON "public"."stock_location" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table stock_location
-- ----------------------------
ALTER TABLE "public"."stock_location" ADD CONSTRAINT "stock_location_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table stock_location_address
-- ----------------------------
CREATE INDEX "IDX_stock_location_address_deleted_at" ON "public"."stock_location_address" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table stock_location_address
-- ----------------------------
ALTER TABLE "public"."stock_location_address" ADD CONSTRAINT "stock_location_address_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table store
-- ----------------------------
CREATE INDEX "IDX_store_deleted_at" ON "public"."store" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;

-- ----------------------------
-- Primary Key structure for table store
-- ----------------------------
ALTER TABLE "public"."store" ADD CONSTRAINT "store_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table store_currency
-- ----------------------------
CREATE INDEX "IDX_store_currency_deleted_at" ON "public"."store_currency" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_store_currency_store_id" ON "public"."store_currency" USING btree (
  "store_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table store_currency
-- ----------------------------
ALTER TABLE "public"."store_currency" ADD CONSTRAINT "store_currency_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table tax_provider
-- ----------------------------
CREATE INDEX "IDX_tax_provider_deleted_at" ON "public"."tax_provider" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table tax_provider
-- ----------------------------
ALTER TABLE "public"."tax_provider" ADD CONSTRAINT "tax_provider_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table tax_rate
-- ----------------------------
CREATE UNIQUE INDEX "IDX_single_default_region" ON "public"."tax_rate" USING btree (
  "tax_region_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE is_default = true AND deleted_at IS NULL;
CREATE INDEX "IDX_tax_rate_deleted_at" ON "public"."tax_rate" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_tax_rate_tax_region_id" ON "public"."tax_rate" USING btree (
  "tax_region_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table tax_rate
-- ----------------------------
ALTER TABLE "public"."tax_rate" ADD CONSTRAINT "tax_rate_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table tax_rate_rule
-- ----------------------------
CREATE INDEX "IDX_tax_rate_rule_deleted_at" ON "public"."tax_rate_rule" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_tax_rate_rule_reference_id" ON "public"."tax_rate_rule" USING btree (
  "reference_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_tax_rate_rule_tax_rate_id" ON "public"."tax_rate_rule" USING btree (
  "tax_rate_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_tax_rate_rule_unique_rate_reference" ON "public"."tax_rate_rule" USING btree (
  "tax_rate_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "reference_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table tax_rate_rule
-- ----------------------------
ALTER TABLE "public"."tax_rate_rule" ADD CONSTRAINT "tax_rate_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table tax_region
-- ----------------------------
CREATE INDEX "IDX_tax_region_deleted_at" ON "public"."tax_region" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE INDEX "IDX_tax_region_parent_id" ON "public"."tax_region" USING btree (
  "parent_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_tax_region_provider_id" ON "public"."tax_region" USING btree (
  "provider_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_tax_region_unique_country_nullable_province" ON "public"."tax_region" USING btree (
  "country_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE province_code IS NULL AND deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_tax_region_unique_country_province" ON "public"."tax_region" USING btree (
  "country_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "province_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Checks structure for table tax_region
-- ----------------------------
ALTER TABLE "public"."tax_region" ADD CONSTRAINT "CK_tax_region_country_top_level" CHECK (parent_id IS NULL OR province_code IS NOT NULL);
ALTER TABLE "public"."tax_region" ADD CONSTRAINT "CK_tax_region_provider_top_level" CHECK (parent_id IS NULL OR provider_id IS NULL);

-- ----------------------------
-- Primary Key structure for table tax_region
-- ----------------------------
ALTER TABLE "public"."tax_region" ADD CONSTRAINT "tax_region_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table user
-- ----------------------------
CREATE INDEX "IDX_user_deleted_at" ON "public"."user" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NOT NULL;
CREATE UNIQUE INDEX "IDX_user_email_unique" ON "public"."user" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table user
-- ----------------------------
ALTER TABLE "public"."user" ADD CONSTRAINT "user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table user_preference
-- ----------------------------
CREATE INDEX "IDX_user_preference_deleted_at" ON "public"."user_preference" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_user_preference_user_id" ON "public"."user_preference" USING btree (
  "user_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_user_preference_user_id_key_unique" ON "public"."user_preference" USING btree (
  "user_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table user_preference
-- ----------------------------
ALTER TABLE "public"."user_preference" ADD CONSTRAINT "user_preference_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table view_configuration
-- ----------------------------
CREATE INDEX "IDX_view_configuration_deleted_at" ON "public"."view_configuration" USING btree (
  "deleted_at" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_view_configuration_entity_is_system_default" ON "public"."view_configuration" USING btree (
  "entity" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "is_system_default" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_view_configuration_entity_user_id" ON "public"."view_configuration" USING btree (
  "entity" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "user_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_view_configuration_user_id" ON "public"."view_configuration" USING btree (
  "user_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table view_configuration
-- ----------------------------
ALTER TABLE "public"."view_configuration" ADD CONSTRAINT "view_configuration_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table workflow_execution
-- ----------------------------
CREATE INDEX "IDX_workflow_execution_deleted_at" ON "public"."workflow_execution" USING btree (
  "deleted_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_workflow_execution_id" ON "public"."workflow_execution" USING btree (
  "id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_workflow_execution_run_id" ON "public"."workflow_execution" USING btree (
  "run_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_workflow_execution_state" ON "public"."workflow_execution" USING btree (
  "state" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_workflow_execution_transaction_id" ON "public"."workflow_execution" USING btree (
  "transaction_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE INDEX "IDX_workflow_execution_workflow_id" ON "public"."workflow_execution" USING btree (
  "workflow_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX "IDX_workflow_execution_workflow_id_transaction_id_run_id_unique" ON "public"."workflow_execution" USING btree (
  "workflow_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "transaction_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "run_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_at IS NULL;

-- ----------------------------
-- Primary Key structure for table workflow_execution
-- ----------------------------
ALTER TABLE "public"."workflow_execution" ADD CONSTRAINT "workflow_execution_pkey" PRIMARY KEY ("workflow_id", "transaction_id", "run_id");

-- ----------------------------
-- Foreign Keys structure for table application_method_buy_rules
-- ----------------------------
ALTER TABLE "public"."application_method_buy_rules" ADD CONSTRAINT "application_method_buy_rules_application_method_id_foreign" FOREIGN KEY ("application_method_id") REFERENCES "public"."promotion_application_method" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."application_method_buy_rules" ADD CONSTRAINT "application_method_buy_rules_promotion_rule_id_foreign" FOREIGN KEY ("promotion_rule_id") REFERENCES "public"."promotion_rule" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table application_method_target_rules
-- ----------------------------
ALTER TABLE "public"."application_method_target_rules" ADD CONSTRAINT "application_method_target_rules_application_method_id_foreign" FOREIGN KEY ("application_method_id") REFERENCES "public"."promotion_application_method" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."application_method_target_rules" ADD CONSTRAINT "application_method_target_rules_promotion_rule_id_foreign" FOREIGN KEY ("promotion_rule_id") REFERENCES "public"."promotion_rule" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table capture
-- ----------------------------
ALTER TABLE "public"."capture" ADD CONSTRAINT "capture_payment_id_foreign" FOREIGN KEY ("payment_id") REFERENCES "public"."payment" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table cart
-- ----------------------------
ALTER TABLE "public"."cart" ADD CONSTRAINT "cart_billing_address_id_foreign" FOREIGN KEY ("billing_address_id") REFERENCES "public"."cart_address" ("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."cart" ADD CONSTRAINT "cart_shipping_address_id_foreign" FOREIGN KEY ("shipping_address_id") REFERENCES "public"."cart_address" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table cart_line_item
-- ----------------------------
ALTER TABLE "public"."cart_line_item" ADD CONSTRAINT "cart_line_item_cart_id_foreign" FOREIGN KEY ("cart_id") REFERENCES "public"."cart" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table cart_line_item_adjustment
-- ----------------------------
ALTER TABLE "public"."cart_line_item_adjustment" ADD CONSTRAINT "cart_line_item_adjustment_item_id_foreign" FOREIGN KEY ("item_id") REFERENCES "public"."cart_line_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table cart_line_item_tax_line
-- ----------------------------
ALTER TABLE "public"."cart_line_item_tax_line" ADD CONSTRAINT "cart_line_item_tax_line_item_id_foreign" FOREIGN KEY ("item_id") REFERENCES "public"."cart_line_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table cart_shipping_method
-- ----------------------------
ALTER TABLE "public"."cart_shipping_method" ADD CONSTRAINT "cart_shipping_method_cart_id_foreign" FOREIGN KEY ("cart_id") REFERENCES "public"."cart" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table cart_shipping_method_adjustment
-- ----------------------------
ALTER TABLE "public"."cart_shipping_method_adjustment" ADD CONSTRAINT "cart_shipping_method_adjustment_shipping_method_id_foreign" FOREIGN KEY ("shipping_method_id") REFERENCES "public"."cart_shipping_method" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table cart_shipping_method_tax_line
-- ----------------------------
ALTER TABLE "public"."cart_shipping_method_tax_line" ADD CONSTRAINT "cart_shipping_method_tax_line_shipping_method_id_foreign" FOREIGN KEY ("shipping_method_id") REFERENCES "public"."cart_shipping_method" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table credit_line
-- ----------------------------
ALTER TABLE "public"."credit_line" ADD CONSTRAINT "credit_line_cart_id_foreign" FOREIGN KEY ("cart_id") REFERENCES "public"."cart" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table customer_address
-- ----------------------------
ALTER TABLE "public"."customer_address" ADD CONSTRAINT "customer_address_customer_id_foreign" FOREIGN KEY ("customer_id") REFERENCES "public"."customer" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table customer_group_customer
-- ----------------------------
ALTER TABLE "public"."customer_group_customer" ADD CONSTRAINT "customer_group_customer_customer_group_id_foreign" FOREIGN KEY ("customer_group_id") REFERENCES "public"."customer_group" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."customer_group_customer" ADD CONSTRAINT "customer_group_customer_customer_id_foreign" FOREIGN KEY ("customer_id") REFERENCES "public"."customer" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table fulfillment
-- ----------------------------
ALTER TABLE "public"."fulfillment" ADD CONSTRAINT "fulfillment_delivery_address_id_foreign" FOREIGN KEY ("delivery_address_id") REFERENCES "public"."fulfillment_address" ("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."fulfillment" ADD CONSTRAINT "fulfillment_provider_id_foreign" FOREIGN KEY ("provider_id") REFERENCES "public"."fulfillment_provider" ("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."fulfillment" ADD CONSTRAINT "fulfillment_shipping_option_id_foreign" FOREIGN KEY ("shipping_option_id") REFERENCES "public"."shipping_option" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table fulfillment_item
-- ----------------------------
ALTER TABLE "public"."fulfillment_item" ADD CONSTRAINT "fulfillment_item_fulfillment_id_foreign" FOREIGN KEY ("fulfillment_id") REFERENCES "public"."fulfillment" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table fulfillment_label
-- ----------------------------
ALTER TABLE "public"."fulfillment_label" ADD CONSTRAINT "fulfillment_label_fulfillment_id_foreign" FOREIGN KEY ("fulfillment_id") REFERENCES "public"."fulfillment" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table geo_zone
-- ----------------------------
ALTER TABLE "public"."geo_zone" ADD CONSTRAINT "geo_zone_service_zone_id_foreign" FOREIGN KEY ("service_zone_id") REFERENCES "public"."service_zone" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table image
-- ----------------------------
ALTER TABLE "public"."image" ADD CONSTRAINT "image_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "public"."product" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table inventory_level
-- ----------------------------
ALTER TABLE "public"."inventory_level" ADD CONSTRAINT "inventory_level_inventory_item_id_foreign" FOREIGN KEY ("inventory_item_id") REFERENCES "public"."inventory_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table notification
-- ----------------------------
ALTER TABLE "public"."notification" ADD CONSTRAINT "notification_provider_id_foreign" FOREIGN KEY ("provider_id") REFERENCES "public"."notification_provider" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order
-- ----------------------------
ALTER TABLE "public"."order" ADD CONSTRAINT "order_billing_address_id_foreign" FOREIGN KEY ("billing_address_id") REFERENCES "public"."order_address" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."order" ADD CONSTRAINT "order_shipping_address_id_foreign" FOREIGN KEY ("shipping_address_id") REFERENCES "public"."order_address" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_change
-- ----------------------------
ALTER TABLE "public"."order_change" ADD CONSTRAINT "order_change_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_change_action
-- ----------------------------
ALTER TABLE "public"."order_change_action" ADD CONSTRAINT "order_change_action_order_change_id_foreign" FOREIGN KEY ("order_change_id") REFERENCES "public"."order_change" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_credit_line
-- ----------------------------
ALTER TABLE "public"."order_credit_line" ADD CONSTRAINT "order_credit_line_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_item
-- ----------------------------
ALTER TABLE "public"."order_item" ADD CONSTRAINT "order_item_item_id_foreign" FOREIGN KEY ("item_id") REFERENCES "public"."order_line_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."order_item" ADD CONSTRAINT "order_item_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_line_item
-- ----------------------------
ALTER TABLE "public"."order_line_item" ADD CONSTRAINT "order_line_item_totals_id_foreign" FOREIGN KEY ("totals_id") REFERENCES "public"."order_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_line_item_adjustment
-- ----------------------------
ALTER TABLE "public"."order_line_item_adjustment" ADD CONSTRAINT "order_line_item_adjustment_item_id_foreign" FOREIGN KEY ("item_id") REFERENCES "public"."order_line_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_line_item_tax_line
-- ----------------------------
ALTER TABLE "public"."order_line_item_tax_line" ADD CONSTRAINT "order_line_item_tax_line_item_id_foreign" FOREIGN KEY ("item_id") REFERENCES "public"."order_line_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_shipping
-- ----------------------------
ALTER TABLE "public"."order_shipping" ADD CONSTRAINT "order_shipping_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_shipping_method_adjustment
-- ----------------------------
ALTER TABLE "public"."order_shipping_method_adjustment" ADD CONSTRAINT "order_shipping_method_adjustment_shipping_method_id_foreign" FOREIGN KEY ("shipping_method_id") REFERENCES "public"."order_shipping_method" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_shipping_method_tax_line
-- ----------------------------
ALTER TABLE "public"."order_shipping_method_tax_line" ADD CONSTRAINT "order_shipping_method_tax_line_shipping_method_id_foreign" FOREIGN KEY ("shipping_method_id") REFERENCES "public"."order_shipping_method" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_summary
-- ----------------------------
ALTER TABLE "public"."order_summary" ADD CONSTRAINT "order_summary_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table order_transaction
-- ----------------------------
ALTER TABLE "public"."order_transaction" ADD CONSTRAINT "order_transaction_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table payment
-- ----------------------------
ALTER TABLE "public"."payment" ADD CONSTRAINT "payment_payment_collection_id_foreign" FOREIGN KEY ("payment_collection_id") REFERENCES "public"."payment_collection" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table payment_collection_payment_providers
-- ----------------------------
ALTER TABLE "public"."payment_collection_payment_providers" ADD CONSTRAINT "payment_collection_payment_providers_payment_col_aa276_foreign" FOREIGN KEY ("payment_collection_id") REFERENCES "public"."payment_collection" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."payment_collection_payment_providers" ADD CONSTRAINT "payment_collection_payment_providers_payment_pro_2d555_foreign" FOREIGN KEY ("payment_provider_id") REFERENCES "public"."payment_provider" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table payment_session
-- ----------------------------
ALTER TABLE "public"."payment_session" ADD CONSTRAINT "payment_session_payment_collection_id_foreign" FOREIGN KEY ("payment_collection_id") REFERENCES "public"."payment_collection" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table price
-- ----------------------------
ALTER TABLE "public"."price" ADD CONSTRAINT "price_price_list_id_foreign" FOREIGN KEY ("price_list_id") REFERENCES "public"."price_list" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."price" ADD CONSTRAINT "price_price_set_id_foreign" FOREIGN KEY ("price_set_id") REFERENCES "public"."price_set" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table price_list_rule
-- ----------------------------
ALTER TABLE "public"."price_list_rule" ADD CONSTRAINT "price_list_rule_price_list_id_foreign" FOREIGN KEY ("price_list_id") REFERENCES "public"."price_list" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table price_rule
-- ----------------------------
ALTER TABLE "public"."price_rule" ADD CONSTRAINT "price_rule_price_id_foreign" FOREIGN KEY ("price_id") REFERENCES "public"."price" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product
-- ----------------------------
ALTER TABLE "public"."product" ADD CONSTRAINT "product_collection_id_foreign" FOREIGN KEY ("collection_id") REFERENCES "public"."product_collection" ("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."product" ADD CONSTRAINT "product_type_id_foreign" FOREIGN KEY ("type_id") REFERENCES "public"."product_type" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product_category
-- ----------------------------
ALTER TABLE "public"."product_category" ADD CONSTRAINT "product_category_parent_category_id_foreign" FOREIGN KEY ("parent_category_id") REFERENCES "public"."product_category" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product_category_product
-- ----------------------------
ALTER TABLE "public"."product_category_product" ADD CONSTRAINT "product_category_product_product_category_id_foreign" FOREIGN KEY ("product_category_id") REFERENCES "public"."product_category" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."product_category_product" ADD CONSTRAINT "product_category_product_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "public"."product" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product_option
-- ----------------------------
ALTER TABLE "public"."product_option" ADD CONSTRAINT "product_option_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "public"."product" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product_option_value
-- ----------------------------
ALTER TABLE "public"."product_option_value" ADD CONSTRAINT "product_option_value_option_id_foreign" FOREIGN KEY ("option_id") REFERENCES "public"."product_option" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product_tags
-- ----------------------------
ALTER TABLE "public"."product_tags" ADD CONSTRAINT "product_tags_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "public"."product" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."product_tags" ADD CONSTRAINT "product_tags_product_tag_id_foreign" FOREIGN KEY ("product_tag_id") REFERENCES "public"."product_tag" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product_variant
-- ----------------------------
ALTER TABLE "public"."product_variant" ADD CONSTRAINT "product_variant_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "public"."product" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table product_variant_option
-- ----------------------------
ALTER TABLE "public"."product_variant_option" ADD CONSTRAINT "product_variant_option_option_value_id_foreign" FOREIGN KEY ("option_value_id") REFERENCES "public"."product_option_value" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."product_variant_option" ADD CONSTRAINT "product_variant_option_variant_id_foreign" FOREIGN KEY ("variant_id") REFERENCES "public"."product_variant" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table promotion
-- ----------------------------
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_campaign_id_foreign" FOREIGN KEY ("campaign_id") REFERENCES "public"."promotion_campaign" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table promotion_application_method
-- ----------------------------
ALTER TABLE "public"."promotion_application_method" ADD CONSTRAINT "promotion_application_method_promotion_id_foreign" FOREIGN KEY ("promotion_id") REFERENCES "public"."promotion" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table promotion_campaign_budget
-- ----------------------------
ALTER TABLE "public"."promotion_campaign_budget" ADD CONSTRAINT "promotion_campaign_budget_campaign_id_foreign" FOREIGN KEY ("campaign_id") REFERENCES "public"."promotion_campaign" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table promotion_promotion_rule
-- ----------------------------
ALTER TABLE "public"."promotion_promotion_rule" ADD CONSTRAINT "promotion_promotion_rule_promotion_id_foreign" FOREIGN KEY ("promotion_id") REFERENCES "public"."promotion" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."promotion_promotion_rule" ADD CONSTRAINT "promotion_promotion_rule_promotion_rule_id_foreign" FOREIGN KEY ("promotion_rule_id") REFERENCES "public"."promotion_rule" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table promotion_rule_value
-- ----------------------------
ALTER TABLE "public"."promotion_rule_value" ADD CONSTRAINT "promotion_rule_value_promotion_rule_id_foreign" FOREIGN KEY ("promotion_rule_id") REFERENCES "public"."promotion_rule" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table provider_identity
-- ----------------------------
ALTER TABLE "public"."provider_identity" ADD CONSTRAINT "provider_identity_auth_identity_id_foreign" FOREIGN KEY ("auth_identity_id") REFERENCES "public"."auth_identity" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table refund
-- ----------------------------
ALTER TABLE "public"."refund" ADD CONSTRAINT "refund_payment_id_foreign" FOREIGN KEY ("payment_id") REFERENCES "public"."payment" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table region_country
-- ----------------------------
ALTER TABLE "public"."region_country" ADD CONSTRAINT "region_country_region_id_foreign" FOREIGN KEY ("region_id") REFERENCES "public"."region" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table reservation_item
-- ----------------------------
ALTER TABLE "public"."reservation_item" ADD CONSTRAINT "reservation_item_inventory_item_id_foreign" FOREIGN KEY ("inventory_item_id") REFERENCES "public"."inventory_item" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table return_reason
-- ----------------------------
ALTER TABLE "public"."return_reason" ADD CONSTRAINT "return_reason_parent_return_reason_id_foreign" FOREIGN KEY ("parent_return_reason_id") REFERENCES "public"."return_reason" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table service_zone
-- ----------------------------
ALTER TABLE "public"."service_zone" ADD CONSTRAINT "service_zone_fulfillment_set_id_foreign" FOREIGN KEY ("fulfillment_set_id") REFERENCES "public"."fulfillment_set" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table shipping_option
-- ----------------------------
ALTER TABLE "public"."shipping_option" ADD CONSTRAINT "shipping_option_provider_id_foreign" FOREIGN KEY ("provider_id") REFERENCES "public"."fulfillment_provider" ("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."shipping_option" ADD CONSTRAINT "shipping_option_service_zone_id_foreign" FOREIGN KEY ("service_zone_id") REFERENCES "public"."service_zone" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."shipping_option" ADD CONSTRAINT "shipping_option_shipping_option_type_id_foreign" FOREIGN KEY ("shipping_option_type_id") REFERENCES "public"."shipping_option_type" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE "public"."shipping_option" ADD CONSTRAINT "shipping_option_shipping_profile_id_foreign" FOREIGN KEY ("shipping_profile_id") REFERENCES "public"."shipping_profile" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table shipping_option_rule
-- ----------------------------
ALTER TABLE "public"."shipping_option_rule" ADD CONSTRAINT "shipping_option_rule_shipping_option_id_foreign" FOREIGN KEY ("shipping_option_id") REFERENCES "public"."shipping_option" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table stock_location
-- ----------------------------
ALTER TABLE "public"."stock_location" ADD CONSTRAINT "stock_location_address_id_foreign" FOREIGN KEY ("address_id") REFERENCES "public"."stock_location_address" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table store_currency
-- ----------------------------
ALTER TABLE "public"."store_currency" ADD CONSTRAINT "store_currency_store_id_foreign" FOREIGN KEY ("store_id") REFERENCES "public"."store" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table tax_rate
-- ----------------------------
ALTER TABLE "public"."tax_rate" ADD CONSTRAINT "FK_tax_rate_tax_region_id" FOREIGN KEY ("tax_region_id") REFERENCES "public"."tax_region" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table tax_rate_rule
-- ----------------------------
ALTER TABLE "public"."tax_rate_rule" ADD CONSTRAINT "FK_tax_rate_rule_tax_rate_id" FOREIGN KEY ("tax_rate_id") REFERENCES "public"."tax_rate" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table tax_region
-- ----------------------------
ALTER TABLE "public"."tax_region" ADD CONSTRAINT "FK_tax_region_parent_id" FOREIGN KEY ("parent_id") REFERENCES "public"."tax_region" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."tax_region" ADD CONSTRAINT "FK_tax_region_provider_id" FOREIGN KEY ("provider_id") REFERENCES "public"."tax_provider" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
