--
-- PostgreSQL database dump
--

\restrict j3J3EwsrJXmRzd2MZl5ak16E3wLDjpbYjTOvuWVQyucTpfMjFrbKPzoP4pp8H4h

-- Dumped from database version 17.6 (Homebrew)
-- Dumped by pg_dump version 17.6 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: claim_reason_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.claim_reason_enum AS ENUM (
    'missing_item',
    'wrong_item',
    'production_failure',
    'other'
);


ALTER TYPE public.claim_reason_enum OWNER TO postgres;

--
-- Name: order_claim_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_claim_type_enum AS ENUM (
    'refund',
    'replace'
);


ALTER TYPE public.order_claim_type_enum OWNER TO postgres;

--
-- Name: order_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status_enum AS ENUM (
    'pending',
    'completed',
    'draft',
    'archived',
    'canceled',
    'requires_action'
);


ALTER TYPE public.order_status_enum OWNER TO postgres;

--
-- Name: return_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.return_status_enum AS ENUM (
    'open',
    'requested',
    'received',
    'partially_received',
    'canceled'
);


ALTER TYPE public.return_status_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_holder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_holder (
    id text NOT NULL,
    provider_id text NOT NULL,
    external_id text NOT NULL,
    email text,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.account_holder OWNER TO postgres;

--
-- Name: api_key; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_key (
    id text NOT NULL,
    token text NOT NULL,
    salt text NOT NULL,
    redacted text NOT NULL,
    title text NOT NULL,
    type text NOT NULL,
    last_used_at timestamp(6) with time zone,
    created_by text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    revoked_by text,
    revoked_at timestamp(6) with time zone,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT api_key_type_check CHECK ((type = ANY (ARRAY['publishable'::text, 'secret'::text])))
);


ALTER TABLE public.api_key OWNER TO postgres;

--
-- Name: application_method_buy_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_method_buy_rules (
    application_method_id text NOT NULL,
    promotion_rule_id text NOT NULL
);


ALTER TABLE public.application_method_buy_rules OWNER TO postgres;

--
-- Name: application_method_target_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_method_target_rules (
    application_method_id text NOT NULL,
    promotion_rule_id text NOT NULL
);


ALTER TABLE public.application_method_target_rules OWNER TO postgres;

--
-- Name: auth_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_identity (
    id text NOT NULL,
    app_metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.auth_identity OWNER TO postgres;

--
-- Name: auth_mfa_factor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_mfa_factor (
    id text NOT NULL,
    auth_identity_id text NOT NULL,
    provider text NOT NULL,
    status text NOT NULL,
    provider_metadata jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.auth_mfa_factor OWNER TO postgres;

--
-- Name: auth_mfa_recovery_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_mfa_recovery_code (
    id text NOT NULL,
    auth_identity_id text NOT NULL,
    code_hash text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.auth_mfa_recovery_code OWNER TO postgres;

--
-- Name: auth_password_reset_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_password_reset_token (
    id text NOT NULL,
    auth_identity_id text NOT NULL,
    provider_identity_id text NOT NULL,
    entity_id text NOT NULL,
    token_hash text NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.auth_password_reset_token OWNER TO postgres;

--
-- Name: auth_verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_verification (
    id text NOT NULL,
    auth_identity_id text NOT NULL,
    entity_id text NOT NULL,
    entity_type text NOT NULL,
    code_provider text NOT NULL,
    verified_at timestamp with time zone,
    requested_at timestamp with time zone NOT NULL,
    provider_metadata jsonb,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.auth_verification OWNER TO postgres;

--
-- Name: brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brand (
    id text NOT NULL,
    name text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.brand OWNER TO postgres;

--
-- Name: capture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capture (
    id text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    payment_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    created_by text,
    metadata jsonb
);


ALTER TABLE public.capture OWNER TO postgres;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id text NOT NULL,
    region_id text,
    customer_id text,
    sales_channel_id text,
    email text,
    currency_code text NOT NULL,
    shipping_address_id text,
    billing_address_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    completed_at timestamp(6) with time zone,
    locale text
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_address (
    id text NOT NULL,
    customer_id text,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.cart_address OWNER TO postgres;

--
-- Name: cart_line_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_line_item (
    id text NOT NULL,
    cart_id text NOT NULL,
    title text NOT NULL,
    subtitle text,
    thumbnail text,
    quantity integer NOT NULL,
    variant_id text,
    product_id text,
    product_title text,
    product_description text,
    product_subtitle text,
    product_type text,
    product_collection text,
    product_handle text,
    variant_sku text,
    variant_barcode text,
    variant_title text,
    variant_option_values jsonb,
    requires_shipping boolean DEFAULT true NOT NULL,
    is_discountable boolean DEFAULT true NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    compare_at_unit_price numeric,
    raw_compare_at_unit_price jsonb,
    unit_price numeric NOT NULL,
    raw_unit_price jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    product_type_id text,
    is_custom_price boolean DEFAULT false NOT NULL,
    is_giftcard boolean DEFAULT false NOT NULL,
    CONSTRAINT cart_line_item_unit_price_check CHECK ((unit_price >= (0)::numeric))
);


ALTER TABLE public.cart_line_item OWNER TO postgres;

--
-- Name: cart_line_item_adjustment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_line_item_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    item_id text,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    CONSTRAINT cart_line_item_adjustment_check CHECK ((amount >= (0)::numeric))
);


ALTER TABLE public.cart_line_item_adjustment OWNER TO postgres;

--
-- Name: cart_line_item_tax_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_line_item_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate real NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    item_id text
);


ALTER TABLE public.cart_line_item_tax_line OWNER TO postgres;

--
-- Name: cart_payment_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_payment_collection (
    cart_id character varying(255) NOT NULL,
    payment_collection_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.cart_payment_collection OWNER TO postgres;

--
-- Name: cart_promotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_promotion (
    cart_id character varying(255) NOT NULL,
    promotion_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.cart_promotion OWNER TO postgres;

--
-- Name: cart_shipping_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_shipping_method (
    id text NOT NULL,
    cart_id text NOT NULL,
    name text NOT NULL,
    description jsonb,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    shipping_option_id text,
    data jsonb,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT cart_shipping_method_check CHECK ((amount >= (0)::numeric))
);


ALTER TABLE public.cart_shipping_method OWNER TO postgres;

--
-- Name: cart_shipping_method_adjustment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_shipping_method_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    shipping_method_id text
);


ALTER TABLE public.cart_shipping_method_adjustment OWNER TO postgres;

--
-- Name: cart_shipping_method_tax_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_shipping_method_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate real NOT NULL,
    provider_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    shipping_method_id text
);


ALTER TABLE public.cart_shipping_method_tax_line OWNER TO postgres;

--
-- Name: credit_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credit_line (
    id text NOT NULL,
    cart_id text NOT NULL,
    reference text,
    reference_id text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.credit_line OWNER TO postgres;

--
-- Name: currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currency (
    code text NOT NULL,
    symbol text NOT NULL,
    symbol_native text NOT NULL,
    decimal_digits integer DEFAULT 0 NOT NULL,
    rounding numeric DEFAULT 0 NOT NULL,
    raw_rounding jsonb NOT NULL,
    name text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.currency OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id text NOT NULL,
    company_name text,
    first_name text,
    last_name text,
    email text,
    phone text,
    has_account boolean DEFAULT false NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    created_by text
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_account_holder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_account_holder (
    customer_id character varying(255) NOT NULL,
    account_holder_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.customer_account_holder OWNER TO postgres;

--
-- Name: customer_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_address (
    id text NOT NULL,
    customer_id text NOT NULL,
    address_name text,
    is_default_shipping boolean DEFAULT false NOT NULL,
    is_default_billing boolean DEFAULT false NOT NULL,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.customer_address OWNER TO postgres;

--
-- Name: customer_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_group (
    id text NOT NULL,
    name text NOT NULL,
    metadata jsonb,
    created_by text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.customer_group OWNER TO postgres;

--
-- Name: customer_group_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_group_customer (
    id text NOT NULL,
    customer_id text NOT NULL,
    customer_group_id text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.customer_group_customer OWNER TO postgres;

--
-- Name: fulfillment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment (
    id text NOT NULL,
    location_id text NOT NULL,
    packed_at timestamp(6) with time zone,
    shipped_at timestamp(6) with time zone,
    delivered_at timestamp(6) with time zone,
    canceled_at timestamp(6) with time zone,
    data jsonb,
    provider_id text,
    shipping_option_id text,
    metadata jsonb,
    delivery_address_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    marked_shipped_by text,
    created_by text,
    requires_shipping boolean DEFAULT true NOT NULL
);


ALTER TABLE public.fulfillment OWNER TO postgres;

--
-- Name: fulfillment_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment_address (
    id text NOT NULL,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.fulfillment_address OWNER TO postgres;

--
-- Name: fulfillment_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment_item (
    id text NOT NULL,
    title text NOT NULL,
    sku text NOT NULL,
    barcode text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    line_item_id text,
    inventory_item_id text,
    fulfillment_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.fulfillment_item OWNER TO postgres;

--
-- Name: fulfillment_label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment_label (
    id text NOT NULL,
    tracking_number text NOT NULL,
    tracking_url text NOT NULL,
    label_url text NOT NULL,
    fulfillment_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.fulfillment_label OWNER TO postgres;

--
-- Name: fulfillment_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment_provider (
    id text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.fulfillment_provider OWNER TO postgres;

--
-- Name: fulfillment_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment_set (
    id text NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.fulfillment_set OWNER TO postgres;

--
-- Name: geo_zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.geo_zone (
    id text NOT NULL,
    type text DEFAULT 'country'::text NOT NULL,
    country_code text NOT NULL,
    province_code text,
    city text,
    service_zone_id text NOT NULL,
    postal_expression jsonb,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT geo_zone_type_check CHECK ((type = ANY (ARRAY['country'::text, 'province'::text, 'city'::text, 'zip'::text])))
);


ALTER TABLE public.geo_zone OWNER TO postgres;

--
-- Name: image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image (
    id text NOT NULL,
    url text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    rank integer DEFAULT 0 NOT NULL,
    product_id text NOT NULL
);


ALTER TABLE public.image OWNER TO postgres;

--
-- Name: inventory_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_item (
    id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    sku text,
    origin_country text,
    hs_code text,
    mid_code text,
    material text,
    weight integer,
    length integer,
    height integer,
    width integer,
    requires_shipping boolean DEFAULT true NOT NULL,
    description text,
    title text,
    thumbnail text,
    metadata jsonb
);


ALTER TABLE public.inventory_item OWNER TO postgres;

--
-- Name: inventory_level; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_level (
    id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    inventory_item_id text NOT NULL,
    location_id text NOT NULL,
    stocked_quantity numeric DEFAULT 0 NOT NULL,
    reserved_quantity numeric DEFAULT 0 NOT NULL,
    incoming_quantity numeric DEFAULT 0 NOT NULL,
    metadata jsonb,
    raw_stocked_quantity jsonb,
    raw_reserved_quantity jsonb,
    raw_incoming_quantity jsonb
);


ALTER TABLE public.inventory_level OWNER TO postgres;

--
-- Name: invite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invite (
    id text NOT NULL,
    email text NOT NULL,
    accepted boolean DEFAULT false NOT NULL,
    token text NOT NULL,
    expires_at timestamp(6) with time zone NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.invite OWNER TO postgres;

--
-- Name: invite_rbac_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invite_rbac_role (
    invite_id character varying(255) NOT NULL,
    rbac_role_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.invite_rbac_role OWNER TO postgres;

--
-- Name: layout_configuration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.layout_configuration (
    id text NOT NULL,
    zone text NOT NULL,
    user_id text,
    is_system_default boolean DEFAULT false NOT NULL,
    configuration jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.layout_configuration OWNER TO postgres;

--
-- Name: link_module_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.link_module_migrations (
    id integer NOT NULL,
    table_name character varying(255) NOT NULL,
    link_descriptor jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.link_module_migrations OWNER TO postgres;

--
-- Name: link_module_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.link_module_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.link_module_migrations_id_seq OWNER TO postgres;

--
-- Name: link_module_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.link_module_migrations_id_seq OWNED BY public.link_module_migrations.id;


--
-- Name: location_fulfillment_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location_fulfillment_provider (
    stock_location_id character varying(255) NOT NULL,
    fulfillment_provider_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.location_fulfillment_provider OWNER TO postgres;

--
-- Name: location_fulfillment_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location_fulfillment_set (
    stock_location_id character varying(255) NOT NULL,
    fulfillment_set_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.location_fulfillment_set OWNER TO postgres;

--
-- Name: mikro_orm_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mikro_orm_migrations (
    id integer NOT NULL,
    name character varying(255),
    executed_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.mikro_orm_migrations OWNER TO postgres;

--
-- Name: mikro_orm_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mikro_orm_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.mikro_orm_migrations_id_seq OWNER TO postgres;

--
-- Name: mikro_orm_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mikro_orm_migrations_id_seq OWNED BY public.mikro_orm_migrations.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id text NOT NULL,
    "to" text NOT NULL,
    channel text NOT NULL,
    template text,
    data jsonb,
    trigger_type text,
    resource_id text,
    resource_type text,
    receiver_id text,
    original_notification_id text,
    idempotency_key text,
    external_id text,
    provider_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    status text DEFAULT 'pending'::text NOT NULL,
    "from" text,
    provider_data jsonb,
    CONSTRAINT notification_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'success'::text, 'failure'::text])))
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_provider (
    id text NOT NULL,
    handle text NOT NULL,
    name text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    channels text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.notification_provider OWNER TO postgres;

--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id text NOT NULL,
    region_id text,
    display_id integer,
    customer_id text,
    version integer DEFAULT 1 NOT NULL,
    sales_channel_id text,
    status public.order_status_enum DEFAULT 'pending'::public.order_status_enum NOT NULL,
    is_draft_order boolean DEFAULT false NOT NULL,
    email text,
    currency_code text NOT NULL,
    shipping_address_id text,
    billing_address_id text,
    no_notification boolean,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    canceled_at timestamp(6) with time zone,
    custom_display_id text,
    locale text
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: order_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_address (
    id text NOT NULL,
    customer_id text,
    company text,
    first_name text,
    last_name text,
    address_1 text,
    address_2 text,
    city text,
    country_code text,
    province text,
    postal_code text,
    phone text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_address OWNER TO postgres;

--
-- Name: order_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_cart (
    order_id character varying(255) NOT NULL,
    cart_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_cart OWNER TO postgres;

--
-- Name: order_change; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_change (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer NOT NULL,
    description text,
    status text DEFAULT 'pending'::text NOT NULL,
    internal_note text,
    created_by text,
    requested_by text,
    requested_at timestamp(6) with time zone,
    confirmed_by text,
    confirmed_at timestamp(6) with time zone,
    declined_by text,
    declined_reason text,
    metadata jsonb,
    declined_at timestamp(6) with time zone,
    canceled_by text,
    canceled_at timestamp(6) with time zone,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    change_type text,
    deleted_at timestamp(6) with time zone,
    return_id text,
    claim_id text,
    exchange_id text,
    carry_over_promotions boolean,
    CONSTRAINT order_change_status_check CHECK ((status = ANY (ARRAY['confirmed'::text, 'declined'::text, 'requested'::text, 'pending'::text, 'canceled'::text])))
);


ALTER TABLE public.order_change OWNER TO postgres;

--
-- Name: order_change_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_change_action (
    id text NOT NULL,
    order_id text,
    version integer,
    ordering bigint NOT NULL,
    order_change_id text,
    reference text,
    reference_id text,
    action text NOT NULL,
    details jsonb,
    amount numeric,
    raw_amount jsonb,
    internal_note text,
    applied boolean DEFAULT false NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    return_id text,
    claim_id text,
    exchange_id text
);


ALTER TABLE public.order_change_action OWNER TO postgres;

--
-- Name: order_change_action_ordering_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_change_action_ordering_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_change_action_ordering_seq OWNER TO postgres;

--
-- Name: order_change_action_ordering_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_change_action_ordering_seq OWNED BY public.order_change_action.ordering;


--
-- Name: order_claim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_claim (
    id text NOT NULL,
    order_id text NOT NULL,
    return_id text,
    order_version integer NOT NULL,
    display_id integer NOT NULL,
    type public.order_claim_type_enum NOT NULL,
    no_notification boolean,
    refund_amount numeric,
    raw_refund_amount jsonb,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    canceled_at timestamp(6) with time zone,
    created_by text
);


ALTER TABLE public.order_claim OWNER TO postgres;

--
-- Name: order_claim_display_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_claim_display_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.order_claim_display_id_seq OWNER TO postgres;

--
-- Name: order_claim_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_claim_display_id_seq OWNED BY public.order_claim.display_id;


--
-- Name: order_claim_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_claim_item (
    id text NOT NULL,
    claim_id text NOT NULL,
    item_id text NOT NULL,
    is_additional_item boolean DEFAULT false NOT NULL,
    reason public.claim_reason_enum,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    note text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_claim_item OWNER TO postgres;

--
-- Name: order_claim_item_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_claim_item_image (
    id text NOT NULL,
    claim_item_id text NOT NULL,
    url text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_claim_item_image OWNER TO postgres;

--
-- Name: order_credit_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_credit_line (
    id text NOT NULL,
    order_id text NOT NULL,
    reference text,
    reference_id text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    version integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.order_credit_line OWNER TO postgres;

--
-- Name: order_display_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_display_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.order_display_id_seq OWNER TO postgres;

--
-- Name: order_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_display_id_seq OWNED BY public."order".display_id;


--
-- Name: order_exchange; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_exchange (
    id text NOT NULL,
    order_id text NOT NULL,
    return_id text,
    order_version integer NOT NULL,
    display_id integer NOT NULL,
    no_notification boolean,
    allow_backorder boolean DEFAULT false NOT NULL,
    difference_due numeric,
    raw_difference_due jsonb,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    canceled_at timestamp(6) with time zone,
    created_by text
);


ALTER TABLE public.order_exchange OWNER TO postgres;

--
-- Name: order_exchange_display_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_exchange_display_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.order_exchange_display_id_seq OWNER TO postgres;

--
-- Name: order_exchange_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_exchange_display_id_seq OWNED BY public.order_exchange.display_id;


--
-- Name: order_exchange_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_exchange_item (
    id text NOT NULL,
    exchange_id text NOT NULL,
    item_id text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    note text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_exchange_item OWNER TO postgres;

--
-- Name: order_fulfillment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_fulfillment (
    order_id character varying(255) NOT NULL,
    fulfillment_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_fulfillment OWNER TO postgres;

--
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer NOT NULL,
    item_id text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    fulfilled_quantity numeric NOT NULL,
    raw_fulfilled_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    shipped_quantity numeric NOT NULL,
    raw_shipped_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    return_requested_quantity numeric NOT NULL,
    raw_return_requested_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    return_received_quantity numeric NOT NULL,
    raw_return_received_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    return_dismissed_quantity numeric NOT NULL,
    raw_return_dismissed_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    written_off_quantity numeric NOT NULL,
    raw_written_off_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    delivered_quantity numeric DEFAULT 0 NOT NULL,
    raw_delivered_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    unit_price numeric,
    raw_unit_price jsonb,
    compare_at_unit_price numeric,
    raw_compare_at_unit_price jsonb
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- Name: order_line_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_line_item (
    id text NOT NULL,
    totals_id text,
    title text NOT NULL,
    subtitle text,
    thumbnail text,
    variant_id text,
    product_id text,
    product_title text,
    product_description text,
    product_subtitle text,
    product_type text,
    product_collection text,
    product_handle text,
    variant_sku text,
    variant_barcode text,
    variant_title text,
    variant_option_values jsonb,
    requires_shipping boolean DEFAULT true NOT NULL,
    is_discountable boolean DEFAULT true NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    compare_at_unit_price numeric,
    raw_compare_at_unit_price jsonb,
    unit_price numeric NOT NULL,
    raw_unit_price jsonb NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    is_custom_price boolean DEFAULT false NOT NULL,
    product_type_id text,
    is_giftcard boolean DEFAULT false NOT NULL
);


ALTER TABLE public.order_line_item OWNER TO postgres;

--
-- Name: order_line_item_adjustment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_line_item_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    item_id text NOT NULL,
    deleted_at timestamp(6) with time zone,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    version integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.order_line_item_adjustment OWNER TO postgres;

--
-- Name: order_line_item_tax_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_line_item_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate numeric NOT NULL,
    raw_rate jsonb NOT NULL,
    provider_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    item_id text NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_line_item_tax_line OWNER TO postgres;

--
-- Name: order_payment_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_payment_collection (
    order_id character varying(255) NOT NULL,
    payment_collection_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_payment_collection OWNER TO postgres;

--
-- Name: order_promotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_promotion (
    order_id character varying(255) NOT NULL,
    promotion_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_promotion OWNER TO postgres;

--
-- Name: order_shipping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_shipping (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer NOT NULL,
    shipping_method_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    return_id text,
    claim_id text,
    exchange_id text
);


ALTER TABLE public.order_shipping OWNER TO postgres;

--
-- Name: order_shipping_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_shipping_method (
    id text NOT NULL,
    name text NOT NULL,
    description jsonb,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    shipping_option_id text,
    data jsonb,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    is_custom_amount boolean DEFAULT false NOT NULL
);


ALTER TABLE public.order_shipping_method OWNER TO postgres;

--
-- Name: order_shipping_method_adjustment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_shipping_method_adjustment (
    id text NOT NULL,
    description text,
    promotion_id text,
    code text,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    shipping_method_id text NOT NULL,
    deleted_at timestamp(6) with time zone,
    version integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.order_shipping_method_adjustment OWNER TO postgres;

--
-- Name: order_shipping_method_tax_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_shipping_method_tax_line (
    id text NOT NULL,
    description text,
    tax_rate_id text,
    code text NOT NULL,
    rate numeric NOT NULL,
    raw_rate jsonb NOT NULL,
    provider_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    shipping_method_id text NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_shipping_method_tax_line OWNER TO postgres;

--
-- Name: order_summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_summary (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    totals jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.order_summary OWNER TO postgres;

--
-- Name: order_transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_transaction (
    id text NOT NULL,
    order_id text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    currency_code text NOT NULL,
    reference text,
    reference_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    return_id text,
    claim_id text,
    exchange_id text
);


ALTER TABLE public.order_transaction OWNER TO postgres;

--
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    currency_code text NOT NULL,
    provider_id text NOT NULL,
    data jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    captured_at timestamp(6) with time zone,
    canceled_at timestamp(6) with time zone,
    payment_collection_id text NOT NULL,
    payment_session_id text NOT NULL,
    metadata jsonb
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- Name: payment_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_collection (
    id text NOT NULL,
    currency_code text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    authorized_amount numeric,
    raw_authorized_amount jsonb,
    captured_amount numeric,
    raw_captured_amount jsonb,
    refunded_amount numeric,
    raw_refunded_amount jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    completed_at timestamp(6) with time zone,
    status text DEFAULT 'not_paid'::text NOT NULL,
    metadata jsonb,
    CONSTRAINT payment_collection_status_check CHECK ((status = ANY (ARRAY['not_paid'::text, 'awaiting'::text, 'authorized'::text, 'partially_authorized'::text, 'canceled'::text, 'failed'::text, 'partially_captured'::text, 'completed'::text])))
);


ALTER TABLE public.payment_collection OWNER TO postgres;

--
-- Name: payment_collection_payment_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_collection_payment_providers (
    payment_collection_id text NOT NULL,
    payment_provider_id text NOT NULL
);


ALTER TABLE public.payment_collection_payment_providers OWNER TO postgres;

--
-- Name: payment_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_provider (
    id text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.payment_provider OWNER TO postgres;

--
-- Name: payment_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_session (
    id text NOT NULL,
    currency_code text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    provider_id text NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    context jsonb,
    status text DEFAULT 'pending'::text NOT NULL,
    authorized_at timestamp(6) with time zone,
    payment_collection_id text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT payment_session_status_check CHECK ((status = ANY (ARRAY['authorized'::text, 'captured'::text, 'pending'::text, 'requires_more'::text, 'error'::text, 'canceled'::text, 'pending_authorization'::text])))
);


ALTER TABLE public.payment_session OWNER TO postgres;

--
-- Name: price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price (
    id text NOT NULL,
    title text,
    price_set_id text NOT NULL,
    currency_code text NOT NULL,
    raw_amount jsonb NOT NULL,
    rules_count integer DEFAULT 0,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    price_list_id text,
    amount numeric NOT NULL,
    min_quantity numeric,
    max_quantity numeric,
    raw_min_quantity jsonb,
    raw_max_quantity jsonb
);


ALTER TABLE public.price OWNER TO postgres;

--
-- Name: price_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_list (
    id text NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    starts_at timestamp(6) with time zone,
    ends_at timestamp(6) with time zone,
    rules_count integer DEFAULT 0,
    title text NOT NULL,
    description text NOT NULL,
    type text DEFAULT 'sale'::text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    metadata jsonb,
    CONSTRAINT price_list_status_check CHECK ((status = ANY (ARRAY['active'::text, 'draft'::text]))),
    CONSTRAINT price_list_type_check CHECK ((type = ANY (ARRAY['sale'::text, 'override'::text])))
);


ALTER TABLE public.price_list OWNER TO postgres;

--
-- Name: price_list_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_list_rule (
    id text NOT NULL,
    price_list_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    value jsonb,
    attribute text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.price_list_rule OWNER TO postgres;

--
-- Name: price_preference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_preference (
    id text NOT NULL,
    attribute text NOT NULL,
    value text,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.price_preference OWNER TO postgres;

--
-- Name: price_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_rule (
    id text NOT NULL,
    value text NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    price_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    attribute text DEFAULT ''::text NOT NULL,
    operator text DEFAULT 'eq'::text NOT NULL,
    CONSTRAINT price_rule_operator_check CHECK ((operator = ANY (ARRAY['gte'::text, 'lte'::text, 'gt'::text, 'lt'::text, 'eq'::text])))
);


ALTER TABLE public.price_rule OWNER TO postgres;

--
-- Name: price_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_set (
    id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.price_set OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id text NOT NULL,
    title text NOT NULL,
    handle text NOT NULL,
    subtitle text,
    description text,
    is_giftcard boolean DEFAULT false NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    thumbnail text,
    weight real,
    length real,
    height real,
    width real,
    origin_country text,
    hs_code text,
    mid_code text,
    material text,
    collection_id text,
    type_id text,
    discountable boolean DEFAULT true NOT NULL,
    external_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    metadata jsonb,
    CONSTRAINT product_status_check CHECK ((status = ANY (ARRAY['draft'::text, 'proposed'::text, 'published'::text, 'rejected'::text])))
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category (
    id text NOT NULL,
    name text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    handle text NOT NULL,
    mpath text NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    is_internal boolean DEFAULT false NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    parent_category_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    metadata jsonb,
    external_id text
);


ALTER TABLE public.product_category OWNER TO postgres;

--
-- Name: product_category_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category_product (
    product_id text NOT NULL,
    product_category_id text NOT NULL
);


ALTER TABLE public.product_category_product OWNER TO postgres;

--
-- Name: product_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_collection (
    id text NOT NULL,
    title text NOT NULL,
    handle text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    external_id text
);


ALTER TABLE public.product_collection OWNER TO postgres;

--
-- Name: product_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_option (
    id text NOT NULL,
    title text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    is_exclusive boolean DEFAULT false NOT NULL
);


ALTER TABLE public.product_option OWNER TO postgres;

--
-- Name: product_option_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_option_value (
    id text NOT NULL,
    value text NOT NULL,
    option_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    rank integer
);


ALTER TABLE public.product_option_value OWNER TO postgres;

--
-- Name: product_product_brand_brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_product_brand_brand (
    product_id character varying(255) NOT NULL,
    brand_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.product_product_brand_brand OWNER TO postgres;

--
-- Name: product_product_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_product_option (
    id text NOT NULL,
    product_id text NOT NULL,
    product_option_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.product_product_option OWNER TO postgres;

--
-- Name: product_product_option_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_product_option_value (
    id text NOT NULL,
    product_product_option_id text NOT NULL,
    product_option_value_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.product_product_option_value OWNER TO postgres;

--
-- Name: product_sales_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_sales_channel (
    product_id character varying(255) NOT NULL,
    sales_channel_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.product_sales_channel OWNER TO postgres;

--
-- Name: product_shipping_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_shipping_profile (
    product_id character varying(255) NOT NULL,
    shipping_profile_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.product_shipping_profile OWNER TO postgres;

--
-- Name: product_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tag (
    id text NOT NULL,
    value text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    external_id text
);


ALTER TABLE public.product_tag OWNER TO postgres;

--
-- Name: product_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tags (
    product_id text NOT NULL,
    product_tag_id text NOT NULL
);


ALTER TABLE public.product_tags OWNER TO postgres;

--
-- Name: product_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_type (
    id text NOT NULL,
    value text NOT NULL,
    metadata json,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    external_id text
);


ALTER TABLE public.product_type OWNER TO postgres;

--
-- Name: product_variant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant (
    id text NOT NULL,
    title text NOT NULL,
    sku text,
    barcode text,
    ean text,
    upc text,
    allow_backorder boolean DEFAULT false NOT NULL,
    manage_inventory boolean DEFAULT true NOT NULL,
    hs_code text,
    origin_country text,
    mid_code text,
    material text,
    weight real,
    length real,
    height real,
    width real,
    metadata jsonb,
    variant_rank integer DEFAULT 0,
    product_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    thumbnail text
);


ALTER TABLE public.product_variant OWNER TO postgres;

--
-- Name: product_variant_inventory_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant_inventory_item (
    variant_id character varying(255) NOT NULL,
    inventory_item_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    required_quantity integer DEFAULT 1 NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.product_variant_inventory_item OWNER TO postgres;

--
-- Name: product_variant_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant_option (
    variant_id text NOT NULL,
    option_value_id text NOT NULL
);


ALTER TABLE public.product_variant_option OWNER TO postgres;

--
-- Name: product_variant_price_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant_price_set (
    variant_id character varying(255) NOT NULL,
    price_set_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.product_variant_price_set OWNER TO postgres;

--
-- Name: product_variant_product_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant_product_image (
    id text NOT NULL,
    variant_id text NOT NULL,
    image_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.product_variant_product_image OWNER TO postgres;

--
-- Name: promotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion (
    id text NOT NULL,
    code text NOT NULL,
    campaign_id text,
    is_automatic boolean DEFAULT false NOT NULL,
    type text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    status text DEFAULT 'draft'::text NOT NULL,
    is_tax_inclusive boolean DEFAULT false NOT NULL,
    "limit" integer,
    used integer DEFAULT 0 NOT NULL,
    metadata jsonb,
    CONSTRAINT promotion_status_check CHECK ((status = ANY (ARRAY['draft'::text, 'active'::text, 'inactive'::text]))),
    CONSTRAINT promotion_type_check CHECK ((type = ANY (ARRAY['standard'::text, 'buyget'::text])))
);


ALTER TABLE public.promotion OWNER TO postgres;

--
-- Name: promotion_application_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_application_method (
    id text NOT NULL,
    value numeric,
    raw_value jsonb,
    max_quantity integer,
    apply_to_quantity integer,
    buy_rules_min_quantity integer,
    type text NOT NULL,
    target_type text NOT NULL,
    allocation text,
    promotion_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    currency_code text,
    CONSTRAINT promotion_application_method_allocation_check CHECK ((allocation = ANY (ARRAY['each'::text, 'across'::text, 'once'::text]))),
    CONSTRAINT promotion_application_method_target_type_check CHECK ((target_type = ANY (ARRAY['order'::text, 'shipping_methods'::text, 'items'::text]))),
    CONSTRAINT promotion_application_method_type_check CHECK ((type = ANY (ARRAY['fixed'::text, 'percentage'::text])))
);


ALTER TABLE public.promotion_application_method OWNER TO postgres;

--
-- Name: promotion_campaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_campaign (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    campaign_identifier text NOT NULL,
    starts_at timestamp(6) with time zone,
    ends_at timestamp(6) with time zone,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.promotion_campaign OWNER TO postgres;

--
-- Name: promotion_campaign_budget; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_campaign_budget (
    id text NOT NULL,
    type text NOT NULL,
    campaign_id text NOT NULL,
    "limit" numeric,
    raw_limit jsonb,
    used numeric DEFAULT 0 NOT NULL,
    raw_used jsonb NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    currency_code text,
    attribute text,
    CONSTRAINT promotion_campaign_budget_type_check CHECK ((type = ANY (ARRAY['spend'::text, 'usage'::text, 'use_by_attribute'::text, 'spend_by_attribute'::text])))
);


ALTER TABLE public.promotion_campaign_budget OWNER TO postgres;

--
-- Name: promotion_campaign_budget_usage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_campaign_budget_usage (
    id text NOT NULL,
    attribute_value text NOT NULL,
    used numeric DEFAULT 0 NOT NULL,
    budget_id text NOT NULL,
    raw_used jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.promotion_campaign_budget_usage OWNER TO postgres;

--
-- Name: promotion_promotion_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_promotion_rule (
    promotion_id text NOT NULL,
    promotion_rule_id text NOT NULL
);


ALTER TABLE public.promotion_promotion_rule OWNER TO postgres;

--
-- Name: promotion_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_rule (
    id text NOT NULL,
    description text,
    attribute text NOT NULL,
    operator text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT promotion_rule_operator_check CHECK ((operator = ANY (ARRAY['gte'::text, 'lte'::text, 'gt'::text, 'lt'::text, 'eq'::text, 'ne'::text, 'in'::text])))
);


ALTER TABLE public.promotion_rule OWNER TO postgres;

--
-- Name: promotion_rule_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_rule_value (
    id text NOT NULL,
    promotion_rule_id text NOT NULL,
    value text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.promotion_rule_value OWNER TO postgres;

--
-- Name: property_label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.property_label (
    id text NOT NULL,
    entity text NOT NULL,
    property text NOT NULL,
    label text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.property_label OWNER TO postgres;

--
-- Name: provider_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_identity (
    id text NOT NULL,
    entity_id text NOT NULL,
    provider text NOT NULL,
    auth_identity_id text NOT NULL,
    user_metadata jsonb,
    provider_metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.provider_identity OWNER TO postgres;

--
-- Name: publishable_api_key_sales_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishable_api_key_sales_channel (
    publishable_key_id character varying(255) NOT NULL,
    sales_channel_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.publishable_api_key_sales_channel OWNER TO postgres;

--
-- Name: refund; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refund (
    id text NOT NULL,
    amount numeric NOT NULL,
    raw_amount jsonb NOT NULL,
    payment_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    created_by text,
    metadata jsonb,
    refund_reason_id text,
    note text
);


ALTER TABLE public.refund OWNER TO postgres;

--
-- Name: refund_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refund_reason (
    id text NOT NULL,
    label text NOT NULL,
    description text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    code text NOT NULL
);


ALTER TABLE public.refund_reason OWNER TO postgres;

--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region (
    id text NOT NULL,
    name text NOT NULL,
    currency_code text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    automatic_taxes boolean DEFAULT true NOT NULL
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: region_country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region_country (
    iso_2 text NOT NULL,
    iso_3 text NOT NULL,
    num_code text NOT NULL,
    name text NOT NULL,
    display_name text NOT NULL,
    region_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.region_country OWNER TO postgres;

--
-- Name: region_payment_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region_payment_provider (
    region_id character varying(255) NOT NULL,
    payment_provider_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.region_payment_provider OWNER TO postgres;

--
-- Name: reservation_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation_item (
    id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    line_item_id text,
    location_id text NOT NULL,
    quantity numeric NOT NULL,
    external_id text,
    description text,
    created_by text,
    metadata jsonb,
    inventory_item_id text NOT NULL,
    allow_backorder boolean DEFAULT false,
    raw_quantity jsonb
);


ALTER TABLE public.reservation_item OWNER TO postgres;

--
-- Name: return; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return (
    id text NOT NULL,
    order_id text NOT NULL,
    claim_id text,
    exchange_id text,
    order_version integer NOT NULL,
    display_id integer NOT NULL,
    status public.return_status_enum DEFAULT 'open'::public.return_status_enum NOT NULL,
    no_notification boolean,
    refund_amount numeric,
    raw_refund_amount jsonb,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    received_at timestamp(6) with time zone,
    canceled_at timestamp(6) with time zone,
    location_id text,
    requested_at timestamp(6) with time zone,
    created_by text
);


ALTER TABLE public.return OWNER TO postgres;

--
-- Name: return_display_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.return_display_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.return_display_id_seq OWNER TO postgres;

--
-- Name: return_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.return_display_id_seq OWNED BY public.return.display_id;


--
-- Name: return_fulfillment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_fulfillment (
    return_id character varying(255) NOT NULL,
    fulfillment_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.return_fulfillment OWNER TO postgres;

--
-- Name: return_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_item (
    id text NOT NULL,
    return_id text NOT NULL,
    reason_id text,
    item_id text NOT NULL,
    quantity numeric NOT NULL,
    raw_quantity jsonb NOT NULL,
    received_quantity numeric DEFAULT 0 NOT NULL,
    raw_received_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL,
    note text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    damaged_quantity numeric DEFAULT 0 NOT NULL,
    raw_damaged_quantity jsonb DEFAULT '{"value": "0", "precision": 20}'::jsonb NOT NULL
);


ALTER TABLE public.return_item OWNER TO postgres;

--
-- Name: return_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_reason (
    id character varying NOT NULL,
    value character varying NOT NULL,
    label character varying NOT NULL,
    description character varying,
    metadata jsonb,
    parent_return_reason_id character varying,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.return_reason OWNER TO postgres;

--
-- Name: sales_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_channel (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    is_disabled boolean DEFAULT false NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.sales_channel OWNER TO postgres;

--
-- Name: sales_channel_stock_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_channel_stock_location (
    sales_channel_id character varying(255) NOT NULL,
    stock_location_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.sales_channel_stock_location OWNER TO postgres;

--
-- Name: script_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.script_migrations (
    id integer NOT NULL,
    script_name character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP,
    finished_at timestamp(6) with time zone
);


ALTER TABLE public.script_migrations OWNER TO postgres;

--
-- Name: script_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.script_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.script_migrations_id_seq OWNER TO postgres;

--
-- Name: script_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.script_migrations_id_seq OWNED BY public.script_migrations.id;


--
-- Name: service_zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_zone (
    id text NOT NULL,
    name text NOT NULL,
    metadata jsonb,
    fulfillment_set_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.service_zone OWNER TO postgres;

--
-- Name: shipping_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_option (
    id text NOT NULL,
    name text NOT NULL,
    price_type text DEFAULT 'flat'::text NOT NULL,
    service_zone_id text NOT NULL,
    shipping_profile_id text,
    provider_id text,
    data jsonb,
    metadata jsonb,
    shipping_option_type_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT shipping_option_price_type_check CHECK ((price_type = ANY (ARRAY['calculated'::text, 'flat'::text])))
);


ALTER TABLE public.shipping_option OWNER TO postgres;

--
-- Name: shipping_option_price_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_option_price_set (
    shipping_option_id character varying(255) NOT NULL,
    price_set_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.shipping_option_price_set OWNER TO postgres;

--
-- Name: shipping_option_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_option_rule (
    id text NOT NULL,
    attribute text NOT NULL,
    operator text NOT NULL,
    value jsonb,
    shipping_option_id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT shipping_option_rule_operator_check CHECK ((operator = ANY (ARRAY['in'::text, 'eq'::text, 'ne'::text, 'gt'::text, 'gte'::text, 'lt'::text, 'lte'::text, 'nin'::text])))
);


ALTER TABLE public.shipping_option_rule OWNER TO postgres;

--
-- Name: shipping_option_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_option_type (
    id text NOT NULL,
    label text NOT NULL,
    description text,
    code text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.shipping_option_type OWNER TO postgres;

--
-- Name: shipping_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_profile (
    id text NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.shipping_profile OWNER TO postgres;

--
-- Name: stock_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_location (
    id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    name text NOT NULL,
    address_id text,
    metadata jsonb
);


ALTER TABLE public.stock_location OWNER TO postgres;

--
-- Name: stock_location_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_location_address (
    id text NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone,
    address_1 text NOT NULL,
    address_2 text,
    company text,
    city text,
    country_code text NOT NULL,
    phone text,
    province text,
    postal_code text,
    metadata jsonb
);


ALTER TABLE public.stock_location_address OWNER TO postgres;

--
-- Name: store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store (
    id text NOT NULL,
    name text DEFAULT 'Medusa Store'::text NOT NULL,
    default_sales_channel_id text,
    default_region_id text,
    default_location_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.store OWNER TO postgres;

--
-- Name: store_currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_currency (
    id text NOT NULL,
    currency_code text NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    store_id text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.store_currency OWNER TO postgres;

--
-- Name: store_locale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_locale (
    id text NOT NULL,
    locale_code text NOT NULL,
    store_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.store_locale OWNER TO postgres;

--
-- Name: tax_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_provider (
    id text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.tax_provider OWNER TO postgres;

--
-- Name: tax_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_rate (
    id text NOT NULL,
    rate real,
    code text NOT NULL,
    name text NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    is_combinable boolean DEFAULT false NOT NULL,
    tax_region_id text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.tax_rate OWNER TO postgres;

--
-- Name: tax_rate_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_rate_rule (
    id text NOT NULL,
    tax_rate_id text NOT NULL,
    reference_id text NOT NULL,
    reference text NOT NULL,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.tax_rate_rule OWNER TO postgres;

--
-- Name: tax_region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_region (
    id text NOT NULL,
    provider_id text,
    country_code text NOT NULL,
    province_code text,
    parent_id text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    created_by text,
    deleted_at timestamp(6) with time zone,
    CONSTRAINT "CK_tax_region_country_top_level" CHECK (((parent_id IS NULL) OR (province_code IS NOT NULL))),
    CONSTRAINT "CK_tax_region_provider_top_level" CHECK (((parent_id IS NULL) OR (provider_id IS NULL)))
);


ALTER TABLE public.tax_region OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id text NOT NULL,
    first_name text,
    last_name text,
    email text NOT NULL,
    avatar_url text,
    metadata jsonb,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_preference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preference (
    id text NOT NULL,
    user_id text NOT NULL,
    key text NOT NULL,
    value jsonb NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.user_preference OWNER TO postgres;

--
-- Name: user_rbac_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_rbac_role (
    user_id character varying(255) NOT NULL,
    rbac_role_id character varying(255) NOT NULL,
    id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.user_rbac_role OWNER TO postgres;

--
-- Name: view_configuration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.view_configuration (
    id text NOT NULL,
    entity text NOT NULL,
    name text,
    user_id text,
    is_system_default boolean DEFAULT false NOT NULL,
    configuration jsonb NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) with time zone
);


ALTER TABLE public.view_configuration OWNER TO postgres;

--
-- Name: workflow_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_execution (
    id character varying NOT NULL,
    workflow_id character varying NOT NULL,
    transaction_id character varying NOT NULL,
    execution jsonb,
    context jsonb,
    state character varying NOT NULL,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(6) without time zone,
    retention_time integer,
    run_id text DEFAULT '01K0DQNJW4ZB0V3GW9H2031DB9'::text NOT NULL
);


ALTER TABLE public.workflow_execution OWNER TO postgres;

--
-- Name: link_module_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link_module_migrations ALTER COLUMN id SET DEFAULT nextval('public.link_module_migrations_id_seq'::regclass);


--
-- Name: mikro_orm_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mikro_orm_migrations ALTER COLUMN id SET DEFAULT nextval('public.mikro_orm_migrations_id_seq'::regclass);


--
-- Name: order display_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN display_id SET DEFAULT nextval('public.order_display_id_seq'::regclass);


--
-- Name: order_change_action ordering; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_change_action ALTER COLUMN ordering SET DEFAULT nextval('public.order_change_action_ordering_seq'::regclass);


--
-- Name: order_claim display_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_claim ALTER COLUMN display_id SET DEFAULT nextval('public.order_claim_display_id_seq'::regclass);


--
-- Name: order_exchange display_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_exchange ALTER COLUMN display_id SET DEFAULT nextval('public.order_exchange_display_id_seq'::regclass);


--
-- Name: return display_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return ALTER COLUMN display_id SET DEFAULT nextval('public.return_display_id_seq'::regclass);


--
-- Name: script_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.script_migrations ALTER COLUMN id SET DEFAULT nextval('public.script_migrations_id_seq'::regclass);


--
-- Data for Name: account_holder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_holder (id, provider_id, external_id, email, data, metadata, created_at, updated_at, deleted_at) FROM stdin;
acchld_01KN1NK6ASF3Z70B7QCZ5HPAY3	pp_system_default	cus_01KN1GCKQN0QW3VXF1VGZQ4ND5	validation.ui.20260331.0830@example.com	{}	\N	2026-03-31 17:03:58.681+07	2026-03-31 17:03:58.681+07	\N
acchld_01KNRRJB09ZQ8R88V39PVRQR5Z	pp_system_default	cus_01KMYZB2P21PMGEBWDS6EAS3JX	mabiaura@gmail.com	{}	\N	2026-04-09 16:18:28.364+07	2026-04-09 16:18:28.364+07	\N
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_key (id, token, salt, redacted, title, type, last_used_at, created_by, created_at, revoked_by, revoked_at, updated_at, deleted_at) FROM stdin;
apk_01K0DQNR524GW4VFN0CYPT9DHB	pk_fd557f02f0e90969cff1644a00d57beb5101e31a084ad0ce919c2c8a4f0322c2		pk_fd5***2c2	Webshop	publishable	\N		2025-07-18 10:01:34.498+07	\N	\N	2025-07-18 10:01:34.498+07	\N
\.


--
-- Data for Name: application_method_buy_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_method_buy_rules (application_method_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: application_method_target_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_method_target_rules (application_method_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: auth_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_identity (id, app_metadata, created_at, updated_at, deleted_at) FROM stdin;
authid_01K0DQTQBAP2VATK818YG970GH	{"user_id": "user_01K0DQTQ8DKZ8PHEZFREPTS5SN"}	2025-07-18 10:04:17.514+07	2025-07-18 10:04:17.527+07	\N
authid_01KMV75BJYCPNP4S9AWE2STR7Y	\N	2026-03-29 04:56:18.654+07	2026-03-29 04:56:18.654+07	\N
authid_01KMV80KGHGQQKYYSM2BN46ZHD	\N	2026-03-29 05:11:11.505+07	2026-03-29 05:11:11.505+07	\N
authid_01KMV7REPHSQBXHFJWRVYBR7FZ	{"customer_id": null}	2026-03-29 05:06:44.433+07	2026-03-30 12:33:48.257+07	\N
authid_01KMV7YXN05W9PE6YWMX6FWR89	{"customer_id": null}	2026-03-29 05:10:16.352+07	2026-03-30 12:33:58.119+07	\N
authid_01KMV7SRAP83TMH3SHJVVFFQD5	{"customer_id": null}	2026-03-29 05:07:27.063+07	2026-03-30 12:34:08.492+07	\N
authid_01KMYKW43TCAEA8HCAK885H5P9	{"customer_id": null}	2026-03-30 12:36:10.874+07	2026-03-30 12:40:47.09+07	\N
authid_01KMYM708DZNEN7XGQZJQP18TT	\N	2026-03-30 12:42:07.373+07	2026-03-30 12:42:07.373+07	\N
authid_01KMYZAYZY30Z5241JSF101RJX	{"customer_id": "cus_01KMYZB2P21PMGEBWDS6EAS3JX"}	2026-03-30 15:56:31.486+07	2026-03-30 15:56:35.282+07	\N
authid_01KMWXVTE8A6C856T8W42H83GQ	{"customer_id": null}	2026-03-29 20:52:17.864+07	2026-03-30 15:57:17.849+07	\N
authid_01KMYKPXKYAQP1FTKKT60N7NR5	{"customer_id": null}	2026-03-30 12:33:20.382+07	2026-03-30 15:57:26.382+07	\N
authid_01KN1E1CS8NY0EMF54X5AXAJGK	\N	2026-03-31 14:51:55.434+07	2026-03-31 14:51:55.434+07	\N
authid_01KN1E41SJAEVRX24E3DJ5QCB2	\N	2026-03-31 14:53:22.483+07	2026-03-31 14:53:22.483+07	\N
authid_01KN1E9VF7G9N7C0VKDRZKXSEH	{"customer_id": "cus_01KN1E9VS542B3M324QEM0KS9G"}	2026-03-31 14:56:32.617+07	2026-03-31 14:56:32.969+07	\N
authid_01KN1GCKM59JBB07RZF8856RA2	{"customer_id": "cus_01KN1GCKQN0QW3VXF1VGZQ4ND5"}	2026-03-31 15:33:00.038+07	2026-03-31 15:33:00.172+07	\N
\.


--
-- Data for Name: auth_mfa_factor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_mfa_factor (id, auth_identity_id, provider, status, provider_metadata, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: auth_mfa_recovery_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_mfa_recovery_code (id, auth_identity_id, code_hash, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: auth_password_reset_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_password_reset_token (id, auth_identity_id, provider_identity_id, entity_id, token_hash, expires_at, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: auth_verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_verification (id, auth_identity_id, entity_id, entity_type, code_provider, verified_at, requested_at, provider_metadata, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brand (id, name, created_at, updated_at, deleted_at) FROM stdin;
01K3T7N63AW9QF91WMV43FZXK1	Acme	2025-08-29 13:18:51.882+07	2025-08-29 13:18:51.882+07	\N
01K3TH0WAM0MJGT97J3JZ95KFT	Medusa	2025-08-29 16:02:32.277+07	2025-08-29 16:02:32.277+07	\N
01K3TMD83E17DRCEGZ4676YD7B	Torch	2025-08-29 17:01:43.279+07	2025-08-29 17:01:43.279+07	\N
01K3TMES12SJBAHXKST7MNFFCR	Consina	2025-08-29 17:02:33.378+07	2025-08-29 17:02:33.378+07	\N
01K3TMG2DWSQVPSE3RSQKFY9XN	The North Face	2025-08-29 17:03:15.772+07	2025-08-29 17:03:15.772+07	\N
01K3TMH1D7M1KMTWCY904F4KE4	Eiger	2025-08-29 17:03:47.495+07	2025-08-29 17:03:47.495+07	\N
\.


--
-- Data for Name: capture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.capture (id, amount, raw_amount, payment_id, created_at, updated_at, deleted_at, created_by, metadata) FROM stdin;
capt_01K38B6YBD1DZ246KFY5R70NQZ	290000	{"value": "290000", "precision": 20}	pay_01K38B666YHMYFNN1XNB33B719	2025-08-22 14:34:39.725+07	2025-08-22 14:34:39.725+07	\N	\N	\N
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (id, region_id, customer_id, sales_channel_id, email, currency_code, shipping_address_id, billing_address_id, metadata, created_at, updated_at, deleted_at, completed_at, locale) FROM stdin;
cart_01K33CW1JP7SDSJ6WYD5KJ08X3	reg_01K33FFDX0M838JWM069761552	cus_01K38AJPD0KBWRW4Y2EHBQWFW4	sc_01K0DQNP6KWXP3R7NJGNA411PQ	alrocha@gmail.com	idr	caaddr_01K38AJWQ93BNJWGYPYHQWS89M	caaddr_01K38AJWQ9AG394J43MNSJ4BG0	\N	2025-08-20 16:27:27.574+07	2025-08-22 14:34:14.957+07	\N	2025-08-22 14:34:14.935+07	\N
cart_01KHSGGYQY4GS6GP43M508TT6B	reg_01K33FFDX0M838JWM069761552	\N	sc_01K0DQNP6KWXP3R7NJGNA411PQ	\N	idr	caaddr_01KHSGGYQZDHHV3HZ8GETXE7ZB	\N	\N	2026-02-19 06:14:21.567+07	2026-02-19 06:14:21.567+07	\N	\N	\N
cart_01KMTV6CZX4TMBF7HCN5R7DR70	reg_01K33FFDX0M838JWM069761552	\N	sc_01K0DQNP6KWXP3R7NJGNA411PQ	\N	idr	caaddr_01KMTV6D03T1VZJ3M7SKCNYTEQ	\N	\N	2026-03-29 01:27:09.958+07	2026-03-29 01:27:09.958+07	\N	\N	\N
cart_01KMV701ZRZGYQFKGMPJSVWJGP	reg_01K33FFDX0M838JWM069761552	\N	sc_01K0DQNP6KWXP3R7NJGNA411PQ	\N	idr	caaddr_01KMV701ZTZFQVXSNTTAYXTRJ0	\N	\N	2026-03-29 04:53:24.987+07	2026-03-29 04:53:24.987+07	\N	\N	\N
cart_01KMV7PWBJHTRE556JK3PDXHRC	reg_01K33FFDX0M838JWM069761552	\N	sc_01K0DQNP6KWXP3R7NJGNA411PQ	\N	idr	caaddr_01KMV7PWBJPMX62JHZHQG7MQVF	\N	\N	2026-03-29 05:05:52.882+07	2026-03-29 05:05:52.882+07	\N	\N	\N
cart_01KMV863N0FKZ91QY504NS9HJ0	reg_01K33FFDX0M838JWM069761552	cus_01KMYKW46QEJTDD0XZTX375JVT	sc_01K0DQNP6KWXP3R7NJGNA411PQ	patih@gmail.com	idr	caaddr_01KMV863N0QK2JM27V6F7153ZE	\N	\N	2026-03-29 05:14:11.872+07	2026-03-30 12:36:11.085+07	\N	\N	\N
cart_01KN03CGXDZJ99RPTSAJVG7MCT	reg_01K33FFDX0M838JWM069761552	cus_01KMYZB2P21PMGEBWDS6EAS3JX	sc_01K0DQNP6KWXP3R7NJGNA411PQ	mabiaura@gmail.com	idr	caaddr_01KN03CGXPY936SH54FNWH1TWF	\N	\N	2026-03-31 02:26:31.352+07	2026-03-31 02:26:31.352+07	\N	\N	\N
cart_01KN1J9B9X8NFP6APDW5W91A81	reg_01K33FFDX0M838JWM069761552	cus_01KN1GCKQN0QW3VXF1VGZQ4ND5	sc_01K0DQNP6KWXP3R7NJGNA411PQ	validation.ui.20260331.0830@example.com	idr	caaddr_01KN1K0HD6R8CSVWX18YNK75ZY	caaddr_01KN1K0HD6Y10B73BWDFP1EBPG	\N	2026-03-31 16:06:10.374+07	2026-03-31 17:07:15.214+07	\N	2026-03-31 17:07:15.203+07	\N
cart_01KNJZSJEPF8R6G97CZB5QKVJ7	reg_01K33FFDX0M838JWM069761552	cus_01KMYZB2P21PMGEBWDS6EAS3JX	sc_01K0DQNP6KWXP3R7NJGNA411PQ	mabiaura@gmail.com	idr	caaddr_01KNJZSJEQP1NXAC2N5Y5XPHRW	\N	\N	2026-04-07 10:29:18.807+07	2026-04-09 15:06:09.885+07	\N	\N	\N
cart_01KNRKD9WC1KSM36G6G6DFV7SA	reg_01K33FFDX0M838JWM069761552	cus_01KMYZB2P21PMGEBWDS6EAS3JX	sc_01K0DQNP6KWXP3R7NJGNA411PQ	mabiaura@gmail.com	idr	caaddr_01KNRS403Y9PH88KWY8DMFKCX0	caaddr_01KNRS403XSA1GR08QRHRKYMF7	\N	2026-04-09 14:48:20.502+07	2026-04-09 16:33:01.458+07	\N	2026-04-09 16:33:01.418+07	\N
cart_01KNVDXFSRHTCQT2ZBC4BX8X2W	reg_01K33FFDX0M838JWM069761552	cus_01KMYZB2P21PMGEBWDS6EAS3JX	sc_01K0DQNP6KWXP3R7NJGNA411PQ	mabiaura@gmail.com	idr	caaddr_01KNVDY7Q2SZ9WZR7DFG2SHG38	\N	\N	2026-04-10 17:10:02.684+07	2026-04-10 17:10:27.17+07	\N	\N	\N
cart_01KQVHWG2PGA9DF412JYX7E4YP	reg_01K33FFDX0M838JWM069761552	cus_01KQVHXB9DF754Y23NXJMMTP8S	sc_01K0DQNP6KWXP3R7NJGNA411PQ	user@example.com	idr	caaddr_01KQVHXB9W9JGCTRVRY4ZHFJR0	caaddr_01KQVHXB9V7HJ9C0K7YPH8XBSG	\N	2026-05-05 14:50:48.152+07	2026-05-05 14:51:25.974+07	\N	2026-05-05 14:51:25.962+07	\N
cart_01KQVMFNMMVDD3GK0SNDBVK4XV	reg_01K33FFDX0M838JWM069761552	\N	sc_01K0DQNP6KWXP3R7NJGNA411PQ	\N	idr	caaddr_01KQVMFNMNK7YWXZDDGQHX4Y8S	\N	\N	2026-05-05 15:36:13.59+07	2026-05-05 15:36:13.59+07	\N	\N	\N
cart_01KWTQ0RZAD466FHER6363MV1N	reg_01K33FFDX0M838JWM069761552	\N	sc_01K0DQNP6KWXP3R7NJGNA411PQ	\N	idr	caaddr_01KWTQ0RZBG3SXSGRZM72VN1W0	\N	\N	2026-07-06 10:19:45.9+07	2026-07-06 10:19:45.9+07	\N	\N	\N
cart_01KWTV0A09189AV1D27XXXKGY2	reg_01K33FFDX0M838JWM069761552	\N	sc_01K0DQNP6KWXP3R7NJGNA411PQ	\N	idr	caaddr_01KWTV0A0APGJMKEJQEXSMRQT2	\N	\N	2026-07-06 11:29:24.874+07	2026-07-06 11:29:24.874+07	\N	\N	\N
\.


--
-- Data for Name: cart_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_address (id, customer_id, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
caaddr_01K33FVJNYXKH1DEB6S3A1BN62	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2025-08-20 17:19:38.047+07	2025-08-20 17:19:38.047+07	\N
caaddr_01K33GCGFSM78FDE806XS177BD	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2025-08-20 17:28:52.857+07	2025-08-20 17:28:52.857+07	\N
caaddr_01K33GJ9GE1QQWYKY2BPS90HSM	\N	\N	\N	\N	\N	\N	\N	us	\N	\N	\N	\N	2025-08-20 17:32:02.318+07	2025-08-20 17:32:02.318+07	\N
caaddr_01K38AHEFVX8MX125BPV2KJRMG	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2025-08-22 14:22:55.356+07	2025-08-22 14:22:55.356+07	\N
caaddr_01K38AJPDMAH73FAGG7X6CZMRE	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id	Jawa Barat	40264		\N	2025-08-22 14:23:36.244+07	2025-08-22 14:23:36.244+07	\N
caaddr_01K38AJPDMTE5FX0JCZ4P9G5H1	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id	Jawa Barat	40264		\N	2025-08-22 14:23:36.244+07	2025-08-22 14:23:36.244+07	\N
caaddr_01K38AJWQ9AG394J43MNSJ4BG0	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id	Jawa Barat	40264		\N	2025-08-22 14:23:42.697+07	2025-08-22 14:23:42.697+07	\N
caaddr_01K38AJWQ93BNJWGYPYHQWS89M	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id	Jawa Barat	40264		\N	2025-08-22 14:23:42.697+07	2025-08-22 14:23:42.697+07	\N
caaddr_01KHSGGYQZDHHV3HZ8GETXE7ZB	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-02-19 06:14:21.567+07	2026-02-19 06:14:21.567+07	\N
caaddr_01KMTV6D03T1VZJ3M7SKCNYTEQ	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-03-29 01:27:09.958+07	2026-03-29 01:27:09.958+07	\N
caaddr_01KMV701ZTZFQVXSNTTAYXTRJ0	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-03-29 04:53:24.987+07	2026-03-29 04:53:24.987+07	\N
caaddr_01KMV7PWBJPMX62JHZHQG7MQVF	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-03-29 05:05:52.882+07	2026-03-29 05:05:52.882+07	\N
caaddr_01KMV863N0QK2JM27V6F7153ZE	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-03-29 05:14:11.872+07	2026-03-29 05:14:11.872+07	\N
caaddr_01KN03CGXPY936SH54FNWH1TWF	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-03-31 02:26:31.351+07	2026-03-31 02:26:31.351+07	\N
caaddr_01KN1J9BA2RC2M6JFPA8CNGQ7E	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-03-31 16:06:10.374+07	2026-03-31 16:06:10.374+07	\N
caaddr_01KN1K0HD6Y10B73BWDFP1EBPG	\N	Mercora QA	Validation	Flow	Jl. Merdeka 123		Jakarta	id	DKI Jakarta	10110	+6281234567001	\N	2026-03-31 16:18:50.278+07	2026-03-31 16:18:50.278+07	\N
caaddr_01KN1K0HD6R8CSVWX18YNK75ZY	\N	Mercora QA	Validation	Flow	Jl. Merdeka 123		Jakarta	id	DKI Jakarta	10110	+6281234567001	\N	2026-03-31 16:18:50.279+07	2026-03-31 16:18:50.279+07	\N
caaddr_01KNJZSJEQP1NXAC2N5Y5XPHRW	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-04-07 10:29:18.807+07	2026-04-07 10:29:18.807+07	\N
caaddr_01KNRKD9WJ0AAVS9XVBSFM9M2T	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-04-09 14:48:20.502+07	2026-04-09 14:48:20.502+07	\N
caaddr_01KNRS403XSA1GR08QRHRKYMF7	\N	Mercora	Mabia	Ura	Jl. Melati 123		Jakarta	id	DKI Jakarta	12345	08123456789	\N	2026-04-09 16:28:07.04+07	2026-04-09 16:28:07.04+07	\N
caaddr_01KNRS403Y9PH88KWY8DMFKCX0	\N	Mercora	Mabia	Ura	Jl. Melati 123		Jakarta	id	DKI Jakarta	12345	08123456789	\N	2026-04-09 16:28:07.04+07	2026-04-09 16:28:07.04+07	\N
caaddr_01KNVDXFSTAXAT6WRTAPWBS53T	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-04-10 17:10:02.684+07	2026-04-10 17:10:02.684+07	\N
caaddr_01KNVDY7Q2SZ9WZR7DFG2SHG38	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-04-10 17:10:27.17+07	2026-04-10 17:10:27.17+07	\N
caaddr_01KQVHWG2R8J4CQQBRZ6M0PPYA	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-05-05 14:50:48.152+07	2026-05-05 14:50:48.152+07	\N
caaddr_01KQVHXB9V7HJ9C0K7YPH8XBSG	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id		40264	T	\N	2026-05-05 14:51:16.028+07	2026-05-05 14:51:16.028+07	\N
caaddr_01KQVHXB9W9JGCTRVRY4ZHFJR0	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id		40264	T	\N	2026-05-05 14:51:16.028+07	2026-05-05 14:51:16.028+07	\N
caaddr_01KQVMFNMNK7YWXZDDGQHX4Y8S	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-05-05 15:36:13.59+07	2026-05-05 15:36:13.59+07	\N
caaddr_01KWTQ0RZBG3SXSGRZM72VN1W0	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-07-06 10:19:45.899+07	2026-07-06 10:19:45.899+07	\N
caaddr_01KWTV0A0APGJMKEJQEXSMRQT2	\N	\N	\N	\N	\N	\N	\N	id	\N	\N	\N	\N	2026-07-06 11:29:24.874+07	2026-07-06 11:29:24.874+07	\N
\.


--
-- Data for Name: cart_line_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_line_item (id, cart_id, title, subtitle, thumbnail, quantity, variant_id, product_id, product_title, product_description, product_subtitle, product_type, product_collection, product_handle, variant_sku, variant_barcode, variant_title, variant_option_values, requires_shipping, is_discountable, is_tax_inclusive, compare_at_unit_price, raw_compare_at_unit_price, unit_price, raw_unit_price, metadata, created_at, updated_at, deleted_at, product_type_id, is_custom_price, is_giftcard) FROM stdin;
cali_01K33CW1RG825MP86Q28ZCA8K8	cart_01K33CW1JP7SDSJ6WYD5KJ08X3	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	10	{"value": "10", "precision": 20}	{}	2025-08-20 16:27:27.76+07	2025-08-20 16:27:40.999+07	2025-08-20 16:27:40.998+07	\N	f	f
cali_01K33GF460RP1302PQESS09SJW	cart_01K33CW1JP7SDSJ6WYD5KJ08X3	Medusa T-Shirt	M / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	1	variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-M-BLACK	\N	M / Black	\N	t	t	f	\N	\N	15	{"value": "15", "precision": 20}	{}	2025-08-20 17:30:18.56+07	2025-08-20 17:33:29.693+07	2025-08-20 17:33:29.693+07	\N	f	f
cali_01K33EWQD7JBQ19VJB49B13JDN	cart_01K33CW1JP7SDSJ6WYD5KJ08X3	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	15	{"value": "15", "precision": 20}	{}	2025-08-20 17:02:47.079+07	2025-08-20 17:33:30.582+07	2025-08-20 17:33:30.581+07	\N	f	f
cali_01K38AHEQK3EB43FYNVAX46ZQD	cart_01K33CW1JP7SDSJ6WYD5KJ08X3	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2025-08-22 14:22:55.603+07	2025-08-22 14:22:55.603+07	\N	\N	f	f
cali_01KHSGGYYDPBTT0P50KNHVZBBP	cart_01KHSGGYQY4GS6GP43M508TT6B	Medusa Sweatshirt	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-M	\N	M	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-02-19 06:14:21.773+07	2026-02-19 06:14:21.773+07	\N	\N	f	f
cali_01KMTYSQHA9EHZEP17C3QTVYPR	cart_01KMTV6CZX4TMBF7HCN5R7DR70	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 02:30:09.066+07	2026-03-29 02:46:47.431+07	2026-03-29 02:46:47.43+07	\N	f	f
cali_01KMTV6D9ZTNXTSNWNRP7ZNAGZ	cart_01KMTV6CZX4TMBF7HCN5R7DR70	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	2	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 01:27:10.271+07	2026-03-29 01:27:37.443+07	2026-03-29 01:27:37.441+07	\N	f	f
cali_01KMTVG775JNS37DE4X19RP0P8	cart_01KMTV6CZX4TMBF7HCN5R7DR70	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	3	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 01:32:31.718+07	2026-03-29 01:32:45.183+07	2026-03-29 01:32:45.183+07	\N	f	f
cali_01KMTZR45YEFX4G1DRT7ZFH36R	cart_01KMTV6CZX4TMBF7HCN5R7DR70	Medusa Shorts	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png	1	variant_01K0DQNR7SC08ZVVMA3CXF0RG4	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	Medusa Shorts	Reimagine the feeling of classic shorts. With our cotton shorts, everyday essentials no longer have to be ordinary.	\N	\N	\N	shorts	SHORTS-S	\N	S	\N	t	t	f	\N	\N	100000	{"value": "100000", "precision": 20}	{}	2026-03-29 02:46:45.054+07	2026-03-29 02:46:46.62+07	2026-03-29 02:46:46.619+07	\N	f	f
cali_01KMV4JX2DNH06TM7A5TCP8PXK	cart_01KMTV6CZX4TMBF7HCN5R7DR70	Medusa T-Shirt	M / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	2	variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-M-BLACK	\N	M / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-03-29 04:11:16.813+07	2026-03-29 04:11:38.375+07	\N	\N	f	f
cali_01KMV26KRV79EBCVRS0RZQ1W04	cart_01KMTV6CZX4TMBF7HCN5R7DR70	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	8	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 03:29:36.923+07	2026-03-29 04:45:51.904+07	\N	\N	f	f
cali_01KMV7024WH5QXCD179PG4M78D	cart_01KMV701ZRZGYQFKGMPJSVWJGP	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 04:53:25.148+07	2026-03-29 04:53:30.355+07	2026-03-29 04:53:30.354+07	\N	f	f
cali_01KMTZSVY6PAET5GZC08CNTTSG	cart_01KMTV6CZX4TMBF7HCN5R7DR70	Medusa T-Shirt	S / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	3	variant_01K0DQNR7R7M74ES9DA7NHJFDD	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-S-BLACK	\N	S / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-03-29 02:47:42.15+07	2026-03-29 04:10:10.437+07	\N	\N	f	f
cali_01KMV70BP1GWEE6XAAC152AA1B	cart_01KMV701ZRZGYQFKGMPJSVWJGP	Medusa Sweatpants	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	1	variant_01K0DQNR7SY6H1KQXPA51E5WHC	prod_01K0DQNR60F4HVA8YYA27N3KT3	Medusa Sweatpants	Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatpants	SWEATPANTS-M	\N	M	\N	t	t	f	\N	\N	220000	{"value": "220000", "precision": 20}	{}	2026-03-29 04:53:34.913+07	2026-03-29 04:53:51.62+07	2026-03-29 04:53:51.62+07	\N	f	f
cali_01KMV70MT111V29GNVXJ9NFSPC	cart_01KMV701ZRZGYQFKGMPJSVWJGP	Medusa Sweatpants	L	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	2	variant_01K0DQNR7S4W9GH3SK0YFR9FR4	prod_01K0DQNR60F4HVA8YYA27N3KT3	Medusa Sweatpants	Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatpants	SWEATPANTS-L	\N	L	\N	t	t	f	\N	\N	220000	{"value": "220000", "precision": 20}	{}	2026-03-29 04:53:44.257+07	2026-03-29 04:53:52.537+07	2026-03-29 04:53:52.536+07	\N	f	f
cali_01KMV7MBTJAQZM9BNKWKMB7H98	cart_01KMV701ZRZGYQFKGMPJSVWJGP	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 05:04:30.419+07	2026-03-29 05:04:30.419+07	\N	\N	f	f
cali_01KMV7PWFRBGJ20X3CZYBDBVWG	cart_01KMV7PWBJHTRE556JK3PDXHRC	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 05:05:53.016+07	2026-03-29 05:05:55.611+07	2026-03-29 05:05:55.611+07	\N	f	f
cali_01KMV7QFXRGAHGBJ6R9F815K6C	cart_01KMV7PWBJHTRE556JK3PDXHRC	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 05:06:12.92+07	2026-03-29 05:06:12.92+07	\N	\N	f	f
cali_01KMV82F056Q5GD96X5YESKF1E	cart_01KMV7PWBJHTRE556JK3PDXHRC	Medusa T-Shirt	M / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	1	variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-M-BLACK	\N	M / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-03-29 05:12:12.421+07	2026-03-29 05:12:39.847+07	\N	\N	f	f
cali_01KMV863SSRQYPZJJHJQS96SYV	cart_01KMV863N0FKZ91QY504NS9HJ0	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 05:14:12.025+07	2026-03-29 05:14:15.526+07	2026-03-29 05:14:15.526+07	\N	f	f
cali_01KMWXT38J3RF7H7GXVWQYBQ1D	cart_01KMV863N0FKZ91QY504NS9HJ0	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-03-29 20:51:21.362+07	2026-03-29 20:54:07.849+07	2026-03-29 20:54:07.847+07	\N	f	f
cali_01KN03CHB1DHQCBMXVCYBWTNJ2	cart_01KN03CGXDZJ99RPTSAJVG7MCT	Medusa Shorts	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png	4	variant_01K0DQNR7SC08ZVVMA3CXF0RG4	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	Medusa Shorts	Reimagine the feeling of classic shorts. With our cotton shorts, everyday essentials no longer have to be ordinary.	\N	\N	\N	shorts	SHORTS-S	\N	S	\N	t	t	f	\N	\N	100000	{"value": "100000", "precision": 20}	{}	2026-03-31 02:26:31.777+07	2026-03-31 02:26:38.522+07	2026-03-31 02:26:38.522+07	\N	f	f
cali_01KN1J9BMDK08RF5G6D81YKX7V	cart_01KN1J9B9X8NFP6APDW5W91A81	Medusa Sweatpants	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	2	variant_01K0DQNR7SY6H1KQXPA51E5WHC	prod_01K0DQNR60F4HVA8YYA27N3KT3	Medusa Sweatpants	Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatpants	SWEATPANTS-M	\N	M	\N	t	t	f	\N	\N	220000	{"value": "220000", "precision": 20}	{}	2026-03-31 16:06:10.701+07	2026-03-31 16:08:21.004+07	\N	\N	f	f
cali_01KNJZSJP5Q7GP9Z1HNS3GK48Q	cart_01KNJZSJEPF8R6G97CZB5QKVJ7	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-04-07 10:29:19.045+07	2026-04-07 10:29:19.045+07	\N	\N	f	f
cali_01KNRKDAAQ3B49F7F2XATHNSV1	cart_01KNRKD9WC1KSM36G6G6DFV7SA	Medusa T-Shirt	M / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	1	variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-M-BLACK	\N	M / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-04-09 14:48:20.952+07	2026-04-09 14:48:20.952+07	\N	\N	f	f
cali_01KQVHWG90BF0H5D6DQMZ2D7DF	cart_01KQVHWG2PGA9DF412JYX7E4YP	Medusa Sweatshirt	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-M	\N	M	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-05-05 14:50:48.352+07	2026-05-05 14:50:48.352+07	\N	\N	f	f
cali_01KNVDXG320BQPDTQTTEMNE9GV	cart_01KNVDXFSRHTCQT2ZBC4BX8X2W	Medusa Sweatshirt	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-M	\N	M	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-04-10 17:10:02.978+07	2026-04-10 17:10:27.229+07	\N	\N	f	f
cali_01KQVMFNT8BGD70256DT9PMCZ3	cart_01KQVMFNMMVDD3GK0SNDBVK4XV	Medusa Shorts	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png	1	variant_01K0DQNR7S19WE18DFGYT0645D	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	Medusa Shorts	Reimagine the feeling of classic shorts. With our cotton shorts, everyday essentials no longer have to be ordinary.	\N	\N	\N	shorts	SHORTS-M	\N	M	\N	t	t	f	\N	\N	100000	{"value": "100000", "precision": 20}	{}	2026-05-05 15:36:13.768+07	2026-05-05 15:41:28.92+07	2026-05-05 15:41:28.914+07	\N	f	f
cali_01KQVMV9WHCW1Y25QR2PBYGH8K	cart_01KQVMFNMMVDD3GK0SNDBVK4XV	Medusa Sweatshirt	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-M	\N	M	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-05-05 15:42:34.769+07	2026-05-06 08:59:06.379+07	2026-05-06 08:59:06.373+07	\N	f	f
cali_01KWTV0A4XQZPV2B12Y0WCAP10	cart_01KWTV0A09189AV1D27XXXKGY2	Medusa Sweatshirt	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-M	\N	M	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-07-06 11:29:25.022+07	2026-07-06 11:44:21.403+07	2026-07-06 11:44:21.401+07	\N	f	f
cali_01KQZC1YTDQDWSYEH399YH9REQ	cart_01KQVMFNMMVDD3GK0SNDBVK4XV	Medusa Sweatshirt	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	1	variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-M	\N	M	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-05-07 02:25:53.357+07	2026-05-07 02:25:55.931+07	2026-05-07 02:25:55.931+07	\N	f	f
cali_01KQZC0DKVEFSQ90HDRBXX1JDP	cart_01KQVMFNMMVDD3GK0SNDBVK4XV	Medusa T-Shirt	L / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	1	variant_01K0DQNR7RPMB10TTHA20NJQSN	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-L-BLACK	\N	L / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-05-07 02:25:02.971+07	2026-05-07 02:25:56.516+07	2026-05-07 02:25:56.515+07	\N	f	f
cali_01KQZC080KWDYW3YCQB5VJNDWT	cart_01KQVMFNMMVDD3GK0SNDBVK4XV	Medusa T-Shirt	S / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	2	variant_01K0DQNR7R7M74ES9DA7NHJFDD	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-S-BLACK	\N	S / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-05-07 02:24:57.235+07	2026-05-07 02:25:57.118+07	2026-05-07 02:25:57.117+07	\N	f	f
cali_01KQZC29TQBPZRK59JFWA3DDNY	cart_01KQVMFNMMVDD3GK0SNDBVK4XV	Medusa T-Shirt	S / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	1	variant_01K0DQNR7R7M74ES9DA7NHJFDD	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-S-BLACK	\N	S / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-05-07 02:26:04.632+07	2026-05-07 02:26:06.752+07	2026-05-07 02:26:06.751+07	\N	f	f
cali_01KQZC2FPYJE3KH118J6XV3C00	cart_01KQVMFNMMVDD3GK0SNDBVK4XV	Medusa T-Shirt	L / White	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	1	variant_01K0DQNR7RTYF6JFCGDG5B7HEG	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-L-WHITE	\N	L / White	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-05-07 02:26:10.654+07	2026-05-07 02:26:15.017+07	2026-05-07 02:26:15.017+07	\N	f	f
cali_01KWTQ0S3ZA2348BEXG3B26BEV	cart_01KWTQ0RZAD466FHER6363MV1N	Medusa T-Shirt	M / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	1	variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-M-BLACK	\N	M / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-07-06 10:19:46.047+07	2026-07-06 10:19:46.047+07	\N	\N	f	f
\.


--
-- Data for Name: cart_line_item_adjustment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_line_item_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, metadata, created_at, updated_at, deleted_at, item_id, is_tax_inclusive) FROM stdin;
\.


--
-- Data for Name: cart_line_item_tax_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_line_item_tax_line (id, description, tax_rate_id, code, rate, provider_id, metadata, created_at, updated_at, deleted_at, item_id) FROM stdin;
\.


--
-- Data for Name: cart_payment_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_payment_collection (cart_id, payment_collection_id, id, created_at, updated_at, deleted_at) FROM stdin;
cart_01K33CW1JP7SDSJ6WYD5KJ08X3	pay_col_01K38B5ZBK6GQS7AKVQNS5APWX	capaycol_01K38B5ZBXJN726FYKKA3HD9KY	2025-08-22 14:34:07.997673+07	2025-08-22 14:34:07.997673+07	\N
cart_01KN1J9B9X8NFP6APDW5W91A81	pay_col_01KN1NK68AT0T4RYEH039MET1B	capaycol_01KN1NK692SDC85W7YNTV1PVXJ	2026-03-31 17:03:58.625654+07	2026-03-31 17:03:58.625654+07	\N
cart_01KNRKD9WC1KSM36G6G6DFV7SA	pay_col_01KNRRJAW2BB5EDGRTS0TVZYFZ	capaycol_01KNRRJAXWMMC3AMFZYK1NH94Q	2026-04-09 16:18:28.283076+07	2026-04-09 16:18:28.283076+07	\N
cart_01KQVHWG2PGA9DF412JYX7E4YP	pay_col_01KQVHXHAZDGM3K6XZPY1A509G	capaycol_01KQVHXHBCMFY2TF0KJ6PAJ2SN	2026-05-05 14:51:22.220469+07	2026-05-05 14:51:22.220469+07	\N
\.


--
-- Data for Name: cart_promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_promotion (cart_id, promotion_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: cart_shipping_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_shipping_method (id, cart_id, name, description, amount, raw_amount, is_tax_inclusive, shipping_option_id, data, metadata, created_at, updated_at, deleted_at) FROM stdin;
casm_01K38B52B0WA60A1XTF4FDZ13Z	cart_01K33CW1JP7SDSJ6WYD5KJ08X3	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2025-08-22 14:33:38.272+07	2025-08-22 14:33:38.272+07	\N
casm_01KN1NA9GWV6P45Z52M3D16QZZ	cart_01KN1J9B9X8NFP6APDW5W91A81	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2026-03-31 16:59:07.038+07	2026-03-31 16:59:07.038+07	\N
casm_01KNRRP4Q4DBGMW62GN19E6MFX	cart_01KNRKD9WC1KSM36G6G6DFV7SA	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2026-04-09 16:20:32.996+07	2026-04-09 16:20:32.996+07	\N
casm_01KQVHXE82AT111GE98T9E6AHW	cart_01KQVHWG2PGA9DF412JYX7E4YP	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2026-05-05 14:51:19.042+07	2026-05-05 14:51:19.042+07	\N
\.


--
-- Data for Name: cart_shipping_method_adjustment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_shipping_method_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, metadata, created_at, updated_at, deleted_at, shipping_method_id) FROM stdin;
\.


--
-- Data for Name: cart_shipping_method_tax_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_shipping_method_tax_line (id, description, tax_rate_id, code, rate, provider_id, metadata, created_at, updated_at, deleted_at, shipping_method_id) FROM stdin;
\.


--
-- Data for Name: credit_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credit_line (id, cart_id, reference, reference_id, amount, raw_amount, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currency (code, symbol, symbol_native, decimal_digits, rounding, raw_rounding, name, created_at, updated_at, deleted_at) FROM stdin;
usd	$	$	2	0	{"value": "0", "precision": 20}	US Dollar	2025-07-18 10:01:30.344+07	2025-07-18 10:01:30.344+07	\N
cad	CA$	$	2	0	{"value": "0", "precision": 20}	Canadian Dollar	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
eur	€	€	2	0	{"value": "0", "precision": 20}	Euro	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
aed	AED	د.إ.‏	2	0	{"value": "0", "precision": 20}	United Arab Emirates Dirham	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
afn	Af	؋	0	0	{"value": "0", "precision": 20}	Afghan Afghani	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
all	ALL	Lek	0	0	{"value": "0", "precision": 20}	Albanian Lek	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
amd	AMD	դր.	0	0	{"value": "0", "precision": 20}	Armenian Dram	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
ars	AR$	$	2	0	{"value": "0", "precision": 20}	Argentine Peso	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
aud	AU$	$	2	0	{"value": "0", "precision": 20}	Australian Dollar	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
azn	man.	ман.	2	0	{"value": "0", "precision": 20}	Azerbaijani Manat	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bam	KM	KM	2	0	{"value": "0", "precision": 20}	Bosnia-Herzegovina Convertible Mark	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bdt	Tk	৳	2	0	{"value": "0", "precision": 20}	Bangladeshi Taka	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bgn	BGN	лв.	2	0	{"value": "0", "precision": 20}	Bulgarian Lev	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bhd	BD	د.ب.‏	3	0	{"value": "0", "precision": 20}	Bahraini Dinar	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bif	FBu	FBu	0	0	{"value": "0", "precision": 20}	Burundian Franc	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bnd	BN$	$	2	0	{"value": "0", "precision": 20}	Brunei Dollar	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bob	Bs	Bs	2	0	{"value": "0", "precision": 20}	Bolivian Boliviano	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
brl	R$	R$	2	0	{"value": "0", "precision": 20}	Brazilian Real	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bwp	BWP	P	2	0	{"value": "0", "precision": 20}	Botswanan Pula	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
byn	Br	руб.	2	0	{"value": "0", "precision": 20}	Belarusian Ruble	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
bzd	BZ$	$	2	0	{"value": "0", "precision": 20}	Belize Dollar	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
cdf	CDF	FrCD	2	0	{"value": "0", "precision": 20}	Congolese Franc	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
chf	CHF	CHF	2	0.05	{"value": "0.05", "precision": 20}	Swiss Franc	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
clp	CL$	$	0	0	{"value": "0", "precision": 20}	Chilean Peso	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
cny	CN¥	CN¥	2	0	{"value": "0", "precision": 20}	Chinese Yuan	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
cop	CO$	$	0	0	{"value": "0", "precision": 20}	Colombian Peso	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
crc	₡	₡	0	0	{"value": "0", "precision": 20}	Costa Rican Colón	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
cve	CV$	CV$	2	0	{"value": "0", "precision": 20}	Cape Verdean Escudo	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
czk	Kč	Kč	2	0	{"value": "0", "precision": 20}	Czech Republic Koruna	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
djf	Fdj	Fdj	0	0	{"value": "0", "precision": 20}	Djiboutian Franc	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
dkk	Dkr	kr	2	0	{"value": "0", "precision": 20}	Danish Krone	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
dop	RD$	RD$	2	0	{"value": "0", "precision": 20}	Dominican Peso	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
dzd	DA	د.ج.‏	2	0	{"value": "0", "precision": 20}	Algerian Dinar	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
eek	Ekr	kr	2	0	{"value": "0", "precision": 20}	Estonian Kroon	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
egp	EGP	ج.م.‏	2	0	{"value": "0", "precision": 20}	Egyptian Pound	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
ern	Nfk	Nfk	2	0	{"value": "0", "precision": 20}	Eritrean Nakfa	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
etb	Br	Br	2	0	{"value": "0", "precision": 20}	Ethiopian Birr	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
gbp	£	£	2	0	{"value": "0", "precision": 20}	British Pound Sterling	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
gel	GEL	GEL	2	0	{"value": "0", "precision": 20}	Georgian Lari	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
ghs	GH₵	GH₵	2	0	{"value": "0", "precision": 20}	Ghanaian Cedi	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
gnf	FG	FG	0	0	{"value": "0", "precision": 20}	Guinean Franc	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
gtq	GTQ	Q	2	0	{"value": "0", "precision": 20}	Guatemalan Quetzal	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
hkd	HK$	$	2	0	{"value": "0", "precision": 20}	Hong Kong Dollar	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
hnl	HNL	L	2	0	{"value": "0", "precision": 20}	Honduran Lempira	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
hrk	kn	kn	2	0	{"value": "0", "precision": 20}	Croatian Kuna	2025-07-18 10:01:30.345+07	2025-07-18 10:01:30.345+07	\N
huf	Ft	Ft	0	0	{"value": "0", "precision": 20}	Hungarian Forint	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
idr	Rp	Rp	0	0	{"value": "0", "precision": 20}	Indonesian Rupiah	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
ils	₪	₪	2	0	{"value": "0", "precision": 20}	Israeli New Sheqel	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
inr	Rs	₹	2	0	{"value": "0", "precision": 20}	Indian Rupee	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
iqd	IQD	د.ع.‏	0	0	{"value": "0", "precision": 20}	Iraqi Dinar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
irr	IRR	﷼	0	0	{"value": "0", "precision": 20}	Iranian Rial	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
isk	Ikr	kr	0	0	{"value": "0", "precision": 20}	Icelandic Króna	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
jmd	J$	$	2	0	{"value": "0", "precision": 20}	Jamaican Dollar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
jod	JD	د.أ.‏	3	0	{"value": "0", "precision": 20}	Jordanian Dinar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
jpy	¥	￥	0	0	{"value": "0", "precision": 20}	Japanese Yen	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
kes	Ksh	Ksh	2	0	{"value": "0", "precision": 20}	Kenyan Shilling	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
khr	KHR	៛	2	0	{"value": "0", "precision": 20}	Cambodian Riel	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
kmf	CF	FC	0	0	{"value": "0", "precision": 20}	Comorian Franc	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
krw	₩	₩	0	0	{"value": "0", "precision": 20}	South Korean Won	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
kwd	KD	د.ك.‏	3	0	{"value": "0", "precision": 20}	Kuwaiti Dinar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
kzt	KZT	тңг.	2	0	{"value": "0", "precision": 20}	Kazakhstani Tenge	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
lbp	LB£	ل.ل.‏	0	0	{"value": "0", "precision": 20}	Lebanese Pound	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
lkr	SLRs	SL Re	2	0	{"value": "0", "precision": 20}	Sri Lankan Rupee	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
ltl	Lt	Lt	2	0	{"value": "0", "precision": 20}	Lithuanian Litas	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
lvl	Ls	Ls	2	0	{"value": "0", "precision": 20}	Latvian Lats	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
lyd	LD	د.ل.‏	3	0	{"value": "0", "precision": 20}	Libyan Dinar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mad	MAD	د.م.‏	2	0	{"value": "0", "precision": 20}	Moroccan Dirham	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mdl	MDL	MDL	2	0	{"value": "0", "precision": 20}	Moldovan Leu	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mga	MGA	MGA	0	0	{"value": "0", "precision": 20}	Malagasy Ariary	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mkd	MKD	MKD	2	0	{"value": "0", "precision": 20}	Macedonian Denar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mmk	MMK	K	0	0	{"value": "0", "precision": 20}	Myanma Kyat	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mnt	MNT	₮	0	0	{"value": "0", "precision": 20}	Mongolian Tugrig	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mop	MOP$	MOP$	2	0	{"value": "0", "precision": 20}	Macanese Pataca	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mur	MURs	MURs	0	0	{"value": "0", "precision": 20}	Mauritian Rupee	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mxn	MX$	$	2	0	{"value": "0", "precision": 20}	Mexican Peso	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
myr	RM	RM	2	0	{"value": "0", "precision": 20}	Malaysian Ringgit	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mzn	MTn	MTn	2	0	{"value": "0", "precision": 20}	Mozambican Metical	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
nad	N$	N$	2	0	{"value": "0", "precision": 20}	Namibian Dollar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
ngn	₦	₦	2	0	{"value": "0", "precision": 20}	Nigerian Naira	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
nio	C$	C$	2	0	{"value": "0", "precision": 20}	Nicaraguan Córdoba	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
nok	Nkr	kr	2	0	{"value": "0", "precision": 20}	Norwegian Krone	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
npr	NPRs	नेरू	2	0	{"value": "0", "precision": 20}	Nepalese Rupee	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
nzd	NZ$	$	2	0	{"value": "0", "precision": 20}	New Zealand Dollar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
omr	OMR	ر.ع.‏	3	0	{"value": "0", "precision": 20}	Omani Rial	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
pab	B/.	B/.	2	0	{"value": "0", "precision": 20}	Panamanian Balboa	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
pen	S/.	S/.	2	0	{"value": "0", "precision": 20}	Peruvian Nuevo Sol	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
php	₱	₱	2	0	{"value": "0", "precision": 20}	Philippine Peso	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
pkr	PKRs	₨	0	0	{"value": "0", "precision": 20}	Pakistani Rupee	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
pln	zł	zł	2	0	{"value": "0", "precision": 20}	Polish Zloty	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
pyg	₲	₲	0	0	{"value": "0", "precision": 20}	Paraguayan Guarani	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
qar	QR	ر.ق.‏	2	0	{"value": "0", "precision": 20}	Qatari Rial	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
ron	RON	RON	2	0	{"value": "0", "precision": 20}	Romanian Leu	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
rsd	din.	дин.	0	0	{"value": "0", "precision": 20}	Serbian Dinar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
rub	RUB	₽.	2	0	{"value": "0", "precision": 20}	Russian Ruble	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
rwf	RWF	FR	0	0	{"value": "0", "precision": 20}	Rwandan Franc	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
sar	SR	ر.س.‏	2	0	{"value": "0", "precision": 20}	Saudi Riyal	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
sdg	SDG	SDG	2	0	{"value": "0", "precision": 20}	Sudanese Pound	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
sek	Skr	kr	2	0	{"value": "0", "precision": 20}	Swedish Krona	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
sgd	S$	$	2	0	{"value": "0", "precision": 20}	Singapore Dollar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
sos	Ssh	Ssh	0	0	{"value": "0", "precision": 20}	Somali Shilling	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
syp	SY£	ل.س.‏	0	0	{"value": "0", "precision": 20}	Syrian Pound	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
thb	฿	฿	2	0	{"value": "0", "precision": 20}	Thai Baht	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
tnd	DT	د.ت.‏	3	0	{"value": "0", "precision": 20}	Tunisian Dinar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
top	T$	T$	2	0	{"value": "0", "precision": 20}	Tongan Paʻanga	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
try	₺	₺	2	0	{"value": "0", "precision": 20}	Turkish Lira	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
ttd	TT$	$	2	0	{"value": "0", "precision": 20}	Trinidad and Tobago Dollar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
twd	NT$	NT$	2	0	{"value": "0", "precision": 20}	New Taiwan Dollar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
tzs	TSh	TSh	0	0	{"value": "0", "precision": 20}	Tanzanian Shilling	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
uah	₴	₴	2	0	{"value": "0", "precision": 20}	Ukrainian Hryvnia	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
ugx	USh	USh	0	0	{"value": "0", "precision": 20}	Ugandan Shilling	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
uyu	$U	$	2	0	{"value": "0", "precision": 20}	Uruguayan Peso	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
uzs	UZS	UZS	0	0	{"value": "0", "precision": 20}	Uzbekistan Som	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
vef	Bs.F.	Bs.F.	2	0	{"value": "0", "precision": 20}	Venezuelan Bolívar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
vnd	₫	₫	0	0	{"value": "0", "precision": 20}	Vietnamese Dong	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
xaf	FCFA	FCFA	0	0	{"value": "0", "precision": 20}	CFA Franc BEAC	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
xof	CFA	CFA	0	0	{"value": "0", "precision": 20}	CFA Franc BCEAO	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
yer	YR	ر.ي.‏	0	0	{"value": "0", "precision": 20}	Yemeni Rial	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
zar	R	R	2	0	{"value": "0", "precision": 20}	South African Rand	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
zmk	ZK	ZK	0	0	{"value": "0", "precision": 20}	Zambian Kwacha	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
zwl	ZWL$	ZWL$	0	0	{"value": "0", "precision": 20}	Zimbabwean Dollar	2025-07-18 10:01:30.346+07	2025-07-18 10:01:30.346+07	\N
mwk	K	K	2	0	{"value": "0", "precision": 20}	Malawian Kwacha	2025-08-29 10:39:02.718+07	2025-08-29 10:39:02.718+07	\N
xpf	₣	₣	0	0	{"value": "0", "precision": 20}	CFP Franc	2025-08-29 10:39:02.718+07	2025-08-29 10:39:02.718+07	\N
tjs	TJS	с.	2	0	{"value": "0", "precision": 20}	Tajikistani Somoni	2026-02-19 05:56:33.618+07	2026-02-19 05:56:33.618+07	\N
gmd	D	D	2	0	{"value": "0", "precision": 20}	Gambian Dalasi	2026-07-06 11:37:34.494+07	2026-07-06 11:37:34.494+07	\N
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (id, company_name, first_name, last_name, email, phone, has_account, metadata, created_at, updated_at, deleted_at, created_by) FROM stdin;
cus_01K38AJPD0KBWRW4Y2EHBQWFW4	\N	\N	\N	alrocha@gmail.com	\N	f	\N	2025-08-22 14:23:36.224+07	2025-08-22 14:23:36.224+07	\N	\N
cus_01KMYZB2P21PMGEBWDS6EAS3JX	\N	Mabia	Ura	mabiaura@gmail.com	087888827718	t	\N	2026-03-30 15:56:35.266+07	2026-03-30 15:56:59.893+07	\N	\N
cus_01KMYKPXP9HY7D5PQ1XA621372	\N	Boy	Tegar	boytegar@gmail.com	0878992817721	t	\N	2026-03-30 12:33:20.457+07	2026-03-30 15:57:17.838+07	2026-03-30 15:57:17.837+07	\N
cus_01KMYM709GAS877P4STRD2ERP0	\N	Jonah	Hill	jonahill@gmail.com	087899281772	t	\N	2026-03-30 12:42:07.409+07	2026-03-30 15:57:26.372+07	2026-03-30 15:57:26.371+07	\N
cus_01KN1E9VS542B3M324QEM0KS9G	\N	Adrian	Validation	validation.20260331.0756@example.com	081234567890	t	\N	2026-03-31 14:56:32.933+07	2026-03-31 15:06:55.526+07	\N	\N
cus_01KN1GCKQN0QW3VXF1VGZQ4ND5	\N	Validation	Flow	validation.ui.20260331.0830@example.com	+6281234567001	t	\N	2026-03-31 15:33:00.149+07	2026-03-31 15:36:29.481+07	\N	\N
cus_01KQVHXB9DF754Y23NXJMMTP8S	\N	\N	\N	user@example.com	\N	f	\N	2026-05-05 14:51:16.013+07	2026-05-05 14:51:16.013+07	\N	\N
\.


--
-- Data for Name: customer_account_holder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_account_holder (customer_id, account_holder_id, id, created_at, updated_at, deleted_at) FROM stdin;
cus_01KN1GCKQN0QW3VXF1VGZQ4ND5	acchld_01KN1NK6ASF3Z70B7QCZ5HPAY3	custacchldr_01KN1NK6B3APQFET3MD119AZ0V	2026-03-31 17:03:58.69081+07	2026-03-31 17:03:58.69081+07	\N
cus_01KMYZB2P21PMGEBWDS6EAS3JX	acchld_01KNRRJB09ZQ8R88V39PVRQR5Z	custacchldr_01KNRRJB0MQ4A8JWHGFV6XESTV	2026-04-09 16:18:28.372353+07	2026-04-09 16:18:28.372353+07	\N
\.


--
-- Data for Name: customer_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_address (id, customer_id, address_name, is_default_shipping, is_default_billing, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: customer_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_group (id, name, metadata, created_by, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: customer_group_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_group_customer (id, customer_id, customer_group_id, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
\.


--
-- Data for Name: fulfillment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment (id, location_id, packed_at, shipped_at, delivered_at, canceled_at, data, provider_id, shipping_option_id, metadata, delivery_address_id, created_at, updated_at, deleted_at, marked_shipped_by, created_by, requires_shipping) FROM stdin;
ful_01K38B78K3XRCPCKVWN8MY5VV5	sloc_01K33F59FEB33XCB0DA9WPWN5Z	2025-08-22 14:34:50.2+07	\N	2025-08-22 14:35:00.148+07	\N	{}	manual_manual	so_01K38B4T1FCQDKK7TT2MPC8DCG	\N	fuladdr_01K38B78K3THNCD3W7FT1FXEKK	2025-08-22 14:34:50.212+07	2025-08-22 14:35:00.173+07	\N	\N	\N	t
\.


--
-- Data for Name: fulfillment_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment_address (id, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
fuladdr_01K38B78K3THNCD3W7FT1FXEKK		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id	Jawa Barat	40264		\N	2025-08-22 14:23:42.697+07	2025-08-22 14:23:42.697+07	\N
\.


--
-- Data for Name: fulfillment_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment_item (id, title, sku, barcode, quantity, raw_quantity, line_item_id, inventory_item_id, fulfillment_id, created_at, updated_at, deleted_at) FROM stdin;
fulit_01K38B78K21WDDEY6HNNJD1SE4	S	SWEATSHIRT-S		1	{"value": "1", "precision": 20}	ordli_01K38B662S2GB9JV4A7YRCMK9F	iitem_01K0DQNR8HDKZFXMZW258EV36W	ful_01K38B78K3XRCPCKVWN8MY5VV5	2025-08-22 14:34:50.212+07	2025-08-22 14:34:50.212+07	\N
\.


--
-- Data for Name: fulfillment_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment_label (id, tracking_number, tracking_url, label_url, fulfillment_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: fulfillment_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment_provider (id, is_enabled, created_at, updated_at, deleted_at) FROM stdin;
manual_manual	t	2025-07-18 10:01:30.375+07	2025-07-18 10:01:30.375+07	\N
\.


--
-- Data for Name: fulfillment_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment_set (id, name, type, metadata, created_at, updated_at, deleted_at) FROM stdin;
fuset_01K0DQNR1A9GSP9NT5MMF387RW	European Warehouse delivery	shipping	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fuset_01K33F5NGSCZ63W678VJ0MBZ5M	Gudang Utama shipping	shipping	\N	2025-08-20 17:07:40.058+07	2025-08-20 17:07:40.058+07	\N
fuset_01K33F5DKDPKNRQ347TPW1N0E3	Gudang Utama pick up	pickup	\N	2025-08-20 17:07:31.95+07	2025-08-20 17:25:35.175+07	2025-08-20 17:25:35.173+07
\.


--
-- Data for Name: geo_zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.geo_zone (id, type, country_code, province_code, city, service_zone_id, postal_expression, metadata, created_at, updated_at, deleted_at) FROM stdin;
fgz_01K0DQNR1AY080YVJ6VN0X39PM	country	gb	\N	\N	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	\N	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fgz_01K0DQNR1AY57FJ63P14TS17NZ	country	de	\N	\N	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	\N	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fgz_01K0DQNR1AV70TDK1MFDMRJW7F	country	dk	\N	\N	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	\N	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fgz_01K0DQNR1AB69T92A39Q4JRSPH	country	se	\N	\N	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	\N	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fgz_01K0DQNR1AF68N6DN3Y0DDP9QE	country	fr	\N	\N	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	\N	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fgz_01K0DQNR1A7GM5K86TK84B9HEE	country	es	\N	\N	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	\N	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fgz_01K0DQNR1A1PE7R4S7DZDC3AQN	country	it	\N	\N	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	\N	\N	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
fgz_01K33G5SS6W01XR6T7CKH526W8	country	id	\N	\N	serzo_01K33G5SS77RAVYA695YTY8D6R	\N	\N	2025-08-20 17:25:13+07	2025-08-20 17:25:13+07	\N
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.image (id, url, metadata, created_at, updated_at, deleted_at, rank, product_id) FROM stdin;
img_01K0DQNR621433HFRB9J3X111J	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X
img_01K0DQNR626GHMH9BFRRKT3B4A	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-back.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	1	prod_01K0DQNR60K5B3EZJ3TNWY0X9X
img_01K0DQNR628H9TQKCM37QPMVYP	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-white-front.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	2	prod_01K0DQNR60K5B3EZJ3TNWY0X9X
img_01K0DQNR62EC34DHXPRWWW993V	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-white-back.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	3	prod_01K0DQNR60K5B3EZJ3TNWY0X9X
img_01K0DQNR63JV8DE9084FQ4YT5N	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	0	prod_01K0DQNR60DXF0084R3YNQHSXJ
img_01K0DQNR63XWZGQDBRW16QAH5S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-back.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	1	prod_01K0DQNR60DXF0084R3YNQHSXJ
img_01K0DQNR6372B5AAXE599DR7T2	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	0	prod_01K0DQNR60F4HVA8YYA27N3KT3
img_01K0DQNR63BV68GW9HKY8Z8D64	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-back.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	1	prod_01K0DQNR60F4HVA8YYA27N3KT3
img_01K0DQNR6348STTTB0N00EVC90	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	0	prod_01K0DQNR60MNDVFQQ4PNFTPRC9
img_01K0DQNR63YT8P2FCAHX4X3PPD	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-back.png	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	1	prod_01K0DQNR60MNDVFQQ4PNFTPRC9
\.


--
-- Data for Name: inventory_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_item (id, created_at, updated_at, deleted_at, sku, origin_country, hs_code, mid_code, material, weight, length, height, width, requires_shipping, description, title, thumbnail, metadata) FROM stdin;
iitem_01K0DQNR8HZ8V16J0A12QJSX3Z	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-S-BLACK	\N	\N	\N	\N	\N	\N	\N	\N	t	S / Black	S / Black	\N	\N
iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-S-WHITE	\N	\N	\N	\N	\N	\N	\N	\N	t	S / White	S / White	\N	\N
iitem_01K0DQNR8H6FMW591ZAWE8CC6V	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-M-BLACK	\N	\N	\N	\N	\N	\N	\N	\N	t	M / Black	M / Black	\N	\N
iitem_01K0DQNR8HN7FREQ43S7HR4XBJ	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-M-WHITE	\N	\N	\N	\N	\N	\N	\N	\N	t	M / White	M / White	\N	\N
iitem_01K0DQNR8H7TSKNZPDMT9H5CDA	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-L-BLACK	\N	\N	\N	\N	\N	\N	\N	\N	t	L / Black	L / Black	\N	\N
iitem_01K0DQNR8HQ5N14ZPE16W32M8A	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-L-WHITE	\N	\N	\N	\N	\N	\N	\N	\N	t	L / White	L / White	\N	\N
iitem_01K0DQNR8HDEG38Z3SSC6BTDP2	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-XL-BLACK	\N	\N	\N	\N	\N	\N	\N	\N	t	XL / Black	XL / Black	\N	\N
iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHIRT-XL-WHITE	\N	\N	\N	\N	\N	\N	\N	\N	t	XL / White	XL / White	\N	\N
iitem_01K0DQNR8HDKZFXMZW258EV36W	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATSHIRT-S	\N	\N	\N	\N	\N	\N	\N	\N	t	S	S	\N	\N
iitem_01K0DQNR8HR59HTB6ERH8DZASY	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATSHIRT-M	\N	\N	\N	\N	\N	\N	\N	\N	t	M	M	\N	\N
iitem_01K0DQNR8HHMNTR22RZE0C3VDE	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATSHIRT-L	\N	\N	\N	\N	\N	\N	\N	\N	t	L	L	\N	\N
iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATSHIRT-XL	\N	\N	\N	\N	\N	\N	\N	\N	t	XL	XL	\N	\N
iitem_01K0DQNR8HEP3A6M8P8RVFT5JG	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATPANTS-S	\N	\N	\N	\N	\N	\N	\N	\N	t	S	S	\N	\N
iitem_01K0DQNR8HKWFJWJVHX5SWTADW	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATPANTS-M	\N	\N	\N	\N	\N	\N	\N	\N	t	M	M	\N	\N
iitem_01K0DQNR8HNDAVZP18NAD0E3XJ	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATPANTS-L	\N	\N	\N	\N	\N	\N	\N	\N	t	L	L	\N	\N
iitem_01K0DQNR8H473MMSD7EKP3MQK6	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SWEATPANTS-XL	\N	\N	\N	\N	\N	\N	\N	\N	t	XL	XL	\N	\N
iitem_01K0DQNR8J7722RFA36MATZMYN	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHORTS-S	\N	\N	\N	\N	\N	\N	\N	\N	t	S	S	\N	\N
iitem_01K0DQNR8J4CA4D5ADAH6ANXQS	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHORTS-M	\N	\N	\N	\N	\N	\N	\N	\N	t	M	M	\N	\N
iitem_01K0DQNR8JXCP0JAGSG543T09G	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHORTS-L	\N	\N	\N	\N	\N	\N	\N	\N	t	L	L	\N	\N
iitem_01K0DQNR8J8DJWWBSQX1CNYN0T	2025-07-18 10:01:34.61+07	2025-07-18 10:01:34.61+07	\N	SHORTS-XL	\N	\N	\N	\N	\N	\N	\N	\N	t	XL	XL	\N	\N
\.


--
-- Data for Name: inventory_level; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_level (id, created_at, updated_at, deleted_at, inventory_item_id, location_id, stocked_quantity, reserved_quantity, incoming_quantity, metadata, raw_stocked_quantity, raw_reserved_quantity, raw_incoming_quantity) FROM stdin;
ilev_01K33F99V1D1PWQPRAH5G0GZ7H	2025-08-20 17:09:39.169+07	2025-08-20 17:10:12.078+07	2025-08-20 17:10:12.075+07	iitem_01K0DQNR8H473MMSD7EKP3MQK6	sloc_01K33F59FEB33XCB0DA9WPWN5Z	0	0	0	\N	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ12K39YJ3VEZ2NF6A6	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8H7TSKNZPDMT9H5CDA	sloc_01K33F59FEB33XCB0DA9WPWN5Z	100	0	0	\N	{"value": "100", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ176P176NZS257K4DZ	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6	sloc_01K33F59FEB33XCB0DA9WPWN5Z	250	0	0	\N	{"value": "250", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ1ZRWJE1886D5WZF92	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HDEG38Z3SSC6BTDP2	sloc_01K33F59FEB33XCB0DA9WPWN5Z	150	0	0	\N	{"value": "150", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBQRGA7ZZK8P3BFX4D1	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.549+07	\N	iitem_01K0DQNR8H6FMW591ZAWE8CC6V	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	200	0	0	\N	{"value": "200", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBQTSQX85S2H1MP9H7E	2025-07-18 10:01:34.712+07	2025-08-20 17:23:55.566+07	\N	iitem_01K0DQNR8H473MMSD7EKP3MQK6	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ1BA6T62801YZDJ4FC	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T	sloc_01K33F59FEB33XCB0DA9WPWN5Z	200	0	0	\N	{"value": "200", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ1CK1AD061FQANCQDP	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HEP3A6M8P8RVFT5JG	sloc_01K33F59FEB33XCB0DA9WPWN5Z	320	0	0	\N	{"value": "320", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ1D7PP5KVTGDQSZX6X	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HHMNTR22RZE0C3VDE	sloc_01K33F59FEB33XCB0DA9WPWN5Z	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJAQ21ZJW2Q9ZD2D6YV	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HN7FREQ43S7HR4XBJ	sloc_01K33F59FEB33XCB0DA9WPWN5Z	250	0	0	\N	{"value": "250", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJAX2BC8FB9PCTB453J	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HNDAVZP18NAD0E3XJ	sloc_01K33F59FEB33XCB0DA9WPWN5Z	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJAQ2NGD1JG9V1E0ME8	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HQ5N14ZPE16W32M8A	sloc_01K33F59FEB33XCB0DA9WPWN5Z	150	0	0	\N	{"value": "150", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJBP4DJSX8AWFCJC1DV	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z	sloc_01K33F59FEB33XCB0DA9WPWN5Z	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJB70YTMW149NQNJDM1	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8HZ8V16J0A12QJSX3Z	sloc_01K33F59FEB33XCB0DA9WPWN5Z	300	0	0	\N	{"value": "300", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJBNP6W4ZBR306HFASG	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8J4CA4D5ADAH6ANXQS	sloc_01K33F59FEB33XCB0DA9WPWN5Z	225	0	0	\N	{"value": "225", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJBT3MEWCYPG3H3FRBT	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8J7722RFA36MATZMYN	sloc_01K33F59FEB33XCB0DA9WPWN5Z	200	0	0	\N	{"value": "200", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJB1TKCZ0QH4D7GSEQY	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8J8DJWWBSQX1CNYN0T	sloc_01K33F59FEB33XCB0DA9WPWN5Z	200	0	0	\N	{"value": "200", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJBXXZVPZDA80WWEJJT	2025-08-20 17:23:35.5+07	2025-08-20 17:23:35.5+07	\N	iitem_01K0DQNR8JXCP0JAGSG543T09G	sloc_01K33F59FEB33XCB0DA9WPWN5Z	110	0	0	\N	{"value": "110", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBQVB9S77CB8Z3NARQV	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.549+07	\N	iitem_01K0DQNR8H7TSKNZPDMT9H5CDA	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	300	0	0	\N	{"value": "300", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBQ69N6B60NQRKHH1ZP	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.549+07	\N	iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBQ7128BJ97NVPMTAYY	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.549+07	\N	iitem_01K0DQNR8HDEG38Z3SSC6BTDP2	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	150	0	0	\N	{"value": "150", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBQN7FZ6HKMEJS830WP	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.549+07	\N	iitem_01K0DQNR8HDKZFXMZW258EV36W	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	500	0	0	\N	{"value": "500", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR0M5Y05X85FBBSKTC	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.549+07	\N	iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	225	0	0	\N	{"value": "225", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR8FDJMBQ14F4NSBFP	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HEP3A6M8P8RVFT5JG	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ0035698Y4WW5GVP1W	2025-08-20 17:23:35.499+07	2026-04-09 16:33:01.451+07	\N	iitem_01K0DQNR8H6FMW591ZAWE8CC6V	sloc_01K33F59FEB33XCB0DA9WPWN5Z	200	1	0	\N	{"value": "200", "precision": 20}	{"value": "1", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJBHM69MD145R1NRH3G	2025-08-20 17:23:35.5+07	2026-05-05 14:51:25.977+07	\N	iitem_01K0DQNR8HR59HTB6ERH8DZASY	sloc_01K33F59FEB33XCB0DA9WPWN5Z	300	1	0	\N	{"value": "300", "precision": 20}	{"value": "1", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR003JEANR9Y51XBS7	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.549+07	\N	iitem_01K0DQNR8HHMNTR22RZE0C3VDE	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	200	0	0	\N	{"value": "200", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBRW2G9C1XET1QH4V46	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HKWFJWJVHX5SWTADW	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	150	0	0	\N	{"value": "150", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR9XMWYH7E87914PCN	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HN7FREQ43S7HR4XBJ	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	500	0	0	\N	{"value": "500", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR4510NGGY2YYH65B3	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HNDAVZP18NAD0E3XJ	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	300	0	0	\N	{"value": "300", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBRWNSGDG7ESQM7FZE2	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HQ5N14ZPE16W32M8A	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	500	0	0	\N	{"value": "500", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBRKNRXNS275AJ10CXG	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HR59HTB6ERH8DZASY	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	200	0	0	\N	{"value": "200", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR391XPS7RZ96993N2	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	210	0	0	\N	{"value": "210", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR1CP19MWN9D5BGVDG	2025-07-18 10:01:34.712+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8HZ8V16J0A12QJSX3Z	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	300	0	0	\N	{"value": "300", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBRAWP5R6H03Q8M7MTP	2025-07-18 10:01:34.713+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8J4CA4D5ADAH6ANXQS	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBRT02YN89QH288D9JQ	2025-07-18 10:01:34.713+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8J7722RFA36MATZMYN	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	330	0	0	\N	{"value": "330", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBRV4PGCP6BYD7QA8P5	2025-07-18 10:01:34.713+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8J8DJWWBSQX1CNYN0T	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	400	0	0	\N	{"value": "400", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K0DQNRBR0ZZGKS0K4BFNKZGG	2025-07-18 10:01:34.713+07	2025-08-20 17:23:35.55+07	\N	iitem_01K0DQNR8JXCP0JAGSG543T09G	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	150	0	0	\N	{"value": "150", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G3E4DQZTSJM04YA1FCXB0	2025-08-20 17:23:55.534+07	2025-08-20 17:23:55.534+07	\N	iitem_01K0DQNR8H473MMSD7EKP3MQK6	sloc_01K33F59FEB33XCB0DA9WPWN5Z	200	0	0	\N	{"value": "200", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJ1X12FP5VZT741J4M6	2025-08-20 17:23:35.5+07	2025-08-22 14:34:50.287+07	\N	iitem_01K0DQNR8HDKZFXMZW258EV36W	sloc_01K33F59FEB33XCB0DA9WPWN5Z	149	0	0	\N	{"value": "149", "precision": 20}	{"value": "0", "precision": 20}	{"value": "0", "precision": 20}
ilev_01K33G2TJAWVNMRK2JQDRD97SB	2025-08-20 17:23:35.5+07	2026-03-31 17:07:15.218+07	\N	iitem_01K0DQNR8HKWFJWJVHX5SWTADW	sloc_01K33F59FEB33XCB0DA9WPWN5Z	200	2	0	\N	{"value": "200", "precision": 20}	{"value": "2", "precision": 20}	{"value": "0", "precision": 20}
\.


--
-- Data for Name: invite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invite (id, email, accepted, token, expires_at, metadata, created_at, updated_at, deleted_at) FROM stdin;
invite_01K0DQNP7QJDX2MC6W99GZRW8M	admin@medusa-test.com	f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Imludml0ZV8wMUswRFFOUDdRSkRYMk1DNlc5OUdaUlc4TSIsImVtYWlsIjoiYWRtaW5AbWVkdXNhLXRlc3QuY29tIiwiaWF0IjoxNzUyODA3NjkyLCJleHAiOjE3NTI4OTQwOTIsImp0aSI6Ijk2MjIxODgyLWNiMzQtNDI4NC1hNjQ4LTU4NDNkYzQ4MTAwNiJ9.Tn8y8Ao5KkVFxwVuWeCyMF4VTeupzOtcUD6Tk_9ZXjI	2025-07-19 10:01:32.535+07	\N	2025-07-18 10:01:32.536+07	2025-07-18 10:01:32.536+07	\N
\.


--
-- Data for Name: invite_rbac_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invite_rbac_role (invite_id, rbac_role_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: layout_configuration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.layout_configuration (id, zone, user_id, is_system_default, configuration, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: link_module_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.link_module_migrations (id, table_name, link_descriptor, created_at) FROM stdin;
1	order_cart	{"toModel": "cart", "toModule": "cart", "fromModel": "order", "fromModule": "order"}	2025-07-18 03:01:29.344686
2	location_fulfillment_provider	{"toModel": "fulfillment_provider", "toModule": "fulfillment", "fromModel": "location", "fromModule": "stock_location"}	2025-07-18 03:01:29.344912
3	cart_promotion	{"toModel": "promotions", "toModule": "promotion", "fromModel": "cart", "fromModule": "cart"}	2025-07-18 03:01:29.344939
4	order_fulfillment	{"toModel": "fulfillments", "toModule": "fulfillment", "fromModel": "order", "fromModule": "order"}	2025-07-18 03:01:29.344993
5	location_fulfillment_set	{"toModel": "fulfillment_set", "toModule": "fulfillment", "fromModel": "location", "fromModule": "stock_location"}	2025-07-18 03:01:29.344687
6	order_payment_collection	{"toModel": "payment_collection", "toModule": "payment", "fromModel": "order", "fromModule": "order"}	2025-07-18 03:01:29.345522
8	order_promotion	{"toModel": "promotion", "toModule": "promotion", "fromModel": "order", "fromModule": "order"}	2025-07-18 03:01:29.346219
7	return_fulfillment	{"toModel": "fulfillments", "toModule": "fulfillment", "fromModel": "return", "fromModule": "order"}	2025-07-18 03:01:29.346224
10	product_variant_inventory_item	{"toModel": "inventory", "toModule": "inventory", "fromModel": "variant", "fromModule": "product"}	2025-07-18 03:01:29.347203
9	product_sales_channel	{"toModel": "sales_channel", "toModule": "sales_channel", "fromModel": "product", "fromModule": "product"}	2025-07-18 03:01:29.346784
11	product_variant_price_set	{"toModel": "price_set", "toModule": "pricing", "fromModel": "variant", "fromModule": "product"}	2025-07-18 03:01:29.375379
12	publishable_api_key_sales_channel	{"toModel": "sales_channel", "toModule": "sales_channel", "fromModel": "api_key", "fromModule": "api_key"}	2025-07-18 03:01:29.380166
13	region_payment_provider	{"toModel": "payment_provider", "toModule": "payment", "fromModel": "region", "fromModule": "region"}	2025-07-18 03:01:29.382312
14	sales_channel_stock_location	{"toModel": "location", "toModule": "stock_location", "fromModel": "sales_channel", "fromModule": "sales_channel"}	2025-07-18 03:01:29.383208
15	product_shipping_profile	{"toModel": "shipping_profile", "toModule": "fulfillment", "fromModel": "product", "fromModule": "product"}	2025-07-18 03:01:29.383534
16	shipping_option_price_set	{"toModel": "price_set", "toModule": "pricing", "fromModel": "shipping_option", "fromModule": "fulfillment"}	2025-07-18 03:01:29.383713
17	customer_account_holder	{"toModel": "account_holder", "toModule": "payment", "fromModel": "customer", "fromModule": "customer"}	2025-07-18 03:01:29.383504
18	cart_payment_collection	{"toModel": "payment_collection", "toModule": "payment", "fromModel": "cart", "fromModule": "cart"}	2025-07-18 03:01:29.384017
37	product_product_brand_brand	{"toModel": "brand", "toModule": "brand", "fromModel": "product", "fromModule": "product"}	2025-08-29 03:39:01.664593
57	user_rbac_role	{"toModel": "rbac_role", "toModule": "rbac", "fromModel": "user", "fromModule": "user"}	2026-02-19 05:56:32.491158
78	invite_rbac_role	{"toModel": "rbac_role", "toModule": "rbac", "fromModel": "invite", "fromModule": "user"}	2026-07-06 11:41:32.277929
\.


--
-- Data for Name: location_fulfillment_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location_fulfillment_provider (stock_location_id, fulfillment_provider_id, id, created_at, updated_at, deleted_at) FROM stdin;
sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	manual_manual	locfp_01K0DQNR0ZTQ0MF1C7F1HAZSCR	2025-07-18 10:01:34.367267+07	2025-07-18 10:01:34.367267+07	\N
sloc_01K33F59FEB33XCB0DA9WPWN5Z	manual_manual	locfp_01K33G4ZM07BM6HH4MSHKG8Y4N	2025-08-20 17:24:46.219524+07	2025-08-20 17:24:46.219524+07	\N
\.


--
-- Data for Name: location_fulfillment_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location_fulfillment_set (stock_location_id, fulfillment_set_id, id, created_at, updated_at, deleted_at) FROM stdin;
sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	fuset_01K0DQNR1A9GSP9NT5MMF387RW	locfs_01K0DQNR1WNXPVT1ZPZPAKAX6M	2025-07-18 10:01:34.39607+07	2025-07-18 10:01:34.39607+07	\N
sloc_01K33F59FEB33XCB0DA9WPWN5Z	fuset_01K33F5NGSCZ63W678VJ0MBZ5M	locfs_01K33F5NHB89CE0KC6MAG8BV3F	2025-08-20 17:07:40.071277+07	2025-08-20 17:07:40.071277+07	\N
sloc_01K33F59FEB33XCB0DA9WPWN5Z	fuset_01K33F5DKDPKNRQ347TPW1N0E3	locfs_01K33F5DM912QQ2Y522Q5ZBBZC	2025-08-20 17:07:31.973151+07	2025-08-20 17:25:35.199+07	2025-08-20 17:25:35.197+07
\.


--
-- Data for Name: mikro_orm_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mikro_orm_migrations (id, name, executed_at) FROM stdin;
1	Migration20240307161216	2025-07-18 10:01:27.233829+07
2	Migration20241210073813	2025-07-18 10:01:27.233829+07
3	Migration20250106142624	2025-07-18 10:01:27.233829+07
4	Migration20250120110820	2025-07-18 10:01:27.233829+07
5	Migration20240307132720	2025-07-18 10:01:27.288524+07
6	Migration20240719123015	2025-07-18 10:01:27.288524+07
7	Migration20241213063611	2025-07-18 10:01:27.288524+07
8	InitialSetup20240401153642	2025-07-18 10:01:27.362788+07
9	Migration20240601111544	2025-07-18 10:01:27.362788+07
10	Migration202408271511	2025-07-18 10:01:27.362788+07
11	Migration20241122120331	2025-07-18 10:01:27.362788+07
12	Migration20241125090957	2025-07-18 10:01:27.362788+07
13	Migration20250411073236	2025-07-18 10:01:27.362788+07
14	Migration20250516081326	2025-07-18 10:01:27.362788+07
15	Migration20230929122253	2025-07-18 10:01:27.518345+07
16	Migration20240322094407	2025-07-18 10:01:27.518345+07
17	Migration20240322113359	2025-07-18 10:01:27.518345+07
18	Migration20240322120125	2025-07-18 10:01:27.518345+07
19	Migration20240626133555	2025-07-18 10:01:27.518345+07
20	Migration20240704094505	2025-07-18 10:01:27.518345+07
21	Migration20241127114534	2025-07-18 10:01:27.518345+07
22	Migration20241127223829	2025-07-18 10:01:27.518345+07
23	Migration20241128055359	2025-07-18 10:01:27.518345+07
24	Migration20241212190401	2025-07-18 10:01:27.518345+07
25	Migration20250408145122	2025-07-18 10:01:27.518345+07
26	Migration20250409122219	2025-07-18 10:01:27.518345+07
27	Migration20240227120221	2025-07-18 10:01:27.698184+07
28	Migration20240617102917	2025-07-18 10:01:27.698184+07
29	Migration20240624153824	2025-07-18 10:01:27.698184+07
30	Migration20241211061114	2025-07-18 10:01:27.698184+07
31	Migration20250113094144	2025-07-18 10:01:27.698184+07
32	Migration20250120110700	2025-07-18 10:01:27.698184+07
33	Migration20250226130616	2025-07-18 10:01:27.698184+07
34	Migration20250508081510	2025-07-18 10:01:27.698184+07
35	Migration20240124154000	2025-07-18 10:01:27.856392+07
36	Migration20240524123112	2025-07-18 10:01:27.856392+07
37	Migration20240602110946	2025-07-18 10:01:27.856392+07
38	Migration20241211074630	2025-07-18 10:01:27.856392+07
39	Migration20240115152146	2025-07-18 10:01:27.928392+07
40	Migration20240222170223	2025-07-18 10:01:27.950511+07
41	Migration20240831125857	2025-07-18 10:01:27.950511+07
42	Migration20241106085918	2025-07-18 10:01:27.950511+07
43	Migration20241205095237	2025-07-18 10:01:27.950511+07
44	Migration20241216183049	2025-07-18 10:01:27.950511+07
45	Migration20241218091938	2025-07-18 10:01:27.950511+07
46	Migration20250120115059	2025-07-18 10:01:27.950511+07
47	Migration20250212131240	2025-07-18 10:01:27.950511+07
48	Migration20250326151602	2025-07-18 10:01:27.950511+07
49	Migration20250508081553	2025-07-18 10:01:27.950511+07
50	Migration20240205173216	2025-07-18 10:01:28.07752+07
51	Migration20240624200006	2025-07-18 10:01:28.07752+07
52	Migration20250120110744	2025-07-18 10:01:28.07752+07
53	InitialSetup20240221144943	2025-07-18 10:01:28.17994+07
54	Migration20240604080145	2025-07-18 10:01:28.17994+07
55	Migration20241205122700	2025-07-18 10:01:28.17994+07
56	InitialSetup20240227075933	2025-07-18 10:01:28.215727+07
57	Migration20240621145944	2025-07-18 10:01:28.215727+07
58	Migration20241206083313	2025-07-18 10:01:28.215727+07
59	Migration20240227090331	2025-07-18 10:01:28.261553+07
60	Migration20240710135844	2025-07-18 10:01:28.261553+07
61	Migration20240924114005	2025-07-18 10:01:28.261553+07
62	Migration20241212052837	2025-07-18 10:01:28.261553+07
63	InitialSetup20240228133303	2025-07-18 10:01:28.338948+07
64	Migration20240624082354	2025-07-18 10:01:28.338948+07
65	Migration20240225134525	2025-07-18 10:01:28.369738+07
66	Migration20240806072619	2025-07-18 10:01:28.369738+07
67	Migration20241211151053	2025-07-18 10:01:28.369738+07
68	Migration20250115160517	2025-07-18 10:01:28.369738+07
69	Migration20250120110552	2025-07-18 10:01:28.369738+07
70	Migration20250123122334	2025-07-18 10:01:28.369738+07
71	Migration20250206105639	2025-07-18 10:01:28.369738+07
72	Migration20250207132723	2025-07-18 10:01:28.369738+07
73	Migration20250625084134	2025-07-18 10:01:28.369738+07
74	Migration20240219102530	2025-07-18 10:01:28.47955+07
75	Migration20240604100512	2025-07-18 10:01:28.47955+07
76	Migration20240715102100	2025-07-18 10:01:28.47955+07
77	Migration20240715174100	2025-07-18 10:01:28.47955+07
78	Migration20240716081800	2025-07-18 10:01:28.47955+07
79	Migration20240801085921	2025-07-18 10:01:28.47955+07
80	Migration20240821164505	2025-07-18 10:01:28.47955+07
81	Migration20240821170920	2025-07-18 10:01:28.47955+07
82	Migration20240827133639	2025-07-18 10:01:28.47955+07
83	Migration20240902195921	2025-07-18 10:01:28.47955+07
84	Migration20240913092514	2025-07-18 10:01:28.47955+07
85	Migration20240930122627	2025-07-18 10:01:28.47955+07
86	Migration20241014142943	2025-07-18 10:01:28.47955+07
87	Migration20241106085223	2025-07-18 10:01:28.47955+07
88	Migration20241129124827	2025-07-18 10:01:28.47955+07
89	Migration20241217162224	2025-07-18 10:01:28.47955+07
90	Migration20250326151554	2025-07-18 10:01:28.47955+07
91	Migration20250522181137	2025-07-18 10:01:28.47955+07
92	Migration20250702095353	2025-07-18 10:01:28.47955+07
93	Migration20250704120229	2025-07-18 10:01:28.47955+07
94	Migration20240205025928	2025-07-18 10:01:28.708684+07
95	Migration20240529080336	2025-07-18 10:01:28.708684+07
96	Migration20241202100304	2025-07-18 10:01:28.708684+07
97	Migration20240214033943	2025-07-18 10:01:28.779255+07
98	Migration20240703095850	2025-07-18 10:01:28.779255+07
99	Migration20241202103352	2025-07-18 10:01:28.779255+07
100	Migration20240311145700_InitialSetupMigration	2025-07-18 10:01:28.827928+07
101	Migration20240821170957	2025-07-18 10:01:28.827928+07
102	Migration20240917161003	2025-07-18 10:01:28.827928+07
103	Migration20241217110416	2025-07-18 10:01:28.827928+07
104	Migration20250113122235	2025-07-18 10:01:28.827928+07
105	Migration20250120115002	2025-07-18 10:01:28.827928+07
106	Migration20240509083918_InitialSetupMigration	2025-07-18 10:01:28.981998+07
107	Migration20240628075401	2025-07-18 10:01:28.981998+07
108	Migration20240830094712	2025-07-18 10:01:28.981998+07
109	Migration20250120110514	2025-07-18 10:01:28.981998+07
110	Migration20231228143900	2025-07-18 10:01:29.073037+07
111	Migration20241206101446	2025-07-18 10:01:29.073037+07
112	Migration20250128174331	2025-07-18 10:01:29.073037+07
113	Migration20250505092459	2025-07-18 10:01:29.073037+07
114	Migration20250717162007	2025-08-29 10:39:00.936372+07
115	Migration20250822130931	2025-08-29 10:39:01.056774+07
116	Migration20250825132614	2025-08-29 10:39:01.056774+07
117	Migration20250819104213	2025-08-29 10:39:01.157494+07
118	Migration20250829033855	2025-08-29 10:39:01.216285+07
119	Migration20251010131115	2026-02-19 05:56:30.454519+07
120	Migration20250910154539	2026-02-19 05:56:30.508033+07
121	Migration20250911092221	2026-02-19 05:56:30.508033+07
122	Migration20250929204438	2026-02-19 05:56:30.508033+07
123	Migration20251008132218	2026-02-19 05:56:30.508033+07
124	Migration20251011090511	2026-02-19 05:56:30.508033+07
125	Migration20251009110625	2026-02-19 05:56:30.649845+07
126	Migration20251112192723	2026-02-19 05:56:30.649845+07
127	Migration20250828075407	2026-02-19 05:56:30.830839+07
128	Migration20250909083125	2026-02-19 05:56:30.830839+07
129	Migration20250916120552	2026-02-19 05:56:30.830839+07
130	Migration20250917143818	2026-02-19 05:56:30.830839+07
131	Migration20250919122137	2026-02-19 05:56:30.830839+07
132	Migration20251006000000	2026-02-19 05:56:30.830839+07
133	Migration20251015113934	2026-02-19 05:56:30.830839+07
134	Migration20251107050148	2026-02-19 05:56:30.830839+07
135	Migration20251010130829	2026-02-19 05:56:31.219592+07
136	Migration20251017153909	2026-02-19 05:56:31.288159+07
137	Migration20251208130704	2026-02-19 05:56:31.288159+07
138	Migration20251015123842	2026-02-19 05:56:31.363639+07
139	Migration20251202184737	2026-02-19 05:56:31.389336+07
140	Migration20251212161429	2026-02-19 05:56:31.389336+07
141	Migration20250924135437	2026-02-19 05:56:31.462713+07
142	Migration20250929124701	2026-02-19 05:56:31.462713+07
143	Migration20250910130000	2026-02-19 05:56:31.485189+07
144	Migration20251016160403	2026-02-19 05:56:31.485189+07
145	Migration20251016182939	2026-02-19 05:56:31.485189+07
146	Migration20251017155709	2026-02-19 05:56:31.485189+07
147	Migration20251114100559	2026-02-19 05:56:31.485189+07
148	Migration20251125164002	2026-02-19 05:56:31.485189+07
149	Migration20251210112909	2026-02-19 05:56:31.485189+07
150	Migration20251210112924	2026-02-19 05:56:31.485189+07
151	Migration20251225120947	2026-02-19 05:56:31.485189+07
152	Migration20251114133146	2026-02-19 05:56:31.636461+07
153	Migration20251028172715	2026-02-19 05:56:31.673765+07
154	Migration20251121123942	2026-02-19 05:56:31.673765+07
155	Migration20251121150408	2026-02-19 05:56:31.673765+07
156	Migration20250819110924	2026-02-19 05:56:31.745083+07
157	Migration20250908080305	2026-02-19 05:56:31.745083+07
158	Migration20251022153442	2026-07-06 11:41:31.035959+07
159	Migration20251029150809	2026-07-06 11:41:31.035959+07
160	Migration20251110180907	2026-07-06 11:41:31.035959+07
161	Migration20251113183352	2026-07-06 11:41:31.035959+07
162	Migration20260224120000	2026-07-06 11:41:31.035959+07
163	Migration20260301002050	2026-07-06 11:41:31.035959+07
164	Migration20260306120000	2026-07-06 11:41:31.035959+07
165	Migration20260429163502	2026-07-06 11:41:31.294351+07
166	Migration20260411223700	2026-07-06 11:41:31.450971+07
167	Migration20260106185528	2026-07-06 11:41:31.481642+07
168	Migration20260127081758	2026-07-06 11:41:31.516912+07
169	Migration20260615151246	2026-07-06 11:41:31.516912+07
170	Migration20260514083900	2026-07-06 11:41:31.540238+07
171	Migration20260525090000	2026-07-06 11:41:31.540238+07
172	Migration20260604120000	2026-07-06 11:41:31.540238+07
173	Migration20260616075929	2026-07-06 11:41:31.540238+07
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, "to", channel, template, data, trigger_type, resource_id, resource_type, receiver_id, original_notification_id, idempotency_key, external_id, provider_id, created_at, updated_at, deleted_at, status, "from", provider_data) FROM stdin;
\.


--
-- Data for Name: notification_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_provider (id, handle, name, is_enabled, channels, created_at, updated_at, deleted_at) FROM stdin;
local	local	local	t	{feed}	2025-07-18 10:01:30.375+07	2025-07-18 10:01:30.375+07	\N
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id, region_id, display_id, customer_id, version, sales_channel_id, status, is_draft_order, email, currency_code, shipping_address_id, billing_address_id, no_notification, metadata, created_at, updated_at, deleted_at, canceled_at, custom_display_id, locale) FROM stdin;
order_01K38B662RTMWSDZD5ZQKYWPT2	reg_01K33FFDX0M838JWM069761552	1	cus_01K38AJPD0KBWRW4Y2EHBQWFW4	3	sc_01K0DQNP6KWXP3R7NJGNA411PQ	pending	f	alrocha@gmail.com	idr	ordaddr_01K38B662N2RWASJYNCQQHPTPY	ordaddr_01K38B662NKQCSSRGH0BMYPDG1	f	\N	2025-08-22 14:34:14.875+07	2025-08-22 14:35:00.201+07	\N	\N	\N	\N
order_01KN1NS64RRTHX86HEAXAF662C	reg_01K33FFDX0M838JWM069761552	2	cus_01KN1E9VS542B3M324QEM0KS9G	2	sc_01K0DQNP6KWXP3R7NJGNA411PQ	pending	f	validation.ui.20260331.0830@example.com	idr	ordaddr_01KN1NS64GZZ9CDRQ9N25SWKRW	ordaddr_01KN1NS64ERPFWY652DCKFYSFR	f	\N	2026-03-31 17:07:15.104+07	2026-03-31 18:16:23.7+07	\N	\N	\N	\N
order_01KNRSCZFAKHKZ76309AYZ5TPW	reg_01K33FFDX0M838JWM069761552	3	cus_01KMYZB2P21PMGEBWDS6EAS3JX	1	sc_01K0DQNP6KWXP3R7NJGNA411PQ	pending	f	mabiaura@gmail.com	idr	ordaddr_01KNRSCZETJDTPJG9NNJBHJX5Y	ordaddr_01KNRSCZETQMAQMCB9M20C7AYW	f	\N	2026-04-09 16:33:01.296+07	2026-04-09 16:33:01.296+07	\N	\N	\N	\N
order_01KQVHXMXKWMJ36ECST0YSMKD4	reg_01K33FFDX0M838JWM069761552	4	cus_01KQVHXB9DF754Y23NXJMMTP8S	1	sc_01K0DQNP6KWXP3R7NJGNA411PQ	pending	f	user@example.com	idr	ordaddr_01KQVHXMXG76N219V8VT6YYBT9	ordaddr_01KQVHXMXGRT1A0AAG1KMR3HBD	f	\N	2026-05-05 14:51:25.878+07	2026-05-05 14:51:25.878+07	\N	\N	\N	\N
\.


--
-- Data for Name: order_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_address (id, customer_id, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, metadata, created_at, updated_at, deleted_at) FROM stdin;
ordaddr_01K38B662NKQCSSRGH0BMYPDG1	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id	Jawa Barat	40264		\N	2025-08-22 14:23:42.697+07	2025-08-22 14:23:42.697+07	\N
ordaddr_01K38B662N2RWASJYNCQQHPTPY	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id	Jawa Barat	40264		\N	2025-08-22 14:23:42.697+07	2025-08-22 14:23:42.697+07	\N
ordaddr_01KN1NS64ERPFWY652DCKFYSFR	\N	Mercora QA	Validation	Flow	Jl. Merdeka 123		Jakarta	id	DKI Jakarta	10110	+6281234567001	\N	2026-03-31 16:18:50.278+07	2026-03-31 16:18:50.278+07	\N
ordaddr_01KN1NS64GZZ9CDRQ9N25SWKRW	\N	Mercora QA	Validation	Flow	Jl. Merdeka 123		Jakarta	id	DKI Jakarta	10110	+6281234567001	\N	2026-03-31 16:18:50.279+07	2026-03-31 16:18:50.279+07	\N
ordaddr_01KNRSCZETQMAQMCB9M20C7AYW	\N	Mercora	Mabia	Ura	Jl. Melati 123		Jakarta	id	DKI Jakarta	12345	08123456789	\N	2026-04-09 16:28:07.04+07	2026-04-09 16:28:07.04+07	\N
ordaddr_01KNRSCZETJDTPJG9NNJBHJX5Y	\N	Mercora	Mabia	Ura	Jl. Melati 123		Jakarta	id	DKI Jakarta	12345	08123456789	\N	2026-04-09 16:28:07.04+07	2026-04-09 16:28:07.04+07	\N
ordaddr_01KQVHXMXGRT1A0AAG1KMR3HBD	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id		40264	T	\N	2026-05-05 14:51:16.028+07	2026-05-05 14:51:16.028+07	\N
ordaddr_01KQVHXMXG76N219V8VT6YYBT9	\N		Al Rocha	Cabrerra	Jl. Simponi No. 21		Bandung	id		40264	T	\N	2026-05-05 14:51:16.028+07	2026-05-05 14:51:16.028+07	\N
\.


--
-- Data for Name: order_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_cart (order_id, cart_id, id, created_at, updated_at, deleted_at) FROM stdin;
order_01K38B662RTMWSDZD5ZQKYWPT2	cart_01K33CW1JP7SDSJ6WYD5KJ08X3	ordercart_01K38B665HSSV49DZB7GRV7WRG	2025-08-22 14:34:14.960543+07	2025-08-22 14:34:14.960543+07	\N
order_01KN1NS64RRTHX86HEAXAF662C	cart_01KN1J9B9X8NFP6APDW5W91A81	ordercart_01KN1NS68RFWGTV7GW9P3QHRJ8	2026-03-31 17:07:15.223791+07	2026-03-31 17:07:15.223791+07	\N
order_01KNRSCZFAKHKZ76309AYZ5TPW	cart_01KNRKD9WC1KSM36G6G6DFV7SA	ordercart_01KNRSCZKVCYPNJ055ZYPC9AXR	2026-04-09 16:33:01.435181+07	2026-04-09 16:33:01.435181+07	\N
order_01KQVHXMXKWMJ36ECST0YSMKD4	cart_01KQVHWG2PGA9DF412JYX7E4YP	ordercart_01KQVHXN0NC2HQFHTJSV5JH1YE	2026-05-05 14:51:25.971263+07	2026-05-05 14:51:25.971263+07	\N
\.


--
-- Data for Name: order_change; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_change (id, order_id, version, description, status, internal_note, created_by, requested_by, requested_at, confirmed_by, confirmed_at, declined_by, declined_reason, metadata, declined_at, canceled_by, canceled_at, created_at, updated_at, change_type, deleted_at, return_id, claim_id, exchange_id, carry_over_promotions) FROM stdin;
ordch_01K38B78NAKJC58S982X4CSDVW	order_01K38B662RTMWSDZD5ZQKYWPT2	2	\N	confirmed	\N	\N	\N	\N	\N	2025-08-22 14:34:50.296+07	\N	\N	\N	\N	\N	\N	2025-08-22 14:34:50.282+07	2025-08-22 14:34:50.3+07	\N	\N	\N	\N	\N	\N
ordch_01K38B7J9XH86ERHGJAKZZZBVF	order_01K38B662RTMWSDZD5ZQKYWPT2	3	\N	confirmed	\N	\N	\N	\N	\N	2025-08-22 14:35:00.171+07	\N	\N	\N	\N	\N	\N	2025-08-22 14:35:00.157+07	2025-08-22 14:35:00.176+07	\N	\N	\N	\N	\N	\N
ordch_01KN1S3980A5FF29RDW4QE8B0Q	order_01KN1NS64RRTHX86HEAXAF662C	2	\N	confirmed	\N	cus_01KN1E9VS542B3M324QEM0KS9G	cus_01KN1E9VS542B3M324QEM0KS9G	2026-03-31 18:05:11.747+07	\N	2026-03-31 18:16:23.611+07	\N	\N	\N	\N	\N	\N	2026-03-31 18:05:11.683+07	2026-03-31 18:16:23.658+07	transfer	\N	\N	\N	\N	\N
\.


--
-- Data for Name: order_change_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_change_action (id, order_id, version, ordering, order_change_id, reference, reference_id, action, details, amount, raw_amount, internal_note, applied, created_at, updated_at, deleted_at, return_id, claim_id, exchange_id) FROM stdin;
ordchact_01K38B78NA156MGVSFA1AG371D	order_01K38B662RTMWSDZD5ZQKYWPT2	2	1	ordch_01K38B78NAKJC58S982X4CSDVW	fulfillment	ful_01K38B78K3XRCPCKVWN8MY5VV5	FULFILL_ITEM	{"quantity": 1, "reference_id": "ordli_01K38B662S2GB9JV4A7YRCMK9F"}	\N	\N	\N	t	2025-08-22 14:34:50.283+07	2025-08-22 14:34:50.33+07	\N	\N	\N	\N
ordchact_01K38B7J9XJ8HXVY27G0K999XJ	order_01K38B662RTMWSDZD5ZQKYWPT2	3	2	ordch_01K38B7J9XH86ERHGJAKZZZBVF	fulfillment	ful_01K38B78K3XRCPCKVWN8MY5VV5	DELIVER_ITEM	{"quantity": "1", "reference_id": "ordli_01K38B662S2GB9JV4A7YRCMK9F"}	\N	\N	\N	t	2025-08-22 14:35:00.158+07	2025-08-22 14:35:00.202+07	\N	\N	\N	\N
ordchact_01KN1S399G0QDH86KH016NVT5C	order_01KN1NS64RRTHX86HEAXAF662C	2	3	ordch_01KN1S3980A5FF29RDW4QE8B0Q	customer	cus_01KN1E9VS542B3M324QEM0KS9G	TRANSFER_CUSTOMER	{"token": "6fa166ba-cffc-4c7b-88be-6b2aad7b36d4", "original_email": "validation.ui.20260331.0830@example.com"}	\N	\N	\N	t	2026-03-31 18:05:11.729+07	2026-03-31 18:16:23.701+07	\N	\N	\N	\N
\.


--
-- Data for Name: order_claim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_claim (id, order_id, return_id, order_version, display_id, type, no_notification, refund_amount, raw_refund_amount, metadata, created_at, updated_at, deleted_at, canceled_at, created_by) FROM stdin;
\.


--
-- Data for Name: order_claim_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_claim_item (id, claim_id, item_id, is_additional_item, reason, quantity, raw_quantity, note, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_claim_item_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_claim_item_image (id, claim_item_id, url, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_credit_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_credit_line (id, order_id, reference, reference_id, amount, raw_amount, metadata, created_at, updated_at, deleted_at, version) FROM stdin;
\.


--
-- Data for Name: order_exchange; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_exchange (id, order_id, return_id, order_version, display_id, no_notification, allow_backorder, difference_due, raw_difference_due, metadata, created_at, updated_at, deleted_at, canceled_at, created_by) FROM stdin;
\.


--
-- Data for Name: order_exchange_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_exchange_item (id, exchange_id, item_id, quantity, raw_quantity, note, metadata, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_fulfillment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_fulfillment (order_id, fulfillment_id, id, created_at, updated_at, deleted_at) FROM stdin;
order_01K38B662RTMWSDZD5ZQKYWPT2	ful_01K38B78K3XRCPCKVWN8MY5VV5	ordful_01K38B78N0GQPFA1SMJWC911V4	2025-08-22 14:34:50.271064+07	2025-08-22 14:34:50.271064+07	\N
\.


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_item (id, order_id, version, item_id, quantity, raw_quantity, fulfilled_quantity, raw_fulfilled_quantity, shipped_quantity, raw_shipped_quantity, return_requested_quantity, raw_return_requested_quantity, return_received_quantity, raw_return_received_quantity, return_dismissed_quantity, raw_return_dismissed_quantity, written_off_quantity, raw_written_off_quantity, metadata, created_at, updated_at, deleted_at, delivered_quantity, raw_delivered_quantity, unit_price, raw_unit_price, compare_at_unit_price, raw_compare_at_unit_price) FROM stdin;
orditem_01K38B662T4ST80A7TW0SNNYJ7	order_01K38B662RTMWSDZD5ZQKYWPT2	1	ordli_01K38B662S2GB9JV4A7YRCMK9F	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2025-08-22 14:34:14.875+07	2025-08-22 14:34:14.875+07	\N	0	{"value": "0", "precision": 20}	\N	\N	\N	\N
orditem_01K38B78PJDGVCSKDPK78YMPQ2	order_01K38B662RTMWSDZD5ZQKYWPT2	2	ordli_01K38B662S2GB9JV4A7YRCMK9F	1	{"value": "1", "precision": 20}	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2025-08-22 14:34:50.329+07	2025-08-22 14:34:50.329+07	\N	0	{"value": "0", "precision": 20}	240000	{"value": "240000", "precision": 20}	\N	\N
orditem_01K38B7JB3MQHXZ83RD1BD7DF4	order_01K38B662RTMWSDZD5ZQKYWPT2	3	ordli_01K38B662S2GB9JV4A7YRCMK9F	1	{"value": "1", "precision": 20}	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2025-08-22 14:35:00.201+07	2025-08-22 14:35:00.201+07	\N	1	{"value": "1", "precision": 20}	240000	{"value": "240000", "precision": 20}	\N	\N
orditem_01KN1NS650YE34Z4YQY812V0BM	order_01KN1NS64RRTHX86HEAXAF662C	1	ordli_01KN1NS64Y38PE672KNKFA3ZXM	2	{"value": "2", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-03-31 17:07:15.105+07	2026-03-31 17:07:15.105+07	\N	0	{"value": "0", "precision": 20}	\N	\N	\N	\N
orditem_01KN1SQSF8CX6D0KP03P488WBE	order_01KN1NS64RRTHX86HEAXAF662C	2	ordli_01KN1NS64Y38PE672KNKFA3ZXM	2	{"value": "2", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-03-31 18:16:23.658+07	2026-03-31 18:16:23.658+07	\N	0	{"value": "0", "precision": 20}	220000	{"value": "220000", "precision": 20}	\N	\N
orditem_01KNRSCZFFR8RWHQX4NQ3F0K8E	order_01KNRSCZFAKHKZ76309AYZ5TPW	1	ordli_01KNRSCZFEV2QDMV14TR42QXY9	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-04-09 16:33:01.297+07	2026-04-09 16:33:01.297+07	\N	0	{"value": "0", "precision": 20}	\N	\N	\N	\N
orditem_01KQVHXMXNDX1N42DN1JXFAJQR	order_01KQVHXMXKWMJ36ECST0YSMKD4	1	ordli_01KQVHXMXMWSD3F91XRQAAM3D3	1	{"value": "1", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	\N	2026-05-05 14:51:25.878+07	2026-05-05 14:51:25.878+07	\N	0	{"value": "0", "precision": 20}	\N	\N	\N	\N
\.


--
-- Data for Name: order_line_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_line_item (id, totals_id, title, subtitle, thumbnail, variant_id, product_id, product_title, product_description, product_subtitle, product_type, product_collection, product_handle, variant_sku, variant_barcode, variant_title, variant_option_values, requires_shipping, is_discountable, is_tax_inclusive, compare_at_unit_price, raw_compare_at_unit_price, unit_price, raw_unit_price, metadata, created_at, updated_at, deleted_at, is_custom_price, product_type_id, is_giftcard) FROM stdin;
ordli_01K38B662S2GB9JV4A7YRCMK9F	\N	Medusa Sweatshirt	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	variant_01K0DQNR7S1W0SBA0M5YX93AN7	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-S	\N	S	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2025-08-22 14:34:14.875+07	2025-08-22 14:34:14.875+07	\N	f	\N	f
ordli_01KN1NS64Y38PE672KNKFA3ZXM	\N	Medusa Sweatpants	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	variant_01K0DQNR7SY6H1KQXPA51E5WHC	prod_01K0DQNR60F4HVA8YYA27N3KT3	Medusa Sweatpants	Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatpants	SWEATPANTS-M	\N	M	\N	t	t	f	\N	\N	220000	{"value": "220000", "precision": 20}	{}	2026-03-31 17:07:15.105+07	2026-03-31 17:07:15.105+07	\N	f	\N	f
ordli_01KNRSCZFEV2QDMV14TR42QXY9	\N	Medusa T-Shirt	M / Black	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	\N	\N	\N	t-shirt	SHIRT-M-BLACK	\N	M / Black	\N	t	t	f	\N	\N	150000	{"value": "150000", "precision": 20}	{}	2026-04-09 16:33:01.297+07	2026-04-09 16:33:01.297+07	\N	f	\N	f
ordli_01KQVHXMXMWSD3F91XRQAAM3D3	\N	Medusa Sweatshirt	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	\N	\N	\N	sweatshirt	SWEATSHIRT-M	\N	M	\N	t	t	f	\N	\N	240000	{"value": "240000", "precision": 20}	{}	2026-05-05 14:51:25.878+07	2026-05-05 14:51:25.878+07	\N	f	\N	f
\.


--
-- Data for Name: order_line_item_adjustment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_line_item_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, created_at, updated_at, item_id, deleted_at, is_tax_inclusive, version) FROM stdin;
\.


--
-- Data for Name: order_line_item_tax_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_line_item_tax_line (id, description, tax_rate_id, code, rate, raw_rate, provider_id, created_at, updated_at, item_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_payment_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_payment_collection (order_id, payment_collection_id, id, created_at, updated_at, deleted_at) FROM stdin;
order_01K38B662RTMWSDZD5ZQKYWPT2	pay_col_01K38B5ZBK6GQS7AKVQNS5APWX	ordpay_01K38B665JAMR4KKYAGMQ5FA0T	2025-08-22 14:34:14.960616+07	2025-08-22 14:34:14.960616+07	\N
order_01KN1NS64RRTHX86HEAXAF662C	pay_col_01KN1NK68AT0T4RYEH039MET1B	ordpay_01KN1NS68RMJCAYAME9F5E0Q3V	2026-03-31 17:07:15.223824+07	2026-03-31 17:07:15.223824+07	\N
order_01KNRSCZFAKHKZ76309AYZ5TPW	pay_col_01KNRRJAW2BB5EDGRTS0TVZYFZ	ordpay_01KNRSCZKYHD4503YPAHYDBQFK	2026-04-09 16:33:01.435199+07	2026-04-09 16:33:01.435199+07	\N
order_01KQVHXMXKWMJ36ECST0YSMKD4	pay_col_01KQVHXHAZDGM3K6XZPY1A509G	ordpay_01KQVHXN0QM3H08YYN336RJKC0	2026-05-05 14:51:25.971339+07	2026-05-05 14:51:25.971339+07	\N
\.


--
-- Data for Name: order_promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_promotion (order_id, promotion_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_shipping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_shipping (id, order_id, version, shipping_method_id, created_at, updated_at, deleted_at, return_id, claim_id, exchange_id) FROM stdin;
ordspmv_01K38B662R1KSCH3BZ0YTY95E7	order_01K38B662RTMWSDZD5ZQKYWPT2	1	ordsm_01K38B662R30MT96GG0EZQ44HF	2025-08-22 14:34:14.875+07	2025-08-22 14:34:14.875+07	\N	\N	\N	\N
ordspmv_01K38B78PK82Y6JB7ASSM8EVJ5	order_01K38B662RTMWSDZD5ZQKYWPT2	2	ordsm_01K38B662R30MT96GG0EZQ44HF	2025-08-22 14:34:14.875+07	2025-08-22 14:34:14.875+07	\N	\N	\N	\N
ordspmv_01K38B7JB3E6CJ551HMYSAXG7C	order_01K38B662RTMWSDZD5ZQKYWPT2	3	ordsm_01K38B662R30MT96GG0EZQ44HF	2025-08-22 14:34:14.875+07	2025-08-22 14:34:14.875+07	\N	\N	\N	\N
ordspmv_01KN1NS64RZWWMCHHB31RTWETZ	order_01KN1NS64RRTHX86HEAXAF662C	1	ordsm_01KN1NS64RA4K15AF8K41AE8Q9	2026-03-31 17:07:15.106+07	2026-03-31 17:07:15.106+07	\N	\N	\N	\N
ordspmv_01KN1SQSF95S66T2QJPCV84ZXH	order_01KN1NS64RRTHX86HEAXAF662C	2	ordsm_01KN1NS64RA4K15AF8K41AE8Q9	2026-03-31 17:07:15.106+07	2026-03-31 17:07:15.106+07	\N	\N	\N	\N
ordspmv_01KNRSCZF94H06A4V1S5W84V0Q	order_01KNRSCZFAKHKZ76309AYZ5TPW	1	ordsm_01KNRSCZF9E3B2VGY1H3YQ9CFY	2026-04-09 16:33:01.298+07	2026-04-09 16:33:01.298+07	\N	\N	\N	\N
ordspmv_01KQVHXMXK4BMF5NX33B9QCQC9	order_01KQVHXMXKWMJ36ECST0YSMKD4	1	ordsm_01KQVHXMXKGV7D0KFZGXR72VT0	2026-05-05 14:51:25.878+07	2026-05-05 14:51:25.878+07	\N	\N	\N	\N
\.


--
-- Data for Name: order_shipping_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_shipping_method (id, name, description, amount, raw_amount, is_tax_inclusive, shipping_option_id, data, metadata, created_at, updated_at, deleted_at, is_custom_amount) FROM stdin;
ordsm_01K38B662R30MT96GG0EZQ44HF	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2025-08-22 14:34:14.875+07	2025-08-22 14:34:14.875+07	\N	f
ordsm_01KN1NS64RA4K15AF8K41AE8Q9	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2026-03-31 17:07:15.106+07	2026-03-31 17:07:15.106+07	\N	f
ordsm_01KNRSCZF9E3B2VGY1H3YQ9CFY	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2026-04-09 16:33:01.298+07	2026-04-09 16:33:01.298+07	\N	f
ordsm_01KQVHXMXKGV7D0KFZGXR72VT0	Fixed Manual	\N	50000	{"value": "50000", "precision": 20}	f	so_01K38B4T1FCQDKK7TT2MPC8DCG	{}	\N	2026-05-05 14:51:25.878+07	2026-05-05 14:51:25.878+07	\N	f
\.


--
-- Data for Name: order_shipping_method_adjustment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_shipping_method_adjustment (id, description, promotion_id, code, amount, raw_amount, provider_id, created_at, updated_at, shipping_method_id, deleted_at, version) FROM stdin;
\.


--
-- Data for Name: order_shipping_method_tax_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_shipping_method_tax_line (id, description, tax_rate_id, code, rate, raw_rate, provider_id, created_at, updated_at, shipping_method_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_summary (id, order_id, version, totals, created_at, updated_at, deleted_at) FROM stdin;
ordsum_01K38B662QH8BCMTKHSFE1MBDF	order_01K38B662RTMWSDZD5ZQKYWPT2	1	{"paid_total": 290000, "raw_paid_total": {"value": "290000", "precision": 20}, "refunded_total": 0, "accounting_total": 290000, "credit_line_total": 0, "transaction_total": 290000, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 290000, "original_order_total": 290000, "raw_accounting_total": {"value": "290000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "290000", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "290000", "precision": 20}, "raw_original_order_total": {"value": "290000", "precision": 20}}	2025-08-22 14:34:14.875+07	2025-08-22 14:34:39.851+07	\N
ordsum_01K38B78PJYJC1N0AC38VP7NP6	order_01K38B662RTMWSDZD5ZQKYWPT2	2	{"paid_total": 290000, "raw_paid_total": {"value": "290000", "precision": 20}, "refunded_total": 0, "accounting_total": 290000, "credit_line_total": 0, "transaction_total": 290000, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 290000, "original_order_total": 290000, "raw_accounting_total": {"value": "290000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "290000", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "290000", "precision": 20}, "raw_original_order_total": {"value": "290000", "precision": 20}}	2025-08-22 14:34:50.33+07	2025-08-22 14:34:50.33+07	\N
ordsum_01K38B7JB3KRVGMPCCY9N1R51R	order_01K38B662RTMWSDZD5ZQKYWPT2	3	{"paid_total": 290000, "raw_paid_total": {"value": "290000", "precision": 20}, "refunded_total": 0, "accounting_total": 290000, "credit_line_total": 0, "transaction_total": 290000, "pending_difference": 0, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 290000, "original_order_total": 290000, "raw_accounting_total": {"value": "290000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "290000", "precision": 20}, "raw_pending_difference": {"value": "0", "precision": 20}, "raw_current_order_total": {"value": "290000", "precision": 20}, "raw_original_order_total": {"value": "290000", "precision": 20}}	2025-08-22 14:35:00.201+07	2025-08-22 14:35:00.201+07	\N
ordsum_01KN1NS64QMDVEEQ0RHAXJJ0V0	order_01KN1NS64RRTHX86HEAXAF662C	1	{"paid_total": 0, "raw_paid_total": {"value": "0", "precision": 20}, "refunded_total": 0, "accounting_total": 490000, "credit_line_total": 0, "transaction_total": 0, "pending_difference": 490000, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 490000, "original_order_total": 490000, "raw_accounting_total": {"value": "490000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "0", "precision": 20}, "raw_pending_difference": {"value": "490000", "precision": 20}, "raw_current_order_total": {"value": "490000", "precision": 20}, "raw_original_order_total": {"value": "490000", "precision": 20}}	2026-03-31 17:07:15.106+07	2026-03-31 17:07:15.106+07	\N
ordsum_01KN1SQSF9SZ8CAJXVF9545PKW	order_01KN1NS64RRTHX86HEAXAF662C	2	{"paid_total": 0, "raw_paid_total": {"value": "0", "precision": 20}, "refunded_total": 0, "accounting_total": 490000, "credit_line_total": 0, "transaction_total": 0, "pending_difference": 490000, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 490000, "original_order_total": 490000, "raw_accounting_total": {"value": "490000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "0", "precision": 20}, "raw_pending_difference": {"value": "490000", "precision": 20}, "raw_current_order_total": {"value": "490000", "precision": 20}, "raw_original_order_total": {"value": "490000", "precision": 20}}	2026-03-31 18:16:23.66+07	2026-03-31 18:16:23.66+07	\N
ordsum_01KNRSCZF5YFAKTCBKR6P1AS10	order_01KNRSCZFAKHKZ76309AYZ5TPW	1	{"paid_total": 0, "raw_paid_total": {"value": "0", "precision": 20}, "refunded_total": 0, "accounting_total": 200000, "credit_line_total": 0, "transaction_total": 0, "pending_difference": 200000, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 200000, "original_order_total": 200000, "raw_accounting_total": {"value": "200000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "0", "precision": 20}, "raw_pending_difference": {"value": "200000", "precision": 20}, "raw_current_order_total": {"value": "200000", "precision": 20}, "raw_original_order_total": {"value": "200000", "precision": 20}}	2026-04-09 16:33:01.298+07	2026-04-09 16:33:01.298+07	\N
ordsum_01KQVHXMXJG0D52JKNQHVX23J2	order_01KQVHXMXKWMJ36ECST0YSMKD4	1	{"paid_total": 0, "raw_paid_total": {"value": "0", "precision": 20}, "refunded_total": 0, "accounting_total": 290000, "credit_line_total": 0, "transaction_total": 0, "pending_difference": 290000, "raw_refunded_total": {"value": "0", "precision": 20}, "current_order_total": 290000, "original_order_total": 290000, "raw_accounting_total": {"value": "290000", "precision": 20}, "raw_credit_line_total": {"value": "0", "precision": 20}, "raw_transaction_total": {"value": "0", "precision": 20}, "raw_pending_difference": {"value": "290000", "precision": 20}, "raw_current_order_total": {"value": "290000", "precision": 20}, "raw_original_order_total": {"value": "290000", "precision": 20}}	2026-05-05 14:51:25.878+07	2026-05-05 14:51:25.878+07	\N
\.


--
-- Data for Name: order_transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_transaction (id, order_id, version, amount, raw_amount, currency_code, reference, reference_id, created_at, updated_at, deleted_at, return_id, claim_id, exchange_id) FROM stdin;
ordtrx_01K38B6YE7YQ4SH301T672EPEA	order_01K38B662RTMWSDZD5ZQKYWPT2	1	290000	{"value": "290000", "precision": 20}	idr	capture	capt_01K38B6YBD1DZ246KFY5R70NQZ	2025-08-22 14:34:39.816+07	2025-08-22 14:34:39.816+07	\N	\N	\N	\N
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (id, amount, raw_amount, currency_code, provider_id, data, created_at, updated_at, deleted_at, captured_at, canceled_at, payment_collection_id, payment_session_id, metadata) FROM stdin;
pay_01K38B666YHMYFNN1XNB33B719	290000	{"value": "290000", "precision": 20}	idr	pp_system_default	{}	2025-08-22 14:34:15.006+07	2025-08-22 14:34:39.749+07	\N	2025-08-22 14:34:39.736+07	\N	pay_col_01K38B5ZBK6GQS7AKVQNS5APWX	payses_01K38B5ZCX9ZSHPP1AW6FPEAE2	\N
pay_01KN1NS69CZMF14M9Z27GDPXHD	490000	{"value": "490000", "precision": 20}	idr	pp_system_default	{}	2026-03-31 17:07:15.245+07	2026-03-31 17:07:15.245+07	\N	\N	\N	pay_col_01KN1NK68AT0T4RYEH039MET1B	payses_01KN1NK6BA88BX6P8HHBQS4VJN	\N
pay_01KNRSCZN947ESQ2G60AJR34PW	200000	{"value": "200000", "precision": 20}	idr	pp_system_default	{}	2026-04-09 16:33:01.481+07	2026-04-09 16:33:01.481+07	\N	\N	\N	pay_col_01KNRRJAW2BB5EDGRTS0TVZYFZ	payses_01KNRRQBJG3K3RX2TRMA04NM8P	\N
pay_01KQVHXN192629V2WNSYXV49C1	290000	{"value": "290000", "precision": 20}	idr	pp_system_default	{}	2026-05-05 14:51:25.993+07	2026-05-05 14:51:25.993+07	\N	\N	\N	pay_col_01KQVHXHAZDGM3K6XZPY1A509G	payses_01KQVHXHCFQ6PAVJJ9J2RY5HNZ	\N
\.


--
-- Data for Name: payment_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_collection (id, currency_code, amount, raw_amount, authorized_amount, raw_authorized_amount, captured_amount, raw_captured_amount, refunded_amount, raw_refunded_amount, created_at, updated_at, deleted_at, completed_at, status, metadata) FROM stdin;
pay_col_01K38B5ZBK6GQS7AKVQNS5APWX	idr	290000	{"value": "290000", "precision": 20}	290000	{"value": "290000", "precision": 20}	290000	{"value": "290000", "precision": 20}	0	{"value": "0", "precision": 20}	2025-08-22 14:34:07.987+07	2025-08-22 14:34:39.784+07	\N	2025-08-22 14:34:39.777+07	completed	\N
pay_col_01KN1NK68AT0T4RYEH039MET1B	idr	490000	{"value": "490000", "precision": 20}	490000	{"value": "490000", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	2026-03-31 17:03:58.602+07	2026-03-31 17:07:15.312+07	\N	\N	authorized	\N
pay_col_01KNRRJAW2BB5EDGRTS0TVZYFZ	idr	200000	{"value": "200000", "precision": 20}	200000	{"value": "200000", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	2026-04-09 16:18:28.227+07	2026-04-09 16:33:01.538+07	\N	\N	authorized	\N
pay_col_01KQVHXHAZDGM3K6XZPY1A509G	idr	290000	{"value": "290000", "precision": 20}	290000	{"value": "290000", "precision": 20}	0	{"value": "0", "precision": 20}	0	{"value": "0", "precision": 20}	2026-05-05 14:51:22.208+07	2026-05-05 14:51:26.023+07	\N	\N	authorized	\N
\.


--
-- Data for Name: payment_collection_payment_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_collection_payment_providers (payment_collection_id, payment_provider_id) FROM stdin;
\.


--
-- Data for Name: payment_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_provider (id, is_enabled, created_at, updated_at, deleted_at) FROM stdin;
pp_system_default	t	2025-07-18 10:01:30.387+07	2025-07-18 10:01:30.387+07	\N
\.


--
-- Data for Name: payment_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_session (id, currency_code, amount, raw_amount, provider_id, data, context, status, authorized_at, payment_collection_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
payses_01K38B5ZCX9ZSHPP1AW6FPEAE2	idr	290000	{"value": "290000", "precision": 20}	pp_system_default	{}	{}	authorized	2025-08-22 14:34:15.005+07	pay_col_01K38B5ZBK6GQS7AKVQNS5APWX	{}	2025-08-22 14:34:08.029+07	2025-08-22 14:34:15.007+07	\N
payses_01KN1NK6BA88BX6P8HHBQS4VJN	idr	490000	{"value": "490000", "precision": 20}	pp_system_default	{}	{"customer": {"id": "cus_01KN1GCKQN0QW3VXF1VGZQ4ND5", "email": "validation.ui.20260331.0830@example.com", "phone": "+6281234567001", "metadata": null, "addresses": [], "last_name": "Flow", "first_name": "Validation", "company_name": null, "account_holders": []}, "account_holder": {"id": "acchld_01KN1NK6ASF3Z70B7QCZ5HPAY3", "data": {}, "email": "validation.ui.20260331.0830@example.com", "metadata": null, "created_at": "2026-03-31T10:03:58.681Z", "deleted_at": null, "updated_at": "2026-03-31T10:03:58.681Z", "external_id": "cus_01KN1GCKQN0QW3VXF1VGZQ4ND5", "provider_id": "pp_system_default"}}	authorized	2026-03-31 17:07:15.24+07	pay_col_01KN1NK68AT0T4RYEH039MET1B	{}	2026-03-31 17:03:58.699+07	2026-03-31 17:07:15.246+07	\N
payses_01KNRTM92K74BDTMV5ABG9PSCA	idr	200000	{"value": "200000", "precision": 20}	pp_system_default	{}	{"customer": {"id": "cus_01KMYZB2P21PMGEBWDS6EAS3JX", "email": "mabiaura@gmail.com", "phone": "087888827718", "metadata": null, "addresses": [], "last_name": "Ura", "first_name": "Mabia", "company_name": null, "account_holders": [{"id": "acchld_01KNRRJB09ZQ8R88V39PVRQR5Z", "data": {}, "email": "mabiaura@gmail.com", "metadata": null, "created_at": "2026-04-09T09:18:28.364Z", "deleted_at": null, "updated_at": "2026-04-09T09:18:28.364Z", "external_id": "cus_01KMYZB2P21PMGEBWDS6EAS3JX", "provider_id": "pp_system_default"}]}, "account_holder": {"id": "acchld_01KNRRJB09ZQ8R88V39PVRQR5Z", "data": {}, "email": "mabiaura@gmail.com", "metadata": null, "created_at": "2026-04-09T09:18:28.364Z", "deleted_at": null, "updated_at": "2026-04-09T09:18:28.364Z", "external_id": "cus_01KMYZB2P21PMGEBWDS6EAS3JX", "provider_id": "pp_system_default"}}	pending	\N	pay_col_01KNRRJAW2BB5EDGRTS0TVZYFZ	{}	2026-04-09 16:54:29.076+07	2026-04-09 16:54:29.076+07	\N
payses_01KQVHXHCFQ6PAVJJ9J2RY5HNZ	idr	290000	{"value": "290000", "precision": 20}	pp_system_default	{}	{}	authorized	2026-05-05 14:51:25.99+07	pay_col_01KQVHXHAZDGM3K6XZPY1A509G	{}	2026-05-05 14:51:22.255+07	2026-05-05 14:51:25.993+07	\N
\.


--
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price (id, title, price_set_id, currency_code, raw_amount, rules_count, created_at, updated_at, deleted_at, price_list_id, amount, min_quantity, max_quantity, raw_min_quantity, raw_max_quantity) FROM stdin;
price_01K0DQNR38NW0F9SR0W4AFV48J	\N	pset_01K0DQNR397KW016XRAXC77EB2	usd	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR3946CYY8VVAJ992AJR	\N	pset_01K0DQNR397KW016XRAXC77EB2	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR3902T367DZWXV3F626	\N	pset_01K0DQNR397KW016XRAXC77EB2	eur	{"value": "10", "precision": 20}	1	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR3999223M0QD8DKZ98V	\N	pset_01K0DQNR393J1JRXAJM1KFWD58	usd	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR39JQ7794SK2R5EDPMH	\N	pset_01K0DQNR393J1JRXAJM1KFWD58	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR39J4AR25QBP6DYR0GD	\N	pset_01K0DQNR393J1JRXAJM1KFWD58	eur	{"value": "10", "precision": 20}	1	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9R3455K2XX65HWD2W9	\N	pset_01K0DQNR9S01R7K62BXDDGWM70	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9Q8YGCKR3A310HXKNQ	\N	pset_01K0DQNR9RFQDS8C039XSSS2FQ	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9R6GJMX4A7V6DNSF8T	\N	pset_01K0DQNR9RFQDS8C039XSSS2FQ	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9QEQQ6DH80H0RMTYGP	\N	pset_01K0DQNR9QHKWPASA05WN6GEPF	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9QJE1RAYB86GJTETWN	\N	pset_01K0DQNR9QHKWPASA05WN6GEPF	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9RD8B15PXY63HS5FE5	\N	pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9RX936HVWRT9DQV21G	\N	pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9RDAP1AH0VX8688XMD	\N	pset_01K0DQNR9R23H0ZDHTQQ6G3G50	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9R1FWJZV9GVR26BKD1	\N	pset_01K0DQNR9R23H0ZDHTQQ6G3G50	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9R8QE10PRHME0DCZ33	\N	pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9RX4E7CATQXG19T0EW	\N	pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9RWFBTQ3PEM7NDY50C	\N	pset_01K0DQNR9R7RYE16M414CDW0T7	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9RA9HPW0AFAJ7B277Z	\N	pset_01K0DQNR9R7RYE16M414CDW0T7	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9Q2SR5TFMJ39VMD486	\N	pset_01K0DQNR9QX36JXEB5JYQAHKM3	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9Q66D175WPRHND2EGP	\N	pset_01K0DQNR9QX36JXEB5JYQAHKM3	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9PXY9RDMY0T7T00JG9	\N	pset_01K0DQNR9P6KDDEBCQ4JFPF6YG	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9QR5YWBXEK7VBKMD29	\N	pset_01K0DQNR9Q4F3AQT23RVWMDMD7	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9QP3GY47FCE7VMPG44	\N	pset_01K0DQNR9Q4F3AQT23RVWMDMD7	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9QAKF6K5AV55QCPXS2	\N	pset_01K0DQNR9Q3RPKX6ES79KE0YRV	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9QZTF12KC12JQ4PTEZ	\N	pset_01K0DQNR9Q3RPKX6ES79KE0YRV	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9QF4PPTC0NRVYHHM0P	\N	pset_01K0DQNR9QYY9FA462VKZ3VC6K	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9QG9CZ0822MS2ZSYCT	\N	pset_01K0DQNR9QYY9FA462VKZ3VC6K	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9Q1THQB126XMSDR946	\N	pset_01K0DQNR9QP6RB0JSZQ09P4FHN	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9QA9EK690PS3A39FV9	\N	pset_01K0DQNR9QP6RB0JSZQ09P4FHN	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9PVPPHP7SYD4W3JZMC	\N	pset_01K0DQNR9PB3DN7FPEWR724T17	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9PT6PM7NK77XTTZ7EA	\N	pset_01K0DQNR9PB3DN7FPEWR724T17	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9PJDA9MQY3XVBV9AWX	\N	pset_01K0DQNR9Q2GT6RYB58AA208RQ	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9PBEAF2ZTY5N70EKWD	\N	pset_01K0DQNR9Q2GT6RYB58AA208RQ	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9RR3YNS91DZ04A0DCK	\N	pset_01K0DQNR9RJ93XG4FXSNA23CPF	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9R5PCNFV650MGSE0S6	\N	pset_01K0DQNR9RJ93XG4FXSNA23CPF	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9RJHND2NXQ34AJM8JY	\N	pset_01K0DQNR9R701E5WPGBDKM7064	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9R2K4FAMDSE6J9KSRZ	\N	pset_01K0DQNR9R701E5WPGBDKM7064	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9RBY5RSSVNA1G33YZC	\N	pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9RQWXST33ZSV1G0SB0	\N	pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K0DQNR9QH6KPZ693X2KC73E5	\N	pset_01K0DQNR9QZBBNVWDZY1HWABQY	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9QY5892E2YG4729K46	\N	pset_01K0DQNR9QZBBNVWDZY1HWABQY	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K33FJT4S0R2R22TB8EPBBASJ	\N	pset_01K0DQNR9QZBBNVWDZY1HWABQY	idr	{"value": "240000", "precision": 20}	0	2025-08-20 17:14:50.769141+07	2025-08-20 17:14:50.769141+07	\N	\N	240000	\N	\N	\N	\N
price_01K0DQNR9RAJGWWA08AC3EX446	\N	pset_01K0DQNR9R98D5B7VKRVY907YJ	eur	{"value": "10", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	10	\N	\N	\N	\N
price_01K0DQNR9R2592NDFZNP2W3QZ2	\N	pset_01K0DQNR9R98D5B7VKRVY907YJ	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K33FKFJFTJW8MPSPXVSGX12W	\N	pset_01K0DQNR9R98D5B7VKRVY907YJ	idr	{"value": "240000", "precision": 20}	0	2025-08-20 17:15:12.715151+07	2025-08-20 17:15:12.715151+07	\N	\N	240000	\N	\N	\N	\N
price_01K33FKZKAD3MW7V16RXJQWTEX	\N	pset_01K0DQNR9RFQDS8C039XSSS2FQ	idr	{"value": "240000", "precision": 20}	0	2025-08-20 17:15:29.124733+07	2025-08-20 17:15:29.124733+07	\N	\N	240000	\N	\N	\N	\N
price_01K33FMAG8AJNM6K1X7FS5JGGM	\N	pset_01K0DQNR9QHKWPASA05WN6GEPF	idr	{"value": "240000", "precision": 20}	0	2025-08-20 17:15:40.290489+07	2025-08-20 17:15:40.290489+07	\N	\N	240000	\N	\N	\N	\N
price_01K33FMRH71NNM0FF8M85ED0NG	\N	pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ	idr	{"value": "220000", "precision": 20}	0	2025-08-20 17:15:54.660451+07	2025-08-20 17:15:54.660451+07	\N	\N	220000	\N	\N	\N	\N
price_01K33FNHBFMRPDS2S1ASNZ9P3H	\N	pset_01K0DQNR9R23H0ZDHTQQ6G3G50	idr	{"value": "220000", "precision": 20}	0	2025-08-20 17:16:20.073383+07	2025-08-20 17:16:20.073383+07	\N	\N	220000	\N	\N	\N	\N
price_01K33FNV3R2AR24G214C9Y5W35	\N	pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ	idr	{"value": "220000", "precision": 20}	0	2025-08-20 17:16:30.06626+07	2025-08-20 17:16:30.06626+07	\N	\N	220000	\N	\N	\N	\N
price_01K33FP3BGK9HH5E8WYS2GPQVF	\N	pset_01K0DQNR9R7RYE16M414CDW0T7	idr	{"value": "220000", "precision": 20}	0	2025-08-20 17:16:38.507242+07	2025-08-20 17:16:38.507242+07	\N	\N	220000	\N	\N	\N	\N
price_01K33FPTV1W57AY00KTXW3NKBH	\N	pset_01K0DQNR9QX36JXEB5JYQAHKM3	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:17:02.555841+07	2025-08-20 17:17:02.555841+07	\N	\N	150000	\N	\N	\N	\N
price_01K0DQNR9P1QMAYHTGW4N38MQK	\N	pset_01K0DQNR9P6KDDEBCQ4JFPF6YG	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K33FQH63CSSTN9FYK4QKZ5DS	\N	pset_01K0DQNR9P6KDDEBCQ4JFPF6YG	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:17:25.438086+07	2025-08-20 17:17:25.438086+07	\N	\N	150000	\N	\N	\N	\N
price_01K33FQVA7TWT82B2JT3R0JA0T	\N	pset_01K0DQNR9Q4F3AQT23RVWMDMD7	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:17:35.809073+07	2025-08-20 17:17:35.809073+07	\N	\N	150000	\N	\N	\N	\N
price_01K33FR55KRGSACJ5CJANM5ASQ	\N	pset_01K0DQNR9Q3RPKX6ES79KE0YRV	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:17:45.90384+07	2025-08-20 17:17:45.90384+07	\N	\N	150000	\N	\N	\N	\N
price_01K33FRCQB5E661TTF35D71JVD	\N	pset_01K0DQNR9QYY9FA462VKZ3VC6K	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:17:53.634741+07	2025-08-20 17:17:53.634741+07	\N	\N	150000	\N	\N	\N	\N
price_01K33FRM63K3D3K33YZ9ZPCNQ3	\N	pset_01K0DQNR9QP6RB0JSZQ09P4FHN	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:18:01.278067+07	2025-08-20 17:18:01.278067+07	\N	\N	150000	\N	\N	\N	\N
price_01K33FRVMGQEJSF25J2FKEMGSM	\N	pset_01K0DQNR9PB3DN7FPEWR724T17	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:18:08.908934+07	2025-08-20 17:18:08.908934+07	\N	\N	150000	\N	\N	\N	\N
price_01K33FS364TMBZAFGSX8FDCTVA	\N	pset_01K0DQNR9Q2GT6RYB58AA208RQ	idr	{"value": "150000", "precision": 20}	0	2025-08-20 17:18:16.638888+07	2025-08-20 17:18:16.638888+07	\N	\N	150000	\N	\N	\N	\N
price_01K33FSDZ7A67V085GQZKKCA5X	\N	pset_01K0DQNR9RJ93XG4FXSNA23CPF	idr	{"value": "100000", "precision": 20}	0	2025-08-20 17:18:27.682599+07	2025-08-20 17:18:27.682599+07	\N	\N	100000	\N	\N	\N	\N
price_01K33FSP3NYCH8RJYH2493CEYR	\N	pset_01K0DQNR9R701E5WPGBDKM7064	idr	{"value": "100000", "precision": 20}	0	2025-08-20 17:18:36.017413+07	2025-08-20 17:18:36.017413+07	\N	\N	100000	\N	\N	\N	\N
price_01K33FSWT1GK37GNRFSXRSNSQK	\N	pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7	idr	{"value": "100000", "precision": 20}	0	2025-08-20 17:18:42.87799+07	2025-08-20 17:18:42.87799+07	\N	\N	100000	\N	\N	\N	\N
price_01K0DQNR9SF42GH9J23WZX8417	\N	pset_01K0DQNR9S01R7K62BXDDGWM70	usd	{"value": "15", "precision": 20}	0	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N	\N	15	\N	\N	\N	\N
price_01K33FT3TG3Q63M9KA292CAZRZ	\N	pset_01K0DQNR9S01R7K62BXDDGWM70	idr	{"value": "100000", "precision": 20}	0	2025-08-20 17:18:50.058744+07	2025-08-20 17:18:50.058744+07	\N	\N	100000	\N	\N	\N	\N
price_01K38B4T2K59882D4PP6WS7NHP	\N	pset_01K38B4T2MWXPRPPQW8S67AQEV	idr	{"value": "50000", "precision": 20}	0	2025-08-22 14:33:29.813+07	2025-08-22 14:33:29.813+07	\N	\N	50000	\N	\N	\N	\N
price_01K38B4T2KDS5KGSBK39AGY019	\N	pset_01K38B4T2MWXPRPPQW8S67AQEV	eur	{"value": "10", "precision": 20}	0	2025-08-22 14:33:29.814+07	2025-08-22 14:33:29.814+07	\N	\N	10	\N	\N	\N	\N
price_01K38B4T2MJH66TTDMD7VZAB7P	\N	pset_01K38B4T2MWXPRPPQW8S67AQEV	usd	{"value": "15", "precision": 20}	0	2025-08-22 14:33:29.814+07	2025-08-22 14:33:29.814+07	\N	\N	15	\N	\N	\N	\N
\.


--
-- Data for Name: price_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_list (id, status, starts_at, ends_at, rules_count, title, description, type, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: price_list_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_list_rule (id, price_list_id, created_at, updated_at, deleted_at, value, attribute) FROM stdin;
\.


--
-- Data for Name: price_preference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_preference (id, attribute, value, is_tax_inclusive, created_at, updated_at, deleted_at) FROM stdin;
prpref_01K0DQNP7EXVSASDZ7PR6B5665	currency_code	eur	f	2025-07-18 10:01:32.526+07	2025-07-18 10:01:32.526+07	\N
prpref_01K0DQNQYTP8NTQJTM20XGYTW1	currency_code	usd	f	2025-07-18 10:01:34.298+07	2025-07-18 10:01:34.298+07	\N
prpref_01K0DQNQZQBK1CEH4T8KAHW58C	region_id	reg_01K0DQNQZ1T2G2043BVM0MJB6C	f	2025-07-18 10:01:34.327+07	2025-07-18 10:01:34.327+07	\N
prpref_01K33F6QVXHBEZMCMQA5GS14VP	currency_code	idr	f	2025-08-20 17:08:15.229+07	2025-08-20 17:08:15.229+07	\N
prpref_01K33FFDYKHDYVBRKSPF9XC5AH	region_id	reg_01K33FFDX0M838JWM069761552	f	2025-08-20 17:12:59.987+07	2025-08-20 17:12:59.987+07	\N
prpref_01K33GHTQBHPHKSAM44NH3PWSR	region_id	reg_01K33GHTP2XF16W0MCZC4B3TWP	f	2025-08-20 17:31:47.179+07	2025-08-20 17:31:47.179+07	\N
\.


--
-- Data for Name: price_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_rule (id, value, priority, price_id, created_at, updated_at, deleted_at, attribute, operator) FROM stdin;
prule_01K0DQNR39418YT5HAGR83QR19	reg_01K0DQNQZ1T2G2043BVM0MJB6C	0	price_01K0DQNR3902T367DZWXV3F626	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	region_id	eq
prule_01K0DQNR395NYDAXYJE4GEQ0WN	reg_01K0DQNQZ1T2G2043BVM0MJB6C	0	price_01K0DQNR39J4AR25QBP6DYR0GD	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N	region_id	eq
\.


--
-- Data for Name: price_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_set (id, created_at, updated_at, deleted_at) FROM stdin;
pset_01K0DQNR397KW016XRAXC77EB2	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N
pset_01K0DQNR393J1JRXAJM1KFWD58	2025-07-18 10:01:34.442+07	2025-07-18 10:01:34.442+07	\N
pset_01K0DQNR9QZBBNVWDZY1HWABQY	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9R98D5B7VKRVY907YJ	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9RFQDS8C039XSSS2FQ	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9QHKWPASA05WN6GEPF	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9R23H0ZDHTQQ6G3G50	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9R7RYE16M414CDW0T7	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9QX36JXEB5JYQAHKM3	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9P6KDDEBCQ4JFPF6YG	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9Q4F3AQT23RVWMDMD7	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9Q3RPKX6ES79KE0YRV	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9QYY9FA462VKZ3VC6K	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9QP6RB0JSZQ09P4FHN	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9PB3DN7FPEWR724T17	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9Q2GT6RYB58AA208RQ	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9RJ93XG4FXSNA23CPF	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9R701E5WPGBDKM7064	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K0DQNR9S01R7K62BXDDGWM70	2025-07-18 10:01:34.649+07	2025-07-18 10:01:34.649+07	\N
pset_01K38B4T2MWXPRPPQW8S67AQEV	2025-08-22 14:33:29.813+07	2025-08-22 14:33:29.813+07	\N
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, title, handle, subtitle, description, is_giftcard, status, thumbnail, weight, length, height, width, origin_country, hs_code, mid_code, material, collection_id, type_id, discountable, external_id, created_at, updated_at, deleted_at, metadata) FROM stdin;
prod_01K0DQNR60K5B3EZJ3TNWY0X9X	Medusa T-Shirt	t-shirt	\N	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	f	published	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	400	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
prod_01K0DQNR60DXF0084R3YNQHSXJ	Medusa Sweatshirt	sweatshirt	\N	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	f	published	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	400	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
prod_01K0DQNR60F4HVA8YYA27N3KT3	Medusa Sweatpants	sweatpants	\N	Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.	f	published	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	400	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
prod_01K0DQNR60MNDVFQQ4PNFTPRC9	Medusa Shorts	shorts	\N	Reimagine the feeling of classic shorts. With our cotton shorts, everyday essentials no longer have to be ordinary.	f	published	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png	400	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_category (id, name, description, handle, mpath, is_active, is_internal, rank, parent_category_id, created_at, updated_at, deleted_at, metadata, external_id) FROM stdin;
pcat_01K0DQNR5SWNZRS3R0NNWP9561	Shirts		shirts	pcat_01K0DQNR5SWNZRS3R0NNWP9561	t	f	0	\N	2025-07-18 10:01:34.522+07	2025-07-18 10:01:34.522+07	\N	\N	\N
pcat_01K0DQNR5S1ARSS9BR6ZDAZ0N3	Sweatshirts		sweatshirts	pcat_01K0DQNR5S1ARSS9BR6ZDAZ0N3	t	f	1	\N	2025-07-18 10:01:34.522+07	2025-07-18 10:01:34.522+07	\N	\N	\N
pcat_01K0DQNR5S0X1YGF3PN5G9N9N7	Pants		pants	pcat_01K0DQNR5S0X1YGF3PN5G9N9N7	t	f	2	\N	2025-07-18 10:01:34.522+07	2025-07-18 10:01:34.522+07	\N	\N	\N
pcat_01K0DQNR5TDE9XRGST6V35MJ0W	Merch		merch	pcat_01K0DQNR5TDE9XRGST6V35MJ0W	t	f	3	\N	2025-07-18 10:01:34.522+07	2025-07-18 10:01:34.522+07	\N	\N	\N
\.


--
-- Data for Name: product_category_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_category_product (product_id, product_category_id) FROM stdin;
prod_01K0DQNR60K5B3EZJ3TNWY0X9X	pcat_01K0DQNR5SWNZRS3R0NNWP9561
prod_01K0DQNR60DXF0084R3YNQHSXJ	pcat_01K0DQNR5S1ARSS9BR6ZDAZ0N3
prod_01K0DQNR60F4HVA8YYA27N3KT3	pcat_01K0DQNR5S0X1YGF3PN5G9N9N7
prod_01K0DQNR60MNDVFQQ4PNFTPRC9	pcat_01K0DQNR5TDE9XRGST6V35MJ0W
\.


--
-- Data for Name: product_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_collection (id, title, handle, metadata, created_at, updated_at, deleted_at, external_id) FROM stdin;
\.


--
-- Data for Name: product_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_option (id, title, metadata, created_at, updated_at, deleted_at, is_exclusive) FROM stdin;
opt_01K0DQNR62FFWPFSZPMWPB048H	Size	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	t
opt_01K0DQNR62RZVNSQS1ZZETWPFE	Color	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	t
opt_01K0DQNR62WSNB29SRBMND3ASZ	Size	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	t
opt_01K0DQNR63S22AR74XGE3G7113	Size	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	t
opt_01K0DQNR63721YM6DBEB7FXXXG	Size	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	t
\.


--
-- Data for Name: product_option_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_option_value (id, value, option_id, metadata, created_at, updated_at, deleted_at, rank) FROM stdin;
optval_01K0DQNR61MBCEJ06217PV869R	S	opt_01K0DQNR62FFWPFSZPMWPB048H	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR61M5K7NW3KBQFVTNSH	M	opt_01K0DQNR62FFWPFSZPMWPB048H	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR61MC4Y4SQ8ASSWNYXM	L	opt_01K0DQNR62FFWPFSZPMWPB048H	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR61EKY8M709Q6HKJQVE	XL	opt_01K0DQNR62FFWPFSZPMWPB048H	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR62F93H3Y49C9THZEPF	Black	opt_01K0DQNR62RZVNSQS1ZZETWPFE	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR62SPCYRJPS4FBWJB8G	White	opt_01K0DQNR62RZVNSQS1ZZETWPFE	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR62R9NMQKY0FHCC488K	S	opt_01K0DQNR62WSNB29SRBMND3ASZ	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR62BWG0RHNMG4JNP0RC	M	opt_01K0DQNR62WSNB29SRBMND3ASZ	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR62PMGDWDTN3S64XMRV	L	opt_01K0DQNR62WSNB29SRBMND3ASZ	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR62BTE0T4SB4GRGN9EM	XL	opt_01K0DQNR62WSNB29SRBMND3ASZ	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR6374H1R8Y5N250F743	S	opt_01K0DQNR63S22AR74XGE3G7113	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR63Y009YDMZ7KWZ7HMV	M	opt_01K0DQNR63S22AR74XGE3G7113	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR63Y5V9W3SBXXTWW10F	L	opt_01K0DQNR63S22AR74XGE3G7113	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR63BSQFGQ921ZDVYYEX	XL	opt_01K0DQNR63S22AR74XGE3G7113	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR63PPE50V57DFKG5Q7C	S	opt_01K0DQNR63721YM6DBEB7FXXXG	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR63AC9YA33PXQK2YZQX	M	opt_01K0DQNR63721YM6DBEB7FXXXG	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR63HSKXHNBC3KFHBD4Q	L	opt_01K0DQNR63721YM6DBEB7FXXXG	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
optval_01K0DQNR63PJJBX7ZNHRQVM784	XL	opt_01K0DQNR63721YM6DBEB7FXXXG	\N	2025-07-18 10:01:34.532+07	2025-07-18 10:01:34.532+07	\N	\N
\.


--
-- Data for Name: product_product_brand_brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_product_brand_brand (product_id, brand_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: product_product_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_product_option (id, product_id, product_option_id, created_at, updated_at, deleted_at) FROM stdin;
prodopt_01KWTVPJGVKY1EJVG1KWY3FHKY	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	opt_01K0DQNR62FFWPFSZPMWPB048H	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodopt_01KWTVPJGVNVEE84TS31X73BFZ	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	opt_01K0DQNR62RZVNSQS1ZZETWPFE	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodopt_01KWTVPJGVQ7TJH39DW8A2TCGE	prod_01K0DQNR60DXF0084R3YNQHSXJ	opt_01K0DQNR62WSNB29SRBMND3ASZ	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodopt_01KWTVPJGV55VTN7GGVK7PKK3B	prod_01K0DQNR60F4HVA8YYA27N3KT3	opt_01K0DQNR63S22AR74XGE3G7113	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodopt_01KWTVPJGVKVMM5MKZD9WKAK0D	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	opt_01K0DQNR63721YM6DBEB7FXXXG	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
\.


--
-- Data for Name: product_product_option_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_product_option_value (id, product_product_option_id, product_option_value_id, created_at, updated_at, deleted_at) FROM stdin;
prodoptval_01KWTVPJGZPCBHM81KYGHW4HPZ	prodopt_01KWTVPJGVKY1EJVG1KWY3FHKY	optval_01K0DQNR61MBCEJ06217PV869R	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZYPJ3H4566Q9XF2RT	prodopt_01KWTVPJGVKY1EJVG1KWY3FHKY	optval_01K0DQNR61M5K7NW3KBQFVTNSH	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZV12YN173RSA4YMG5	prodopt_01KWTVPJGVKY1EJVG1KWY3FHKY	optval_01K0DQNR61MC4Y4SQ8ASSWNYXM	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZZTJ5ADRZ78ZJBS4E	prodopt_01KWTVPJGVKY1EJVG1KWY3FHKY	optval_01K0DQNR61EKY8M709Q6HKJQVE	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZFCQJKQT2PNWGVS26	prodopt_01KWTVPJGVNVEE84TS31X73BFZ	optval_01K0DQNR62F93H3Y49C9THZEPF	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZ1415CVE49TYEAR0N	prodopt_01KWTVPJGVNVEE84TS31X73BFZ	optval_01K0DQNR62SPCYRJPS4FBWJB8G	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZ5Q98HP18GF2Z8S0S	prodopt_01KWTVPJGVQ7TJH39DW8A2TCGE	optval_01K0DQNR62R9NMQKY0FHCC488K	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZJDJ7B9F7RR56XGAY	prodopt_01KWTVPJGVQ7TJH39DW8A2TCGE	optval_01K0DQNR62BWG0RHNMG4JNP0RC	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZZ5CJRDKPTC3GNKJ7	prodopt_01KWTVPJGVQ7TJH39DW8A2TCGE	optval_01K0DQNR62PMGDWDTN3S64XMRV	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZDN76HWZ4SA1MZ65K	prodopt_01KWTVPJGVQ7TJH39DW8A2TCGE	optval_01K0DQNR62BTE0T4SB4GRGN9EM	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZCBC3SZWPR3ATRKTW	prodopt_01KWTVPJGV55VTN7GGVK7PKK3B	optval_01K0DQNR6374H1R8Y5N250F743	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZBFA6Z19Q884Z97AD	prodopt_01KWTVPJGV55VTN7GGVK7PKK3B	optval_01K0DQNR63Y009YDMZ7KWZ7HMV	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZXZ4VJR5YHQ7S0PJ6	prodopt_01KWTVPJGV55VTN7GGVK7PKK3B	optval_01K0DQNR63Y5V9W3SBXXTWW10F	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZ4V4JQ6BTH4DBE01F	prodopt_01KWTVPJGV55VTN7GGVK7PKK3B	optval_01K0DQNR63BSQFGQ921ZDVYYEX	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZPG7ADZVWNJFWXDAA	prodopt_01KWTVPJGVKVMM5MKZD9WKAK0D	optval_01K0DQNR63PPE50V57DFKG5Q7C	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZAC7FAN6G22MYCXZT	prodopt_01KWTVPJGVKVMM5MKZD9WKAK0D	optval_01K0DQNR63AC9YA33PXQK2YZQX	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZ1J0YTRFJXES7VW46	prodopt_01KWTVPJGVKVMM5MKZD9WKAK0D	optval_01K0DQNR63HSKXHNBC3KFHBD4Q	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
prodoptval_01KWTVPJGZH0E46F9YSH5BFVHJ	prodopt_01KWTVPJGVKVMM5MKZD9WKAK0D	optval_01K0DQNR63PJJBX7ZNHRQVM784	2026-07-06 11:41:31.035959+07	2026-07-06 11:41:31.035959+07	\N
\.


--
-- Data for Name: product_sales_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_sales_channel (product_id, sales_channel_id, id, created_at, updated_at, deleted_at) FROM stdin;
prod_01K0DQNR60K5B3EZJ3TNWY0X9X	sc_01K0DQNP6KWXP3R7NJGNA411PQ	prodsc_01K0DQNR6SP8B247BSJDK3KDX7	2025-07-18 10:01:34.553046+07	2025-07-18 10:01:34.553046+07	\N
prod_01K0DQNR60DXF0084R3YNQHSXJ	sc_01K0DQNP6KWXP3R7NJGNA411PQ	prodsc_01K0DQNR6S6EVNDC8726M55DNK	2025-07-18 10:01:34.553046+07	2025-07-18 10:01:34.553046+07	\N
prod_01K0DQNR60F4HVA8YYA27N3KT3	sc_01K0DQNP6KWXP3R7NJGNA411PQ	prodsc_01K0DQNR6TRWVF6TTXFQVHK44A	2025-07-18 10:01:34.553046+07	2025-07-18 10:01:34.553046+07	\N
prod_01K0DQNR60MNDVFQQ4PNFTPRC9	sc_01K0DQNP6KWXP3R7NJGNA411PQ	prodsc_01K0DQNR6TJBZJ1605526CAPEW	2025-07-18 10:01:34.553046+07	2025-07-18 10:01:34.553046+07	\N
prod_01K0DQNR60DXF0084R3YNQHSXJ	sc_01K33F08EMQCJXWNZK1HWXHBHR	prodsc_01K33F120GRXA7X41K1KW7N7RB	2025-08-20 17:05:09.001908+07	2025-08-20 17:05:09.001908+07	\N
prod_01K0DQNR60F4HVA8YYA27N3KT3	sc_01K33F0SW4Y9DSZQ933X15TGQ6	prodsc_01K33F19TYRXX69B921GYKKXKK	2025-08-20 17:05:17.017037+07	2025-08-20 17:05:17.017037+07	\N
prod_01K0DQNR60F4HVA8YYA27N3KT3	sc_01K33F08EMQCJXWNZK1HWXHBHR	prodsc_01K33G7KZTVAHR5MDNCR1PZGH1	2025-08-20 17:26:12.613069+07	2025-08-20 17:26:12.613069+07	\N
prod_01K0DQNR60K5B3EZJ3TNWY0X9X	sc_01K33F08EMQCJXWNZK1HWXHBHR	prodsc_01K33G7KZVH8VG81W5FHFT04CE	2025-08-20 17:26:12.613069+07	2025-08-20 17:26:12.613069+07	\N
prod_01K0DQNR60MNDVFQQ4PNFTPRC9	sc_01K33F08EMQCJXWNZK1HWXHBHR	prodsc_01K33G7KZV0M938S8CRKDQT96Z	2025-08-20 17:26:12.613069+07	2025-08-20 17:26:12.613069+07	\N
prod_01K0DQNR60DXF0084R3YNQHSXJ	sc_01K33F0SW4Y9DSZQ933X15TGQ6	prodsc_01K33G7YVK01529Y7G1YQ9VZ3W	2025-08-20 17:26:23.741652+07	2025-08-20 17:26:23.741652+07	\N
prod_01K0DQNR60K5B3EZJ3TNWY0X9X	sc_01K33F0SW4Y9DSZQ933X15TGQ6	prodsc_01K33G7YVKVJR8AZDYZKFT74J4	2025-08-20 17:26:23.741652+07	2025-08-20 17:26:23.741652+07	\N
prod_01K0DQNR60MNDVFQQ4PNFTPRC9	sc_01K33F0SW4Y9DSZQ933X15TGQ6	prodsc_01K33G7YVK4NPNAXQWP53HZKRP	2025-08-20 17:26:23.741652+07	2025-08-20 17:26:23.741652+07	\N
\.


--
-- Data for Name: product_shipping_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_shipping_profile (product_id, shipping_profile_id, id, created_at, updated_at, deleted_at) FROM stdin;
prod_01K0DQNR60K5B3EZJ3TNWY0X9X	sp_01K0DQNMKKYJED57XQD63HVRN1	prodsp_01K0DQNR74946PN0YE8FGPVQKR	2025-07-18 10:01:34.564362+07	2025-07-18 10:01:34.564362+07	\N
prod_01K0DQNR60DXF0084R3YNQHSXJ	sp_01K0DQNMKKYJED57XQD63HVRN1	prodsp_01K0DQNR754XKCCAS477H1Y301	2025-07-18 10:01:34.564362+07	2025-07-18 10:01:34.564362+07	\N
prod_01K0DQNR60F4HVA8YYA27N3KT3	sp_01K0DQNMKKYJED57XQD63HVRN1	prodsp_01K0DQNR751Y0P8KZ5QSWSXSMJ	2025-07-18 10:01:34.564362+07	2025-07-18 10:01:34.564362+07	\N
prod_01K0DQNR60MNDVFQQ4PNFTPRC9	sp_01K0DQNMKKYJED57XQD63HVRN1	prodsp_01K0DQNR754V75M68AE8V1SZ41	2025-07-18 10:01:34.564362+07	2025-07-18 10:01:34.564362+07	\N
\.


--
-- Data for Name: product_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tag (id, value, metadata, created_at, updated_at, deleted_at, external_id) FROM stdin;
\.


--
-- Data for Name: product_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tags (product_id, product_tag_id) FROM stdin;
\.


--
-- Data for Name: product_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_type (id, value, metadata, created_at, updated_at, deleted_at, external_id) FROM stdin;
\.


--
-- Data for Name: product_variant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant (id, title, sku, barcode, ean, upc, allow_backorder, manage_inventory, hs_code, origin_country, mid_code, material, weight, length, height, width, metadata, variant_rank, product_id, created_at, updated_at, deleted_at, thumbnail) FROM stdin;
variant_01K0DQNR7S1W0SBA0M5YX93AN7	S	SWEATSHIRT-S	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60DXF0084R3YNQHSXJ	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7SCSPGJ6FPVG45BX2W	XL	SWEATSHIRT-XL	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60DXF0084R3YNQHSXJ	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7SMT3TSXEX9WAF456Z	L	SWEATSHIRT-L	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60DXF0084R3YNQHSXJ	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	M	SWEATSHIRT-M	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60DXF0084R3YNQHSXJ	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7S4RDJNS5DE6GA5EVW	S	SWEATPANTS-S	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60F4HVA8YYA27N3KT3	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7S4W9GH3SK0YFR9FR4	L	SWEATPANTS-L	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60F4HVA8YYA27N3KT3	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7S5A4N59KAKT2NCT7H	XL	SWEATPANTS-XL	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60F4HVA8YYA27N3KT3	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7SY6H1KQXPA51E5WHC	M	SWEATPANTS-M	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60F4HVA8YYA27N3KT3	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7R4N5Z66HZ6MXSHTRT	XL / Black	SHIRT-XL-BLACK	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7R7M74ES9DA7NHJFDD	S / Black	SHIRT-S-BLACK	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.585+07	2025-07-18 10:01:34.585+07	\N	\N
variant_01K0DQNR7RHARRCMGM22HSK8PB	M / White	SHIRT-M-WHITE	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7RPMB10TTHA20NJQSN	L / Black	SHIRT-L-BLACK	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7RTYF6JFCGDG5B7HEG	L / White	SHIRT-L-WHITE	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7RWSBGA25N2V40BB83	XL / White	SHIRT-XL-WHITE	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7RXATE0YPVEQBRZB67	S / White	SHIRT-S-WHITE	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	M / Black	SHIRT-M-BLACK	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60K5B3EZJ3TNWY0X9X	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7S19WE18DFGYT0645D	M	SHORTS-M	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7S8N8KE6BVGYRFWE5H	L	SHORTS-L	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7SC08ZVVMA3CXF0RG4	S	SHORTS-S	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
variant_01K0DQNR7SFMX3AQS9EB79MFW8	XL	SHORTS-XL	\N	\N	\N	f	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	prod_01K0DQNR60MNDVFQQ4PNFTPRC9	2025-07-18 10:01:34.586+07	2025-07-18 10:01:34.586+07	\N	\N
\.


--
-- Data for Name: product_variant_inventory_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant_inventory_item (variant_id, inventory_item_id, id, required_quantity, created_at, updated_at, deleted_at) FROM stdin;
variant_01K0DQNR7R7M74ES9DA7NHJFDD	iitem_01K0DQNR8HZ8V16J0A12QJSX3Z	pvitem_01K0DQNR99568M8DGGM29KVXBC	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7RXATE0YPVEQBRZB67	iitem_01K0DQNR8HZ7HZQE4EJXYX2P0Z	pvitem_01K0DQNR9AZXH8YKMG3DN1CX00	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	iitem_01K0DQNR8H6FMW591ZAWE8CC6V	pvitem_01K0DQNR9AHXBR8KRWHNKSQP8X	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7RHARRCMGM22HSK8PB	iitem_01K0DQNR8HN7FREQ43S7HR4XBJ	pvitem_01K0DQNR9AM0KJRQ06VR3HHTBD	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7RPMB10TTHA20NJQSN	iitem_01K0DQNR8H7TSKNZPDMT9H5CDA	pvitem_01K0DQNR9AR5T1TDEY1Q6JJNEQ	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7RTYF6JFCGDG5B7HEG	iitem_01K0DQNR8HQ5N14ZPE16W32M8A	pvitem_01K0DQNR9A3PPQXMEC8588066K	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7R4N5Z66HZ6MXSHTRT	iitem_01K0DQNR8HDEG38Z3SSC6BTDP2	pvitem_01K0DQNR9AC4E1QV5X631Y8G3N	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7RWSBGA25N2V40BB83	iitem_01K0DQNR8HE0X6CWCZTX7XPJ2T	pvitem_01K0DQNR9ABGAHFGCS0MJAKPNR	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7S1W0SBA0M5YX93AN7	iitem_01K0DQNR8HDKZFXMZW258EV36W	pvitem_01K0DQNR9AVE14PE672TBDMDXE	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	iitem_01K0DQNR8HR59HTB6ERH8DZASY	pvitem_01K0DQNR9ARNWN9K9RC2W0G9SP	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7SMT3TSXEX9WAF456Z	iitem_01K0DQNR8HHMNTR22RZE0C3VDE	pvitem_01K0DQNR9ASJZZSBDJFN7W5VE5	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7SCSPGJ6FPVG45BX2W	iitem_01K0DQNR8HCW3R7GGK1AAXQRZ6	pvitem_01K0DQNR9AA8XXXXRKP672NBX7	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7S4RDJNS5DE6GA5EVW	iitem_01K0DQNR8HEP3A6M8P8RVFT5JG	pvitem_01K0DQNR9AB0DHP9TB0EKPZ0KE	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7SY6H1KQXPA51E5WHC	iitem_01K0DQNR8HKWFJWJVHX5SWTADW	pvitem_01K0DQNR9AP34SVK7TZJ82EY58	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7S4W9GH3SK0YFR9FR4	iitem_01K0DQNR8HNDAVZP18NAD0E3XJ	pvitem_01K0DQNR9AVXDQX588KT5Y1SHE	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7S5A4N59KAKT2NCT7H	iitem_01K0DQNR8H473MMSD7EKP3MQK6	pvitem_01K0DQNR9AQPS7V9PB21N2DDFJ	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7SC08ZVVMA3CXF0RG4	iitem_01K0DQNR8J7722RFA36MATZMYN	pvitem_01K0DQNR9A8VM0PSWB1M0X06ZN	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7S19WE18DFGYT0645D	iitem_01K0DQNR8J4CA4D5ADAH6ANXQS	pvitem_01K0DQNR9AT85EP06BYFB0W51Y	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7S8N8KE6BVGYRFWE5H	iitem_01K0DQNR8JXCP0JAGSG543T09G	pvitem_01K0DQNR9ABSA0Y9DFW90HEJT3	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
variant_01K0DQNR7SFMX3AQS9EB79MFW8	iitem_01K0DQNR8J8DJWWBSQX1CNYN0T	pvitem_01K0DQNR9AZ6XW3Z514N19NSNV	1	2025-07-18 10:01:34.633299+07	2025-07-18 10:01:34.633299+07	\N
\.


--
-- Data for Name: product_variant_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant_option (variant_id, option_value_id) FROM stdin;
variant_01K0DQNR7R7M74ES9DA7NHJFDD	optval_01K0DQNR61MBCEJ06217PV869R
variant_01K0DQNR7R7M74ES9DA7NHJFDD	optval_01K0DQNR62F93H3Y49C9THZEPF
variant_01K0DQNR7RXATE0YPVEQBRZB67	optval_01K0DQNR61MBCEJ06217PV869R
variant_01K0DQNR7RXATE0YPVEQBRZB67	optval_01K0DQNR62SPCYRJPS4FBWJB8G
variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	optval_01K0DQNR61M5K7NW3KBQFVTNSH
variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	optval_01K0DQNR62F93H3Y49C9THZEPF
variant_01K0DQNR7RHARRCMGM22HSK8PB	optval_01K0DQNR61M5K7NW3KBQFVTNSH
variant_01K0DQNR7RHARRCMGM22HSK8PB	optval_01K0DQNR62SPCYRJPS4FBWJB8G
variant_01K0DQNR7RPMB10TTHA20NJQSN	optval_01K0DQNR61MC4Y4SQ8ASSWNYXM
variant_01K0DQNR7RPMB10TTHA20NJQSN	optval_01K0DQNR62F93H3Y49C9THZEPF
variant_01K0DQNR7RTYF6JFCGDG5B7HEG	optval_01K0DQNR61MC4Y4SQ8ASSWNYXM
variant_01K0DQNR7RTYF6JFCGDG5B7HEG	optval_01K0DQNR62SPCYRJPS4FBWJB8G
variant_01K0DQNR7R4N5Z66HZ6MXSHTRT	optval_01K0DQNR61EKY8M709Q6HKJQVE
variant_01K0DQNR7R4N5Z66HZ6MXSHTRT	optval_01K0DQNR62F93H3Y49C9THZEPF
variant_01K0DQNR7RWSBGA25N2V40BB83	optval_01K0DQNR61EKY8M709Q6HKJQVE
variant_01K0DQNR7RWSBGA25N2V40BB83	optval_01K0DQNR62SPCYRJPS4FBWJB8G
variant_01K0DQNR7S1W0SBA0M5YX93AN7	optval_01K0DQNR62R9NMQKY0FHCC488K
variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	optval_01K0DQNR62BWG0RHNMG4JNP0RC
variant_01K0DQNR7SMT3TSXEX9WAF456Z	optval_01K0DQNR62PMGDWDTN3S64XMRV
variant_01K0DQNR7SCSPGJ6FPVG45BX2W	optval_01K0DQNR62BTE0T4SB4GRGN9EM
variant_01K0DQNR7S4RDJNS5DE6GA5EVW	optval_01K0DQNR6374H1R8Y5N250F743
variant_01K0DQNR7SY6H1KQXPA51E5WHC	optval_01K0DQNR63Y009YDMZ7KWZ7HMV
variant_01K0DQNR7S4W9GH3SK0YFR9FR4	optval_01K0DQNR63Y5V9W3SBXXTWW10F
variant_01K0DQNR7S5A4N59KAKT2NCT7H	optval_01K0DQNR63BSQFGQ921ZDVYYEX
variant_01K0DQNR7SC08ZVVMA3CXF0RG4	optval_01K0DQNR63PPE50V57DFKG5Q7C
variant_01K0DQNR7S19WE18DFGYT0645D	optval_01K0DQNR63AC9YA33PXQK2YZQX
variant_01K0DQNR7S8N8KE6BVGYRFWE5H	optval_01K0DQNR63HSKXHNBC3KFHBD4Q
variant_01K0DQNR7SFMX3AQS9EB79MFW8	optval_01K0DQNR63PJJBX7ZNHRQVM784
\.


--
-- Data for Name: product_variant_price_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant_price_set (variant_id, price_set_id, id, created_at, updated_at, deleted_at) FROM stdin;
variant_01K0DQNR7R7M74ES9DA7NHJFDD	pset_01K0DQNR9P6KDDEBCQ4JFPF6YG	pvps_01K0DQNRAK69N2F2WX9S5S81C6	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7RXATE0YPVEQBRZB67	pset_01K0DQNR9PB3DN7FPEWR724T17	pvps_01K0DQNRAKNZRGZZXGP5A6G43Z	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7RY5Y9QZF2Q5X7XKPT	pset_01K0DQNR9Q2GT6RYB58AA208RQ	pvps_01K0DQNRAKZ261DW37RAJ4ZZMQ	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7RHARRCMGM22HSK8PB	pset_01K0DQNR9Q4F3AQT23RVWMDMD7	pvps_01K0DQNRAKB7RBJ7AN901DMGQE	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7RPMB10TTHA20NJQSN	pset_01K0DQNR9Q3RPKX6ES79KE0YRV	pvps_01K0DQNRAKGJBS40FEYA0CGSN1	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7RTYF6JFCGDG5B7HEG	pset_01K0DQNR9QYY9FA462VKZ3VC6K	pvps_01K0DQNRAK1C5QXTXECNHTPR2B	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7R4N5Z66HZ6MXSHTRT	pset_01K0DQNR9QX36JXEB5JYQAHKM3	pvps_01K0DQNRAKETRK0AM92TQNSKD6	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7RWSBGA25N2V40BB83	pset_01K0DQNR9QP6RB0JSZQ09P4FHN	pvps_01K0DQNRAK40DKXRQVGSCS9DG0	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7S1W0SBA0M5YX93AN7	pset_01K0DQNR9QZBBNVWDZY1HWABQY	pvps_01K0DQNRAKZNR31FGKR1FWFWB7	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7SZ25W1AQVFGYCJTDQ	pset_01K0DQNR9QHKWPASA05WN6GEPF	pvps_01K0DQNRAK6Z36GNM2WQG6V23F	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7SMT3TSXEX9WAF456Z	pset_01K0DQNR9RFQDS8C039XSSS2FQ	pvps_01K0DQNRAKW9BPPTYKHZ26EFVW	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7SCSPGJ6FPVG45BX2W	pset_01K0DQNR9R98D5B7VKRVY907YJ	pvps_01K0DQNRAK502MWPE122FSHBM7	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7S4RDJNS5DE6GA5EVW	pset_01K0DQNR9RZ1GSP8FJNJTF1TCQ	pvps_01K0DQNRAK82EP89FXCKG2J4R0	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7SY6H1KQXPA51E5WHC	pset_01K0DQNR9R7RYE16M414CDW0T7	pvps_01K0DQNRAKQNMGB6QWDMQGKN80	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7S4W9GH3SK0YFR9FR4	pset_01K0DQNR9R23H0ZDHTQQ6G3G50	pvps_01K0DQNRAK1XGHVRR62ZB417FT	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7S5A4N59KAKT2NCT7H	pset_01K0DQNR9RZVKXQCWA0A9ZFCKJ	pvps_01K0DQNRAMDGTR0H7C7R6FNXJG	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7SC08ZVVMA3CXF0RG4	pset_01K0DQNR9R3ZYDYE4V6Q9PYQM7	pvps_01K0DQNRAM90PFX88TZJQSYZ43	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7S19WE18DFGYT0645D	pset_01K0DQNR9RJ93XG4FXSNA23CPF	pvps_01K0DQNRAMYSYX2D2Q98VR9T1T	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7S8N8KE6BVGYRFWE5H	pset_01K0DQNR9R701E5WPGBDKM7064	pvps_01K0DQNRAMRXCECNMQB7DC54DC	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
variant_01K0DQNR7SFMX3AQS9EB79MFW8	pset_01K0DQNR9S01R7K62BXDDGWM70	pvps_01K0DQNRAMA385G7RZES8WHDXC	2025-07-18 10:01:34.674626+07	2025-07-18 10:01:34.674626+07	\N
\.


--
-- Data for Name: product_variant_product_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant_product_image (id, variant_id, image_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion (id, code, campaign_id, is_automatic, type, created_at, updated_at, deleted_at, status, is_tax_inclusive, "limit", used, metadata) FROM stdin;
\.


--
-- Data for Name: promotion_application_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_application_method (id, value, raw_value, max_quantity, apply_to_quantity, buy_rules_min_quantity, type, target_type, allocation, promotion_id, created_at, updated_at, deleted_at, currency_code) FROM stdin;
\.


--
-- Data for Name: promotion_campaign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_campaign (id, name, description, campaign_identifier, starts_at, ends_at, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion_campaign_budget; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_campaign_budget (id, type, campaign_id, "limit", raw_limit, used, raw_used, created_at, updated_at, deleted_at, currency_code, attribute) FROM stdin;
\.


--
-- Data for Name: promotion_campaign_budget_usage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_campaign_budget_usage (id, attribute_value, used, budget_id, raw_used, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion_promotion_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_promotion_rule (promotion_id, promotion_rule_id) FROM stdin;
\.


--
-- Data for Name: promotion_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_rule (id, description, attribute, operator, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: promotion_rule_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_rule_value (id, promotion_rule_id, value, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: property_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.property_label (id, entity, property, label, description, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: provider_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_identity (id, entity_id, provider, auth_identity_id, user_metadata, provider_metadata, created_at, updated_at, deleted_at) FROM stdin;
01K0DQTQB91YFWT37KPMC7WKMT	radenadriep@gmail.com	emailpass	authid_01K0DQTQBAP2VATK818YG970GH	\N	{"password": "c2NyeXB0AA8AAAAIAAAAASi22pfmPC2l9V+yEFdVI53RjRElRe9b0IoEVqd2eznyHDgxyS6rcGRMlykpMeMlbcZWMR7aA2yaOF/cqwyTkA1TRbHM/iRWoR1OkrSxCsn8"}	2025-07-18 10:04:17.514+07	2025-07-18 10:04:17.514+07	\N
01KMV75BJXMESEF1WV4YVH4XQ9	babadook@test.com	emailpass	authid_01KMV75BJYCPNP4S9AWE2STR7Y	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAez+u2MIIqpWyYfOaekY58zerYKT4uC698lcVAfQujWJF3XCBHsYOa0R6FTksq3758ayRJDVzTkKL0S9NBJJJSj9WvYewW65eqjGiqiGiHL+"}	2026-03-29 04:56:18.655+07	2026-03-29 04:56:18.655+07	\N
01KMV7REPGYDYXNWEQXHSP8R4S	banawahana@test.com	emailpass	authid_01KMV7REPHSQBXHFJWRVYBR7FZ	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAeVEthAwWRjjClA1z4pEeYEwKd60NKWc8N9F/XuTxibJJUCYw8K5JAD1iTVt0ZxMaTMdElmFQ1hB6Pk2nJ5aCj9Wv2ccGZghyXhxinSRjmQ2"}	2026-03-29 05:06:44.433+07	2026-03-29 05:06:58.733+07	\N
01KMV7SRAPZ1GJYS9KRT62QZF8	wanabahana@gmail.com	emailpass	authid_01KMV7SRAP83TMH3SHJVVFFQD5	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAfFCi3413ph/MEeER56zyorQEKr6wkQuaCe6h3uqTYcv+0yog94ei8chb21k5e/B3pBfCYx29lJBqJkZY4fpsAbbpbRs6hOfbLbNwK7fJw2j"}	2026-03-29 05:07:27.063+07	2026-03-29 05:07:27.063+07	\N
01KMV7YXMZKV5KQCKF84XKEEHY	banawahana@gmail.com	emailpass	authid_01KMV7YXN05W9PE6YWMX6FWR89	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAcRW3qL9Uiag/dl/Gs6TbwkN93C8A6UIEtin/z/ZbhAYll4jukAAOOEpDJII0TWnYKr0kglqBHwdy4oajSuw4Vk1+ZHDERHilpJzPlct3cSj"}	2026-03-29 05:10:16.352+07	2026-03-29 05:10:29.508+07	\N
01KMV80KGH9B6B6F0JGFTF0RAH	asfada@gmail.com	emailpass	authid_01KMV80KGHGQQKYYSM2BN46ZHD	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAbr5jgEb2PoJOUhZtQfGyYHlozyojhRZZmICzj6j/cS6li/PaWBBxXcjFh3wbm+fdXA1a4YFdxYky+YzEz7R660HyXH5d4UClXOMSqxo0T7M"}	2026-03-29 05:11:11.505+07	2026-03-29 05:11:11.505+07	\N
01KMWXVTE7H9GBPRZ2EYAGAY55	jonahill@gmail.com	emailpass	authid_01KMWXVTE8A6C856T8W42H83GQ	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAfRlCssxF83gRqsk5FmN0U/Y5E26OIJayDTeNynORIp7qO1VJs0DW2Qs8j5BdffHla0yA2RLIgZYwcqizl5KSCzVXmlESAeIM3w8cRFhbvEY"}	2026-03-29 20:52:17.865+07	2026-03-29 20:52:17.865+07	\N
01KMYKPXKYVYVH4SR0SXR4BK6V	boytegar@gmail.com	emailpass	authid_01KMYKPXKYAQP1FTKKT60N7NR5	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAUXpCd3SxhYGyHGIe2sscFk1yjF1rnuIQKz+eVY4jjKT54xpKGff/8uAr7uUg0aLkWt6hktfzMaUmvCch6tOYuQR5bN2x3c4UiTr7JNweNwu"}	2026-03-30 12:33:20.385+07	2026-03-30 12:33:20.385+07	\N
01KMYKW43SWDRB10TS7SB7V0SC	patih@gmail.com	emailpass	authid_01KMYKW43TCAEA8HCAK885H5P9	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAUqRIWAuxcD2Ck5lwhuIBreaYEJg3l+L14wivO1oge4msfD2xRyfG06NPWMFPsLDUKpa3X/VVVa9GwWD8kDNu/yFPyF2iiNIPBZUNMR+C7w3"}	2026-03-30 12:36:10.874+07	2026-03-30 12:36:10.874+07	\N
01KMYM708C69KWYQJMZWHT9Y2Q	jonahill@gmail.omc	emailpass	authid_01KMYM708DZNEN7XGQZJQP18TT	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAUZnzo2UrRXfFU89McLxvjbdzGLbMjyJlpMsg8UzuKoi25VfoIXyW7OKQUOJmCByl5nJUzI+QOk0UB+zPfHmQI0buovDS7qryneXrMVZbeMG"}	2026-03-30 12:42:07.373+07	2026-03-30 12:42:07.373+07	\N
01KMYZAYZW1CCVMZR1ZC07B4FZ	mabiaura@gmail.com	emailpass	authid_01KMYZAYZY30Z5241JSF101RJX	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAQT+aT0yzWKTgPpmVCAHWJpANL8WgfVXW8v3vqccqSRZlcyLPw3MM/nauctEDXPEFyxs9FNpYPHjKq0/4XbZfkKXIkZ17rA4N+VPSNT4s+60"}	2026-03-30 15:56:31.49+07	2026-03-30 15:56:35.197+07	\N
01KN1E1CS8XCNCNB3GFZ86KT37	validation.20260331.0750@example.com	emailpass	authid_01KN1E1CS8NY0EMF54X5AXAJGK	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAVhfvLKpkeXOffpmyT6pG4jvSQcBLIcxIPOkTdjh6sAy5AUWqFKhM24+p7BIdPp+y38gfZY/AEulQJwEnfsOqoOS/zzwevi/0UuJRPfFqbfG"}	2026-03-31 14:51:55.436+07	2026-03-31 14:51:55.436+07	\N
01KN1E41SJQN1Y7SN4WMVK4YMB	validation.20260331.0750b@example.com	emailpass	authid_01KN1E41SJAEVRX24E3DJ5QCB2	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAVZ8u5tFHHT6ogxAWtzKMVt9/dUFDfcvcXw1G05LwxwvyFc9R6xhNQxZKatH1ThHPJboOh17F3bfwtD2QOWnUFDGeD6T+RpXcsAoA7G5VmUH"}	2026-03-31 14:53:22.483+07	2026-03-31 14:53:22.483+07	\N
01KN1E9VF476QYP6QDGCPHW8YD	validation.20260331.0756@example.com	emailpass	authid_01KN1E9VF7G9N7C0VKDRZKXSEH	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAZVE+E5EU2CXsAa8dgwCcJx+wkoi5wgHtgrtszsbXKfKkazw3nDUH+7j4l/9YjlBniaC/c+3pEhEq6RJyQoH1EBpGw+UQo9xQJ17pHS3Keqb"}	2026-03-31 14:56:32.618+07	2026-03-31 14:56:32.618+07	\N
01KN1GCKM37ZBMJMC3AHS036JG	validation.ui.20260331.0830@example.com	emailpass	authid_01KN1GCKM59JBB07RZF8856RA2	\N	{"password": "c2NyeXB0AA8AAAAIAAAAAUSW6hlMNxjO5YL5quL4Y8OlDLl0QLV9YpvOP+Nc6iA4CHxDNVSFJIBxua5mQtwq0wdJPHts0uwf9fcjGL5qRToAipbWS6uEc0KRsEU0YBgD"}	2026-03-31 15:33:00.039+07	2026-03-31 15:33:00.039+07	\N
\.


--
-- Data for Name: publishable_api_key_sales_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publishable_api_key_sales_channel (publishable_key_id, sales_channel_id, id, created_at, updated_at, deleted_at) FROM stdin;
apk_01K0DQNR524GW4VFN0CYPT9DHB	sc_01K0DQNP6KWXP3R7NJGNA411PQ	pksc_01K0DQNR5G2ZT52ZFDW9MNACWF	2025-07-18 10:01:34.511951+07	2025-07-18 10:01:34.511951+07	\N
apk_01K0DQYC785PQSMC8X6PFYHCHD	sc_01K0DQNP6KWXP3R7NJGNA411PQ	pksc_01K0DQYQ1KQ82ZSJ6JWQGW24VH	2025-07-18 10:06:28.28002+07	2025-07-18 10:24:59.203+07	2025-07-18 10:24:59.201+07
\.


--
-- Data for Name: refund; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refund (id, amount, raw_amount, payment_id, created_at, updated_at, deleted_at, created_by, metadata, refund_reason_id, note) FROM stdin;
\.


--
-- Data for Name: refund_reason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refund_reason (id, label, description, metadata, created_at, updated_at, deleted_at, code) FROM stdin;
refr_01KHSFG9QDV1XX9QRZCBDX1TMD	Shipping Issue	Refund due to lost, delayed, or misdelivered shipment	\N	2026-02-19 05:56:31.462713+07	2026-02-19 05:56:31.462713+07	\N	shipping_issue
refr_01KHSFG9QDQJ41F64VWCDJJPM2	Customer Care Adjustment	Refund given as goodwill or compensation for inconvenience	\N	2026-02-19 05:56:31.462713+07	2026-02-19 05:56:31.462713+07	\N	customer_care_adjustment
refr_01KHSFG9QDZC1C64EWD0B414V3	Pricing Error	Refund to correct an overcharge, missing discount, or incorrect price	\N	2026-02-19 05:56:31.462713+07	2026-02-19 05:56:31.462713+07	\N	pricing_error
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region (id, name, currency_code, metadata, created_at, updated_at, deleted_at, automatic_taxes) FROM stdin;
reg_01K0DQNQZ1T2G2043BVM0MJB6C	Europe	eur	\N	2025-07-18 10:01:34.312+07	2025-07-18 10:01:34.312+07	\N	t
reg_01K33FFDX0M838JWM069761552	Indonesia	idr	\N	2025-08-20 17:12:59.954+07	2025-08-20 17:12:59.954+07	\N	t
reg_01K33GHTP2XF16W0MCZC4B3TWP	US	usd	\N	2025-08-20 17:31:47.151+07	2025-08-20 17:31:47.151+07	\N	t
\.


--
-- Data for Name: region_country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region_country (iso_2, iso_3, num_code, name, display_name, region_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
af	afg	004	AFGHANISTAN	Afghanistan	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
al	alb	008	ALBANIA	Albania	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
dz	dza	012	ALGERIA	Algeria	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
as	asm	016	AMERICAN SAMOA	American Samoa	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ad	and	020	ANDORRA	Andorra	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ao	ago	024	ANGOLA	Angola	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ai	aia	660	ANGUILLA	Anguilla	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
aq	ata	010	ANTARCTICA	Antarctica	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ag	atg	028	ANTIGUA AND BARBUDA	Antigua and Barbuda	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ar	arg	032	ARGENTINA	Argentina	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
am	arm	051	ARMENIA	Armenia	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
aw	abw	533	ARUBA	Aruba	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
au	aus	036	AUSTRALIA	Australia	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
at	aut	040	AUSTRIA	Austria	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
az	aze	031	AZERBAIJAN	Azerbaijan	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bs	bhs	044	BAHAMAS	Bahamas	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bh	bhr	048	BAHRAIN	Bahrain	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bd	bgd	050	BANGLADESH	Bangladesh	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bb	brb	052	BARBADOS	Barbados	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
by	blr	112	BELARUS	Belarus	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
be	bel	056	BELGIUM	Belgium	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bz	blz	084	BELIZE	Belize	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bj	ben	204	BENIN	Benin	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bm	bmu	060	BERMUDA	Bermuda	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bt	btn	064	BHUTAN	Bhutan	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bo	bol	068	BOLIVIA	Bolivia	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bq	bes	535	BONAIRE, SINT EUSTATIUS AND SABA	Bonaire, Sint Eustatius and Saba	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ba	bih	070	BOSNIA AND HERZEGOVINA	Bosnia and Herzegovina	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bw	bwa	072	BOTSWANA	Botswana	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bv	bvd	074	BOUVET ISLAND	Bouvet Island	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
br	bra	076	BRAZIL	Brazil	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
io	iot	086	BRITISH INDIAN OCEAN TERRITORY	British Indian Ocean Territory	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bn	brn	096	BRUNEI DARUSSALAM	Brunei Darussalam	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bg	bgr	100	BULGARIA	Bulgaria	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bf	bfa	854	BURKINA FASO	Burkina Faso	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
bi	bdi	108	BURUNDI	Burundi	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
kh	khm	116	CAMBODIA	Cambodia	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cm	cmr	120	CAMEROON	Cameroon	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ca	can	124	CANADA	Canada	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cv	cpv	132	CAPE VERDE	Cape Verde	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ky	cym	136	CAYMAN ISLANDS	Cayman Islands	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cf	caf	140	CENTRAL AFRICAN REPUBLIC	Central African Republic	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
td	tcd	148	CHAD	Chad	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cl	chl	152	CHILE	Chile	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cn	chn	156	CHINA	China	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cx	cxr	162	CHRISTMAS ISLAND	Christmas Island	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cc	cck	166	COCOS (KEELING) ISLANDS	Cocos (Keeling) Islands	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
co	col	170	COLOMBIA	Colombia	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
km	com	174	COMOROS	Comoros	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cg	cog	178	CONGO	Congo	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cd	cod	180	CONGO, THE DEMOCRATIC REPUBLIC OF THE	Congo, the Democratic Republic of the	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ck	cok	184	COOK ISLANDS	Cook Islands	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cr	cri	188	COSTA RICA	Costa Rica	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
ci	civ	384	COTE D'IVOIRE	Cote D'Ivoire	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
hr	hrv	191	CROATIA	Croatia	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cu	cub	192	CUBA	Cuba	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cw	cuw	531	CURAÇAO	Curaçao	\N	\N	2025-07-18 10:01:30.379+07	2025-07-18 10:01:30.379+07	\N
cy	cyp	196	CYPRUS	Cyprus	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
cz	cze	203	CZECH REPUBLIC	Czech Republic	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
dj	dji	262	DJIBOUTI	Djibouti	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
dm	dma	212	DOMINICA	Dominica	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
do	dom	214	DOMINICAN REPUBLIC	Dominican Republic	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ec	ecu	218	ECUADOR	Ecuador	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
eg	egy	818	EGYPT	Egypt	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sv	slv	222	EL SALVADOR	El Salvador	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gq	gnq	226	EQUATORIAL GUINEA	Equatorial Guinea	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
er	eri	232	ERITREA	Eritrea	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ee	est	233	ESTONIA	Estonia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
et	eth	231	ETHIOPIA	Ethiopia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
fk	flk	238	FALKLAND ISLANDS (MALVINAS)	Falkland Islands (Malvinas)	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
fo	fro	234	FAROE ISLANDS	Faroe Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
fj	fji	242	FIJI	Fiji	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
fi	fin	246	FINLAND	Finland	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gf	guf	254	FRENCH GUIANA	French Guiana	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pf	pyf	258	FRENCH POLYNESIA	French Polynesia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tf	atf	260	FRENCH SOUTHERN TERRITORIES	French Southern Territories	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ga	gab	266	GABON	Gabon	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gm	gmb	270	GAMBIA	Gambia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ge	geo	268	GEORGIA	Georgia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gh	gha	288	GHANA	Ghana	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gi	gib	292	GIBRALTAR	Gibraltar	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gr	grc	300	GREECE	Greece	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gl	grl	304	GREENLAND	Greenland	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gd	grd	308	GRENADA	Grenada	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gp	glp	312	GUADELOUPE	Guadeloupe	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gu	gum	316	GUAM	Guam	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gt	gtm	320	GUATEMALA	Guatemala	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gg	ggy	831	GUERNSEY	Guernsey	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gn	gin	324	GUINEA	Guinea	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gw	gnb	624	GUINEA-BISSAU	Guinea-Bissau	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gy	guy	328	GUYANA	Guyana	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ht	hti	332	HAITI	Haiti	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
hm	hmd	334	HEARD ISLAND AND MCDONALD ISLANDS	Heard Island And Mcdonald Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
va	vat	336	HOLY SEE (VATICAN CITY STATE)	Holy See (Vatican City State)	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
hn	hnd	340	HONDURAS	Honduras	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
hk	hkg	344	HONG KONG	Hong Kong	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
hu	hun	348	HUNGARY	Hungary	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
is	isl	352	ICELAND	Iceland	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
in	ind	356	INDIA	India	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ir	irn	364	IRAN, ISLAMIC REPUBLIC OF	Iran, Islamic Republic of	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
iq	irq	368	IRAQ	Iraq	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ie	irl	372	IRELAND	Ireland	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
im	imn	833	ISLE OF MAN	Isle Of Man	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
il	isr	376	ISRAEL	Israel	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
jm	jam	388	JAMAICA	Jamaica	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
jp	jpn	392	JAPAN	Japan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
je	jey	832	JERSEY	Jersey	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
jo	jor	400	JORDAN	Jordan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
kz	kaz	398	KAZAKHSTAN	Kazakhstan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ke	ken	404	KENYA	Kenya	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ki	kir	296	KIRIBATI	Kiribati	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
kp	prk	408	KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF	Korea, Democratic People's Republic of	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
kr	kor	410	KOREA, REPUBLIC OF	Korea, Republic of	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
xk	xkx	900	KOSOVO	Kosovo	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
kw	kwt	414	KUWAIT	Kuwait	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
kg	kgz	417	KYRGYZSTAN	Kyrgyzstan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
la	lao	418	LAO PEOPLE'S DEMOCRATIC REPUBLIC	Lao People's Democratic Republic	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
lv	lva	428	LATVIA	Latvia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
lb	lbn	422	LEBANON	Lebanon	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ls	lso	426	LESOTHO	Lesotho	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
lr	lbr	430	LIBERIA	Liberia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ly	lby	434	LIBYA	Libya	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
li	lie	438	LIECHTENSTEIN	Liechtenstein	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
lt	ltu	440	LITHUANIA	Lithuania	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
lu	lux	442	LUXEMBOURG	Luxembourg	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mo	mac	446	MACAO	Macao	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mg	mdg	450	MADAGASCAR	Madagascar	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mw	mwi	454	MALAWI	Malawi	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
my	mys	458	MALAYSIA	Malaysia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mv	mdv	462	MALDIVES	Maldives	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ml	mli	466	MALI	Mali	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mt	mlt	470	MALTA	Malta	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mh	mhl	584	MARSHALL ISLANDS	Marshall Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mq	mtq	474	MARTINIQUE	Martinique	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mr	mrt	478	MAURITANIA	Mauritania	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mu	mus	480	MAURITIUS	Mauritius	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
yt	myt	175	MAYOTTE	Mayotte	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mx	mex	484	MEXICO	Mexico	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
fm	fsm	583	MICRONESIA, FEDERATED STATES OF	Micronesia, Federated States of	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
md	mda	498	MOLDOVA, REPUBLIC OF	Moldova, Republic of	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mc	mco	492	MONACO	Monaco	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mn	mng	496	MONGOLIA	Mongolia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
me	mne	499	MONTENEGRO	Montenegro	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ms	msr	500	MONTSERRAT	Montserrat	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ma	mar	504	MOROCCO	Morocco	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mz	moz	508	MOZAMBIQUE	Mozambique	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mm	mmr	104	MYANMAR	Myanmar	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
na	nam	516	NAMIBIA	Namibia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
nr	nru	520	NAURU	Nauru	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
np	npl	524	NEPAL	Nepal	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
nl	nld	528	NETHERLANDS	Netherlands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
nc	ncl	540	NEW CALEDONIA	New Caledonia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
nz	nzl	554	NEW ZEALAND	New Zealand	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ni	nic	558	NICARAGUA	Nicaragua	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ne	ner	562	NIGER	Niger	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ng	nga	566	NIGERIA	Nigeria	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
nu	niu	570	NIUE	Niue	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
nf	nfk	574	NORFOLK ISLAND	Norfolk Island	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mk	mkd	807	NORTH MACEDONIA	North Macedonia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mp	mnp	580	NORTHERN MARIANA ISLANDS	Northern Mariana Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
no	nor	578	NORWAY	Norway	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
om	omn	512	OMAN	Oman	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pk	pak	586	PAKISTAN	Pakistan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pw	plw	585	PALAU	Palau	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ps	pse	275	PALESTINIAN TERRITORY, OCCUPIED	Palestinian Territory, Occupied	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pa	pan	591	PANAMA	Panama	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pg	png	598	PAPUA NEW GUINEA	Papua New Guinea	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
py	pry	600	PARAGUAY	Paraguay	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pe	per	604	PERU	Peru	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ph	phl	608	PHILIPPINES	Philippines	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pn	pcn	612	PITCAIRN	Pitcairn	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pl	pol	616	POLAND	Poland	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pt	prt	620	PORTUGAL	Portugal	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pr	pri	630	PUERTO RICO	Puerto Rico	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
qa	qat	634	QATAR	Qatar	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
re	reu	638	REUNION	Reunion	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ro	rom	642	ROMANIA	Romania	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
id	idn	360	INDONESIA	Indonesia	reg_01K33FFDX0M838JWM069761552	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:12:59.955+07	\N
ru	rus	643	RUSSIAN FEDERATION	Russian Federation	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
rw	rwa	646	RWANDA	Rwanda	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
bl	blm	652	SAINT BARTHÉLEMY	Saint Barthélemy	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sh	shn	654	SAINT HELENA	Saint Helena	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
kn	kna	659	SAINT KITTS AND NEVIS	Saint Kitts and Nevis	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
lc	lca	662	SAINT LUCIA	Saint Lucia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
mf	maf	663	SAINT MARTIN (FRENCH PART)	Saint Martin (French part)	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
pm	spm	666	SAINT PIERRE AND MIQUELON	Saint Pierre and Miquelon	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
vc	vct	670	SAINT VINCENT AND THE GRENADINES	Saint Vincent and the Grenadines	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ws	wsm	882	SAMOA	Samoa	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sm	smr	674	SAN MARINO	San Marino	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
st	stp	678	SAO TOME AND PRINCIPE	Sao Tome and Principe	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sa	sau	682	SAUDI ARABIA	Saudi Arabia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sn	sen	686	SENEGAL	Senegal	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
rs	srb	688	SERBIA	Serbia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sc	syc	690	SEYCHELLES	Seychelles	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sl	sle	694	SIERRA LEONE	Sierra Leone	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sg	sgp	702	SINGAPORE	Singapore	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sx	sxm	534	SINT MAARTEN	Sint Maarten	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sk	svk	703	SLOVAKIA	Slovakia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
si	svn	705	SLOVENIA	Slovenia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sb	slb	090	SOLOMON ISLANDS	Solomon Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
so	som	706	SOMALIA	Somalia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
za	zaf	710	SOUTH AFRICA	South Africa	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
gs	sgs	239	SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS	South Georgia and the South Sandwich Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ss	ssd	728	SOUTH SUDAN	South Sudan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
lk	lka	144	SRI LANKA	Sri Lanka	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sd	sdn	729	SUDAN	Sudan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sr	sur	740	SURINAME	Suriname	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sj	sjm	744	SVALBARD AND JAN MAYEN	Svalbard and Jan Mayen	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sz	swz	748	SWAZILAND	Swaziland	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ch	che	756	SWITZERLAND	Switzerland	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
sy	syr	760	SYRIAN ARAB REPUBLIC	Syrian Arab Republic	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tw	twn	158	TAIWAN, PROVINCE OF CHINA	Taiwan, Province of China	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tj	tjk	762	TAJIKISTAN	Tajikistan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tz	tza	834	TANZANIA, UNITED REPUBLIC OF	Tanzania, United Republic of	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
th	tha	764	THAILAND	Thailand	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tl	tls	626	TIMOR LESTE	Timor Leste	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tg	tgo	768	TOGO	Togo	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tk	tkl	772	TOKELAU	Tokelau	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
to	ton	776	TONGA	Tonga	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tt	tto	780	TRINIDAD AND TOBAGO	Trinidad and Tobago	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tn	tun	788	TUNISIA	Tunisia	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tr	tur	792	TURKEY	Turkey	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tm	tkm	795	TURKMENISTAN	Turkmenistan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tc	tca	796	TURKS AND CAICOS ISLANDS	Turks and Caicos Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
tv	tuv	798	TUVALU	Tuvalu	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ug	uga	800	UGANDA	Uganda	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ua	ukr	804	UKRAINE	Ukraine	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ae	are	784	UNITED ARAB EMIRATES	United Arab Emirates	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
um	umi	581	UNITED STATES MINOR OUTLYING ISLANDS	United States Minor Outlying Islands	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
uy	ury	858	URUGUAY	Uruguay	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
uz	uzb	860	UZBEKISTAN	Uzbekistan	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
vu	vut	548	VANUATU	Vanuatu	\N	\N	2025-07-18 10:01:30.38+07	2025-07-18 10:01:30.38+07	\N
ve	ven	862	VENEZUELA	Venezuela	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
vn	vnm	704	VIET NAM	Viet Nam	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
vg	vgb	092	VIRGIN ISLANDS, BRITISH	Virgin Islands, British	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
vi	vir	850	VIRGIN ISLANDS, U.S.	Virgin Islands, U.S.	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
wf	wlf	876	WALLIS AND FUTUNA	Wallis and Futuna	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
eh	esh	732	WESTERN SAHARA	Western Sahara	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
ye	yem	887	YEMEN	Yemen	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
zm	zmb	894	ZAMBIA	Zambia	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
zw	zwe	716	ZIMBABWE	Zimbabwe	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
ax	ala	248	ÅLAND ISLANDS	Åland Islands	\N	\N	2025-07-18 10:01:30.381+07	2025-07-18 10:01:30.381+07	\N
dk	dnk	208	DENMARK	Denmark	\N	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:27:15.152+07	\N
fr	fra	250	FRANCE	France	\N	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:27:15.152+07	\N
it	ita	380	ITALY	Italy	\N	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:27:15.152+07	\N
es	esp	724	SPAIN	Spain	\N	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:27:15.152+07	\N
se	swe	752	SWEDEN	Sweden	\N	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:27:15.152+07	\N
de	deu	276	GERMANY	Germany	reg_01K0DQNQZ1T2G2043BVM0MJB6C	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:27:15.17+07	\N
gb	gbr	826	UNITED KINGDOM	United Kingdom	reg_01K0DQNQZ1T2G2043BVM0MJB6C	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:27:15.17+07	\N
us	usa	840	UNITED STATES	United States	reg_01K33GHTP2XF16W0MCZC4B3TWP	\N	2025-07-18 10:01:30.38+07	2025-08-20 17:31:47.152+07	\N
\.


--
-- Data for Name: region_payment_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region_payment_provider (region_id, payment_provider_id, id, created_at, updated_at, deleted_at) FROM stdin;
reg_01K0DQNQZ1T2G2043BVM0MJB6C	pp_system_default	regpp_01K0DQNQZVTKTD2V22258EVA26	2025-07-18 10:01:34.331198+07	2025-07-18 10:01:34.331198+07	\N
reg_01K33FFDX0M838JWM069761552	pp_system_default	regpp_01K33FFDYN27ETK10Z430VVTFZ	2025-08-20 17:12:59.989351+07	2025-08-20 17:12:59.989351+07	\N
reg_01K33GHTP2XF16W0MCZC4B3TWP	pp_system_default	regpp_01K33GHTQNXVXBD3A9NW88JNQD	2025-08-20 17:31:47.185672+07	2025-08-20 17:31:47.185672+07	\N
\.


--
-- Data for Name: reservation_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservation_item (id, created_at, updated_at, deleted_at, line_item_id, location_id, quantity, external_id, description, created_by, metadata, inventory_item_id, allow_backorder, raw_quantity) FROM stdin;
resitem_01K38B6656XFYMWJ3S3YZCCKX4	2025-08-22 14:34:14.952+07	2025-08-22 14:34:50.287+07	2025-08-22 14:34:50.279+07	ordli_01K38B662S2GB9JV4A7YRCMK9F	sloc_01K33F59FEB33XCB0DA9WPWN5Z	1	\N	\N	\N	\N	iitem_01K0DQNR8HDKZFXMZW258EV36W	f	{"value": "1", "precision": 20}
resitem_01KN1NS68F2FD3TRCN8PHZWA59	2026-03-31 17:07:15.218+07	2026-03-31 17:07:15.218+07	\N	ordli_01KN1NS64Y38PE672KNKFA3ZXM	sloc_01K33F59FEB33XCB0DA9WPWN5Z	2	\N	\N	\N	\N	iitem_01K0DQNR8HKWFJWJVHX5SWTADW	f	{"value": "2", "precision": 20}
resitem_01KNRSCZM7AAE2HHKW0474JVCG	2026-04-09 16:33:01.451+07	2026-04-09 16:33:01.451+07	\N	ordli_01KNRSCZFEV2QDMV14TR42QXY9	sloc_01K33F59FEB33XCB0DA9WPWN5Z	1	\N	\N	\N	\N	iitem_01K0DQNR8H6FMW591ZAWE8CC6V	f	{"value": "1", "precision": 20}
resitem_01KQVHXN0MTH1VFSC8JYAZAWN9	2026-05-05 14:51:25.976+07	2026-05-05 14:51:25.976+07	\N	ordli_01KQVHXMXMWSD3F91XRQAAM3D3	sloc_01K33F59FEB33XCB0DA9WPWN5Z	1	\N	\N	\N	\N	iitem_01K0DQNR8HR59HTB6ERH8DZASY	f	{"value": "1", "precision": 20}
\.


--
-- Data for Name: return; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return (id, order_id, claim_id, exchange_id, order_version, display_id, status, no_notification, refund_amount, raw_refund_amount, metadata, created_at, updated_at, deleted_at, received_at, canceled_at, location_id, requested_at, created_by) FROM stdin;
\.


--
-- Data for Name: return_fulfillment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return_fulfillment (return_id, fulfillment_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: return_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return_item (id, return_id, reason_id, item_id, quantity, raw_quantity, received_quantity, raw_received_quantity, note, metadata, created_at, updated_at, deleted_at, damaged_quantity, raw_damaged_quantity) FROM stdin;
\.


--
-- Data for Name: return_reason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return_reason (id, value, label, description, metadata, parent_return_reason_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: sales_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_channel (id, name, description, is_disabled, metadata, created_at, updated_at, deleted_at) FROM stdin;
sc_01K33F08EMQCJXWNZK1HWXHBHR	Shopee	Integrasi ke Shopee	f	\N	2025-08-20 17:04:42.837+07	2025-08-20 17:04:42.837+07	\N
sc_01K33F0SW4Y9DSZQ933X15TGQ6	Tiktok	Integrasi ke Tiktok	f	\N	2025-08-20 17:05:00.676+07	2025-08-20 17:05:00.676+07	\N
sc_01K0DQNP6KWXP3R7NJGNA411PQ	Website	Penjualan di website	f	\N	2025-07-18 10:01:32.499+07	2025-08-20 17:26:01.057+07	\N
\.


--
-- Data for Name: sales_channel_stock_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_channel_stock_location (sales_channel_id, stock_location_id, id, created_at, updated_at, deleted_at) FROM stdin;
sc_01K0DQNP6KWXP3R7NJGNA411PQ	sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	scloc_01K0DQNR4WYYQJPXMS1K4S96HN	2025-07-18 10:01:34.492314+07	2025-07-18 10:01:34.492314+07	\N
sc_01K0DQNP6KWXP3R7NJGNA411PQ	sloc_01K33F59FEB33XCB0DA9WPWN5Z	scloc_01K33G4TTA7B7S3YD4Z2ZXNPDR	2025-08-20 17:24:41.301017+07	2025-08-20 17:24:41.301017+07	\N
sc_01K33F08EMQCJXWNZK1HWXHBHR	sloc_01K33F59FEB33XCB0DA9WPWN5Z	scloc_01K33G6WF6SKEW4GFZC25JF9VR	2025-08-20 17:25:48.527157+07	2025-08-20 17:25:48.527157+07	\N
sc_01K33F0SW4Y9DSZQ933X15TGQ6	sloc_01K33F59FEB33XCB0DA9WPWN5Z	scloc_01K33G6WF8KCVST3QYE6QY38SK	2025-08-20 17:25:48.527157+07	2025-08-20 17:25:48.527157+07	\N
\.


--
-- Data for Name: script_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.script_migrations (id, script_name, created_at, finished_at) FROM stdin;
1	migrate-tax-region-provider.js	2025-07-18 10:01:30.825117+07	2025-07-18 10:01:30.854212+07
2	migrate-product-shipping-profile.js	2025-07-18 10:01:30.85776+07	2025-07-18 10:01:30.872483+07
3	migrate-normalize-currency-codes-normalization.js	2026-07-06 11:41:34.443834+07	2026-07-06 11:41:34.484538+07
4	migrate-product-option-link-ids.js	2026-07-06 11:41:34.486228+07	2026-07-06 11:41:34.501073+07
5	reconcile-inventory-reserved-quantity.js	2026-07-06 11:41:34.502442+07	2026-07-06 11:41:34.511925+07
\.


--
-- Data for Name: service_zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_zone (id, name, metadata, fulfillment_set_id, created_at, updated_at, deleted_at) FROM stdin;
serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	Europe	\N	fuset_01K0DQNR1A9GSP9NT5MMF387RW	2025-07-18 10:01:34.378+07	2025-07-18 10:01:34.378+07	\N
serzo_01K33G5SS77RAVYA695YTY8D6R	All Region	\N	fuset_01K33F5NGSCZ63W678VJ0MBZ5M	2025-08-20 17:25:13+07	2025-08-20 17:25:13+07	\N
\.


--
-- Data for Name: shipping_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_option (id, name, price_type, service_zone_id, shipping_profile_id, provider_id, data, metadata, shipping_option_type_id, created_at, updated_at, deleted_at) FROM stdin;
so_01K0DQNR2QDMVGEKRF8BZ3GAPK	Standard Shipping	flat	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	sp_01K0DQNMKKYJED57XQD63HVRN1	manual_manual	\N	\N	sotype_01K0DQNR2PPPZQ1K3YYZQRFTGF	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
so_01K0DQNR2Q89PWCZ1AEQVFW3D0	Express Shipping	flat	serzo_01K0DQNR1AVKJXMKFHSX3K3JX1	sp_01K0DQNMKKYJED57XQD63HVRN1	manual_manual	\N	\N	sotype_01K0DQNR2QDYJV6V9J46F3X2XW	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
so_01K38B4T1FCQDKK7TT2MPC8DCG	Fixed Manual	flat	serzo_01K33G5SS77RAVYA695YTY8D6R	sp_01K0DQNMKKYJED57XQD63HVRN1	manual_manual	{"id": "manual-fulfillment"}	\N	sotype_01K3SYGG262MREJSQ0F86WVA9V	2025-08-22 14:33:29.776+07	2025-08-22 14:33:29.776+07	\N
\.


--
-- Data for Name: shipping_option_price_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_option_price_set (shipping_option_id, price_set_id, id, created_at, updated_at, deleted_at) FROM stdin;
so_01K0DQNR2QDMVGEKRF8BZ3GAPK	pset_01K0DQNR397KW016XRAXC77EB2	sops_01K0DQNR4BRB0XA8NTBCF5E50V	2025-07-18 10:01:34.475001+07	2025-07-18 10:01:34.475001+07	\N
so_01K0DQNR2Q89PWCZ1AEQVFW3D0	pset_01K0DQNR393J1JRXAJM1KFWD58	sops_01K0DQNR4BWES8WSJH8ME345HP	2025-07-18 10:01:34.475001+07	2025-07-18 10:01:34.475001+07	\N
so_01K38B4T1FCQDKK7TT2MPC8DCG	pset_01K38B4T2MWXPRPPQW8S67AQEV	sops_01K38B4T42K1SKZKXW8G2Y1B29	2025-08-22 14:33:29.857819+07	2025-08-22 14:33:29.857819+07	\N
\.


--
-- Data for Name: shipping_option_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_option_rule (id, attribute, operator, value, shipping_option_id, created_at, updated_at, deleted_at) FROM stdin;
sorul_01K0DQNR2PNF85ZT37QGCG3VQD	enabled_in_store	eq	"true"	so_01K0DQNR2QDMVGEKRF8BZ3GAPK	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
sorul_01K0DQNR2QWMGTCXE9YKR10M9C	is_return	eq	"false"	so_01K0DQNR2QDMVGEKRF8BZ3GAPK	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
sorul_01K0DQNR2Q6P1JBSZD10JBQ1EF	enabled_in_store	eq	"true"	so_01K0DQNR2Q89PWCZ1AEQVFW3D0	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
sorul_01K0DQNR2QPAM644BNZ20XG43Y	is_return	eq	"false"	so_01K0DQNR2Q89PWCZ1AEQVFW3D0	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
sorul_01K38B4T1FDQ40DF7V776YKDR4	is_return	eq	"false"	so_01K38B4T1FCQDKK7TT2MPC8DCG	2025-08-22 14:33:29.777+07	2025-08-22 14:33:29.777+07	\N
sorul_01K38B4T1FGBQASHXZEW1ZR4TJ	enabled_in_store	eq	"true"	so_01K38B4T1FCQDKK7TT2MPC8DCG	2025-08-22 14:33:29.777+07	2025-08-22 14:33:29.777+07	\N
\.


--
-- Data for Name: shipping_option_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_option_type (id, label, description, code, created_at, updated_at, deleted_at) FROM stdin;
sotype_01K0DQNR2PPPZQ1K3YYZQRFTGF	Standard	Ship in 2-3 days.	standard	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
sotype_01K0DQNR2QDYJV6V9J46F3X2XW	Express	Ship in 24 hours.	express	2025-07-18 10:01:34.423+07	2025-07-18 10:01:34.423+07	\N
sotype_01K3SYGG262MREJSQ0F86WVA9V	Default	Default shipping option type	default	2025-08-29 10:39:01.056774+07	2025-08-29 10:39:01.056774+07	\N
sotype_01K38B4T1EPS42581QEHEHDGJS	Type label	Type description	type-code	2025-08-22 14:33:29.776+07	2025-08-22 14:33:29.776+07	2025-08-29 10:39:01.056774+07
\.


--
-- Data for Name: shipping_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_profile (id, name, type, metadata, created_at, updated_at, deleted_at) FROM stdin;
sp_01K0DQNMKKYJED57XQD63HVRN1	Default Shipping Profile	default	\N	2025-07-18 10:01:30.868+07	2025-07-18 10:01:30.868+07	\N
sp_01K38AVP4T4NGCSERQTTNWK0GP	Indonesia	all	\N	2025-08-22 14:28:30.876+07	2025-08-22 14:28:30.876+07	\N
\.


--
-- Data for Name: stock_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_location (id, created_at, updated_at, deleted_at, name, address_id, metadata) FROM stdin;
sloc_01K0DQNR0P21PNZ3ZE3Z4W91TB	2025-07-18 10:01:34.358+07	2025-07-18 10:01:34.358+07	\N	European Warehouse	laddr_01K0DQNR0P4JKWJB622E5FPYJA	\N
sloc_01K33F59FEB33XCB0DA9WPWN5Z	2025-08-20 17:07:27.727+07	2025-08-20 17:07:27.727+07	\N	Gudang Utama	laddr_01K33F59FEZ2HD3PRFEYNRZH5F	\N
\.


--
-- Data for Name: stock_location_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_location_address (id, created_at, updated_at, deleted_at, address_1, address_2, company, city, country_code, phone, province, postal_code, metadata) FROM stdin;
laddr_01K0DQNR0P4JKWJB622E5FPYJA	2025-07-18 10:01:34.358+07	2025-07-18 10:01:34.358+07	\N		\N	\N	Copenhagen	DK	\N	\N	\N	\N
laddr_01K33F59FEZ2HD3PRFEYNRZH5F	2025-08-20 17:07:27.727+07	2025-08-20 17:07:27.727+07	\N	Jl. Simponi No. 21			Bandung	id		Jawa Barat	40264	\N
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store (id, name, default_sales_channel_id, default_region_id, default_location_id, metadata, created_at, updated_at, deleted_at) FROM stdin;
store_01K0DQNP70B9E7QBGF6CZ0QCYS	Medusa Store	sc_01K0DQNP6KWXP3R7NJGNA411PQ	reg_01K33FFDX0M838JWM069761552	sloc_01K33F59FEB33XCB0DA9WPWN5Z	\N	2025-07-18 10:01:32.511704+07	2025-07-18 10:01:32.511704+07	\N
\.


--
-- Data for Name: store_currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_currency (id, currency_code, is_default, store_id, created_at, updated_at, deleted_at) FROM stdin;
stocur_01K33FFWMTZMH55BTEFPX31GMZ	idr	t	store_01K0DQNP70B9E7QBGF6CZ0QCYS	2025-08-20 17:13:15.028592+07	2025-08-20 17:13:15.028592+07	\N
stocur_01K33FFWMT5YRKPQR4GCGHZC6N	eur	f	store_01K0DQNP70B9E7QBGF6CZ0QCYS	2025-08-20 17:13:15.028592+07	2025-08-20 17:13:15.028592+07	\N
stocur_01K33FFWMWZFDE8EVTNNX0SBB9	usd	f	store_01K0DQNP70B9E7QBGF6CZ0QCYS	2025-08-20 17:13:15.028592+07	2025-08-20 17:13:15.028592+07	\N
\.


--
-- Data for Name: store_locale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_locale (id, locale_code, store_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: tax_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_provider (id, is_enabled, created_at, updated_at, deleted_at) FROM stdin;
tp_system	t	2025-07-18 10:01:30.372+07	2025-07-18 10:01:30.372+07	\N
\.


--
-- Data for Name: tax_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_rate (id, rate, code, name, is_default, is_combinable, tax_region_id, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
\.


--
-- Data for Name: tax_rate_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_rate_rule (id, tax_rate_id, reference_id, reference, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
\.


--
-- Data for Name: tax_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_region (id, provider_id, country_code, province_code, parent_id, metadata, created_at, updated_at, created_by, deleted_at) FROM stdin;
txreg_01K0DQNR085NBNW8PMMA6JP536	tp_system	gb	\N	\N	\N	2025-07-18 10:01:34.344+07	2025-07-18 10:01:34.344+07	\N	\N
txreg_01K0DQNR08QT66TCNF5JC8R7AE	tp_system	de	\N	\N	\N	2025-07-18 10:01:34.344+07	2025-07-18 10:01:34.344+07	\N	\N
txreg_01K0DQNR08V0PMMCFQ2X4A1A12	tp_system	dk	\N	\N	\N	2025-07-18 10:01:34.344+07	2025-08-20 17:27:32.623+07	\N	2025-08-20 17:27:32.621+07
txreg_01K0DQNR08HGJJVPHVNTMV19KT	tp_system	es	\N	\N	\N	2025-07-18 10:01:34.344+07	2025-08-20 17:27:36.955+07	\N	2025-08-20 17:27:36.955+07
txreg_01K0DQNR08V8B0W2EM0DFDCQT7	tp_system	fr	\N	\N	\N	2025-07-18 10:01:34.344+07	2025-08-20 17:27:40.379+07	\N	2025-08-20 17:27:40.378+07
txreg_01K0DQNR08HPN3W8T55VQSXXXD	tp_system	it	\N	\N	\N	2025-07-18 10:01:34.345+07	2025-08-20 17:27:44.278+07	\N	2025-08-20 17:27:44.278+07
txreg_01K0DQNR08MX7MM870JVK48RM4	tp_system	se	\N	\N	\N	2025-07-18 10:01:34.344+07	2025-08-20 17:27:46.677+07	\N	2025-08-20 17:27:46.677+07
txreg_01K33GASJSYTDZC00B0SCCNVWJ	tp_system	id	\N	\N	\N	2025-08-20 17:27:56.634+07	2025-08-20 17:27:56.634+07	user_01K0DQTQ8DKZ8PHEZFREPTS5SN	\N
txreg_01K33GKAFW6D5XH4FPWRR77GKS	tp_system	us	\N	\N	\N	2025-08-20 17:32:36.093+07	2025-08-20 17:32:36.093+07	user_01K0DQTQ8DKZ8PHEZFREPTS5SN	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, first_name, last_name, email, avatar_url, metadata, created_at, updated_at, deleted_at) FROM stdin;
user_01K0DQTQ8DKZ8PHEZFREPTS5SN	Adriana	Eka Prayudha	radenadriep@gmail.com	\N	\N	2025-07-18 10:04:17.421+07	2025-08-20 16:26:41.462+07	\N
\.


--
-- Data for Name: user_preference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preference (id, user_id, key, value, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: user_rbac_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_rbac_role (user_id, rbac_role_id, id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: view_configuration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.view_configuration (id, entity, name, user_id, is_system_default, configuration, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: workflow_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_execution (id, workflow_id, transaction_id, execution, context, state, created_at, updated_at, deleted_at, retention_time, run_id) FROM stdin;
\.


--
-- Name: link_module_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.link_module_migrations_id_seq', 99, true);


--
-- Name: mikro_orm_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mikro_orm_migrations_id_seq', 173, true);


--
-- Name: order_change_action_ordering_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_change_action_ordering_seq', 3, true);


--
-- Name: order_claim_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_claim_display_id_seq', 1, false);


--
-- Name: order_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_display_id_seq', 4, true);


--
-- Name: order_exchange_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_exchange_display_id_seq', 1, false);


--
-- Name: return_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.return_display_id_seq', 1, false);


--
-- Name: script_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.script_migrations_id_seq', 5, true);


--
-- Name: account_holder account_holder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_holder
    ADD CONSTRAINT account_holder_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: application_method_buy_rules application_method_buy_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_method_buy_rules
    ADD CONSTRAINT application_method_buy_rules_pkey PRIMARY KEY (application_method_id, promotion_rule_id);


--
-- Name: application_method_target_rules application_method_target_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_method_target_rules
    ADD CONSTRAINT application_method_target_rules_pkey PRIMARY KEY (application_method_id, promotion_rule_id);


--
-- Name: auth_identity auth_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_identity
    ADD CONSTRAINT auth_identity_pkey PRIMARY KEY (id);


--
-- Name: auth_mfa_factor auth_mfa_factor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_mfa_factor
    ADD CONSTRAINT auth_mfa_factor_pkey PRIMARY KEY (id);


--
-- Name: auth_mfa_recovery_code auth_mfa_recovery_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_mfa_recovery_code
    ADD CONSTRAINT auth_mfa_recovery_code_pkey PRIMARY KEY (id);


--
-- Name: auth_password_reset_token auth_password_reset_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_password_reset_token
    ADD CONSTRAINT auth_password_reset_token_pkey PRIMARY KEY (id);


--
-- Name: auth_verification auth_verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_verification
    ADD CONSTRAINT auth_verification_pkey PRIMARY KEY (id);


--
-- Name: brand brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);


--
-- Name: capture capture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capture
    ADD CONSTRAINT capture_pkey PRIMARY KEY (id);


--
-- Name: cart_address cart_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_address
    ADD CONSTRAINT cart_address_pkey PRIMARY KEY (id);


--
-- Name: cart_line_item_adjustment cart_line_item_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_line_item_adjustment
    ADD CONSTRAINT cart_line_item_adjustment_pkey PRIMARY KEY (id);


--
-- Name: cart_line_item cart_line_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_line_item
    ADD CONSTRAINT cart_line_item_pkey PRIMARY KEY (id);


--
-- Name: cart_line_item_tax_line cart_line_item_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_line_item_tax_line
    ADD CONSTRAINT cart_line_item_tax_line_pkey PRIMARY KEY (id);


--
-- Name: cart_payment_collection cart_payment_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_payment_collection
    ADD CONSTRAINT cart_payment_collection_pkey PRIMARY KEY (cart_id, payment_collection_id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: cart_promotion cart_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_promotion
    ADD CONSTRAINT cart_promotion_pkey PRIMARY KEY (cart_id, promotion_id);


--
-- Name: cart_shipping_method_adjustment cart_shipping_method_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_shipping_method_adjustment
    ADD CONSTRAINT cart_shipping_method_adjustment_pkey PRIMARY KEY (id);


--
-- Name: cart_shipping_method cart_shipping_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_shipping_method
    ADD CONSTRAINT cart_shipping_method_pkey PRIMARY KEY (id);


--
-- Name: cart_shipping_method_tax_line cart_shipping_method_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_shipping_method_tax_line
    ADD CONSTRAINT cart_shipping_method_tax_line_pkey PRIMARY KEY (id);


--
-- Name: credit_line credit_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_line
    ADD CONSTRAINT credit_line_pkey PRIMARY KEY (id);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (code);


--
-- Name: customer_account_holder customer_account_holder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_account_holder
    ADD CONSTRAINT customer_account_holder_pkey PRIMARY KEY (customer_id, account_holder_id);


--
-- Name: customer_address customer_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_pkey PRIMARY KEY (id);


--
-- Name: customer_group_customer customer_group_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group_customer
    ADD CONSTRAINT customer_group_customer_pkey PRIMARY KEY (id);


--
-- Name: customer_group customer_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT customer_group_pkey PRIMARY KEY (id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_address fulfillment_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_address
    ADD CONSTRAINT fulfillment_address_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_item fulfillment_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_item
    ADD CONSTRAINT fulfillment_item_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_label fulfillment_label_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_label
    ADD CONSTRAINT fulfillment_label_pkey PRIMARY KEY (id);


--
-- Name: fulfillment fulfillment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_provider fulfillment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_provider
    ADD CONSTRAINT fulfillment_provider_pkey PRIMARY KEY (id);


--
-- Name: fulfillment_set fulfillment_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_set
    ADD CONSTRAINT fulfillment_set_pkey PRIMARY KEY (id);


--
-- Name: geo_zone geo_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.geo_zone
    ADD CONSTRAINT geo_zone_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: inventory_item inventory_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT inventory_item_pkey PRIMARY KEY (id);


--
-- Name: inventory_level inventory_level_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_level
    ADD CONSTRAINT inventory_level_pkey PRIMARY KEY (id);


--
-- Name: invite invite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invite
    ADD CONSTRAINT invite_pkey PRIMARY KEY (id);


--
-- Name: invite_rbac_role invite_rbac_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invite_rbac_role
    ADD CONSTRAINT invite_rbac_role_pkey PRIMARY KEY (invite_id, rbac_role_id);


--
-- Name: layout_configuration layout_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.layout_configuration
    ADD CONSTRAINT layout_configuration_pkey PRIMARY KEY (id);


--
-- Name: link_module_migrations link_module_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link_module_migrations
    ADD CONSTRAINT link_module_migrations_pkey PRIMARY KEY (id);


--
-- Name: link_module_migrations link_module_migrations_table_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link_module_migrations
    ADD CONSTRAINT link_module_migrations_table_name_key UNIQUE (table_name);


--
-- Name: location_fulfillment_provider location_fulfillment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_fulfillment_provider
    ADD CONSTRAINT location_fulfillment_provider_pkey PRIMARY KEY (stock_location_id, fulfillment_provider_id);


--
-- Name: location_fulfillment_set location_fulfillment_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_fulfillment_set
    ADD CONSTRAINT location_fulfillment_set_pkey PRIMARY KEY (stock_location_id, fulfillment_set_id);


--
-- Name: mikro_orm_migrations mikro_orm_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mikro_orm_migrations
    ADD CONSTRAINT mikro_orm_migrations_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notification_provider notification_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_provider
    ADD CONSTRAINT notification_provider_pkey PRIMARY KEY (id);


--
-- Name: order_address order_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_address
    ADD CONSTRAINT order_address_pkey PRIMARY KEY (id);


--
-- Name: order_cart order_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_pkey PRIMARY KEY (order_id, cart_id);


--
-- Name: order_change_action order_change_action_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_change_action
    ADD CONSTRAINT order_change_action_pkey PRIMARY KEY (id);


--
-- Name: order_change order_change_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_change
    ADD CONSTRAINT order_change_pkey PRIMARY KEY (id);


--
-- Name: order_claim_item_image order_claim_item_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_claim_item_image
    ADD CONSTRAINT order_claim_item_image_pkey PRIMARY KEY (id);


--
-- Name: order_claim_item order_claim_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_claim_item
    ADD CONSTRAINT order_claim_item_pkey PRIMARY KEY (id);


--
-- Name: order_claim order_claim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_claim
    ADD CONSTRAINT order_claim_pkey PRIMARY KEY (id);


--
-- Name: order_credit_line order_credit_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_credit_line
    ADD CONSTRAINT order_credit_line_pkey PRIMARY KEY (id);


--
-- Name: order_exchange_item order_exchange_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_exchange_item
    ADD CONSTRAINT order_exchange_item_pkey PRIMARY KEY (id);


--
-- Name: order_exchange order_exchange_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_exchange
    ADD CONSTRAINT order_exchange_pkey PRIMARY KEY (id);


--
-- Name: order_fulfillment order_fulfillment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_fulfillment
    ADD CONSTRAINT order_fulfillment_pkey PRIMARY KEY (order_id, fulfillment_id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- Name: order_line_item_adjustment order_line_item_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_line_item_adjustment
    ADD CONSTRAINT order_line_item_adjustment_pkey PRIMARY KEY (id);


--
-- Name: order_line_item order_line_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_line_item
    ADD CONSTRAINT order_line_item_pkey PRIMARY KEY (id);


--
-- Name: order_line_item_tax_line order_line_item_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_line_item_tax_line
    ADD CONSTRAINT order_line_item_tax_line_pkey PRIMARY KEY (id);


--
-- Name: order_payment_collection order_payment_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_payment_collection
    ADD CONSTRAINT order_payment_collection_pkey PRIMARY KEY (order_id, payment_collection_id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order_promotion order_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_promotion
    ADD CONSTRAINT order_promotion_pkey PRIMARY KEY (order_id, promotion_id);


--
-- Name: order_shipping_method_adjustment order_shipping_method_adjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipping_method_adjustment
    ADD CONSTRAINT order_shipping_method_adjustment_pkey PRIMARY KEY (id);


--
-- Name: order_shipping_method order_shipping_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipping_method
    ADD CONSTRAINT order_shipping_method_pkey PRIMARY KEY (id);


--
-- Name: order_shipping_method_tax_line order_shipping_method_tax_line_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipping_method_tax_line
    ADD CONSTRAINT order_shipping_method_tax_line_pkey PRIMARY KEY (id);


--
-- Name: order_shipping order_shipping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipping
    ADD CONSTRAINT order_shipping_pkey PRIMARY KEY (id);


--
-- Name: order_summary order_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_summary
    ADD CONSTRAINT order_summary_pkey PRIMARY KEY (id);


--
-- Name: order_transaction order_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_transaction
    ADD CONSTRAINT order_transaction_pkey PRIMARY KEY (id);


--
-- Name: payment_collection_payment_providers payment_collection_payment_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_payment_providers
    ADD CONSTRAINT payment_collection_payment_providers_pkey PRIMARY KEY (payment_collection_id, payment_provider_id);


--
-- Name: payment_collection payment_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection
    ADD CONSTRAINT payment_collection_pkey PRIMARY KEY (id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: payment_provider payment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_provider
    ADD CONSTRAINT payment_provider_pkey PRIMARY KEY (id);


--
-- Name: payment_session payment_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_session
    ADD CONSTRAINT payment_session_pkey PRIMARY KEY (id);


--
-- Name: price_list price_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_list
    ADD CONSTRAINT price_list_pkey PRIMARY KEY (id);


--
-- Name: price_list_rule price_list_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_list_rule
    ADD CONSTRAINT price_list_rule_pkey PRIMARY KEY (id);


--
-- Name: price price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_pkey PRIMARY KEY (id);


--
-- Name: price_preference price_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_preference
    ADD CONSTRAINT price_preference_pkey PRIMARY KEY (id);


--
-- Name: price_rule price_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_rule
    ADD CONSTRAINT price_rule_pkey PRIMARY KEY (id);


--
-- Name: price_set price_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_set
    ADD CONSTRAINT price_set_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product_category_product product_category_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT product_category_product_pkey PRIMARY KEY (product_id, product_category_id);


--
-- Name: product_collection product_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT product_collection_pkey PRIMARY KEY (id);


--
-- Name: product_option product_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option
    ADD CONSTRAINT product_option_pkey PRIMARY KEY (id);


--
-- Name: product_option_value product_option_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option_value
    ADD CONSTRAINT product_option_value_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_product_brand_brand product_product_brand_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_brand_brand
    ADD CONSTRAINT product_product_brand_brand_pkey PRIMARY KEY (product_id, brand_id);


--
-- Name: product_product_option product_product_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_option
    ADD CONSTRAINT product_product_option_pkey PRIMARY KEY (id);


--
-- Name: product_product_option_value product_product_option_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_option_value
    ADD CONSTRAINT product_product_option_value_pkey PRIMARY KEY (id);


--
-- Name: product_sales_channel product_sales_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sales_channel
    ADD CONSTRAINT product_sales_channel_pkey PRIMARY KEY (product_id, sales_channel_id);


--
-- Name: product_shipping_profile product_shipping_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_shipping_profile
    ADD CONSTRAINT product_shipping_profile_pkey PRIMARY KEY (product_id, shipping_profile_id);


--
-- Name: product_tag product_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tag
    ADD CONSTRAINT product_tag_pkey PRIMARY KEY (id);


--
-- Name: product_tags product_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_pkey PRIMARY KEY (product_id, product_tag_id);


--
-- Name: product_type product_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT product_type_pkey PRIMARY KEY (id);


--
-- Name: product_variant_inventory_item product_variant_inventory_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_inventory_item
    ADD CONSTRAINT product_variant_inventory_item_pkey PRIMARY KEY (variant_id, inventory_item_id);


--
-- Name: product_variant_option product_variant_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_option
    ADD CONSTRAINT product_variant_option_pkey PRIMARY KEY (variant_id, option_value_id);


--
-- Name: product_variant product_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT product_variant_pkey PRIMARY KEY (id);


--
-- Name: product_variant_price_set product_variant_price_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_price_set
    ADD CONSTRAINT product_variant_price_set_pkey PRIMARY KEY (variant_id, price_set_id);


--
-- Name: product_variant_product_image product_variant_product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_product_image
    ADD CONSTRAINT product_variant_product_image_pkey PRIMARY KEY (id);


--
-- Name: promotion_application_method promotion_application_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_application_method
    ADD CONSTRAINT promotion_application_method_pkey PRIMARY KEY (id);


--
-- Name: promotion_campaign_budget promotion_campaign_budget_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_campaign_budget
    ADD CONSTRAINT promotion_campaign_budget_pkey PRIMARY KEY (id);


--
-- Name: promotion_campaign_budget_usage promotion_campaign_budget_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_campaign_budget_usage
    ADD CONSTRAINT promotion_campaign_budget_usage_pkey PRIMARY KEY (id);


--
-- Name: promotion_campaign promotion_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_campaign
    ADD CONSTRAINT promotion_campaign_pkey PRIMARY KEY (id);


--
-- Name: promotion promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT promotion_pkey PRIMARY KEY (id);


--
-- Name: promotion_promotion_rule promotion_promotion_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_promotion_rule
    ADD CONSTRAINT promotion_promotion_rule_pkey PRIMARY KEY (promotion_id, promotion_rule_id);


--
-- Name: promotion_rule promotion_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_rule
    ADD CONSTRAINT promotion_rule_pkey PRIMARY KEY (id);


--
-- Name: promotion_rule_value promotion_rule_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_rule_value
    ADD CONSTRAINT promotion_rule_value_pkey PRIMARY KEY (id);


--
-- Name: property_label property_label_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.property_label
    ADD CONSTRAINT property_label_pkey PRIMARY KEY (id);


--
-- Name: provider_identity provider_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_identity
    ADD CONSTRAINT provider_identity_pkey PRIMARY KEY (id);


--
-- Name: publishable_api_key_sales_channel publishable_api_key_sales_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishable_api_key_sales_channel
    ADD CONSTRAINT publishable_api_key_sales_channel_pkey PRIMARY KEY (publishable_key_id, sales_channel_id);


--
-- Name: refund refund_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_pkey PRIMARY KEY (id);


--
-- Name: refund_reason refund_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_reason
    ADD CONSTRAINT refund_reason_pkey PRIMARY KEY (id);


--
-- Name: region_country region_country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_country
    ADD CONSTRAINT region_country_pkey PRIMARY KEY (iso_2);


--
-- Name: region_payment_provider region_payment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_payment_provider
    ADD CONSTRAINT region_payment_provider_pkey PRIMARY KEY (region_id, payment_provider_id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: reservation_item reservation_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_item
    ADD CONSTRAINT reservation_item_pkey PRIMARY KEY (id);


--
-- Name: return_fulfillment return_fulfillment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_fulfillment
    ADD CONSTRAINT return_fulfillment_pkey PRIMARY KEY (return_id, fulfillment_id);


--
-- Name: return_item return_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_item
    ADD CONSTRAINT return_item_pkey PRIMARY KEY (id);


--
-- Name: return return_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT return_pkey PRIMARY KEY (id);


--
-- Name: return_reason return_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_reason
    ADD CONSTRAINT return_reason_pkey PRIMARY KEY (id);


--
-- Name: sales_channel sales_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_channel
    ADD CONSTRAINT sales_channel_pkey PRIMARY KEY (id);


--
-- Name: sales_channel_stock_location sales_channel_stock_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_channel_stock_location
    ADD CONSTRAINT sales_channel_stock_location_pkey PRIMARY KEY (sales_channel_id, stock_location_id);


--
-- Name: script_migrations script_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.script_migrations
    ADD CONSTRAINT script_migrations_pkey PRIMARY KEY (id);


--
-- Name: service_zone service_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_zone
    ADD CONSTRAINT service_zone_pkey PRIMARY KEY (id);


--
-- Name: shipping_option shipping_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_pkey PRIMARY KEY (id);


--
-- Name: shipping_option_price_set shipping_option_price_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option_price_set
    ADD CONSTRAINT shipping_option_price_set_pkey PRIMARY KEY (shipping_option_id, price_set_id);


--
-- Name: shipping_option_rule shipping_option_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option_rule
    ADD CONSTRAINT shipping_option_rule_pkey PRIMARY KEY (id);


--
-- Name: shipping_option_type shipping_option_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option_type
    ADD CONSTRAINT shipping_option_type_pkey PRIMARY KEY (id);


--
-- Name: shipping_profile shipping_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_profile
    ADD CONSTRAINT shipping_profile_pkey PRIMARY KEY (id);


--
-- Name: stock_location_address stock_location_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_location_address
    ADD CONSTRAINT stock_location_address_pkey PRIMARY KEY (id);


--
-- Name: stock_location stock_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_location
    ADD CONSTRAINT stock_location_pkey PRIMARY KEY (id);


--
-- Name: store_currency store_currency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_currency
    ADD CONSTRAINT store_currency_pkey PRIMARY KEY (id);


--
-- Name: store_locale store_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_locale
    ADD CONSTRAINT store_locale_pkey PRIMARY KEY (id);


--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: tax_provider tax_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_provider
    ADD CONSTRAINT tax_provider_pkey PRIMARY KEY (id);


--
-- Name: tax_rate tax_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT tax_rate_pkey PRIMARY KEY (id);


--
-- Name: tax_rate_rule tax_rate_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate_rule
    ADD CONSTRAINT tax_rate_rule_pkey PRIMARY KEY (id);


--
-- Name: tax_region tax_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_region
    ADD CONSTRAINT tax_region_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_preference user_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preference
    ADD CONSTRAINT user_preference_pkey PRIMARY KEY (id);


--
-- Name: user_rbac_role user_rbac_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_rbac_role
    ADD CONSTRAINT user_rbac_role_pkey PRIMARY KEY (user_id, rbac_role_id);


--
-- Name: view_configuration view_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.view_configuration
    ADD CONSTRAINT view_configuration_pkey PRIMARY KEY (id);


--
-- Name: workflow_execution workflow_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_execution
    ADD CONSTRAINT workflow_execution_pkey PRIMARY KEY (workflow_id, transaction_id, run_id);


--
-- Name: IDX_account_holder_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_account_holder_deleted_at" ON public.account_holder USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_account_holder_id_5cb3a0c0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_account_holder_id_5cb3a0c0" ON public.customer_account_holder USING btree (account_holder_id);


--
-- Name: IDX_account_holder_provider_id_external_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_account_holder_provider_id_external_id_unique" ON public.account_holder USING btree (provider_id, external_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_api_key_deleted_at" ON public.api_key USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_redacted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_api_key_redacted" ON public.api_key USING btree (redacted) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_revoked_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_api_key_revoked_at" ON public.api_key USING btree (revoked_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_api_key_token_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_api_key_token_unique" ON public.api_key USING btree (token);


--
-- Name: IDX_api_key_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_api_key_type" ON public.api_key USING btree (type);


--
-- Name: IDX_application_method_allocation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_application_method_allocation" ON public.promotion_application_method USING btree (allocation);


--
-- Name: IDX_application_method_target_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_application_method_target_type" ON public.promotion_application_method USING btree (target_type);


--
-- Name: IDX_application_method_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_application_method_type" ON public.promotion_application_method USING btree (type);


--
-- Name: IDX_auth_identity_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_identity_deleted_at" ON public.auth_identity USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_mfa_factor_auth_identity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_mfa_factor_auth_identity_id" ON public.auth_mfa_factor USING btree (auth_identity_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_mfa_factor_auth_identity_provider_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_auth_mfa_factor_auth_identity_provider_active" ON public.auth_mfa_factor USING btree (auth_identity_id, provider) WHERE ((deleted_at IS NULL) AND (status = ANY (ARRAY['pending'::text, 'enabled'::text])));


--
-- Name: IDX_auth_mfa_factor_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_mfa_factor_deleted_at" ON public.auth_mfa_factor USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_mfa_recovery_code_auth_identity_code_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_auth_mfa_recovery_code_auth_identity_code_hash" ON public.auth_mfa_recovery_code USING btree (auth_identity_id, code_hash) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_mfa_recovery_code_auth_identity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_mfa_recovery_code_auth_identity_id" ON public.auth_mfa_recovery_code USING btree (auth_identity_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_mfa_recovery_code_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_mfa_recovery_code_deleted_at" ON public.auth_mfa_recovery_code USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_password_reset_token_auth_identity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_password_reset_token_auth_identity_id" ON public.auth_password_reset_token USING btree (auth_identity_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_password_reset_token_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_password_reset_token_deleted_at" ON public.auth_password_reset_token USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_password_reset_token_expires_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_password_reset_token_expires_at" ON public.auth_password_reset_token USING btree (expires_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_password_reset_token_provider_identity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_password_reset_token_provider_identity_id" ON public.auth_password_reset_token USING btree (provider_identity_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_password_reset_token_token_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_password_reset_token_token_hash" ON public.auth_password_reset_token USING btree (token_hash) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_verification_auth_identity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_verification_auth_identity_id" ON public.auth_verification USING btree (auth_identity_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_verification_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_auth_verification_deleted_at" ON public.auth_verification USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_auth_verification_unique_auth_identity_entity_id_entity_typ; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_auth_verification_unique_auth_identity_entity_id_entity_typ" ON public.auth_verification USING btree (auth_identity_id, entity_id, entity_type) WHERE (deleted_at IS NULL);


--
-- Name: IDX_brand_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_brand_deleted_at" ON public.brand USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_brand_id_29c624132; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_brand_id_29c624132" ON public.product_product_brand_brand USING btree (brand_id);


--
-- Name: IDX_campaign_budget_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_campaign_budget_type" ON public.promotion_campaign_budget USING btree (type);


--
-- Name: IDX_capture_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_capture_deleted_at" ON public.capture USING btree (deleted_at);


--
-- Name: IDX_capture_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_capture_payment_id" ON public.capture USING btree (payment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_address_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_address_deleted_at" ON public.cart_address USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_billing_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_billing_address_id" ON public.cart USING btree (billing_address_id) WHERE ((deleted_at IS NULL) AND (billing_address_id IS NOT NULL));


--
-- Name: IDX_cart_credit_line_reference_reference_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_credit_line_reference_reference_id" ON public.credit_line USING btree (reference, reference_id) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_currency_code" ON public.cart USING btree (currency_code);


--
-- Name: IDX_cart_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_customer_id" ON public.cart USING btree (customer_id) WHERE ((deleted_at IS NULL) AND (customer_id IS NOT NULL));


--
-- Name: IDX_cart_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_deleted_at" ON public.cart USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_id_-4a39f6c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_id_-4a39f6c9" ON public.cart_payment_collection USING btree (cart_id);


--
-- Name: IDX_cart_id_-71069c16; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_id_-71069c16" ON public.order_cart USING btree (cart_id);


--
-- Name: IDX_cart_id_-a9d4a70b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_id_-a9d4a70b" ON public.cart_promotion USING btree (cart_id);


--
-- Name: IDX_cart_line_item_adjustment_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_line_item_adjustment_deleted_at" ON public.cart_line_item_adjustment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_line_item_adjustment_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_line_item_adjustment_item_id" ON public.cart_line_item_adjustment USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_line_item_cart_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_line_item_cart_id" ON public.cart_line_item USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_line_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_line_item_deleted_at" ON public.cart_line_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_line_item_tax_line_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_line_item_tax_line_deleted_at" ON public.cart_line_item_tax_line USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_line_item_tax_line_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_line_item_tax_line_item_id" ON public.cart_line_item_tax_line USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_region_id" ON public.cart USING btree (region_id) WHERE ((deleted_at IS NULL) AND (region_id IS NOT NULL));


--
-- Name: IDX_cart_sales_channel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_sales_channel_id" ON public.cart USING btree (sales_channel_id) WHERE ((deleted_at IS NULL) AND (sales_channel_id IS NOT NULL));


--
-- Name: IDX_cart_shipping_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_shipping_address_id" ON public.cart USING btree (shipping_address_id) WHERE ((deleted_at IS NULL) AND (shipping_address_id IS NOT NULL));


--
-- Name: IDX_cart_shipping_method_adjustment_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_shipping_method_adjustment_deleted_at" ON public.cart_shipping_method_adjustment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_shipping_method_adjustment_shipping_method_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_shipping_method_adjustment_shipping_method_id" ON public.cart_shipping_method_adjustment USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_shipping_method_cart_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_shipping_method_cart_id" ON public.cart_shipping_method USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_cart_shipping_method_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_shipping_method_deleted_at" ON public.cart_shipping_method USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_shipping_method_tax_line_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_shipping_method_tax_line_deleted_at" ON public.cart_shipping_method_tax_line USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_cart_shipping_method_tax_line_shipping_method_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cart_shipping_method_tax_line_shipping_method_id" ON public.cart_shipping_method_tax_line USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_category_handle_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_category_handle_unique" ON public.product_category USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_collection_handle_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_collection_handle_unique" ON public.product_collection USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_credit_line_cart_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_credit_line_cart_id" ON public.credit_line USING btree (cart_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_credit_line_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_credit_line_deleted_at" ON public.credit_line USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_address_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_address_customer_id" ON public.customer_address USING btree (customer_id);


--
-- Name: IDX_customer_address_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_address_deleted_at" ON public.customer_address USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_address_unique_customer_billing; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_customer_address_unique_customer_billing" ON public.customer_address USING btree (customer_id) WHERE (is_default_billing = true);


--
-- Name: IDX_customer_address_unique_customer_shipping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_customer_address_unique_customer_shipping" ON public.customer_address USING btree (customer_id) WHERE (is_default_shipping = true);


--
-- Name: IDX_customer_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_deleted_at" ON public.customer USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_email_has_account_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_customer_email_has_account_unique" ON public.customer USING btree (email, has_account) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_customer_customer_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_group_customer_customer_group_id" ON public.customer_group_customer USING btree (customer_group_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_customer_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_group_customer_customer_id" ON public.customer_group_customer USING btree (customer_id);


--
-- Name: IDX_customer_group_customer_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_group_customer_deleted_at" ON public.customer_group_customer USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_group_deleted_at" ON public.customer_group USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_group_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_customer_group_name_unique" ON public.customer_group USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_customer_id_5cb3a0c0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_customer_id_5cb3a0c0" ON public.customer_account_holder USING btree (customer_id);


--
-- Name: IDX_deleted_at_-1d67bae40; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-1e5992737; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-1e5992737" ON public.location_fulfillment_provider USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-31ea43a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-31ea43a" ON public.return_fulfillment USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-4a39f6c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-4a39f6c9" ON public.cart_payment_collection USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-71069c16; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-71069c16" ON public.order_cart USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-71518339; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-71518339" ON public.order_promotion USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-85069d44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-85069d44" ON public.invite_rbac_role USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-a9d4a70b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-a9d4a70b" ON public.cart_promotion USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-e88adb96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-e88adb96" ON public.location_fulfillment_set USING btree (deleted_at);


--
-- Name: IDX_deleted_at_-e8d2543e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_-e8d2543e" ON public.order_fulfillment USING btree (deleted_at);


--
-- Name: IDX_deleted_at_17a262437; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_17a262437" ON public.product_shipping_profile USING btree (deleted_at);


--
-- Name: IDX_deleted_at_17b4c4e35; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_17b4c4e35" ON public.product_variant_inventory_item USING btree (deleted_at);


--
-- Name: IDX_deleted_at_1c934dab0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_1c934dab0" ON public.region_payment_provider USING btree (deleted_at);


--
-- Name: IDX_deleted_at_20b454295; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_20b454295" ON public.product_sales_channel USING btree (deleted_at);


--
-- Name: IDX_deleted_at_26d06f470; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_26d06f470" ON public.sales_channel_stock_location USING btree (deleted_at);


--
-- Name: IDX_deleted_at_29c624132; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_29c624132" ON public.product_product_brand_brand USING btree (deleted_at);


--
-- Name: IDX_deleted_at_52b23597; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_52b23597" ON public.product_variant_price_set USING btree (deleted_at);


--
-- Name: IDX_deleted_at_5cb3a0c0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_5cb3a0c0" ON public.customer_account_holder USING btree (deleted_at);


--
-- Name: IDX_deleted_at_64ff0c4c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_64ff0c4c" ON public.user_rbac_role USING btree (deleted_at);


--
-- Name: IDX_deleted_at_ba32fa9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_ba32fa9c" ON public.shipping_option_price_set USING btree (deleted_at);


--
-- Name: IDX_deleted_at_f42b9949; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_deleted_at_f42b9949" ON public.order_payment_collection USING btree (deleted_at);


--
-- Name: IDX_fulfillment_address_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_address_deleted_at" ON public.fulfillment_address USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_deleted_at" ON public.fulfillment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_id_-31ea43a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_id_-31ea43a" ON public.return_fulfillment USING btree (fulfillment_id);


--
-- Name: IDX_fulfillment_id_-e8d2543e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_id_-e8d2543e" ON public.order_fulfillment USING btree (fulfillment_id);


--
-- Name: IDX_fulfillment_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_item_deleted_at" ON public.fulfillment_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_item_fulfillment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_item_fulfillment_id" ON public.fulfillment_item USING btree (fulfillment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_item_inventory_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_item_inventory_item_id" ON public.fulfillment_item USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_item_line_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_item_line_item_id" ON public.fulfillment_item USING btree (line_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_label_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_label_deleted_at" ON public.fulfillment_label USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_label_fulfillment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_label_fulfillment_id" ON public.fulfillment_label USING btree (fulfillment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_location_id" ON public.fulfillment USING btree (location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_provider_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_provider_deleted_at" ON public.fulfillment_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_provider_id_-1e5992737; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_provider_id_-1e5992737" ON public.location_fulfillment_provider USING btree (fulfillment_provider_id);


--
-- Name: IDX_fulfillment_set_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_set_deleted_at" ON public.fulfillment_set USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_fulfillment_set_id_-e88adb96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_set_id_-e88adb96" ON public.location_fulfillment_set USING btree (fulfillment_set_id);


--
-- Name: IDX_fulfillment_set_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_fulfillment_set_name_unique" ON public.fulfillment_set USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_fulfillment_shipping_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fulfillment_shipping_option_id" ON public.fulfillment USING btree (shipping_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_geo_zone_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_geo_zone_city" ON public.geo_zone USING btree (city) WHERE ((deleted_at IS NULL) AND (city IS NOT NULL));


--
-- Name: IDX_geo_zone_country_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_geo_zone_country_code" ON public.geo_zone USING btree (country_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_geo_zone_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_geo_zone_deleted_at" ON public.geo_zone USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_geo_zone_province_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_geo_zone_province_code" ON public.geo_zone USING btree (province_code) WHERE ((deleted_at IS NULL) AND (province_code IS NOT NULL));


--
-- Name: IDX_geo_zone_service_zone_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_geo_zone_service_zone_id" ON public.geo_zone USING btree (service_zone_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_id_-1d67bae40; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (id);


--
-- Name: IDX_id_-1e5992737; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-1e5992737" ON public.location_fulfillment_provider USING btree (id);


--
-- Name: IDX_id_-31ea43a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-31ea43a" ON public.return_fulfillment USING btree (id);


--
-- Name: IDX_id_-4a39f6c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-4a39f6c9" ON public.cart_payment_collection USING btree (id);


--
-- Name: IDX_id_-71069c16; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-71069c16" ON public.order_cart USING btree (id);


--
-- Name: IDX_id_-71518339; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-71518339" ON public.order_promotion USING btree (id);


--
-- Name: IDX_id_-85069d44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-85069d44" ON public.invite_rbac_role USING btree (id);


--
-- Name: IDX_id_-a9d4a70b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-a9d4a70b" ON public.cart_promotion USING btree (id);


--
-- Name: IDX_id_-e88adb96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-e88adb96" ON public.location_fulfillment_set USING btree (id);


--
-- Name: IDX_id_-e8d2543e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_-e8d2543e" ON public.order_fulfillment USING btree (id);


--
-- Name: IDX_id_17a262437; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_17a262437" ON public.product_shipping_profile USING btree (id);


--
-- Name: IDX_id_17b4c4e35; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_17b4c4e35" ON public.product_variant_inventory_item USING btree (id);


--
-- Name: IDX_id_1c934dab0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_1c934dab0" ON public.region_payment_provider USING btree (id);


--
-- Name: IDX_id_20b454295; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_20b454295" ON public.product_sales_channel USING btree (id);


--
-- Name: IDX_id_26d06f470; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_26d06f470" ON public.sales_channel_stock_location USING btree (id);


--
-- Name: IDX_id_29c624132; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_29c624132" ON public.product_product_brand_brand USING btree (id);


--
-- Name: IDX_id_52b23597; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_52b23597" ON public.product_variant_price_set USING btree (id);


--
-- Name: IDX_id_5cb3a0c0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_5cb3a0c0" ON public.customer_account_holder USING btree (id);


--
-- Name: IDX_id_64ff0c4c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_64ff0c4c" ON public.user_rbac_role USING btree (id);


--
-- Name: IDX_id_ba32fa9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_ba32fa9c" ON public.shipping_option_price_set USING btree (id);


--
-- Name: IDX_id_f42b9949; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_id_f42b9949" ON public.order_payment_collection USING btree (id);


--
-- Name: IDX_image_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_image_deleted_at" ON public.image USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_image_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_image_product_id" ON public.image USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_inventory_item_deleted_at" ON public.inventory_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_inventory_item_id_17b4c4e35; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_inventory_item_id_17b4c4e35" ON public.product_variant_inventory_item USING btree (inventory_item_id);


--
-- Name: IDX_inventory_item_sku; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_inventory_item_sku" ON public.inventory_item USING btree (sku) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_level_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_inventory_level_deleted_at" ON public.inventory_level USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_inventory_level_inventory_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_inventory_level_inventory_item_id" ON public.inventory_level USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_level_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_inventory_level_location_id" ON public.inventory_level USING btree (location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_inventory_level_location_id_inventory_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_inventory_level_location_id_inventory_item_id" ON public.inventory_level USING btree (inventory_item_id, location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_invite_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_invite_deleted_at" ON public.invite USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_invite_email_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_invite_email_unique" ON public.invite USING btree (email) WHERE (deleted_at IS NULL);


--
-- Name: IDX_invite_id_-85069d44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_invite_id_-85069d44" ON public.invite_rbac_role USING btree (invite_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_invite_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_invite_token" ON public.invite USING btree (token) WHERE (deleted_at IS NULL);


--
-- Name: IDX_layout_configuration_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_layout_configuration_deleted_at" ON public.layout_configuration USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_layout_configuration_zone_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_layout_configuration_zone_unique" ON public.layout_configuration USING btree (zone) WHERE ((is_system_default = true) AND (deleted_at IS NULL));


--
-- Name: IDX_layout_configuration_zone_user_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_layout_configuration_zone_user_id_unique" ON public.layout_configuration USING btree (zone, user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_line_item_adjustment_promotion_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_line_item_adjustment_promotion_id" ON public.cart_line_item_adjustment USING btree (promotion_id) WHERE ((deleted_at IS NULL) AND (promotion_id IS NOT NULL));


--
-- Name: IDX_line_item_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_line_item_product_id" ON public.cart_line_item USING btree (product_id) WHERE ((deleted_at IS NULL) AND (product_id IS NOT NULL));


--
-- Name: IDX_line_item_product_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_line_item_product_type_id" ON public.order_line_item USING btree (product_type_id) WHERE ((deleted_at IS NULL) AND (product_type_id IS NOT NULL));


--
-- Name: IDX_line_item_tax_line_tax_rate_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_line_item_tax_line_tax_rate_id" ON public.cart_line_item_tax_line USING btree (tax_rate_id) WHERE ((deleted_at IS NULL) AND (tax_rate_id IS NOT NULL));


--
-- Name: IDX_line_item_variant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_line_item_variant_id" ON public.cart_line_item USING btree (variant_id) WHERE ((deleted_at IS NULL) AND (variant_id IS NOT NULL));


--
-- Name: IDX_notification_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_notification_deleted_at" ON public.notification USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_notification_idempotency_key_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_notification_idempotency_key_unique" ON public.notification USING btree (idempotency_key) WHERE (deleted_at IS NULL);


--
-- Name: IDX_notification_provider_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_notification_provider_deleted_at" ON public.notification_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_notification_provider_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_notification_provider_id" ON public.notification USING btree (provider_id);


--
-- Name: IDX_notification_receiver_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_notification_receiver_id" ON public.notification USING btree (receiver_id);


--
-- Name: IDX_option_value_option_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_option_value_option_id_unique" ON public.product_option_value USING btree (option_id, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_address_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_address_customer_id" ON public.order_address USING btree (customer_id);


--
-- Name: IDX_order_address_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_address_deleted_at" ON public.order_address USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_billing_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_billing_address_id" ON public."order" USING btree (billing_address_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_action_claim_id" ON public.order_change_action USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_action_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_action_deleted_at" ON public.order_change_action USING btree (deleted_at);


--
-- Name: IDX_order_change_action_exchange_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_action_exchange_id" ON public.order_change_action USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_action_order_change_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_action_order_change_id" ON public.order_change_action USING btree (order_change_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_action_order_id" ON public.order_change_action USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_ordering; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_action_ordering" ON public.order_change_action USING btree (ordering) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_action_return_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_action_return_id" ON public.order_change_action USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_change_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_change_type" ON public.order_change USING btree (change_type);


--
-- Name: IDX_order_change_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_claim_id" ON public.order_change USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_deleted_at" ON public.order_change USING btree (deleted_at);


--
-- Name: IDX_order_change_exchange_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_exchange_id" ON public.order_change USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_order_id" ON public.order_change USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_order_id_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_order_id_version" ON public.order_change USING btree (order_id, version);


--
-- Name: IDX_order_change_return_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_return_id" ON public.order_change USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_change_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_status" ON public.order_change USING btree (status) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_change_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_change_version" ON public.order_change USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_deleted_at" ON public.order_claim USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_display_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_display_id" ON public.order_claim USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_item_claim_id" ON public.order_claim_item USING btree (claim_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_item_deleted_at" ON public.order_claim_item USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_image_claim_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_item_image_claim_item_id" ON public.order_claim_item_image USING btree (claim_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_item_image_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_item_image_deleted_at" ON public.order_claim_item_image USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_claim_item_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_item_item_id" ON public.order_claim_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_order_id" ON public.order_claim USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_claim_return_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_claim_return_id" ON public.order_claim USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_credit_line_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_credit_line_deleted_at" ON public.order_credit_line USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_credit_line_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_credit_line_order_id" ON public.order_credit_line USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_credit_line_order_id_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_credit_line_order_id_version" ON public.order_credit_line USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_currency_code" ON public."order" USING btree (currency_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_custom_display_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_order_custom_display_id" ON public."order" USING btree (custom_display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_customer_id" ON public."order" USING btree (customer_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_deleted_at" ON public."order" USING btree (deleted_at);


--
-- Name: IDX_order_display_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_display_id" ON public."order" USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_exchange_deleted_at" ON public.order_exchange USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_display_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_exchange_display_id" ON public.order_exchange USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_exchange_item_deleted_at" ON public.order_exchange_item USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_item_exchange_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_exchange_item_exchange_id" ON public.order_exchange_item USING btree (exchange_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_item_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_exchange_item_item_id" ON public.order_exchange_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_exchange_order_id" ON public.order_exchange USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_exchange_return_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_exchange_return_id" ON public.order_exchange USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_id_-71069c16; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_id_-71069c16" ON public.order_cart USING btree (order_id);


--
-- Name: IDX_order_id_-71518339; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_id_-71518339" ON public.order_promotion USING btree (order_id);


--
-- Name: IDX_order_id_-e8d2543e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_id_-e8d2543e" ON public.order_fulfillment USING btree (order_id);


--
-- Name: IDX_order_id_f42b9949; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_id_f42b9949" ON public.order_payment_collection USING btree (order_id);


--
-- Name: IDX_order_is_draft_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_is_draft_order" ON public."order" USING btree (is_draft_order) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_item_deleted_at" ON public.order_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_item_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_item_item_id" ON public.order_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_item_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_item_order_id" ON public.order_item USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_item_order_id_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_item_order_id_version" ON public.order_item USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_adjustment_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_line_item_adjustment_item_id" ON public.order_line_item_adjustment USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_line_item_product_id" ON public.order_line_item USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_tax_line_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_line_item_tax_line_item_id" ON public.order_line_item_tax_line USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_line_item_variant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_line_item_variant_id" ON public.order_line_item USING btree (variant_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_region_id" ON public."order" USING btree (region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_sales_channel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_sales_channel_id" ON public."order" USING btree (sales_channel_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_address_id" ON public."order" USING btree (shipping_address_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_claim_id" ON public.order_shipping USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_shipping_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_deleted_at" ON public.order_shipping USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_shipping_exchange_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_exchange_id" ON public.order_shipping USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_shipping_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_item_id" ON public.order_shipping USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_method_adjustment_shipping_method_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_method_adjustment_shipping_method_id" ON public.order_shipping_method_adjustment USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_method_adjustment_version_shipping_method; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_order_shipping_method_adjustment_version_shipping_method" ON public.order_shipping_method_adjustment USING btree (version, shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_method_shipping_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_method_shipping_option_id" ON public.order_shipping_method USING btree (shipping_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_method_tax_line_shipping_method_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_method_tax_line_shipping_method_id" ON public.order_shipping_method_tax_line USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_order_id" ON public.order_shipping USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_order_id_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_order_id_version" ON public.order_shipping USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_shipping_return_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_return_id" ON public.order_shipping USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_shipping_shipping_method_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_shipping_shipping_method_id" ON public.order_shipping USING btree (shipping_method_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_summary_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_summary_deleted_at" ON public.order_summary USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_order_summary_order_id_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_summary_order_id_version" ON public.order_summary USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_transaction_claim_id" ON public.order_transaction USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_transaction_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_transaction_currency_code" ON public.order_transaction USING btree (currency_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_exchange_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_transaction_exchange_id" ON public.order_transaction USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_order_transaction_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_transaction_order_id" ON public.order_transaction USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_order_id_version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_transaction_order_id_version" ON public.order_transaction USING btree (order_id, version) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_reference_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_transaction_reference_id" ON public.order_transaction USING btree (reference_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_order_transaction_return_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_transaction_return_id" ON public.order_transaction USING btree (return_id) WHERE ((return_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_payment_collection_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_deleted_at" ON public.payment_collection USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_payment_collection_id_-4a39f6c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_id_-4a39f6c9" ON public.cart_payment_collection USING btree (payment_collection_id);


--
-- Name: IDX_payment_collection_id_f42b9949; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_id_f42b9949" ON public.order_payment_collection USING btree (payment_collection_id);


--
-- Name: IDX_payment_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_deleted_at" ON public.payment USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_payment_payment_collection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_payment_collection_id" ON public.payment USING btree (payment_collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_payment_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_payment_session_id" ON public.payment USING btree (payment_session_id);


--
-- Name: IDX_payment_payment_session_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_payment_payment_session_id_unique" ON public.payment USING btree (payment_session_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_provider_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_provider_deleted_at" ON public.payment_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_provider_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_provider_id" ON public.payment USING btree (provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_provider_id_1c934dab0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_provider_id_1c934dab0" ON public.region_payment_provider USING btree (payment_provider_id);


--
-- Name: IDX_payment_session_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_session_deleted_at" ON public.payment_session USING btree (deleted_at);


--
-- Name: IDX_payment_session_payment_collection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_session_payment_collection_id" ON public.payment_session USING btree (payment_collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_currency_code" ON public.price USING btree (currency_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_deleted_at" ON public.price USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_list_deleted_at" ON public.price_list USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_id_status_starts_at_ends_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_list_id_status_starts_at_ends_at" ON public.price_list USING btree (id, status, starts_at, ends_at) WHERE ((deleted_at IS NULL) AND (status = 'active'::text));


--
-- Name: IDX_price_list_rule_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_list_rule_attribute" ON public.price_list_rule USING btree (attribute) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_list_rule_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_list_rule_deleted_at" ON public.price_list_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_rule_price_list_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_list_rule_price_list_id" ON public.price_list_rule USING btree (price_list_id) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_list_rule_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_list_rule_value" ON public.price_list_rule USING gin (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_preference_attribute_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_price_preference_attribute_value" ON public.price_preference USING btree (attribute, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_preference_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_preference_deleted_at" ON public.price_preference USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_price_list_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_price_list_id" ON public.price USING btree (price_list_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_price_set_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_price_set_id" ON public.price USING btree (price_set_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_rule_attribute" ON public.price_rule USING btree (attribute) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_attribute_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_rule_attribute_value" ON public.price_rule USING btree (attribute, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_attribute_value_price_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_rule_attribute_value_price_id" ON public.price_rule USING btree (attribute, value, price_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_rule_deleted_at" ON public.price_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_rule_operator; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_rule_operator" ON public.price_rule USING btree (operator);


--
-- Name: IDX_price_rule_operator_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_rule_operator_value" ON public.price_rule USING btree (operator, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_price_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_rule_price_id" ON public.price_rule USING btree (price_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_rule_price_id_attribute_operator_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_price_rule_price_id_attribute_operator_unique" ON public.price_rule USING btree (price_id, attribute, operator) WHERE (deleted_at IS NULL);


--
-- Name: IDX_price_set_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_set_deleted_at" ON public.price_set USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_price_set_id_52b23597; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_set_id_52b23597" ON public.product_variant_price_set USING btree (price_set_id);


--
-- Name: IDX_price_set_id_ba32fa9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_price_set_id_ba32fa9c" ON public.shipping_option_price_set USING btree (price_set_id);


--
-- Name: IDX_product_category_parent_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_category_parent_category_id" ON public.product_category USING btree (parent_category_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_category_path; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_category_path" ON public.product_category USING btree (mpath) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_collection_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_collection_deleted_at" ON public.product_collection USING btree (deleted_at);


--
-- Name: IDX_product_collection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_collection_id" ON public.product USING btree (collection_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_deleted_at" ON public.product USING btree (deleted_at);


--
-- Name: IDX_product_handle_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_product_handle_unique" ON public.product USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_id_17a262437; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_id_17a262437" ON public.product_shipping_profile USING btree (product_id);


--
-- Name: IDX_product_id_20b454295; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_id_20b454295" ON public.product_sales_channel USING btree (product_id);


--
-- Name: IDX_product_id_29c624132; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_id_29c624132" ON public.product_product_brand_brand USING btree (product_id);


--
-- Name: IDX_product_image_rank; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_image_rank" ON public.image USING btree (rank) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_image_rank_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_image_rank_product_id" ON public.image USING btree (rank, product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_image_url; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_image_url" ON public.image USING btree (url) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_image_url_rank_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_image_url_rank_product_id" ON public.image USING btree (url, rank, product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_option_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_option_deleted_at" ON public.product_option USING btree (deleted_at);


--
-- Name: IDX_product_option_value_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_option_value_deleted_at" ON public.product_option_value USING btree (deleted_at);


--
-- Name: IDX_product_option_value_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_option_value_option_id" ON public.product_option_value USING btree (option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_product_option_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_product_option_deleted_at" ON public.product_product_option USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_product_option_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_product_option_product_id" ON public.product_product_option USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_product_option_product_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_product_option_product_option_id" ON public.product_product_option USING btree (product_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_product_option_value_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_product_option_value_deleted_at" ON public.product_product_option_value USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_product_option_value_product_option_value_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_product_option_value_product_option_value_id" ON public.product_product_option_value USING btree (product_option_value_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_product_option_value_product_product_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_product_option_value_product_product_option_id" ON public.product_product_option_value USING btree (product_product_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_status" ON public.product USING btree (status) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_tag_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_tag_deleted_at" ON public.product_tag USING btree (deleted_at);


--
-- Name: IDX_product_type_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_type_deleted_at" ON public.product_type USING btree (deleted_at);


--
-- Name: IDX_product_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_type_id" ON public.product USING btree (type_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_barcode_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_product_variant_barcode_unique" ON public.product_variant USING btree (barcode) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_deleted_at" ON public.product_variant USING btree (deleted_at);


--
-- Name: IDX_product_variant_ean_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_product_variant_ean_unique" ON public.product_variant USING btree (ean) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_id_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_id_product_id" ON public.product_variant USING btree (id, product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_product_id" ON public.product_variant USING btree (product_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_image_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_product_image_deleted_at" ON public.product_variant_product_image USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_image_image_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_product_image_image_id" ON public.product_variant_product_image USING btree (image_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_product_image_variant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_product_image_variant_id" ON public.product_variant_product_image USING btree (variant_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_sku_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_product_variant_sku_unique" ON public.product_variant USING btree (sku) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_upc_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_product_variant_upc_unique" ON public.product_variant USING btree (upc) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_application_method_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_application_method_currency_code" ON public.promotion_application_method USING btree (currency_code) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_promotion_application_method_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_application_method_deleted_at" ON public.promotion_application_method USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_application_method_promotion_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_promotion_application_method_promotion_id_unique" ON public.promotion_application_method USING btree (promotion_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_campaign_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_promotion_campaign_budget_campaign_id_unique" ON public.promotion_campaign_budget USING btree (campaign_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_campaign_budget_deleted_at" ON public.promotion_campaign_budget USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_usage_attribute_value_budget_id_u; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_promotion_campaign_budget_usage_attribute_value_budget_id_u" ON public.promotion_campaign_budget_usage USING btree (attribute_value, budget_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_usage_budget_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_campaign_budget_usage_budget_id" ON public.promotion_campaign_budget_usage USING btree (budget_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_budget_usage_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_campaign_budget_usage_deleted_at" ON public.promotion_campaign_budget_usage USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_campaign_identifier_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_promotion_campaign_campaign_identifier_unique" ON public.promotion_campaign USING btree (campaign_identifier) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_campaign_deleted_at" ON public.promotion_campaign USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_campaign_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_campaign_id" ON public.promotion USING btree (campaign_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_deleted_at" ON public.promotion USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_id_-71518339; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_id_-71518339" ON public.order_promotion USING btree (promotion_id);


--
-- Name: IDX_promotion_id_-a9d4a70b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_id_-a9d4a70b" ON public.cart_promotion USING btree (promotion_id);


--
-- Name: IDX_promotion_is_automatic; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_is_automatic" ON public.promotion USING btree (is_automatic) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_attribute" ON public.promotion_rule USING btree (attribute);


--
-- Name: IDX_promotion_rule_attribute_operator; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_attribute_operator" ON public.promotion_rule USING btree (attribute, operator) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_attribute_operator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_attribute_operator_id" ON public.promotion_rule USING btree (operator, attribute, id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_deleted_at" ON public.promotion_rule USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_operator; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_operator" ON public.promotion_rule USING btree (operator);


--
-- Name: IDX_promotion_rule_value_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_value_deleted_at" ON public.promotion_rule_value USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_value_promotion_rule_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_value_promotion_rule_id" ON public.promotion_rule_value USING btree (promotion_rule_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_value_rule_id_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_value_rule_id_value" ON public.promotion_rule_value USING btree (promotion_rule_id, value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_rule_value_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_rule_value_value" ON public.promotion_rule_value USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_status" ON public.promotion USING btree (status) WHERE (deleted_at IS NULL);


--
-- Name: IDX_promotion_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_promotion_type" ON public.promotion USING btree (type);


--
-- Name: IDX_property_label_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_property_label_deleted_at" ON public.property_label USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_property_label_entity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_property_label_entity" ON public.property_label USING btree (entity) WHERE (deleted_at IS NULL);


--
-- Name: IDX_property_label_entity_property_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_property_label_entity_property_unique" ON public.property_label USING btree (entity, property) WHERE (deleted_at IS NULL);


--
-- Name: IDX_provider_identity_auth_identity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_provider_identity_auth_identity_id" ON public.provider_identity USING btree (auth_identity_id);


--
-- Name: IDX_provider_identity_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_provider_identity_deleted_at" ON public.provider_identity USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_provider_identity_provider_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_provider_identity_provider_entity_id" ON public.provider_identity USING btree (entity_id, provider);


--
-- Name: IDX_publishable_key_id_-1d67bae40; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_publishable_key_id_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (publishable_key_id);


--
-- Name: IDX_rbac_role_id_-85069d44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_rbac_role_id_-85069d44" ON public.invite_rbac_role USING btree (rbac_role_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_rbac_role_id_64ff0c4c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_rbac_role_id_64ff0c4c" ON public.user_rbac_role USING btree (rbac_role_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_refund_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_refund_deleted_at" ON public.refund USING btree (deleted_at);


--
-- Name: IDX_refund_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_refund_payment_id" ON public.refund USING btree (payment_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_refund_reason_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_refund_reason_deleted_at" ON public.refund_reason USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_refund_refund_reason_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_refund_refund_reason_id" ON public.refund USING btree (refund_reason_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_region_country_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_region_country_deleted_at" ON public.region_country USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_region_country_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_region_country_region_id" ON public.region_country USING btree (region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_region_country_region_id_iso_2_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_region_country_region_id_iso_2_unique" ON public.region_country USING btree (region_id, iso_2);


--
-- Name: IDX_region_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_region_deleted_at" ON public.region USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_region_id_1c934dab0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_region_id_1c934dab0" ON public.region_payment_provider USING btree (region_id);


--
-- Name: IDX_reservation_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_reservation_item_deleted_at" ON public.reservation_item USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_reservation_item_inventory_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_reservation_item_inventory_item_id" ON public.reservation_item USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_reservation_item_line_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_reservation_item_line_item_id" ON public.reservation_item USING btree (line_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_reservation_item_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_reservation_item_location_id" ON public.reservation_item USING btree (location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_claim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_claim_id" ON public.return USING btree (claim_id) WHERE ((claim_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_return_display_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_display_id" ON public.return USING btree (display_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_exchange_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_exchange_id" ON public.return USING btree (exchange_id) WHERE ((exchange_id IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_return_id_-31ea43a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_id_-31ea43a" ON public.return_fulfillment USING btree (return_id);


--
-- Name: IDX_return_item_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_item_deleted_at" ON public.return_item USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_item_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_item_item_id" ON public.return_item USING btree (item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_item_reason_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_item_reason_id" ON public.return_item USING btree (reason_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_item_return_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_item_return_id" ON public.return_item USING btree (return_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_order_id" ON public.return USING btree (order_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_reason_parent_return_reason_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_reason_parent_return_reason_id" ON public.return_reason USING btree (parent_return_reason_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_return_reason_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_return_reason_value" ON public.return_reason USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_sales_channel_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_sales_channel_deleted_at" ON public.sales_channel USING btree (deleted_at);


--
-- Name: IDX_sales_channel_id_-1d67bae40; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_sales_channel_id_-1d67bae40" ON public.publishable_api_key_sales_channel USING btree (sales_channel_id);


--
-- Name: IDX_sales_channel_id_20b454295; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_sales_channel_id_20b454295" ON public.product_sales_channel USING btree (sales_channel_id);


--
-- Name: IDX_sales_channel_id_26d06f470; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_sales_channel_id_26d06f470" ON public.sales_channel_stock_location USING btree (sales_channel_id);


--
-- Name: IDX_service_zone_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_service_zone_deleted_at" ON public.service_zone USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_service_zone_fulfillment_set_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_service_zone_fulfillment_set_id" ON public.service_zone USING btree (fulfillment_set_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_service_zone_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_service_zone_name_unique" ON public.service_zone USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_method_adjustment_promotion_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_method_adjustment_promotion_id" ON public.cart_shipping_method_adjustment USING btree (promotion_id) WHERE ((deleted_at IS NULL) AND (promotion_id IS NOT NULL));


--
-- Name: IDX_shipping_method_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_method_option_id" ON public.cart_shipping_method USING btree (shipping_option_id) WHERE ((deleted_at IS NULL) AND (shipping_option_id IS NOT NULL));


--
-- Name: IDX_shipping_method_tax_line_tax_rate_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_method_tax_line_tax_rate_id" ON public.cart_shipping_method_tax_line USING btree (tax_rate_id) WHERE ((deleted_at IS NULL) AND (tax_rate_id IS NOT NULL));


--
-- Name: IDX_shipping_option_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_deleted_at" ON public.shipping_option USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_option_id_ba32fa9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_id_ba32fa9c" ON public.shipping_option_price_set USING btree (shipping_option_id);


--
-- Name: IDX_shipping_option_provider_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_provider_id" ON public.shipping_option USING btree (provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_rule_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_rule_deleted_at" ON public.shipping_option_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_option_rule_shipping_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_rule_shipping_option_id" ON public.shipping_option_rule USING btree (shipping_option_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_service_zone_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_service_zone_id" ON public.shipping_option USING btree (service_zone_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_shipping_option_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_shipping_option_type_id" ON public.shipping_option USING btree (shipping_option_type_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_shipping_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_shipping_profile_id" ON public.shipping_option USING btree (shipping_profile_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_shipping_option_type_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_option_type_deleted_at" ON public.shipping_option_type USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_profile_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_profile_deleted_at" ON public.shipping_profile USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_shipping_profile_id_17a262437; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_shipping_profile_id_17a262437" ON public.product_shipping_profile USING btree (shipping_profile_id);


--
-- Name: IDX_shipping_profile_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_shipping_profile_name_unique" ON public.shipping_profile USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_single_default_region; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_single_default_region" ON public.tax_rate USING btree (tax_region_id) WHERE ((is_default = true) AND (deleted_at IS NULL));


--
-- Name: IDX_stock_location_address_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_stock_location_address_deleted_at" ON public.stock_location_address USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_stock_location_address_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_stock_location_address_id_unique" ON public.stock_location USING btree (address_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_stock_location_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_stock_location_deleted_at" ON public.stock_location USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_stock_location_id_-1e5992737; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_stock_location_id_-1e5992737" ON public.location_fulfillment_provider USING btree (stock_location_id);


--
-- Name: IDX_stock_location_id_-e88adb96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_stock_location_id_-e88adb96" ON public.location_fulfillment_set USING btree (stock_location_id);


--
-- Name: IDX_stock_location_id_26d06f470; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_stock_location_id_26d06f470" ON public.sales_channel_stock_location USING btree (stock_location_id);


--
-- Name: IDX_store_currency_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_store_currency_deleted_at" ON public.store_currency USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_store_currency_store_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_store_currency_store_id" ON public.store_currency USING btree (store_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_store_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_store_deleted_at" ON public.store USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_store_locale_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_store_locale_deleted_at" ON public.store_locale USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_store_locale_store_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_store_locale_store_id" ON public.store_locale USING btree (store_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tag_value_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_tag_value_unique" ON public.product_tag USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_provider_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_provider_deleted_at" ON public.tax_provider USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_rate_deleted_at" ON public.tax_rate USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_tax_rate_rule_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_rate_rule_deleted_at" ON public.tax_rate_rule USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_tax_rate_rule_reference_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_rate_rule_reference_id" ON public.tax_rate_rule USING btree (reference_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_rule_tax_rate_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_rate_rule_tax_rate_id" ON public.tax_rate_rule USING btree (tax_rate_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_rule_unique_rate_reference; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_tax_rate_rule_unique_rate_reference" ON public.tax_rate_rule USING btree (tax_rate_id, reference_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_rate_tax_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_rate_tax_region_id" ON public.tax_rate USING btree (tax_region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_region_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_region_deleted_at" ON public.tax_region USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_tax_region_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_region_parent_id" ON public.tax_region USING btree (parent_id);


--
-- Name: IDX_tax_region_provider_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_tax_region_provider_id" ON public.tax_region USING btree (provider_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_tax_region_unique_country_nullable_province; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_tax_region_unique_country_nullable_province" ON public.tax_region USING btree (country_code) WHERE ((province_code IS NULL) AND (deleted_at IS NULL));


--
-- Name: IDX_tax_region_unique_country_province; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_tax_region_unique_country_province" ON public.tax_region USING btree (country_code, province_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_type_value_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_type_value_unique" ON public.product_type USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_unique_promotion_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_unique_promotion_code" ON public.promotion USING btree (code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_deleted_at" ON public."user" USING btree (deleted_at) WHERE (deleted_at IS NOT NULL);


--
-- Name: IDX_user_email_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_user_email_unique" ON public."user" USING btree (email) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_id_64ff0c4c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_id_64ff0c4c" ON public.user_rbac_role USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_preference_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_preference_deleted_at" ON public.user_preference USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_preference_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_preference_user_id" ON public.user_preference USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_user_preference_user_id_key_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_user_preference_user_id_key_unique" ON public.user_preference USING btree (user_id, key) WHERE (deleted_at IS NULL);


--
-- Name: IDX_variant_id_17b4c4e35; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_variant_id_17b4c4e35" ON public.product_variant_inventory_item USING btree (variant_id);


--
-- Name: IDX_variant_id_52b23597; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_variant_id_52b23597" ON public.product_variant_price_set USING btree (variant_id);


--
-- Name: IDX_view_configuration_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_view_configuration_deleted_at" ON public.view_configuration USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_view_configuration_entity_is_system_default; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_view_configuration_entity_is_system_default" ON public.view_configuration USING btree (entity, is_system_default) WHERE (deleted_at IS NULL);


--
-- Name: IDX_view_configuration_entity_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_view_configuration_entity_user_id" ON public.view_configuration USING btree (entity, user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_view_configuration_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_view_configuration_user_id" ON public.view_configuration USING btree (user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_deleted_at" ON public.workflow_execution USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_id" ON public.workflow_execution USING btree (id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_retention_time_updated_at_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_retention_time_updated_at_state" ON public.workflow_execution USING btree (retention_time, updated_at, state) WHERE ((deleted_at IS NULL) AND (retention_time IS NOT NULL));


--
-- Name: IDX_workflow_execution_run_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_run_id" ON public.workflow_execution USING btree (run_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_state" ON public.workflow_execution USING btree (state) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_state_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_state_updated_at" ON public.workflow_execution USING btree (state, updated_at) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_transaction_id" ON public.workflow_execution USING btree (transaction_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_updated_at_retention_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_updated_at_retention_time" ON public.workflow_execution USING btree (updated_at, retention_time) WHERE ((deleted_at IS NULL) AND (retention_time IS NOT NULL) AND ((state)::text = ANY ((ARRAY['done'::character varying, 'failed'::character varying, 'reverted'::character varying])::text[])));


--
-- Name: IDX_workflow_execution_workflow_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_workflow_id" ON public.workflow_execution USING btree (workflow_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_workflow_id_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_workflow_execution_workflow_id_transaction_id" ON public.workflow_execution USING btree (workflow_id, transaction_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_workflow_execution_workflow_id_transaction_id_run_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_workflow_execution_workflow_id_transaction_id_run_id_unique" ON public.workflow_execution USING btree (workflow_id, transaction_id, run_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_script_name_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_script_name_unique ON public.script_migrations USING btree (script_name);


--
-- Name: tax_rate_rule FK_tax_rate_rule_tax_rate_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate_rule
    ADD CONSTRAINT "FK_tax_rate_rule_tax_rate_id" FOREIGN KEY (tax_rate_id) REFERENCES public.tax_rate(id) ON DELETE CASCADE;


--
-- Name: tax_rate FK_tax_rate_tax_region_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "FK_tax_rate_tax_region_id" FOREIGN KEY (tax_region_id) REFERENCES public.tax_region(id) ON DELETE CASCADE;


--
-- Name: tax_region FK_tax_region_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_region
    ADD CONSTRAINT "FK_tax_region_parent_id" FOREIGN KEY (parent_id) REFERENCES public.tax_region(id) ON DELETE CASCADE;


--
-- Name: tax_region FK_tax_region_provider_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_region
    ADD CONSTRAINT "FK_tax_region_provider_id" FOREIGN KEY (provider_id) REFERENCES public.tax_provider(id) ON DELETE SET NULL;


--
-- Name: application_method_buy_rules application_method_buy_rules_application_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_method_buy_rules
    ADD CONSTRAINT application_method_buy_rules_application_method_id_foreign FOREIGN KEY (application_method_id) REFERENCES public.promotion_application_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: application_method_buy_rules application_method_buy_rules_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_method_buy_rules
    ADD CONSTRAINT application_method_buy_rules_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: application_method_target_rules application_method_target_rules_application_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_method_target_rules
    ADD CONSTRAINT application_method_target_rules_application_method_id_foreign FOREIGN KEY (application_method_id) REFERENCES public.promotion_application_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: application_method_target_rules application_method_target_rules_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_method_target_rules
    ADD CONSTRAINT application_method_target_rules_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_mfa_factor auth_mfa_factor_auth_identity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_mfa_factor
    ADD CONSTRAINT auth_mfa_factor_auth_identity_id_foreign FOREIGN KEY (auth_identity_id) REFERENCES public.auth_identity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_mfa_recovery_code auth_mfa_recovery_code_auth_identity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_mfa_recovery_code
    ADD CONSTRAINT auth_mfa_recovery_code_auth_identity_id_foreign FOREIGN KEY (auth_identity_id) REFERENCES public.auth_identity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_password_reset_token auth_password_reset_token_auth_identity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_password_reset_token
    ADD CONSTRAINT auth_password_reset_token_auth_identity_id_foreign FOREIGN KEY (auth_identity_id) REFERENCES public.auth_identity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_password_reset_token auth_password_reset_token_provider_identity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_password_reset_token
    ADD CONSTRAINT auth_password_reset_token_provider_identity_id_foreign FOREIGN KEY (provider_identity_id) REFERENCES public.provider_identity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_verification auth_verification_auth_identity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_verification
    ADD CONSTRAINT auth_verification_auth_identity_id_foreign FOREIGN KEY (auth_identity_id) REFERENCES public.auth_identity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: capture capture_payment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capture
    ADD CONSTRAINT capture_payment_id_foreign FOREIGN KEY (payment_id) REFERENCES public.payment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart cart_billing_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_billing_address_id_foreign FOREIGN KEY (billing_address_id) REFERENCES public.cart_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cart_line_item_adjustment cart_line_item_adjustment_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_line_item_adjustment
    ADD CONSTRAINT cart_line_item_adjustment_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.cart_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_line_item cart_line_item_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_line_item
    ADD CONSTRAINT cart_line_item_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_line_item_tax_line cart_line_item_tax_line_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_line_item_tax_line
    ADD CONSTRAINT cart_line_item_tax_line_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.cart_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart cart_shipping_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_shipping_address_id_foreign FOREIGN KEY (shipping_address_id) REFERENCES public.cart_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cart_shipping_method_adjustment cart_shipping_method_adjustment_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_shipping_method_adjustment
    ADD CONSTRAINT cart_shipping_method_adjustment_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.cart_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_shipping_method cart_shipping_method_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_shipping_method
    ADD CONSTRAINT cart_shipping_method_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_shipping_method_tax_line cart_shipping_method_tax_line_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_shipping_method_tax_line
    ADD CONSTRAINT cart_shipping_method_tax_line_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.cart_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: credit_line credit_line_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_line
    ADD CONSTRAINT credit_line_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON UPDATE CASCADE;


--
-- Name: customer_address customer_address_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_group_customer customer_group_customer_customer_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group_customer
    ADD CONSTRAINT customer_group_customer_customer_group_id_foreign FOREIGN KEY (customer_group_id) REFERENCES public.customer_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_group_customer customer_group_customer_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group_customer
    ADD CONSTRAINT customer_group_customer_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fulfillment fulfillment_delivery_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_delivery_address_id_foreign FOREIGN KEY (delivery_address_id) REFERENCES public.fulfillment_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fulfillment_item fulfillment_item_fulfillment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_item
    ADD CONSTRAINT fulfillment_item_fulfillment_id_foreign FOREIGN KEY (fulfillment_id) REFERENCES public.fulfillment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fulfillment_label fulfillment_label_fulfillment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_label
    ADD CONSTRAINT fulfillment_label_fulfillment_id_foreign FOREIGN KEY (fulfillment_id) REFERENCES public.fulfillment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fulfillment fulfillment_provider_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_provider_id_foreign FOREIGN KEY (provider_id) REFERENCES public.fulfillment_provider(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fulfillment fulfillment_shipping_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT fulfillment_shipping_option_id_foreign FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: geo_zone geo_zone_service_zone_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.geo_zone
    ADD CONSTRAINT geo_zone_service_zone_id_foreign FOREIGN KEY (service_zone_id) REFERENCES public.service_zone(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: image image_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_level inventory_level_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_level
    ADD CONSTRAINT inventory_level_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notification notification_provider_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_provider_id_foreign FOREIGN KEY (provider_id) REFERENCES public.notification_provider(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order order_billing_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_billing_address_id_foreign FOREIGN KEY (billing_address_id) REFERENCES public.order_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_change_action order_change_action_order_change_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_change_action
    ADD CONSTRAINT order_change_action_order_change_id_foreign FOREIGN KEY (order_change_id) REFERENCES public.order_change(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_change order_change_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_change
    ADD CONSTRAINT order_change_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_credit_line order_credit_line_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_credit_line
    ADD CONSTRAINT order_credit_line_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_item order_item_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.order_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_item order_item_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_line_item_adjustment order_line_item_adjustment_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_line_item_adjustment
    ADD CONSTRAINT order_line_item_adjustment_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.order_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_line_item_tax_line order_line_item_tax_line_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_line_item_tax_line
    ADD CONSTRAINT order_line_item_tax_line_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.order_line_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_line_item order_line_item_totals_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_line_item
    ADD CONSTRAINT order_line_item_totals_id_foreign FOREIGN KEY (totals_id) REFERENCES public.order_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order order_shipping_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_shipping_address_id_foreign FOREIGN KEY (shipping_address_id) REFERENCES public.order_address(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_shipping_method_adjustment order_shipping_method_adjustment_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipping_method_adjustment
    ADD CONSTRAINT order_shipping_method_adjustment_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.order_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_shipping_method_tax_line order_shipping_method_tax_line_shipping_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipping_method_tax_line
    ADD CONSTRAINT order_shipping_method_tax_line_shipping_method_id_foreign FOREIGN KEY (shipping_method_id) REFERENCES public.order_shipping_method(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_shipping order_shipping_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipping
    ADD CONSTRAINT order_shipping_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_summary order_summary_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_summary
    ADD CONSTRAINT order_summary_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_transaction order_transaction_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_transaction
    ADD CONSTRAINT order_transaction_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_collection_payment_providers payment_collection_payment_providers_payment_col_aa276_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_payment_providers
    ADD CONSTRAINT payment_collection_payment_providers_payment_col_aa276_foreign FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_collection_payment_providers payment_collection_payment_providers_payment_pro_2d555_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_payment_providers
    ADD CONSTRAINT payment_collection_payment_providers_payment_pro_2d555_foreign FOREIGN KEY (payment_provider_id) REFERENCES public.payment_provider(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment payment_payment_collection_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_payment_collection_id_foreign FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_session payment_session_payment_collection_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_session
    ADD CONSTRAINT payment_session_payment_collection_id_foreign FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price_list_rule price_list_rule_price_list_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_list_rule
    ADD CONSTRAINT price_list_rule_price_list_id_foreign FOREIGN KEY (price_list_id) REFERENCES public.price_list(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price price_price_list_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_price_list_id_foreign FOREIGN KEY (price_list_id) REFERENCES public.price_list(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price price_price_set_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_price_set_id_foreign FOREIGN KEY (price_set_id) REFERENCES public.price_set(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price_rule price_rule_price_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_rule
    ADD CONSTRAINT price_rule_price_id_foreign FOREIGN KEY (price_id) REFERENCES public.price(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category product_category_parent_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_parent_category_id_foreign FOREIGN KEY (parent_category_id) REFERENCES public.product_category(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category_product product_category_product_product_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT product_category_product_product_category_id_foreign FOREIGN KEY (product_category_id) REFERENCES public.product_category(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category_product product_category_product_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT product_category_product_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product product_collection_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_collection_id_foreign FOREIGN KEY (collection_id) REFERENCES public.product_collection(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: product_option_value product_option_value_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option_value
    ADD CONSTRAINT product_option_value_option_id_foreign FOREIGN KEY (option_id) REFERENCES public.product_option(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_product_option product_product_option_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_option
    ADD CONSTRAINT product_product_option_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_product_option product_product_option_product_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_option
    ADD CONSTRAINT product_product_option_product_option_id_foreign FOREIGN KEY (product_option_id) REFERENCES public.product_option(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_product_option_value product_product_option_value_product_option_value_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_option_value
    ADD CONSTRAINT product_product_option_value_product_option_value_id_foreign FOREIGN KEY (product_option_value_id) REFERENCES public.product_option_value(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_product_option_value product_product_option_value_product_product_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_option_value
    ADD CONSTRAINT product_product_option_value_product_product_option_id_foreign FOREIGN KEY (product_product_option_id) REFERENCES public.product_product_option(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_tags product_tags_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_tags product_tags_product_tag_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_product_tag_id_foreign FOREIGN KEY (product_tag_id) REFERENCES public.product_tag(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product product_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_type_id_foreign FOREIGN KEY (type_id) REFERENCES public.product_type(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: product_variant_option product_variant_option_option_value_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_option
    ADD CONSTRAINT product_variant_option_option_value_id_foreign FOREIGN KEY (option_value_id) REFERENCES public.product_option_value(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant_option product_variant_option_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_option
    ADD CONSTRAINT product_variant_option_variant_id_foreign FOREIGN KEY (variant_id) REFERENCES public.product_variant(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant product_variant_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT product_variant_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant_product_image product_variant_product_image_image_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_product_image
    ADD CONSTRAINT product_variant_product_image_image_id_foreign FOREIGN KEY (image_id) REFERENCES public.image(id) ON DELETE CASCADE;


--
-- Name: promotion_application_method promotion_application_method_promotion_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_application_method
    ADD CONSTRAINT promotion_application_method_promotion_id_foreign FOREIGN KEY (promotion_id) REFERENCES public.promotion(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_campaign_budget promotion_campaign_budget_campaign_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_campaign_budget
    ADD CONSTRAINT promotion_campaign_budget_campaign_id_foreign FOREIGN KEY (campaign_id) REFERENCES public.promotion_campaign(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_campaign_budget_usage promotion_campaign_budget_usage_budget_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_campaign_budget_usage
    ADD CONSTRAINT promotion_campaign_budget_usage_budget_id_foreign FOREIGN KEY (budget_id) REFERENCES public.promotion_campaign_budget(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion promotion_campaign_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion
    ADD CONSTRAINT promotion_campaign_id_foreign FOREIGN KEY (campaign_id) REFERENCES public.promotion_campaign(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: promotion_promotion_rule promotion_promotion_rule_promotion_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_promotion_rule
    ADD CONSTRAINT promotion_promotion_rule_promotion_id_foreign FOREIGN KEY (promotion_id) REFERENCES public.promotion(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_promotion_rule promotion_promotion_rule_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_promotion_rule
    ADD CONSTRAINT promotion_promotion_rule_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promotion_rule_value promotion_rule_value_promotion_rule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_rule_value
    ADD CONSTRAINT promotion_rule_value_promotion_rule_id_foreign FOREIGN KEY (promotion_rule_id) REFERENCES public.promotion_rule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: provider_identity provider_identity_auth_identity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_identity
    ADD CONSTRAINT provider_identity_auth_identity_id_foreign FOREIGN KEY (auth_identity_id) REFERENCES public.auth_identity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: refund refund_payment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_payment_id_foreign FOREIGN KEY (payment_id) REFERENCES public.payment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region_country region_country_region_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_country
    ADD CONSTRAINT region_country_region_id_foreign FOREIGN KEY (region_id) REFERENCES public.region(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reservation_item reservation_item_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_item
    ADD CONSTRAINT reservation_item_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_item(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: return_reason return_reason_parent_return_reason_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_reason
    ADD CONSTRAINT return_reason_parent_return_reason_id_foreign FOREIGN KEY (parent_return_reason_id) REFERENCES public.return_reason(id);


--
-- Name: service_zone service_zone_fulfillment_set_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_zone
    ADD CONSTRAINT service_zone_fulfillment_set_id_foreign FOREIGN KEY (fulfillment_set_id) REFERENCES public.fulfillment_set(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option shipping_option_provider_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_provider_id_foreign FOREIGN KEY (provider_id) REFERENCES public.fulfillment_provider(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: shipping_option_rule shipping_option_rule_shipping_option_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option_rule
    ADD CONSTRAINT shipping_option_rule_shipping_option_id_foreign FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option shipping_option_service_zone_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_service_zone_id_foreign FOREIGN KEY (service_zone_id) REFERENCES public.service_zone(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option shipping_option_shipping_option_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_shipping_option_type_id_foreign FOREIGN KEY (shipping_option_type_id) REFERENCES public.shipping_option_type(id) ON UPDATE CASCADE;


--
-- Name: shipping_option shipping_option_shipping_profile_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_shipping_profile_id_foreign FOREIGN KEY (shipping_profile_id) REFERENCES public.shipping_profile(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: stock_location stock_location_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_location
    ADD CONSTRAINT stock_location_address_id_foreign FOREIGN KEY (address_id) REFERENCES public.stock_location_address(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_currency store_currency_store_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_currency
    ADD CONSTRAINT store_currency_store_id_foreign FOREIGN KEY (store_id) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: store_locale store_locale_store_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_locale
    ADD CONSTRAINT store_locale_store_id_foreign FOREIGN KEY (store_id) REFERENCES public.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict j3J3EwsrJXmRzd2MZl5ak16E3wLDjpbYjTOvuWVQyucTpfMjFrbKPzoP4pp8H4h

