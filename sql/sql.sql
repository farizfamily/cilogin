--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE customers (
    customer_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    customer_code character varying NOT NULL,
    customer_name character varying NOT NULL,
    full_address character varying(1000),
    province integer,
    city integer,
    phone character varying,
    phone2 character varying,
    fax character varying,
    email character varying,
    website character varying,
    customer_since date,
    customer_contact_1 character varying,
    customer_religion_1 character varying,
    customer_contact_2 character varying,
    customer_religion_2 character varying,
    customer_contact_3 character varying,
    customer_religion_3 character varying
);


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    event_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    event_name character varying,
    short_name character varying,
    industry character varying,
    email character varying,
    website character varying
);


--
-- Name: quotation_status; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE quotation_status (
    quotation_status_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    status_name character varying
);


--
-- Name: quotations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE quotations (
    quotation_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    quotation_number character varying,
    status integer DEFAULT 0,
    loss_factor_id integer DEFAULT 0,
    revision character varying,
    quotation_date date,
    sales_number character varying,
    contract_number character varying,
    sales_date date,
    term_of_payment character varying,
    construction_type character varying,
    size character varying,
    official boolean,
    event_id integer,
    venue_id integer,
    show_day_from date,
    show_day_to date,
    move_in_from_date date,
    move_in_from_time time without time zone,
    move_in_to_date date,
    move_in_to_time time without time zone,
    move_out_from_date date,
    move_out_from_time time without time zone,
    move_out_to_date date,
    move_out_to_time time without time zone,
    customer_id integer,
    customer_contacts character varying,
    project_executive integer,
    project_supervisor integer,
    designer integer,
    notes text,
    fee numeric(20,2),
    discount numeric(20,2)
);


--
-- Name: active_sales; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW active_sales AS
    SELECT a.quotation_id, a.quotation_number AS sales_number, a.revision, a.show_day_from, a.show_day_to, b.customer_name, c.event_name, d.status_name AS status, a.status AS quotation_status_id FROM (((quotations a LEFT JOIN customers b USING (customer_id)) LEFT JOIN events c USING (event_id)) LEFT JOIN quotation_status d ON ((d.quotation_status_id = a.status))) WHERE ((a.status = 5) AND (a.show_day_from >= now()));


--
-- Name: customer_pics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE customer_pics (
    customer_pic_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    customer_id integer NOT NULL,
    pic_name character varying,
    role_id character varying,
    religion character varying,
    birthday date,
    fix_phone character varying,
    mobile_phone character varying,
    email character varying
);


--
-- Name: customer_pics_customer_pic_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customer_pics_customer_pic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_pics_customer_pic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customer_pics_customer_pic_id_seq OWNED BY customer_pics.customer_pic_id;


--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customers_customer_id_seq OWNED BY customers.customer_id;


--
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_event_id_seq OWNED BY events.event_id;


--
-- Name: menus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE menus (
    menu_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    menu_name character varying,
    menu_head character varying,
    module character varying,
    action character varying,
    icon character varying,
    show boolean DEFAULT true
);


--
-- Name: role_menu_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role_menu_maps (
    id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    role_id integer,
    menu_id integer
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    register_number character varying,
    userid character varying,
    username character varying,
    email character varying,
    passw character varying,
    role_id integer,
    dept character varying
);


--
-- Name: head_menu; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW head_menu AS
    SELECT DISTINCT a.user_id, d.menu_head, d.menu_name, d.module, d.action, d.show FROM ((users a JOIN role_menu_maps c USING (role_id)) JOIN menus d USING (menu_id));


--
-- Name: loss_factors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE loss_factors (
    loss_factor_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    loss_factor_name character varying,
    description character varying
);


--
-- Name: loss_factors_loss_factor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE loss_factors_loss_factor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: loss_factors_loss_factor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE loss_factors_loss_factor_id_seq OWNED BY loss_factors.loss_factor_id;


--
-- Name: master_barang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_barang (
    mbar_id integer NOT NULL,
    mbar_kode character varying(50) NOT NULL,
    mbar_nama integer NOT NULL,
    mbar_satuan integer NOT NULL,
    mbar_kelompok integer NOT NULL,
    mbar_jenis integer,
    mbar_status boolean DEFAULT true,
    mbar_time_insert timestamp without time zone NOT NULL,
    mbar_user_insert integer NOT NULL,
    mbar_lasttime_update timestamp without time zone NOT NULL,
    mbar_lastuser_update integer NOT NULL,
    mbar_harga_satuan double precision DEFAULT 0,
    mbar_tipe integer NOT NULL,
    mbar_ukuran character varying(50) NOT NULL,
    mbar_merk integer,
    mbar_gudang integer
);


--
-- Name: master_barang_mbar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_barang_mbar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_barang_mbar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_barang_mbar_id_seq OWNED BY master_barang.mbar_id;


--
-- Name: master_gudang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_gudang (
    mg_id integer NOT NULL,
    mg_kode_gudang character varying(15) NOT NULL,
    mg_nama character varying(100) NOT NULL,
    mg_status boolean DEFAULT true,
    mg_time_insert timestamp without time zone NOT NULL,
    mg_user_insert integer NOT NULL,
    mg_lasttime_update timestamp without time zone NOT NULL,
    mg_lastuser_update integer NOT NULL,
    mg_ket text,
    mg_is_gudang_event boolean DEFAULT false
);


--
-- Name: COLUMN master_gudang.mg_is_gudang_event; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN master_gudang.mg_is_gudang_event IS 'utk mengidentifikasi apakah ini gudang fisik atau hanya gudang event saja?';


--
-- Name: master_gudang_mg_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_gudang_mg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_gudang_mg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_gudang_mg_id_seq OWNED BY master_gudang.mg_id;


--
-- Name: master_jenis_barang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_jenis_barang (
    mjb_id integer NOT NULL,
    mjb_nama character varying(50),
    mjb_ket text,
    mjb_time_insert timestamp without time zone NOT NULL,
    mjb_user_insert integer NOT NULL,
    mjb_lasttime_update timestamp without time zone NOT NULL,
    mjb_lastuser_update integer NOT NULL,
    mjb_status boolean DEFAULT true,
    mjb_spek_bahan_subkon boolean DEFAULT false
);


--
-- Name: master_jenis_barang_mjb_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_jenis_barang_mjb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_jenis_barang_mjb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_jenis_barang_mjb_id_seq OWNED BY master_jenis_barang.mjb_id;


--
-- Name: master_kelompok_barang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_kelompok_barang (
    mkb_id integer NOT NULL,
    mkb_nama character varying(50),
    mkb_ket text,
    mkb_time_insert timestamp without time zone NOT NULL,
    mkb_user_insert integer NOT NULL,
    mkb_lasttime_update timestamp without time zone NOT NULL,
    mkb_lastuser_update integer NOT NULL,
    mkb_status boolean DEFAULT true,
    mkb_kode character varying(3) NOT NULL
);


--
-- Name: master_kelompok_barang_mkb_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_kelompok_barang_mkb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_kelompok_barang_mkb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_kelompok_barang_mkb_id_seq OWNED BY master_kelompok_barang.mkb_id;


--
-- Name: master_merk_barang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_merk_barang (
    mmb_id integer NOT NULL,
    mmb_nama character varying(30) NOT NULL,
    mmb_ket text,
    mmb_time_insert timestamp without time zone DEFAULT now() NOT NULL,
    mmb_user_insert integer NOT NULL,
    mmb_lasttime_update timestamp without time zone NOT NULL,
    mmb_lastuser_update integer NOT NULL
);


--
-- Name: master_merk_barang_mmb_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_merk_barang_mmb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_merk_barang_mmb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_merk_barang_mmb_id_seq OWNED BY master_merk_barang.mmb_id;


--
-- Name: master_nama_barang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_nama_barang (
    mnb_id integer NOT NULL,
    mnb_nama character varying(50) NOT NULL,
    mnb_ket text,
    mnb_time_insert timestamp without time zone DEFAULT now() NOT NULL,
    mnb_user_insert integer NOT NULL,
    mnb_lasttime_update timestamp without time zone NOT NULL,
    mnb_lastuser_update integer NOT NULL,
    mnb_kode character varying(5) NOT NULL
);


--
-- Name: master_nama_barang_mnb_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_nama_barang_mnb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_nama_barang_mnb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_nama_barang_mnb_id_seq OWNED BY master_nama_barang.mnb_id;


--
-- Name: master_satuan_barang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_satuan_barang (
    msb_id integer NOT NULL,
    msb_nama character varying(10),
    msb_ket text,
    msb_status boolean DEFAULT true,
    msb_time_insert timestamp without time zone NOT NULL,
    msb_user_insert integer NOT NULL,
    msb_lasttime_update timestamp without time zone NOT NULL,
    msb_lastuser_update integer NOT NULL
);


--
-- Name: master_satuan_barang_msb_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_satuan_barang_msb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_satuan_barang_msb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_satuan_barang_msb_id_seq OWNED BY master_satuan_barang.msb_id;


--
-- Name: master_tipe_barang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE master_tipe_barang (
    mtb_id integer NOT NULL,
    mtb_nama character varying(15) NOT NULL,
    mtb_ket text,
    mtb_status boolean DEFAULT true NOT NULL,
    mtb_time_insert time without time zone DEFAULT now() NOT NULL,
    mtb_user_insert integer NOT NULL,
    mtb_lasttime_update timestamp without time zone NOT NULL,
    mtb_lastuser_update integer NOT NULL
);


--
-- Name: master_tipe_barang_mtb_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE master_tipe_barang_mtb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_tipe_barang_mtb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE master_tipe_barang_mtb_id_seq OWNED BY master_tipe_barang.mtb_id;


--
-- Name: mcs_headers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mcs_headers (
    mcs_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    mcs_number character varying,
    mcs_status_id integer DEFAULT 0,
    quotation_id integer,
    mcs_date date,
    transaction_type_id integer NOT NULL,
    mcs_notes text,
    supplier_id integer,
    ref_id integer
);


--
-- Name: COLUMN mcs_headers.ref_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN mcs_headers.ref_id IS 'in case the mcs_header refer to another mcs
than put the mcs id here';


--
-- Name: mcs_headers_mcs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mcs_headers_mcs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mcs_headers_mcs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mcs_headers_mcs_id_seq OWNED BY mcs_headers.mcs_id;


--
-- Name: mcs_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mcs_items (
    mcs_item_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    mcs_id integer,
    stock_id integer,
    notes character varying,
    qty numeric(10,2)
);


--
-- Name: mcs_items_mcs_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mcs_items_mcs_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mcs_items_mcs_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mcs_items_mcs_item_id_seq OWNED BY mcs_items.mcs_item_id;


--
-- Name: mcs_status; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mcs_status (
    mcs_status_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    status_name character varying
);


--
-- Name: mcs_transaction_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mcs_transaction_types (
    transaction_type_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    create_by character varying DEFAULT "current_user"(),
    transaction_name character varying,
    code character varying
);


--
-- Name: menu_head; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW menu_head AS
    SELECT DISTINCT a.user_id, d.menu_head, CASE WHEN ((COALESCE(d.icon, ''::character varying))::text = ''::text) THEN 'icon-tasks'::character varying ELSE d.icon END AS icon FROM ((users a JOIN role_menu_maps c USING (role_id)) JOIN menus d USING (menu_id));


--
-- Name: menus_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE menus_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menus_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE menus_menu_id_seq OWNED BY menus.menu_id;


--
-- Name: mo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW mo AS
    SELECT a.mcs_status_id, a.mcs_id, a.mcs_number AS mo_number, a.mcs_date AS mo_date, b.sales_number, c.event_name, b.show_day_from, d.status_name AS status FROM (((mcs_headers a JOIN quotations b USING (quotation_id)) JOIN events c USING (event_id)) JOIN mcs_status d USING (mcs_status_id)) WHERE ((a.transaction_type_id = 2) AND (a.mcs_status_id <> 4));


--
-- Name: multi_company_default; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE multi_company_default (
    id integer NOT NULL,
    create_uid integer,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    write_uid integer,
    name character varying(256) NOT NULL,
    sequence integer,
    expression character varying(256) NOT NULL,
    company_dest_id integer NOT NULL,
    field_id integer,
    company_id integer NOT NULL,
    object_id integer NOT NULL
);


--
-- Name: TABLE multi_company_default; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE multi_company_default IS 'Default multi company';


--
-- Name: COLUMN multi_company_default.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN multi_company_default.name IS 'Name';


--
-- Name: COLUMN multi_company_default.sequence; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN multi_company_default.sequence IS 'Sequence';


--
-- Name: COLUMN multi_company_default.expression; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN multi_company_default.expression IS 'Expression';


--
-- Name: COLUMN multi_company_default.company_dest_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN multi_company_default.company_dest_id IS 'Default Company';


--
-- Name: COLUMN multi_company_default.field_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN multi_company_default.field_id IS 'Field';


--
-- Name: COLUMN multi_company_default.company_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN multi_company_default.company_id IS 'Main Company';


--
-- Name: COLUMN multi_company_default.object_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN multi_company_default.object_id IS 'Object';


--
-- Name: multi_company_default_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE multi_company_default_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: multi_company_default_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE multi_company_default_id_seq OWNED BY multi_company_default.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE suppliers (
    supplier_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    supplier_code character varying,
    supplier_name character varying,
    address character varying,
    province integer,
    city integer,
    fix_phone character varying,
    fax character varying,
    mobile_phone character varying,
    email character varying,
    website character varying
);


--
-- Name: po; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW po AS
    SELECT a.mcs_status_id, a.mcs_id, a.mcs_number AS po_number, a.mcs_date AS mo_date, e.supplier_name, d.status_name AS status FROM ((mcs_headers a JOIN mcs_status d USING (mcs_status_id)) LEFT JOIN suppliers e USING (supplier_id)) WHERE ((a.transaction_type_id = 3) AND (a.mcs_status_id <> 4));


--
-- Name: process_transition_group_rel; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE process_transition_group_rel (
    tid integer NOT NULL,
    rid integer NOT NULL
);


--
-- Name: TABLE process_transition_group_rel; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE process_transition_group_rel IS 'RELATION BETWEEN process_transition AND res_groups';


--
-- Name: quotation_files; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE quotation_files (
    quotation_files_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    quotation_id integer,
    file_name character varying,
    description character varying
);


--
-- Name: quotation_files_quotation_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quotation_files_quotation_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quotation_files_quotation_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quotation_files_quotation_files_id_seq OWNED BY quotation_files.quotation_files_id;


--
-- Name: quotation_list1; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW quotation_list1 AS
    SELECT a.quotation_id, a.quotation_number, a.revision, a.show_day_from, a.show_day_to, b.customer_name, c.event_name, d.status_name AS status, a.status AS quotation_status_id FROM (((quotations a LEFT JOIN customers b USING (customer_id)) LEFT JOIN events c USING (event_id)) LEFT JOIN quotation_status d ON ((d.quotation_status_id = a.status))) WHERE (a.status <> 2);


--
-- Name: quotation_products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE quotation_products (
    quotation_product_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    quotation_id integer,
    product_group character varying,
    description character varying,
    amount numeric(20,2)
);


--
-- Name: quotation_products_quotation_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quotation_products_quotation_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quotation_products_quotation_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quotation_products_quotation_product_id_seq OWNED BY quotation_products.quotation_product_id;


--
-- Name: quotation_status_quotation_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quotation_status_quotation_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quotation_status_quotation_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quotation_status_quotation_status_id_seq OWNED BY quotation_status.quotation_status_id;


--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quotations_quotation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quotations_quotation_id_seq OWNED BY quotations.quotation_id;


--
-- Name: role_menu_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_menu_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_menu_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE role_menu_maps_id_seq OWNED BY role_menu_maps.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    role_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    role_name character varying
);


--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_role_id_seq OWNED BY roles.role_id;


--
-- Name: stock_brands; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stock_brands (
    brand_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    brand_name character varying
);


--
-- Name: stock_brands_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_brands_brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_brands_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_brands_brand_id_seq OWNED BY stock_brands.brand_id;


--
-- Name: stock_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stock_groups (
    group_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    group_name character varying
);


--
-- Name: stock_groups_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_groups_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_groups_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_groups_group_id_seq OWNED BY stock_groups.group_id;


--
-- Name: stock_names; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stock_names (
    stock_name_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    stock_name character varying
);


--
-- Name: stock_name_stock_name_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_name_stock_name_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_name_stock_name_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_name_stock_name_id_seq OWNED BY stock_names.stock_name_id;


--
-- Name: stocks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stocks (
    stock_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    stock_code character varying,
    stock_name_id integer,
    size character varying,
    stock_unit_id integer,
    group_id integer,
    sub_group_id integer,
    type_id integer DEFAULT 0,
    brand_id integer,
    active integer DEFAULT 1
);


--
-- Name: stock_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_stock_id_seq OWNED BY stocks.stock_id;


--
-- Name: stock_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stock_types (
    type_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    type_name character varying
);


--
-- Name: stock_units; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stock_units (
    stock_unit_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    unit_name character varying
);


--
-- Name: stock_units_stock_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_units_stock_unit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_units_stock_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_units_stock_unit_id_seq OWNED BY stock_units.stock_unit_id;


--
-- Name: supplier_pics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE supplier_pics (
    suplier_pic_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    supplier_id integer,
    pic_name character varying,
    fix_phone character varying,
    extensions character varying,
    mobile_phone character varying,
    email character varying
);


--
-- Name: supplier_pics_suplier_pic_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE supplier_pics_suplier_pic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: supplier_pics_suplier_pic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE supplier_pics_suplier_pic_id_seq OWNED BY supplier_pics.suplier_pic_id;


--
-- Name: supplier_stock_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE supplier_stock_groups (
    supplier_stock_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    supplier_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: supplier_stock_groups_supplier_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE supplier_stock_groups_supplier_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: supplier_stock_groups_supplier_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE supplier_stock_groups_supplier_stock_id_seq OWNED BY supplier_stock_groups.supplier_stock_id;


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE suppliers_supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE suppliers_supplier_id_seq OWNED BY suppliers.supplier_id;


--
-- Name: user_role_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_role_maps (
    id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    user_id integer,
    role_id integer
);


--
-- Name: user_role_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_role_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_role_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_role_maps_id_seq OWNED BY user_role_maps.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: v_mcs_items; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_mcs_items AS
    SELECT a.mcs_item_id, a.time_stamp, a.created_by, a.mcs_id, a.stock_id, a.notes, a.qty, b.group_id FROM (mcs_items a JOIN stocks b USING (stock_id));


--
-- Name: v_mcs_list1; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_mcs_list1 AS
    SELECT a.mcs_id, a.mcs_status_id, a.mcs_number, b.show_day_from, b.move_in_from_date AS move_in_from, b.move_in_to_date AS move_in_to, c.event_name, d.customer_name, x.status_name FROM ((((mcs_headers a JOIN mcs_status x USING (mcs_status_id)) JOIN quotations b USING (quotation_id)) JOIN events c USING (event_id)) JOIN customers d USING (customer_id)) WHERE (a.mcs_status_id <> 4);


--
-- Name: v_quotation; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_quotation AS
    SELECT CASE WHEN (quotations.official = true) THEN 'checked'::text ELSE ''::text END AS official2, quotations.quotation_id, quotations.time_stamp, quotations.created_by, quotations.quotation_number, quotations.status AS quotation_status_id, (SELECT quotation_status.status_name FROM quotation_status WHERE (quotation_status.quotation_status_id = quotations.status)) AS status_name, quotations.revision, quotations.sales_number, quotations.quotation_date, quotations.contract_number, quotations.term_of_payment, quotations.construction_type, quotations.size, quotations.official, quotations.event_id, quotations.venue_id, quotations.show_day_from, quotations.show_day_to, quotations.move_in_from_date, quotations.move_in_from_time, quotations.move_in_to_date, quotations.move_in_to_time, quotations.move_out_from_date, quotations.move_out_from_time, quotations.move_out_to_date, quotations.move_out_to_time, quotations.customer_id, quotations.customer_contacts, quotations.project_executive, quotations.project_supervisor, quotations.designer, quotations.notes, quotations.fee, quotations.discount, b.full_address, b.phone, b.customer_contact_1, c.amount AS gross_total, ((c.amount + (COALESCE(quotations.fee, (0)::numeric) * ((-1))::numeric)) + (COALESCE(quotations.discount, (0)::numeric) * ((-1))::numeric)) AS nett_total FROM ((quotations LEFT JOIN customers b USING (customer_id)) LEFT JOIN (SELECT quotation_products.quotation_id, sum(quotation_products.amount) AS amount FROM quotation_products GROUP BY quotation_products.quotation_id) c USING (quotation_id));


--
-- Name: v_stacks; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_stacks AS
    SELECT a.stock_id, c.group_name, b.stock_name, a.size, d.unit_name FROM (((stocks a JOIN stock_names b USING (stock_name_id)) LEFT JOIN stock_groups c USING (group_id)) LEFT JOIN stock_units d USING (stock_unit_id));


--
-- Name: v_stocks; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_stocks AS
    SELECT a.stock_id, a.time_stamp, a.created_by, a.stock_code, a.stock_name_id, a.size, a.stock_unit_id AS unit_id, a.group_id, a.sub_group_id, a.type_id, a.brand_id, a.active, b.stock_name FROM (stocks a JOIN stock_names b USING (stock_name_id));


--
-- Name: venues; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE venues (
    venue_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    venue_name character varying,
    address character varying,
    province integer,
    city integer,
    email character varying,
    website character varying
);


--
-- Name: venues_venue_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE venues_venue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venues_venue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE venues_venue_id_seq OWNED BY venues.venue_id;


--
-- Name: warehouses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE warehouses (
    warehouse_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    warehouse_name character varying,
    adress character varying,
    province integer,
    city integer,
    fix_phone character varying,
    mobile_phone character varying
);


--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE warehouses_warehouse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE warehouses_warehouse_id_seq OWNED BY warehouses.warehouse_id;


--
-- Name: customer_pic_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY customer_pics ALTER COLUMN customer_pic_id SET DEFAULT nextval('customer_pics_customer_pic_id_seq'::regclass);


--
-- Name: customer_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers ALTER COLUMN customer_id SET DEFAULT nextval('customers_customer_id_seq'::regclass);


--
-- Name: event_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN event_id SET DEFAULT nextval('events_event_id_seq'::regclass);


--
-- Name: loss_factor_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY loss_factors ALTER COLUMN loss_factor_id SET DEFAULT nextval('loss_factors_loss_factor_id_seq'::regclass);


--
-- Name: mbar_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_barang ALTER COLUMN mbar_id SET DEFAULT nextval('master_barang_mbar_id_seq'::regclass);


--
-- Name: mg_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_gudang ALTER COLUMN mg_id SET DEFAULT nextval('master_gudang_mg_id_seq'::regclass);


--
-- Name: mjb_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_jenis_barang ALTER COLUMN mjb_id SET DEFAULT nextval('master_jenis_barang_mjb_id_seq'::regclass);


--
-- Name: mkb_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_kelompok_barang ALTER COLUMN mkb_id SET DEFAULT nextval('master_kelompok_barang_mkb_id_seq'::regclass);


--
-- Name: mmb_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_merk_barang ALTER COLUMN mmb_id SET DEFAULT nextval('master_merk_barang_mmb_id_seq'::regclass);


--
-- Name: mnb_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_nama_barang ALTER COLUMN mnb_id SET DEFAULT nextval('master_nama_barang_mnb_id_seq'::regclass);


--
-- Name: msb_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_satuan_barang ALTER COLUMN msb_id SET DEFAULT nextval('master_satuan_barang_msb_id_seq'::regclass);


--
-- Name: mtb_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY master_tipe_barang ALTER COLUMN mtb_id SET DEFAULT nextval('master_tipe_barang_mtb_id_seq'::regclass);


--
-- Name: mcs_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mcs_headers ALTER COLUMN mcs_id SET DEFAULT nextval('mcs_headers_mcs_id_seq'::regclass);


--
-- Name: mcs_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mcs_items ALTER COLUMN mcs_item_id SET DEFAULT nextval('mcs_items_mcs_item_id_seq'::regclass);


--
-- Name: menu_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY menus ALTER COLUMN menu_id SET DEFAULT nextval('menus_menu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY multi_company_default ALTER COLUMN id SET DEFAULT nextval('multi_company_default_id_seq'::regclass);


--
-- Name: quotation_files_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotation_files ALTER COLUMN quotation_files_id SET DEFAULT nextval('quotation_files_quotation_files_id_seq'::regclass);


--
-- Name: quotation_product_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotation_products ALTER COLUMN quotation_product_id SET DEFAULT nextval('quotation_products_quotation_product_id_seq'::regclass);


--
-- Name: quotation_status_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotation_status ALTER COLUMN quotation_status_id SET DEFAULT nextval('quotation_status_quotation_status_id_seq'::regclass);


--
-- Name: quotation_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotations ALTER COLUMN quotation_id SET DEFAULT nextval('quotations_quotation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_menu_maps ALTER COLUMN id SET DEFAULT nextval('role_menu_maps_id_seq'::regclass);


--
-- Name: role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN role_id SET DEFAULT nextval('roles_role_id_seq'::regclass);


--
-- Name: brand_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_brands ALTER COLUMN brand_id SET DEFAULT nextval('stock_brands_brand_id_seq'::regclass);


--
-- Name: group_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_groups ALTER COLUMN group_id SET DEFAULT nextval('stock_groups_group_id_seq'::regclass);


--
-- Name: stock_name_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_names ALTER COLUMN stock_name_id SET DEFAULT nextval('stock_name_stock_name_id_seq'::regclass);


--
-- Name: stock_unit_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_units ALTER COLUMN stock_unit_id SET DEFAULT nextval('stock_units_stock_unit_id_seq'::regclass);


--
-- Name: stock_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks ALTER COLUMN stock_id SET DEFAULT nextval('stock_stock_id_seq'::regclass);


--
-- Name: suplier_pic_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY supplier_pics ALTER COLUMN suplier_pic_id SET DEFAULT nextval('supplier_pics_suplier_pic_id_seq'::regclass);


--
-- Name: supplier_stock_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY supplier_stock_groups ALTER COLUMN supplier_stock_id SET DEFAULT nextval('supplier_stock_groups_supplier_stock_id_seq'::regclass);


--
-- Name: supplier_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('suppliers_supplier_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role_maps ALTER COLUMN id SET DEFAULT nextval('user_role_maps_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: venue_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY venues ALTER COLUMN venue_id SET DEFAULT nextval('venues_venue_id_seq'::regclass);


--
-- Name: warehouse_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY warehouses ALTER COLUMN warehouse_id SET DEFAULT nextval('warehouses_warehouse_id_seq'::regclass);


--
-- Data for Name: customer_pics; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: customer_pics_customer_pic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('customer_pics_customer_pic_id_seq', 1, false);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO customers VALUES (1, '2015-01-16 23:25:27.951', 'dei', 'C140101', 'Jaya Abadi', 'Jl. Bandengan', 1, 1, '3333', NULL, '1234', 'jaya@abadi.com', 'abadi.com', '2014-01-01', 'Jaka Tarbu', NULL, NULL, NULL, NULL, NULL);
INSERT INTO customers VALUES (2, '2015-01-16 23:26:17.802', 'dei', 'C140102', 'Tunas Jaya', 'Jl. Merbabu 2/30', 1, 1, '33334', NULL, '1233', 'tunas@jaya.com', 'jaya.com', '2014-01-01', 'Sebastian Gundala', NULL, NULL, NULL, NULL, NULL);
INSERT INTO customers VALUES (3, '2015-01-17 21:27:00.887', 'postgres', 'C140201', 'STARBUCKS COFFEE', 'Jl. Raya Tambun No. 3', 1, 1, '555666', NULL, '1235', 'cs@starbucks.com', NULL, '2015-01-01', 'Dunlop norisk', NULL, NULL, NULL, NULL, NULL);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('customers_customer_id_seq', 3, true);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO events VALUES (1, '2015-01-17 21:27:57.967', 'postgres', 'Jakarta International Motor Show', 'JIMS', 'Automotive', NULL, NULL);
INSERT INTO events VALUES (2, '2015-01-17 21:28:27.569', 'postgres', 'Pameran Komputer', NULL, NULL, NULL, NULL);
INSERT INTO events VALUES (3, '2015-01-17 21:28:35.815', 'postgres', 'Event Besar', NULL, NULL, NULL, NULL);


--
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('events_event_id_seq', 3, true);


--
-- Data for Name: loss_factors; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO loss_factors VALUES (1, '2015-01-20 20:42:00.002', 'dei', 'Price too high', NULL);
INSERT INTO loss_factors VALUES (2, '2015-01-20 20:42:15.569', 'dei', 'Design', NULL);
INSERT INTO loss_factors VALUES (0, '2015-01-29 20:41:24.779', 'dei', NULL, NULL);


--
-- Name: loss_factors_loss_factor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('loss_factors_loss_factor_id_seq', 2, true);


--
-- Data for Name: master_barang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_barang VALUES (12, '00KAA-002-2', 2257, 34, 13, 24, true, '2014-08-08 16:05:46', 435, '2014-08-08 21:53:34', 435, 100000, 6, '100', 1, 24);
INSERT INTO master_barang VALUES (10, '000AC-005-2', 2261, 43, 16, 25, true, '2014-08-07 22:12:19', 435, '2014-08-09 10:45:06', 435, 1000, 1, '1 pk', 3, 18);
INSERT INTO master_barang VALUES (11, '00M12-004-6', 2576, 43, 15, 22, true, '2014-08-08 14:25:45', 435, '2014-08-09 10:44:02', 435, 75000, 6, '10', 3, 16);
INSERT INTO master_barang VALUES (14, '00AC3-030-1', 2791, 52, 41, 25, true, '2014-08-10 05:42:56', 435, '2014-08-10 05:42:56', 435, 3000000, 6, '1 m', 17, 25);
INSERT INTO master_barang VALUES (15, '000AS-005-1', 2270, 43, 16, 24, true, '2014-08-10 06:33:43', 435, '2014-08-10 06:33:43', 435, 10000, 6, '10 cm', 2, 24);
INSERT INTO master_barang VALUES (16, '00BH7-004-1', 2315, 43, 15, 23, true, '2014-08-10 06:38:21', 435, '2014-08-10 06:38:21', 435, 30000, 6, '5 cm', 9, 16);
INSERT INTO master_barang VALUES (17, '000DP-024-1', 2379, 52, 35, 24, true, '2014-08-10 06:45:08', 435, '2014-08-10 06:45:08', 435, 750000, 6, '35 cm', 10, 24);
INSERT INTO master_barang VALUES (18, '000CB-006-1', 2363, 52, 17, 43, true, '2014-08-10 07:29:34', 435, '2014-08-10 07:29:34', 435, 6000000, 6, '40 cm x 50 cm', 6, 23);
INSERT INTO master_barang VALUES (13, '00BH2-004-2', 2316, 43, 15, 23, true, '2014-08-08 20:18:36', 435, '2014-08-11 09:38:04', 435, 40000, 6, '1', 9, 16);
INSERT INTO master_barang VALUES (19, '000KH-004-1', 2416, 34, 15, 21, true, '2014-08-14 14:58:06', 435, '2014-08-14 14:58:06', 435, 1000, 6, '100 m', 21, 16);
INSERT INTO master_barang VALUES (20, '00KRN-001-1', 2798, 52, 12, 34, true, '2014-08-14 21:29:12', 435, '2014-08-14 21:29:12', 435, 400000000, 1, '10 m', NULL, 24);
INSERT INTO master_barang VALUES (21, '00KRN-001-2', 2798, 34, 12, 34, true, '2014-08-14 21:31:34', 435, '2014-08-14 21:31:34', 435, 400000000, 1, '10', 4, 24);
INSERT INTO master_barang VALUES (23, '000MD-005-1', 2583, 34, 16, 26, true, '2014-08-15 07:05:21', 435, '2014-08-15 07:05:21', 435, 200000, 1, '1', 5, 18);
INSERT INTO master_barang VALUES (24, '00BSB-009-1', 2819, 34, 46, 2, true, '2014-08-16 13:50:16', 435, '2014-08-16 13:50:16', 435, 12000, 1, '10', NULL, 15);
INSERT INTO master_barang VALUES (25, 'BSBT1-009-1', 2826, 41, 46, 2, true, '2014-08-16 21:41:27', 435, '2014-08-16 21:41:27', 435, 7000, 1, '6 MM', NULL, 15);
INSERT INTO master_barang VALUES (26, '000B1-004-1', 2335, 43, 15, 25, true, '2014-08-16 21:46:49', 435, '2014-08-16 21:46:49', 435, 125000, 6, '5 CM', 1, 16);
INSERT INTO master_barang VALUES (27, '000BC-008-1', 2287, 20, 45, 17, true, '2014-08-16 22:09:25', 435, '2014-08-16 22:09:25', 435, 170000, 6, '10', 1, 36);
INSERT INTO master_barang VALUES (29, '00M1D-008-1', 2591, 52, 45, 24, true, '2014-08-16 23:59:55', 435, '2014-08-16 23:59:55', 435, 1000, 1, '1', 57, 36);
INSERT INTO master_barang VALUES (30, '000KA-005-1', 2443, 51, 16, 25, true, '2014-08-19 00:59:30', 435, '2014-08-19 00:59:30', 435, 270000, 9, '30 cm', 8, 36);
INSERT INTO master_barang VALUES (31, '0UP1C-008-1', 2758, 51, 45, 24, true, '2014-08-19 01:01:37', 435, '2014-08-19 01:01:37', 435, 30900, 9, '10', 57, 36);
INSERT INTO master_barang VALUES (32, '00BSC-008-1', 2309, 51, 45, 24, true, '2014-08-19 01:04:24', 435, '2014-08-19 01:04:24', 435, 106000, 9, '150', 57, 36);
INSERT INTO master_barang VALUES (33, '0P2X4-008-1', 2637, 51, 45, 18, true, '2014-08-19 01:10:07', 435, '2014-08-19 01:10:07', 435, 85000, 9, '236 x 46.9', 57, 36);
INSERT INTO master_barang VALUES (34, '00BSB-009-2', 2819, 54, 46, 2, true, '2014-08-19 01:16:00', 435, '2014-08-19 01:16:00', 435, 9000, 9, '11', 57, 36);
INSERT INTO master_barang VALUES (35, '0BSBT-009-1', 2825, 54, 46, 2, true, '2014-08-19 01:17:34', 435, '2014-08-19 01:17:34', 435, 8000, 9, '12', 57, 36);
INSERT INTO master_barang VALUES (36, '00PNG-005-1', 2834, 35, 16, 18, true, '2014-08-19 10:20:13', 435, '2014-08-19 10:20:13', 435, 20000000, 3, '10 x 5', 57, 18);
INSERT INTO master_barang VALUES (37, '00CA4-009-1', 2806, 31, 46, 30, true, '2014-08-19 15:54:05', 435, '2014-08-19 15:54:05', 435, 30000, 3, '1', 38, 36);
INSERT INTO master_barang VALUES (22, '00KRE-001-2', 2797, 52, 12, 7, true, '2014-08-14 22:51:02', 435, '2014-08-19 15:54:40', 435, 132000000, 1, '7', 4, 24);
INSERT INTO master_barang VALUES (38, '000AC-004-1', 2261, 52, 15, 24, true, '2014-09-24 15:51:42', 435, '2014-09-24 15:51:42', 435, 1000000, 1, '1', 32, 19);
INSERT INTO master_barang VALUES (39, 'Truck-001-1', 2752, 52, 12, 34, true, '2014-10-04 11:44:06', 435, '2014-10-04 11:44:06', 435, 300000000, 1, '4x4', 52, 24);


--
-- Name: master_barang_mbar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_barang_mbar_id_seq', 39, true);


--
-- Data for Name: master_gudang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_gudang VALUES (30, 'Crafina', 'Crafina', true, '2014-08-07 22:26:28', 436, '2014-08-07 22:26:28', 436, NULL, true);
INSERT INTO master_gudang VALUES (22, '012', 'HRD&GA', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:09:52', 435, NULL, false);
INSERT INTO master_gudang VALUES (25, '015', 'WORKSHOP', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:15:08', 435, NULL, false);
INSERT INTO master_gudang VALUES (18, '004', 'FURNITUR', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:15:39', 435, NULL, false);
INSERT INTO master_gudang VALUES (24, '014', 'UMUM', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:15:59', 435, NULL, false);
INSERT INTO master_gudang VALUES (23, '013', 'MAINTENANCE', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:16:19', 435, NULL, false);
INSERT INTO master_gudang VALUES (15, '001', 'MATERIAL', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:16:45', 435, NULL, false);
INSERT INTO master_gudang VALUES (17, '003', 'SYSTEM', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:17:05', 435, NULL, false);
INSERT INTO master_gudang VALUES (21, '011', 'GRAFIK', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:17:20', 435, NULL, false);
INSERT INTO master_gudang VALUES (19, '007', 'ACRYLIC', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:17:38', 435, NULL, false);
INSERT INTO master_gudang VALUES (16, '002', 'LISTRIK', true, '2014-07-15 23:58:13.344082', 435, '2014-08-08 14:47:38', 435, NULL, false);
INSERT INTO master_gudang VALUES (31, 'IIMS 2014', 'IIMS 2014', true, '2014-08-14 15:49:50', 436, '2014-08-14 15:49:50', 436, NULL, true);
INSERT INTO master_gudang VALUES (32, 'HOSPITAL EXPO ', 'HOSPITAL EXPO 2014', true, '2014-08-14 16:11:48', 436, '2014-08-14 16:11:48', 436, NULL, true);
INSERT INTO master_gudang VALUES (33, 'HOSPITAL EXPO', 'HOSPITAL EXPO', true, '2014-08-14 16:14:44', 436, '2014-08-14 16:14:44', 436, NULL, true);
INSERT INTO master_gudang VALUES (34, 'Pameran  Pemba', 'Pameran  Pembangunan Daerah', true, '2014-08-14 19:32:44', 436, '2014-08-14 19:32:44', 436, NULL, true);
INSERT INTO master_gudang VALUES (20, '009', 'PANGGUNG', true, '2014-07-15 23:58:13.344082', 435, '2014-08-14 22:51:54', 435, NULL, false);
INSERT INTO master_gudang VALUES (35, '016', 'Ruang Produksi', true, '2014-08-14 22:53:57', 435, '2014-08-14 22:53:57', 435, NULL, false);
INSERT INTO master_gudang VALUES (36, '017', 'LOGISTIK', true, '2014-08-14 22:54:48', 435, '2014-08-14 22:54:48', 435, 'gudang logistik', false);
INSERT INTO master_gudang VALUES (37, 'PASANG BACKDRO', 'PASANG BACKDROP DI KANTOR DEBINDO', true, '2014-08-15 09:34:57', 436, '2014-08-15 09:34:57', 436, NULL, true);
INSERT INTO master_gudang VALUES (38, 'POLYTRON @MARG', 'POLYTRON @MARGO CITY', true, '2014-08-15 13:57:19', 436, '2014-08-15 13:57:19', 436, NULL, true);
INSERT INTO master_gudang VALUES (43, 'PRJ 2014', 'PRJ 2014', true, '2014-08-16 11:48:25', 436, '2014-08-16 11:48:25', 436, 'Pekan Raya Jakarta', true);
INSERT INTO master_gudang VALUES (44, 'Pekan Raya Jak', 'Pekan Raya Jakarta', true, '2014-08-16 14:01:32', 436, '2014-08-16 14:01:32', 436, NULL, true);
INSERT INTO master_gudang VALUES (45, 'ASIAN GAMES EX', 'ASIAN GAMES EXEBITION', true, '2014-08-19 11:20:05', 436, '2014-08-19 11:20:05', 436, NULL, true);
INSERT INTO master_gudang VALUES (46, 'Traditional Ar', 'Traditional Art Show', true, '2014-08-28 16:31:51', 436, '2014-08-28 16:31:51', 436, NULL, true);
INSERT INTO master_gudang VALUES (47, 'Pameran Keraji', 'Pameran Kerajinan Tangan', true, '2014-08-28 16:49:06', 436, '2014-08-28 16:49:06', 436, NULL, true);
INSERT INTO master_gudang VALUES (52, 'Pekan Raya Jak', 'Pekan Raya Jakarta 2014', true, '2014-08-29 15:18:22', 436, '2014-08-29 15:18:22', 436, NULL, true);


--
-- Name: master_gudang_mg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_gudang_mg_id_seq', 52, true);


--
-- Data for Name: master_jenis_barang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_jenis_barang VALUES (7, 'Mobil', '-', '2014-08-08 20:01:51', 435, '2014-08-08 20:01:51', 435, true, false);
INSERT INTO master_jenis_barang VALUES (8, 'Motor', '-', '2014-08-08 20:02:01', 435, '2014-08-08 20:02:01', 435, true, false);
INSERT INTO master_jenis_barang VALUES (9, 'Semua Divisi', '-', '2014-08-08 20:03:04', 435, '2014-08-08 20:03:04', 435, true, false);
INSERT INTO master_jenis_barang VALUES (10, 'Divisi Acrylic', '-', '2014-08-08 20:03:15', 435, '2014-08-08 20:03:15', 435, true, false);
INSERT INTO master_jenis_barang VALUES (11, 'Divisi Kayu', '-', '2014-08-08 20:05:24', 435, '2014-08-08 20:05:24', 435, true, false);
INSERT INTO master_jenis_barang VALUES (12, 'Divisi Besi', '-', '2014-08-08 20:05:44', 435, '2014-08-08 20:05:44', 435, true, false);
INSERT INTO master_jenis_barang VALUES (13, 'Divisi Listrik', '-', '2014-08-08 20:06:01', 435, '2014-08-08 20:06:01', 435, true, false);
INSERT INTO master_jenis_barang VALUES (14, 'Divisi System', '-', '2014-08-08 20:06:18', 435, '2014-08-08 20:06:18', 435, true, false);
INSERT INTO master_jenis_barang VALUES (15, 'Divisi Cat', '-', '2014-08-08 20:06:27', 435, '2014-08-08 20:06:27', 435, true, false);
INSERT INTO master_jenis_barang VALUES (19, 'Mero', '-', '2014-08-08 20:07:33', 435, '2014-08-08 20:07:33', 435, true, false);
INSERT INTO master_jenis_barang VALUES (20, 'Voluma', '-', '2014-08-08 20:07:57', 435, '2014-08-08 20:07:57', 435, true, false);
INSERT INTO master_jenis_barang VALUES (24, 'Accecories', '-', '2014-08-08 20:08:51', 435, '2014-08-08 20:08:51', 435, true, false);
INSERT INTO master_jenis_barang VALUES (25, 'Electronic', '-', '2014-08-08 21:25:45', 435, '2014-08-08 21:25:45', 435, true, false);
INSERT INTO master_jenis_barang VALUES (26, 'Kursi', '-', '2014-08-10 05:50:52', 435, '2014-08-10 05:50:52', 435, true, false);
INSERT INTO master_jenis_barang VALUES (27, 'Meja', '-', '2014-08-10 05:51:12', 435, '2014-08-10 05:51:12', 435, true, false);
INSERT INTO master_jenis_barang VALUES (28, 'Peralatan', '-', '2014-08-10 05:52:34', 435, '2014-08-10 05:52:34', 435, true, false);
INSERT INTO master_jenis_barang VALUES (29, 'ATK', '-', '2014-08-10 05:53:02', 435, '2014-08-10 05:53:02', 435, true, false);
INSERT INTO master_jenis_barang VALUES (31, 'Perlengkapan', '-', '2014-08-10 05:54:12', 435, '2014-08-10 05:54:12', 435, true, false);
INSERT INTO master_jenis_barang VALUES (36, 'Pipa', '-', '2014-08-10 06:29:53', 435, '2014-08-10 06:29:53', 435, true, false);
INSERT INTO master_jenis_barang VALUES (37, 'Sticker', '-', '2014-08-10 06:30:14', 435, '2014-08-10 06:30:14', 435, true, false);
INSERT INTO master_jenis_barang VALUES (38, 'Baut', '-', '2014-08-10 06:30:26', 435, '2014-08-10 06:30:26', 435, true, false);
INSERT INTO master_jenis_barang VALUES (39, 'Kunci', '-', '2014-08-10 06:30:33', 435, '2014-08-10 06:30:33', 435, true, false);
INSERT INTO master_jenis_barang VALUES (40, 'Ambalan', '-', '2014-08-10 06:30:51', 435, '2014-08-10 06:30:51', 435, true, false);
INSERT INTO master_jenis_barang VALUES (41, 'Amplas', '-', '2014-08-10 06:30:57', 435, '2014-08-10 06:30:57', 435, true, false);
INSERT INTO master_jenis_barang VALUES (43, 'Mesin', '-', '2014-08-10 07:27:15', 435, '2014-08-10 07:27:15', 435, true, false);
INSERT INTO master_jenis_barang VALUES (44, 'Dept Procurement', '-', '2014-08-16 22:34:43', 435, '2014-08-16 22:34:43', 435, true, false);
INSERT INTO master_jenis_barang VALUES (34, 'Kendaraan Mobil', '-', '2014-08-10 06:29:09', 435, '2014-08-16 22:35:32', 435, true, false);
INSERT INTO master_jenis_barang VALUES (16, 'System Uppright Post Hitam', '-', '2014-08-08 20:06:46', 435, '2014-08-16 23:02:31', 435, true, false);
INSERT INTO master_jenis_barang VALUES (45, 'System Upright Post Putih', '-', '2014-08-16 23:02:54', 435, '2014-08-16 23:02:54', 435, true, false);
INSERT INTO master_jenis_barang VALUES (17, 'System Beam Section Hitam', '-', '2014-08-08 20:07:13', 435, '2014-08-16 23:03:23', 435, true, false);
INSERT INTO master_jenis_barang VALUES (46, 'System Beam Section Putih', '-', '2014-08-16 23:03:45', 435, '2014-08-16 23:03:45', 435, true, false);
INSERT INTO master_jenis_barang VALUES (18, 'System Partisi', '-', '2014-08-08 20:07:27', 435, '2014-08-16 23:04:13', 435, true, false);
INSERT INTO master_jenis_barang VALUES (47, 'Shelving', '-', '2014-08-16 23:04:37', 435, '2014-08-16 23:04:37', 435, true, false);
INSERT INTO master_jenis_barang VALUES (21, 'Elektrik Kabel', '-', '2014-08-08 20:08:13', 435, '2014-08-17 00:24:26', 435, true, false);
INSERT INTO master_jenis_barang VALUES (22, 'ELECTRIC MCB', '-', '2014-08-08 20:08:27', 435, '2014-08-17 00:25:01', 435, true, false);
INSERT INTO master_jenis_barang VALUES (48, 'ELECTRIC ACCESORIES', '-', '2014-08-17 00:26:53', 435, '2014-08-17 00:26:53', 435, true, false);
INSERT INTO master_jenis_barang VALUES (49, 'Komputer ', '-', '2014-08-17 00:28:19', 435, '2014-08-17 00:28:19', 435, true, false);
INSERT INTO master_jenis_barang VALUES (50, 'Printer', '-', '2014-08-17 00:28:26', 435, '2014-08-17 00:28:26', 435, true, false);
INSERT INTO master_jenis_barang VALUES (51, 'Monitor', '-', '2014-08-17 00:28:34', 435, '2014-08-17 00:28:34', 435, true, false);
INSERT INTO master_jenis_barang VALUES (52, 'Scanner', '-', '2014-08-17 00:29:25', 435, '2014-08-17 00:29:25', 435, true, false);
INSERT INTO master_jenis_barang VALUES (57, 'Lain-lain', '-', '2014-08-19 15:40:45', 435, '2014-08-19 15:40:45', 435, true, false);
INSERT INTO master_jenis_barang VALUES (2, 'Besi', 'adsasd', '2014-04-22 18:57:42', 435, '2014-04-22 18:57:42', 435, true, true);
INSERT INTO master_jenis_barang VALUES (32, 'Kayu', '-', '2014-08-10 06:28:33', 435, '2014-08-10 06:28:33', 435, true, true);
INSERT INTO master_jenis_barang VALUES (30, 'Cat', '-', '2014-08-10 05:53:34', 435, '2014-08-10 05:53:34', 435, true, true);
INSERT INTO master_jenis_barang VALUES (55, 'System', '-', '2014-08-19 15:40:13', 435, '2014-08-19 15:40:13', 435, true, true);
INSERT INTO master_jenis_barang VALUES (53, 'Graphic', '-', '2014-08-19 15:39:42', 435, '2014-08-19 15:39:42', 435, true, true);
INSERT INTO master_jenis_barang VALUES (54, 'Karpet', '-', '2014-08-19 15:39:55', 435, '2014-08-19 15:39:55', 435, true, true);
INSERT INTO master_jenis_barang VALUES (56, 'Kaca Acrylic', '-', '2014-08-19 15:40:27', 435, '2014-08-19 15:40:27', 435, true, true);
INSERT INTO master_jenis_barang VALUES (23, 'ELEKTRIK LAMPU', '-', '2014-08-08 20:08:34', 435, '2014-08-17 00:25:52', 435, true, true);


--
-- Name: master_jenis_barang_mjb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_jenis_barang_mjb_id_seq', 57, true);


--
-- Data for Name: master_kelompok_barang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_kelompok_barang VALUES (25, 'HRD dan General Affair', '-', '2014-07-15 03:03:47.723234', 435, '2014-08-09 02:08:29', 435, true, '003');
INSERT INTO master_kelompok_barang VALUES (46, 'MATERIAL', 'Persediaan', '2014-08-14 23:00:24', 435, '2014-08-14 23:00:24', 435, true, '009');
INSERT INTO master_kelompok_barang VALUES (41, 'INVENTARIS KANTOR', 'Asset Tetap', '2014-07-15 03:03:47.723234', 435, '2014-08-16 22:17:04', 435, true, '030');
INSERT INTO master_kelompok_barang VALUES (12, 'TRANSPORTASI/KENDARAAN', 'Asset Tetap', '2014-07-15 03:03:47.723234', 435, '2014-08-16 22:17:38', 435, true, '001');
INSERT INTO master_kelompok_barang VALUES (16, 'FURNITURE', 'Persediaan/Properti Investasi', '2014-07-15 03:03:47.723234', 435, '2014-08-16 22:18:22', 435, true, '005');
INSERT INTO master_kelompok_barang VALUES (45, 'SISTEM DAN AKSESORIS SISTEM', 'Persediaan / Properti Investasi', '2014-08-14 22:58:35', 435, '2014-08-16 22:19:30', 435, true, '008');
INSERT INTO master_kelompok_barang VALUES (15, 'LISTRIK/ELECTRIC', 'Persediaan', '2014-07-15 03:03:47.723234', 435, '2014-08-16 22:20:25', 435, true, '004');
INSERT INTO master_kelompok_barang VALUES (42, 'MACHINE', NULL, '2014-07-15 03:03:47.723234', 435, '2014-08-08 14:12:41', 435, true, '031');
INSERT INTO master_kelompok_barang VALUES (44, 'IT', 'Teknologi Informasi', '2014-07-15 03:03:47.723234', 435, '2014-08-08 14:37:31', 435, true, '033');
INSERT INTO master_kelompok_barang VALUES (40, 'ATK', 'Alat Tulis Kantor', '2014-07-15 03:03:47.723234', 435, '2014-08-08 14:38:06', 435, true, '029');
INSERT INTO master_kelompok_barang VALUES (35, 'PERLENGKAPAN', NULL, '2014-07-15 03:03:47.723234', 435, '2014-08-08 14:41:11', 435, true, '024');
INSERT INTO master_kelompok_barang VALUES (43, 'BRGBEKAS', 'Barang Bekas', '2014-07-15 03:03:47.723234', 435, '2014-08-08 14:41:36', 435, true, '032');
INSERT INTO master_kelompok_barang VALUES (32, 'ACRYLYC', NULL, '2014-07-15 03:03:47.723234', 435, '2014-08-08 14:44:01', 435, true, '021');
INSERT INTO master_kelompok_barang VALUES (30, 'AMBALAN', NULL, '2014-07-15 03:03:47.723234', 435, '2014-08-08 14:45:17', 435, true, '019');
INSERT INTO master_kelompok_barang VALUES (18, 'PEMBERDAYAAN', NULL, '2014-07-15 03:03:47.723234', 435, '2014-08-08 15:20:24', 435, true, '007');
INSERT INTO master_kelompok_barang VALUES (17, 'MAINTENANCE/ALAT PRODUKSI', NULL, '2014-07-15 03:03:47.723234', 435, '2014-08-08 15:22:02', 435, true, '006');
INSERT INTO master_kelompok_barang VALUES (13, 'KARPET', NULL, '2014-07-15 03:03:47.723234', 435, '2014-08-08 16:01:16', 435, true, '002');


--
-- Name: master_kelompok_barang_mkb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_kelompok_barang_mkb_id_seq', 47, true);


--
-- Data for Name: master_merk_barang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_merk_barang VALUES (1, 'Merk 1', 'ada', '2014-06-03 22:37:49', 435, '2014-06-03 22:37:49', 435);
INSERT INTO master_merk_barang VALUES (2, 'candra', 'kredit', '2014-06-15 06:31:28', 435, '2014-06-15 06:31:28', 435);
INSERT INTO master_merk_barang VALUES (3, 'Sanyo', '-', '2014-07-15 06:55:29', 435, '2014-07-15 06:55:29', 435);
INSERT INTO master_merk_barang VALUES (4, 'ISUZU', 'ISUZU DIESEL', '2014-08-09 01:23:01', 435, '2014-08-09 01:23:01', 435);
INSERT INTO master_merk_barang VALUES (5, 'Chitose', 'Kursi Lipat', '2014-08-09 01:23:32', 435, '2014-08-09 01:23:32', 435);
INSERT INTO master_merk_barang VALUES (6, 'Honda', '-', '2014-08-09 01:24:02', 435, '2014-08-09 01:24:02', 435);
INSERT INTO master_merk_barang VALUES (7, 'Panasonic', '-', '2014-08-09 01:24:44', 435, '2014-08-09 01:24:44', 435);
INSERT INTO master_merk_barang VALUES (9, 'Philips', '-', '2014-08-09 01:25:18', 435, '2014-08-09 01:25:18', 435);
INSERT INTO master_merk_barang VALUES (10, 'LG', '-', '2014-08-09 01:25:25', 435, '2014-08-09 01:25:25', 435);
INSERT INTO master_merk_barang VALUES (11, 'Samsung', '-', '2014-08-09 01:28:04', 435, '2014-08-09 01:28:04', 435);
INSERT INTO master_merk_barang VALUES (12, 'Hino', '-', '2014-08-09 01:28:17', 435, '2014-08-09 01:28:17', 435);
INSERT INTO master_merk_barang VALUES (13, 'IBM', '-', '2014-08-09 01:28:41', 435, '2014-08-09 01:28:41', 435);
INSERT INTO master_merk_barang VALUES (14, 'Bosch', '-', '2014-08-09 01:32:33', 435, '2014-08-09 01:32:33', 435);
INSERT INTO master_merk_barang VALUES (15, 'Inbow', '-', '2014-08-09 01:32:42', 435, '2014-08-09 01:32:42', 435);
INSERT INTO master_merk_barang VALUES (16, 'Maktec', '-', '2014-08-09 01:32:52', 435, '2014-08-09 01:32:52', 435);
INSERT INTO master_merk_barang VALUES (17, 'NASIONAL', '-', '2014-08-09 01:33:16', 435, '2014-08-09 01:33:16', 435);
INSERT INTO master_merk_barang VALUES (18, 'Osram', '-', '2014-08-09 01:33:50', 435, '2014-08-09 01:33:50', 435);
INSERT INTO master_merk_barang VALUES (19, 'Bridgestone', '-', '2014-08-09 01:35:20', 435, '2014-08-09 01:35:20', 435);
INSERT INTO master_merk_barang VALUES (20, 'Dunlop', '-', '2014-08-09 01:35:27', 435, '2014-08-09 01:35:27', 435);
INSERT INTO master_merk_barang VALUES (21, 'MAKITA', '-', '2014-08-09 01:37:24', 435, '2014-08-09 01:37:24', 435);
INSERT INTO master_merk_barang VALUES (22, 'AVIAN', '-', '2014-08-09 01:38:04', 435, '2014-08-09 01:38:04', 435);
INSERT INTO master_merk_barang VALUES (23, 'Lumineuk EXPO', '-', '2014-08-09 01:38:23', 435, '2014-08-09 01:38:23', 435);
INSERT INTO master_merk_barang VALUES (24, 'Dana Paint', '-', '2014-08-09 01:38:39', 435, '2014-08-09 01:38:39', 435);
INSERT INTO master_merk_barang VALUES (25, 'Titanlux', '-', '2014-08-09 01:39:07', 435, '2014-08-09 01:39:07', 435);
INSERT INTO master_merk_barang VALUES (26, 'Nippon Paint', '-', '2014-08-09 01:39:19', 435, '2014-08-09 01:39:19', 435);
INSERT INTO master_merk_barang VALUES (27, 'Minilex', '-', '2014-08-09 01:39:41', 435, '2014-08-09 01:39:41', 435);
INSERT INTO master_merk_barang VALUES (28, 'Vinilex', '-', '2014-08-09 01:39:55', 435, '2014-08-09 01:39:55', 435);
INSERT INTO master_merk_barang VALUES (29, 'Toshiba', '-', '2014-08-09 01:40:27', 435, '2014-08-09 01:40:27', 435);
INSERT INTO master_merk_barang VALUES (30, 'Lenkote', '-', '2014-08-09 01:41:52', 435, '2014-08-09 01:41:52', 435);
INSERT INTO master_merk_barang VALUES (31, 'Dulux', '-', '2014-08-09 19:30:58', 435, '2014-08-09 19:30:58', 435);
INSERT INTO master_merk_barang VALUES (32, 'ABC', '-', '2014-08-09 19:31:23', 435, '2014-08-09 19:31:23', 435);
INSERT INTO master_merk_barang VALUES (33, 'Alkaline', '-', '2014-08-09 19:31:47', 435, '2014-08-09 19:31:47', 435);
INSERT INTO master_merk_barang VALUES (34, 'Motorola', '-', '2014-08-09 19:32:10', 435, '2014-08-09 19:32:10', 435);
INSERT INTO master_merk_barang VALUES (35, 'Hitachi', '-', '2014-08-09 19:54:06', 435, '2014-08-09 19:54:06', 435);
INSERT INTO master_merk_barang VALUES (36, 'Energizer', '-', '2014-08-09 20:40:32', 435, '2014-08-09 20:40:32', 435);
INSERT INTO master_merk_barang VALUES (37, 'Mowilex', '-', '2014-08-09 20:42:32', 435, '2014-08-09 20:42:32', 435);
INSERT INTO master_merk_barang VALUES (38, 'Nippe', '-', '2014-08-09 20:42:54', 435, '2014-08-09 20:42:54', 435);
INSERT INTO master_merk_barang VALUES (39, 'Novalux', '-', '2014-08-09 20:43:13', 435, '2014-08-09 20:43:13', 435);
INSERT INTO master_merk_barang VALUES (40, 'Pantone', '-', '2014-08-09 20:43:36', 435, '2014-08-09 20:43:36', 435);
INSERT INTO master_merk_barang VALUES (41, 'Renovo', '-', '2014-08-09 20:44:40', 435, '2014-08-09 20:44:40', 435);
INSERT INTO master_merk_barang VALUES (42, 'Toto', '-', '2014-08-09 20:44:58', 435, '2014-08-09 20:44:58', 435);
INSERT INTO master_merk_barang VALUES (43, 'Pioneer', '-', '2014-08-09 20:45:13', 435, '2014-08-09 20:45:13', 435);
INSERT INTO master_merk_barang VALUES (44, 'Yanma', '-', '2014-08-09 20:45:35', 435, '2014-08-09 20:45:35', 435);
INSERT INTO master_merk_barang VALUES (45, 'Sanwa', '-', '2014-08-09 20:45:48', 435, '2014-08-09 20:45:48', 435);
INSERT INTO master_merk_barang VALUES (47, 'Suzuki', '-', '2014-08-09 20:49:15', 435, '2014-08-09 20:49:15', 435);
INSERT INTO master_merk_barang VALUES (48, 'Acer', '-', '2014-08-09 20:49:42', 435, '2014-08-09 20:49:42', 435);
INSERT INTO master_merk_barang VALUES (49, 'Gree', '-', '2014-08-09 20:57:36', 435, '2014-08-09 20:57:36', 435);
INSERT INTO master_merk_barang VALUES (50, 'Haier', '-', '2014-08-09 20:57:44', 435, '2014-08-09 20:57:44', 435);
INSERT INTO master_merk_barang VALUES (51, 'Green Air', '-', '2014-08-09 20:58:04', 435, '2014-08-09 20:58:04', 435);
INSERT INTO master_merk_barang VALUES (52, 'Mitsubishi', '-', '2014-08-09 20:58:21', 435, '2014-08-09 20:58:21', 435);
INSERT INTO master_merk_barang VALUES (53, 'Akira', '-', '2014-08-09 20:58:41', 435, '2014-08-09 20:58:41', 435);
INSERT INTO master_merk_barang VALUES (54, 'National', '-', '2014-08-09 20:59:34', 435, '2014-08-09 20:59:34', 435);
INSERT INTO master_merk_barang VALUES (55, 'Toyota', '-', '2014-08-14 22:39:08', 435, '2014-08-14 22:39:08', 435);
INSERT INTO master_merk_barang VALUES (56, 'Isuzu', '-', '2014-08-14 22:40:43', 435, '2014-08-14 22:40:43', 435);
INSERT INTO master_merk_barang VALUES (57, 'Tanpa Merek', '-', '2014-08-16 21:47:16', 435, '2014-08-16 21:47:16', 435);
INSERT INTO master_merk_barang VALUES (8, 'Maspion', '-', '2014-08-09 01:24:55', 435, '2014-08-09 01:24:55', 435);


--
-- Name: master_merk_barang_mmb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_merk_barang_mmb_id_seq', 57, true);


--
-- Data for Name: master_nama_barang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_nama_barang VALUES (1, 'Papan', 'ada', '2014-06-03 22:23:28', 435, '2014-06-03 22:23:28', 435, 'Papan');
INSERT INTO master_nama_barang VALUES (2, 'Kertas', 'warna', '2014-06-13 14:23:19', 435, '2014-06-13 14:23:19', 435, 'Kerta');
INSERT INTO master_nama_barang VALUES (3, 'minuman kaleng', 'pembelian tunai', '2014-06-15 06:32:20', 435, '2014-06-15 06:32:20', 435, '000mk');
INSERT INTO master_nama_barang VALUES (4, 'Kawat', '-', '2014-06-29 12:56:14', 435, '2014-06-29 12:56:14', 435, 'Kawat');
INSERT INTO master_nama_barang VALUES (5, 'PLYWOOD 2 ML', '-', '2014-07-15 15:18:49', 435, '2014-07-15 15:18:49', 435, '00P2M');
INSERT INTO master_nama_barang VALUES (6, 'Alat Katrol', '-', '2014-07-21 20:29:24', 435, '2014-07-21 20:29:24', 435, '000AK');
INSERT INTO master_nama_barang VALUES (2558, 'MANAQUIN LADY FULL BODY BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MLFBB');
INSERT INTO master_nama_barang VALUES (2559, 'MANAQUIN LADY HALF BODY CREAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MLHBC');
INSERT INTO master_nama_barang VALUES (2560, 'MANAQUIN MAN FULBODY CREAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0MMFC');
INSERT INTO master_nama_barang VALUES (2561, 'MANAQUIN MAN FULL BODY BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MMFBB');
INSERT INTO master_nama_barang VALUES (2682, 'SKUN 16 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S1O');
INSERT INTO master_nama_barang VALUES (2683, 'SKUN 25 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S2M');
INSERT INTO master_nama_barang VALUES (2684, 'SKUN 35 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S3M');
INSERT INTO master_nama_barang VALUES (2685, 'SKUN 50 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S5M');
INSERT INTO master_nama_barang VALUES (2686, 'SKUN 70 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S7M');
INSERT INTO master_nama_barang VALUES (2687, 'SKUN 95 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S9M');
INSERT INTO master_nama_barang VALUES (2688, 'SLING PENGAMANAN HP', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SPH');
INSERT INTO master_nama_barang VALUES (2689, 'SMOKE GUN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SG');
INSERT INTO master_nama_barang VALUES (2690, 'SOFA CREAM MUDA 1 SEATER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SCM1S');
INSERT INTO master_nama_barang VALUES (2691, 'SOFA CREAM MUDA 2 SEATER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SCM2S');
INSERT INTO master_nama_barang VALUES (2751, 'TROLY KAYU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TK');
INSERT INTO master_nama_barang VALUES (2429, 'KABEL RCA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KR');
INSERT INTO master_nama_barang VALUES (2789, 'Air Conditioner 1/2 PK', '-', '2014-08-09 20:54:08', 435, '2014-08-09 20:54:08', 435, '00AC1');
INSERT INTO master_nama_barang VALUES (2805, 'CAT NIPPE 315', '-', '2014-08-14 23:43:02', 435, '2014-08-14 23:43:02', 435, '00CA3');
INSERT INTO master_nama_barang VALUES (2820, 'BESI BEHEL  12 MM', '-', '2014-08-16 13:08:19', 435, '2014-08-16 13:08:19', 435, '0BB12');
INSERT INTO master_nama_barang VALUES (2790, 'Air Conditioner 1 PK', '-', '2014-08-09 20:54:47', 435, '2014-08-09 20:54:47', 435, '00AC2');
INSERT INTO master_nama_barang VALUES (2806, 'CAT NIPPE 322', '-', '2014-08-14 23:43:25', 435, '2014-08-14 23:43:25', 435, '00CA4');
INSERT INTO master_nama_barang VALUES (2821, 'BESI BEHEL 13 MM', '-', '2014-08-16 13:21:12', 435, '2014-08-16 13:21:12', 435, '0BSB1');
INSERT INTO master_nama_barang VALUES (2363, 'Compresor Bensin', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CB');
INSERT INTO master_nama_barang VALUES (2459, 'Kunci Pas 20/22', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP2');
INSERT INTO master_nama_barang VALUES (2460, 'Kunci Pas 22/24', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP3');
INSERT INTO master_nama_barang VALUES (2461, 'Kunci Pas 27/32', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP4');
INSERT INTO master_nama_barang VALUES (2462, 'Kunci Pas 30/32', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP5');
INSERT INTO master_nama_barang VALUES (2463, 'Kunci Pas 36', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP6');
INSERT INTO master_nama_barang VALUES (2464, 'Kunci Pas 6/7', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP7');
INSERT INTO master_nama_barang VALUES (2465, 'Kunci Pas 8/9', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP8');
INSERT INTO master_nama_barang VALUES (2467, 'Kunci Ring 10/11', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR1');
INSERT INTO master_nama_barang VALUES (2468, 'Kunci Ring 12/13', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR2');
INSERT INTO master_nama_barang VALUES (2768, 'UPPRIGHT POST 500 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP5C');
INSERT INTO master_nama_barang VALUES (2769, 'UPPRIGHT POST 600 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP6C');
INSERT INTO master_nama_barang VALUES (2770, 'UPPRIGHT POST 610 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP6D');
INSERT INTO master_nama_barang VALUES (2771, 'UPPRIGHT POST 7 Blh', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP7B');
INSERT INTO master_nama_barang VALUES (2772, 'UPPRIGHT POST 75 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP7C');
INSERT INTO master_nama_barang VALUES (2773, 'UPPRIGHT POST7 Blh', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00UPB');
INSERT INTO master_nama_barang VALUES (2774, 'VACUM CLEANER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000VC');
INSERT INTO master_nama_barang VALUES (2775, 'Voluma TYPE  C', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTC');
INSERT INTO master_nama_barang VALUES (2776, 'Voluma TYPE A', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTA');
INSERT INTO master_nama_barang VALUES (2777, 'Voluma TYPE B', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTB');
INSERT INTO master_nama_barang VALUES (2778, 'Voluma TYPE D', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTD');
INSERT INTO master_nama_barang VALUES (2779, 'Voluma TYPE E', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTE');
INSERT INTO master_nama_barang VALUES (2780, 'Voluma TYPE F', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTF');
INSERT INTO master_nama_barang VALUES (2791, 'Air Conditioner 2 PK', '-', '2014-08-09 20:55:25', 435, '2014-08-09 20:55:25', 435, '00AC3');
INSERT INTO master_nama_barang VALUES (2807, 'CAT NIPPE 396', '-', '2014-08-14 23:43:50', 435, '2014-08-14 23:43:50', 435, '00CA5');
INSERT INTO master_nama_barang VALUES (2822, 'BESI BEHEL 14 MM', '-', '2014-08-16 13:21:35', 435, '2014-08-16 13:21:35', 435, '0BSB2');
INSERT INTO master_nama_barang VALUES (2792, 'Air Conditioner 1 1/2 PK', '-', '2014-08-09 20:55:54', 435, '2014-08-09 20:55:54', 435, '00AC4');
INSERT INTO master_nama_barang VALUES (2808, 'CAT NIPPE 470 DOFT', '-', '2014-08-14 23:44:21', 435, '2014-08-14 23:44:21', 435, '00CA6');
INSERT INTO master_nama_barang VALUES (2823, 'BESI BEHEL 15 MM', '-', '2014-08-16 13:21:55', 435, '2014-08-16 13:21:55', 435, '0BSB3');
INSERT INTO master_nama_barang VALUES (2781, 'Voluma TYPE G', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTG');
INSERT INTO master_nama_barang VALUES (2782, 'Voluma TYPE H', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTH');
INSERT INTO master_nama_barang VALUES (2783, 'Voluma TYPE Z', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00VTZ');
INSERT INTO master_nama_barang VALUES (2784, 'WALL FAN PLASTIK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00WFP');
INSERT INTO master_nama_barang VALUES (2785, 'WALL FAN STAINLES', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00WFS');
INSERT INTO master_nama_barang VALUES (2532, 'LAMPU PLC 18W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LP1');
INSERT INTO master_nama_barang VALUES (2511, 'LAMPU HALIDA 70W OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LH7OB');
INSERT INTO master_nama_barang VALUES (2512, 'LAMPU HALOGEN 150W HITAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LH1H');
INSERT INTO master_nama_barang VALUES (2513, 'LAMPU HALOGEN 150W PUTIH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LH1P');
INSERT INTO master_nama_barang VALUES (2514, 'LAMPU HALOGEN 500W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LH5');
INSERT INTO master_nama_barang VALUES (2727, 'STOP KONTAK P4 OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SKPOE');
INSERT INTO master_nama_barang VALUES (2728, 'TABUNG TL 20W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TT2');
INSERT INTO master_nama_barang VALUES (2729, 'TABUNG TL 40W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TT4');
INSERT INTO master_nama_barang VALUES (2730, 'TABUNG TL 40W 827 (WARM)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0TT48');
INSERT INTO master_nama_barang VALUES (2519, 'LAMPU MERCURY 160W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LM1');
INSERT INTO master_nama_barang VALUES (2521, 'LAMPU MICRO HALOGEN LED 4W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LMHL4');
INSERT INTO master_nama_barang VALUES (2522, 'LAMPU MICRO HALOGEN STICK 220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LMHS2');
INSERT INTO master_nama_barang VALUES (2523, 'LAMPU MP LED PUTIH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LMLP');
INSERT INTO master_nama_barang VALUES (2524, 'LAMPU NATAL LED', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LNL');
INSERT INTO master_nama_barang VALUES (2525, 'LAMPU PAR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000LP');
INSERT INTO master_nama_barang VALUES (2526, 'LAMPU PIJAR 40W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LP4');
INSERT INTO master_nama_barang VALUES (2793, 'Air Conditioner 3/4 PK', '-', '2014-08-09 20:56:28', 435, '2014-08-09 20:56:28', 435, '00AC5');
INSERT INTO master_nama_barang VALUES (2809, 'CAT NIPPE 480 DOFT', '-', '2014-08-14 23:44:45', 435, '2014-08-14 23:44:45', 435, '00CA7');
INSERT INTO master_nama_barang VALUES (2824, 'BESI BEHEL 16 MM', '-', '2014-08-16 13:23:18', 435, '2014-08-16 13:23:18', 435, '0BSB5');
INSERT INTO master_nama_barang VALUES (2527, 'LAMPU PIJAR 5W BIRU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LP5B');
INSERT INTO master_nama_barang VALUES (2285, 'BARSTOOL PUTIH GLOSSY', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BPG');
INSERT INTO master_nama_barang VALUES (2286, 'Batrey Borcharger Bosh', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BBB');
INSERT INTO master_nama_barang VALUES (2287, 'BEAM CAKRAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BC');
INSERT INTO master_nama_barang VALUES (2288, 'Beam Section 100 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS1C');
INSERT INTO master_nama_barang VALUES (2289, 'Beam Section 136 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS1D');
INSERT INTO master_nama_barang VALUES (2290, 'Beam Section 16 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS1E');
INSERT INTO master_nama_barang VALUES (2291, 'Beam Section 200 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS2C');
INSERT INTO master_nama_barang VALUES (2292, 'Beam Section 206 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS2D');
INSERT INTO master_nama_barang VALUES (2293, 'Beam Section 21 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS2E');
INSERT INTO master_nama_barang VALUES (2294, 'Beam Section 25 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS2F');
INSERT INTO master_nama_barang VALUES (2295, 'Beam Section 276 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS2G');
INSERT INTO master_nama_barang VALUES (2296, 'Beam Section 300 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS3C');
INSERT INTO master_nama_barang VALUES (2297, 'Beam Section 31 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS3D');
INSERT INTO master_nama_barang VALUES (2298, 'Beam Section 350 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS3E');
INSERT INTO master_nama_barang VALUES (2542, 'LAMPU SPOT MP MERAH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LSMM');
INSERT INTO master_nama_barang VALUES (2543, 'LAMPU SPOT MP PUTIH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LSMP');
INSERT INTO master_nama_barang VALUES (2544, 'LAMPU TAMAN D10', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LTD');
INSERT INTO master_nama_barang VALUES (2545, 'LAMPU TL BOX 20W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LTB2');
INSERT INTO master_nama_barang VALUES (2546, 'LAMPU TL BOX 40W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LTB4');
INSERT INTO master_nama_barang VALUES (2547, 'LAMPU TL RANGKAI 15W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LTR1');
INSERT INTO master_nama_barang VALUES (2548, 'LAMPU TL RANGKAI 20W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LTR2');
INSERT INTO master_nama_barang VALUES (2549, 'LAMPU TL RANGKAI 40W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LTR4');
INSERT INTO master_nama_barang VALUES (2528, 'LAMPU PIJAR 5W KUNING', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LP5K');
INSERT INTO master_nama_barang VALUES (2529, 'LAMPU PIJAR 5W MERAH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LP5M');
INSERT INTO master_nama_barang VALUES (2530, 'LAMPU PIJAR 5W PUTIH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LP5P');
INSERT INTO master_nama_barang VALUES (2304, 'Beam Section 605 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS6C');
INSERT INTO master_nama_barang VALUES (2305, 'Beam Section 66 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS6D');
INSERT INTO master_nama_barang VALUES (2306, 'Beam Section CB 100', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BSC1');
INSERT INTO master_nama_barang VALUES (2307, 'Beam Section CB 150', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BSC2');
INSERT INTO master_nama_barang VALUES (2308, 'Beam Section CB 200', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BSC3');
INSERT INTO master_nama_barang VALUES (2309, 'Beam Section150 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BSC');
INSERT INTO master_nama_barang VALUES (2310, 'Beam Section250 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BSD');
INSERT INTO master_nama_barang VALUES (2311, 'BIRU MUDA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BO');
INSERT INTO master_nama_barang VALUES (2312, 'BIRU TUA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BT');
INSERT INTO master_nama_barang VALUES (2313, 'BIRU VICTOR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BV');
INSERT INTO master_nama_barang VALUES (2314, 'BLUMN CHAIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BD');
INSERT INTO master_nama_barang VALUES (2315, 'BOHLAM HALIDA 70W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BH7');
INSERT INTO master_nama_barang VALUES (2316, 'BOHLAM HPIT 250W (WARM)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BH2');
INSERT INTO master_nama_barang VALUES (2317, 'BOHLAM MICRO HALOGEN 12V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BMH1');
INSERT INTO master_nama_barang VALUES (2318, 'BOHLAM MICRO HALOGEN 220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BMH2');
INSERT INTO master_nama_barang VALUES (2733, 'Tang Buaya', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TB');
INSERT INTO master_nama_barang VALUES (2734, 'TANG FUSE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TF');
INSERT INTO master_nama_barang VALUES (2735, 'Tang Kombinasi', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TL');
INSERT INTO master_nama_barang VALUES (2736, 'Tang Potong', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TP');
INSERT INTO master_nama_barang VALUES (2737, 'Tang Potong Sling', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TPS');
INSERT INTO master_nama_barang VALUES (2738, 'Tang Skun', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TS');
INSERT INTO master_nama_barang VALUES (2616, 'Mesin Potong kayu 3 Phase', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MPk3P');
INSERT INTO master_nama_barang VALUES (2617, 'Mesin Potong System', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MPS');
INSERT INTO master_nama_barang VALUES (2618, 'Mesin Router', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MR');
INSERT INTO master_nama_barang VALUES (2619, 'Mesin Router Besar', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MRB');
INSERT INTO master_nama_barang VALUES (2620, 'Mesin Router Kecil', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MRK');
INSERT INTO master_nama_barang VALUES (2621, 'Mesin Serut', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MS');
INSERT INTO master_nama_barang VALUES (2622, 'Meteran Kain', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MK');
INSERT INTO master_nama_barang VALUES (2623, 'Mikro Bus', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MB');
INSERT INTO master_nama_barang VALUES (2624, 'Minivan', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Miniv');
INSERT INTO master_nama_barang VALUES (2625, 'MISTIFAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MISTI');
INSERT INTO master_nama_barang VALUES (2377, 'DEALING TABLE GLASS STD D100 cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'DTGSD');
INSERT INTO master_nama_barang VALUES (2379, 'DVD PLAYER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000DP');
INSERT INTO master_nama_barang VALUES (2380, 'EASY CHAIR BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00ECB');
INSERT INTO master_nama_barang VALUES (2382, 'EXAUS FAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000EF');
INSERT INTO master_nama_barang VALUES (2383, 'FISH BOWL', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000FB');
INSERT INTO master_nama_barang VALUES (2384, 'FITING HOLOGEN 150 W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0FH1W');
INSERT INTO master_nama_barang VALUES (2385, 'FITING KERAMIK SPOT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00FKS');
INSERT INTO master_nama_barang VALUES (2386, 'FITING LAMPU GANTUNG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00FLG');
INSERT INTO master_nama_barang VALUES (2631, 'Obeng (-)', '-', '2014-07-21 19:32:40.662912', 435, '2014-08-07 22:02:05', 435, 'Obng-');
INSERT INTO master_nama_barang VALUES (2632, 'Obeng (+)', NULL, '2014-07-21 19:32:40.662912', 435, '2014-08-07 22:03:06', 435, 'Obng+');
INSERT INTO master_nama_barang VALUES (2794, 'AC Portabel', '-', '2014-08-09 20:57:14', 435, '2014-08-09 20:57:14', 435, '00AC0');
INSERT INTO master_nama_barang VALUES (2810, 'CAT NIPPE 480 SB', '-', '2014-08-14 23:45:09', 435, '2014-08-14 23:45:09', 435, '00CA8');
INSERT INTO master_nama_barang VALUES (2825, 'BESI BETON', '-', '2014-08-16 13:23:47', 435, '2014-08-16 13:23:47', 435, '0BSBT');
INSERT INTO master_nama_barang VALUES (2387, 'FITING MIKA BULAT DOWNLIGHT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0FMBD');
INSERT INTO master_nama_barang VALUES (2388, 'FITING MIKA KOTAK DOWNLIGHT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0FMKD');
INSERT INTO master_nama_barang VALUES (2389, 'FITING TEMPEL', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000FT');
INSERT INTO master_nama_barang VALUES (2390, 'FLASTER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'FLAST');
INSERT INTO master_nama_barang VALUES (2391, 'FOLDING CHAIR (WHITE)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000FC');
INSERT INTO master_nama_barang VALUES (2392, 'FOLDING CHAIR BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00FCB');
INSERT INTO master_nama_barang VALUES (2393, 'Forklif', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Forkl');
INSERT INTO master_nama_barang VALUES (2394, 'FUNCTION CHAIR STAINLESS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00FCS');
INSERT INTO master_nama_barang VALUES (2395, 'GARDEN CHAIR CELEBRITY', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00GCC');
INSERT INTO master_nama_barang VALUES (2396, 'GARDEN CHAIR CELEBRITY (BESAR)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00GCD');
INSERT INTO master_nama_barang VALUES (2397, 'Gergaji Besi', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000GB');
INSERT INTO master_nama_barang VALUES (2398, 'Glue Gun', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000GG');
INSERT INTO master_nama_barang VALUES (2399, 'GREAT WALL BLACK CHAIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0GWBC');
INSERT INTO master_nama_barang VALUES (2400, 'GREAT WALL CHAIR RED', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0GWCR');
INSERT INTO master_nama_barang VALUES (2401, 'GREAT WALL PUTIH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00GWP');
INSERT INTO master_nama_barang VALUES (2402, 'GREAT WALL RED CHAIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0GWRC');
INSERT INTO master_nama_barang VALUES (2403, 'GREAT WALL WHITE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00GWW');
INSERT INTO master_nama_barang VALUES (2404, 'GULIA CHAIR WHITE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00GCW');
INSERT INTO master_nama_barang VALUES (2435, 'KACA CERMIN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KC');
INSERT INTO master_nama_barang VALUES (2520, 'LAMPU MICRO HALOGEN LED 1W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LMHL1');
INSERT INTO master_nama_barang VALUES (2626, 'MONITOR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MONIT');
INSERT INTO master_nama_barang VALUES (2627, 'Motor', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Motor');
INSERT INTO master_nama_barang VALUES (2628, 'Muli tester', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000Mt');
INSERT INTO master_nama_barang VALUES (2629, 'Multitester', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Multi');
INSERT INTO master_nama_barang VALUES (2630, 'NH FUSE 100 A', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0NF1A');
INSERT INTO master_nama_barang VALUES (2633, 'Obeng Testpen', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000OT');
INSERT INTO master_nama_barang VALUES (2634, 'ORANGE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'ORANG');
INSERT INTO master_nama_barang VALUES (2635, 'ORBIT CHAIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000OC');
INSERT INTO master_nama_barang VALUES (2636, 'Oven / Regulator Acrylic', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00ORA');
INSERT INTO master_nama_barang VALUES (2637, 'Partisi 236 X 46,9', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0P2X4');
INSERT INTO master_nama_barang VALUES (2638, 'Partisi 236 X 96,4', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0P2X9');
INSERT INTO master_nama_barang VALUES (2639, 'PATUNG MACAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000PM');
INSERT INTO master_nama_barang VALUES (2640, 'PAYUNG 3 SUSUN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00P3S');
INSERT INTO master_nama_barang VALUES (2641, 'PEMBATAS JALAN (CONE)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000PJ');
INSERT INTO master_nama_barang VALUES (2642, 'PENANGKAL PETIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000PP');
INSERT INTO master_nama_barang VALUES (2643, 'PEROSOTAN T 2,5 cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0PT2c');
INSERT INTO master_nama_barang VALUES (2644, 'PLASTIK CHAIR BLUE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00PCB');
INSERT INTO master_nama_barang VALUES (2645, 'PLASTIK CHAIR ORANGE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00PCO');
INSERT INTO master_nama_barang VALUES (2646, 'POHON MEHWA T 0,5', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0PMT0');
INSERT INTO master_nama_barang VALUES (2647, 'POHON MEHWA T 2,0', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0PMT2');
INSERT INTO master_nama_barang VALUES (2648, 'POHON MEHWA T 2,5', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0PMT3');
INSERT INTO master_nama_barang VALUES (2649, 'RAK BROSUR CRISS CROSS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0RBCC');
INSERT INTO master_nama_barang VALUES (2650, 'RAK BROSUR STANDING', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00RBS');
INSERT INTO master_nama_barang VALUES (2430, 'KABEL RGB/VGA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KS');
INSERT INTO master_nama_barang VALUES (2431, 'Kabel Rol', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KT');
INSERT INTO master_nama_barang VALUES (2432, 'KABEL SENUR 2 x 0,23 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KS2x0');
INSERT INTO master_nama_barang VALUES (2433, 'KABEL SENUR 2 x 0,50 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KS2x1');
INSERT INTO master_nama_barang VALUES (2434, 'KABEL/TALI TIES 30 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KT3C');
INSERT INTO master_nama_barang VALUES (2436, 'KAKI KANVAS (HITAM)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KK');
INSERT INTO master_nama_barang VALUES (2437, 'KAP LAMPU MERCURY', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KLM');
INSERT INTO master_nama_barang VALUES (2438, 'KAP LAMPU TAMAN ANDONG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KLTA');
INSERT INTO master_nama_barang VALUES (2439, 'KAP LAMPU TAMAN BULAT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KLTB');
INSERT INTO master_nama_barang VALUES (2440, 'Kendaraan Roda 4', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR4');
INSERT INTO master_nama_barang VALUES (2441, 'KERANJANG ROTAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KU');
INSERT INTO master_nama_barang VALUES (2442, 'KERANJANG SAMPAH PLASTIK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KSP');
INSERT INTO master_nama_barang VALUES (2443, 'KIPAS ANGIN (KOTAK)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KA');
INSERT INTO master_nama_barang VALUES (2381, 'EIFFEL CHAIR (RED)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000EC');
INSERT INTO master_nama_barang VALUES (2795, 'AC Standing 1/2 PK', '-', '2014-08-09 21:06:58', 435, '2014-08-09 21:06:58', 435, '00AC6');
INSERT INTO master_nama_barang VALUES (2539, 'LAMPU SPOT MP BIRU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LSMB');
INSERT INTO master_nama_barang VALUES (2257, 'KARPET ABU-ABU AWAN', '-', '2014-07-21 19:32:40.662912', 435, '2014-07-22 08:53:57', 435, '00KAA');
INSERT INTO master_nama_barang VALUES (2258, 'KARPET ABU-ABU BINTIK', '-', '2014-07-21 19:32:40.662912', 435, '2014-07-22 08:54:42', 435, '00KAB');
INSERT INTO master_nama_barang VALUES (2259, 'KARPET ABU-ABU MUDA', '-', '2014-07-21 19:32:40.662912', 435, '2014-07-22 08:55:29', 435, '00KAN');
INSERT INTO master_nama_barang VALUES (2260, 'KARPET ABU-ABU TUA', '-', '2014-07-21 19:32:40.662912', 435, '2014-07-22 08:56:15', 435, '00KAU');
INSERT INTO master_nama_barang VALUES (2261, 'AIR COOLER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000AC');
INSERT INTO master_nama_barang VALUES (2262, 'Alat Pembolong Beam', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00APB');
INSERT INTO master_nama_barang VALUES (2263, 'Alat Rivert', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000AR');
INSERT INTO master_nama_barang VALUES (2264, 'Alat Rol Electrik Krisbow', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0AREK');
INSERT INTO master_nama_barang VALUES (2265, 'ANTENA TV IN DOOR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0ATID');
INSERT INTO master_nama_barang VALUES (2266, 'ANTENA TV IN DOOR PF 5000', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'ATIDP');
INSERT INTO master_nama_barang VALUES (2267, 'ARM WHITE CHAIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00AWC');
INSERT INTO master_nama_barang VALUES (2268, 'ASBAK KACA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000AL');
INSERT INTO master_nama_barang VALUES (2269, 'ASBAK KACA MEJA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00AKM');
INSERT INTO master_nama_barang VALUES (2270, 'ASBAK STAINLESS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000AS');
INSERT INTO master_nama_barang VALUES (2271, 'BALAS DC 12V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BD1');
INSERT INTO master_nama_barang VALUES (2272, 'BALAS DOWNLIGHT 12V PHILPS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BD1P');
INSERT INTO master_nama_barang VALUES (2273, 'BALAS DOWNLIGHT 12V VOSLOH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BD1V');
INSERT INTO master_nama_barang VALUES (2274, 'BALAS NEON SEN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BNS');
INSERT INTO master_nama_barang VALUES (2275, 'BALAS TL 20 W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BT2W');
INSERT INTO master_nama_barang VALUES (2276, 'BALAS TL 40 W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BT4W');
INSERT INTO master_nama_barang VALUES (2277, 'BALDOR DINAMO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BE');
INSERT INTO master_nama_barang VALUES (2278, 'BARRIER HITAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BH');
INSERT INTO master_nama_barang VALUES (2279, 'BARRIER STAINLESS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BU');
INSERT INTO master_nama_barang VALUES (2280, 'BARSTOL HITAM GLOSSY', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BHG');
INSERT INTO master_nama_barang VALUES (2281, 'BARSTOL KOTAK HITAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BKH');
INSERT INTO master_nama_barang VALUES (2282, 'BARSTOL PUTIH GLOSSY', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BPH');
INSERT INTO master_nama_barang VALUES (2283, 'BARSTOOL BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BF');
INSERT INTO master_nama_barang VALUES (2611, 'Mesin Las Travo Rinho', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0MLTR');
INSERT INTO master_nama_barang VALUES (2586, 'MEJA PAYUNG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MP');
INSERT INTO master_nama_barang VALUES (2587, 'MERAH BINTIK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MC');
INSERT INTO master_nama_barang VALUES (2588, 'MERAH TERANG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MT');
INSERT INTO master_nama_barang VALUES (2589, 'Merk MAKITA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MM');
INSERT INTO master_nama_barang VALUES (2420, 'KABEL NYM 3 x 2,5 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN3x2');
INSERT INTO master_nama_barang VALUES (2590, 'Mero  150 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M1C');
INSERT INTO master_nama_barang VALUES (2708, 'Spray Gun Camport', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SGC');
INSERT INTO master_nama_barang VALUES (2709, 'Spray Gun Tabung Bawah', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SGTB');
INSERT INTO master_nama_barang VALUES (2710, 'SPUYER MISTIFAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SN');
INSERT INTO master_nama_barang VALUES (2711, 'STAGER UK. 70 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SU7C');
INSERT INTO master_nama_barang VALUES (2712, 'STAND HANGER BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SHB');
INSERT INTO master_nama_barang VALUES (2713, 'STAND HANGER SINGLE RAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SHSR');
INSERT INTO master_nama_barang VALUES (2714, 'STAND HANGER STAINLESS HORIS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SHSH');
INSERT INTO master_nama_barang VALUES (2715, 'Staples Flexi Tangan', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SFT');
INSERT INTO master_nama_barang VALUES (2717, 'STATER S2', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SS');
INSERT INTO master_nama_barang VALUES (2718, 'STECKER K2', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SK');
INSERT INTO master_nama_barang VALUES (2719, 'STECKER K3', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SL');
INSERT INTO master_nama_barang VALUES (2741, 'Tembakan Paku F-30', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TPF');
INSERT INTO master_nama_barang VALUES (2742, 'Tembakan Paku F-50', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TPG');
INSERT INTO master_nama_barang VALUES (2743, 'Tembakan Paku Laminasi', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TPL');
INSERT INTO master_nama_barang VALUES (2744, 'Tembakan Sambung', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TT');
INSERT INTO master_nama_barang VALUES (2746, 'TEMPAT TIDUR LIPAT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TTL');
INSERT INTO master_nama_barang VALUES (2348, 'CANTOLAN CEILLING', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CC');
INSERT INTO master_nama_barang VALUES (2349, 'CANTOLAN COUNTER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CD');
INSERT INTO master_nama_barang VALUES (2350, 'CAT WALK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CW');
INSERT INTO master_nama_barang VALUES (2351, 'CENTRIFUGAL FAN(BLOWER KEONG)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CFK');
INSERT INTO master_nama_barang VALUES (2352, 'Charger Borcharger Mactek', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CBM');
INSERT INTO master_nama_barang VALUES (2353, 'Charger Bosrcharger Bosh', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CBB');
INSERT INTO master_nama_barang VALUES (2354, 'CHITOSE CHAIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CE');
INSERT INTO master_nama_barang VALUES (2355, 'CLASSY CHAIR CREAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CCC');
INSERT INTO master_nama_barang VALUES (2356, 'CLASSY CHAIR HITAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CCH');
INSERT INTO master_nama_barang VALUES (2357, 'CLICK MERO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CN');
INSERT INTO master_nama_barang VALUES (2358, 'COFFE TABLE EX. HONDA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0CTEH');
INSERT INTO master_nama_barang VALUES (2359, 'COFFE TABLE UK.50x50x40', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CTU');
INSERT INTO master_nama_barang VALUES (2360, 'COFFE TABLE UK.90x60x40', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CTV');
INSERT INTO master_nama_barang VALUES (2562, 'MANAQUIN MAN HALF BODY CREAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MMHBC');
INSERT INTO master_nama_barang VALUES (2563, 'MANAQUIN MAN KALFL BODY BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MMKBB');
INSERT INTO master_nama_barang VALUES (2564, 'Mata Bor  Hole', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MBH');
INSERT INTO master_nama_barang VALUES (2580, 'MCB 3PH/25A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M3');
INSERT INTO master_nama_barang VALUES (2581, 'MCB 3PH/32A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M4');
INSERT INTO master_nama_barang VALUES (2582, 'MCB 3PH/50A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M5');
INSERT INTO master_nama_barang VALUES (2583, 'MEETING CHAIR', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MD');
INSERT INTO master_nama_barang VALUES (2584, 'MEETING CHAIR DESIGNER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MCD');
INSERT INTO master_nama_barang VALUES (2585, 'MEETING TABLE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MU');
INSERT INTO master_nama_barang VALUES (2703, 'SOLID', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SOLID');
INSERT INTO master_nama_barang VALUES (2704, 'SPIRAL KABEL', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SR');
INSERT INTO master_nama_barang VALUES (2705, 'SPLITER RCA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000ST');
INSERT INTO master_nama_barang VALUES (2706, 'SPLITER VGA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SV');
INSERT INTO master_nama_barang VALUES (2552, 'LAMPU XION T5 8W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LXT8');
INSERT INTO master_nama_barang VALUES (2553, 'LAMPU/BOHLAM HALOGEN 150W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LH1');
INSERT INTO master_nama_barang VALUES (2554, 'LAMPU/BOHLAM HALOGEN 300W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LH3');
INSERT INTO master_nama_barang VALUES (2555, 'LAMPU/BOHLAM HALOGEN 500W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LH6');
INSERT INTO master_nama_barang VALUES (2556, 'LOCKER 4 PINTU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00L4P');
INSERT INTO master_nama_barang VALUES (2557, 'LOCKER 6 PINTU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00L6P');
INSERT INTO master_nama_barang VALUES (2796, 'Acrylic ', '-', '2014-08-09 21:09:08', 435, '2014-08-09 21:09:08', 435, '00ACR');
INSERT INTO master_nama_barang VALUES (2347, 'Cafe Chair', NULL, '2014-07-21 19:32:40.662912', 435, '2014-08-14 14:20:40', 435, '000CF');
INSERT INTO master_nama_barang VALUES (2811, 'CAT TEMBOK Q-LUC @25 KG', '-', '2014-08-14 23:45:48', 435, '2014-08-14 23:45:48', 435, '00CA9');
INSERT INTO master_nama_barang VALUES (2826, 'BESI BETON 6 MM', '-', '2014-08-16 13:24:43', 435, '2014-08-16 13:24:43', 435, 'BSBT1');
INSERT INTO master_nama_barang VALUES (2299, 'Beam Section 400 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS4C');
INSERT INTO master_nama_barang VALUES (2300, 'Beam Section 450 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS4D');
INSERT INTO master_nama_barang VALUES (2301, 'Beam Section 50 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS5C');
INSERT INTO master_nama_barang VALUES (2302, 'Beam Section 500 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS5D');
INSERT INTO master_nama_barang VALUES (2303, 'Beam Section 600 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BS6E');
INSERT INTO master_nama_barang VALUES (2333, 'BRACKET PLASMA 19"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BP1');
INSERT INTO master_nama_barang VALUES (2334, 'BRACKET PLASMA 42"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BP4');
INSERT INTO master_nama_barang VALUES (2335, 'BREKER 100A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B1');
INSERT INTO master_nama_barang VALUES (2336, 'BREKER 125A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B2');
INSERT INTO master_nama_barang VALUES (2337, 'BREKER 160A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B3');
INSERT INTO master_nama_barang VALUES (2338, 'BREKER 200A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B4');
INSERT INTO master_nama_barang VALUES (2339, 'BREKER 250A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B5');
INSERT INTO master_nama_barang VALUES (2340, 'BREKER 300A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B6');
INSERT INTO master_nama_barang VALUES (2341, 'BREKER 30A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B7');
INSERT INTO master_nama_barang VALUES (2342, 'BREKER 32A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B8');
INSERT INTO master_nama_barang VALUES (2343, 'BREKER 500A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000B9');
INSERT INTO master_nama_barang VALUES (2344, 'BREKER 60A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00B10');
INSERT INTO master_nama_barang VALUES (2345, 'BREKER 63A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00B11');
INSERT INTO master_nama_barang VALUES (2346, 'Bus', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00Bus');
INSERT INTO master_nama_barang VALUES (2658, 'ROUND COFFE TABLE D.50', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0RCTD');
INSERT INTO master_nama_barang VALUES (2659, 'ROUND TABLE HOLOGRAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00RTH');
INSERT INTO master_nama_barang VALUES (2660, 'ROUND TABLE POLOS D 80', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'RTPD8');
INSERT INTO master_nama_barang VALUES (2661, 'RUBBASE CHAIR BLACK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00RCB');
INSERT INTO master_nama_barang VALUES (2663, 'SAKLAR 1 PHOLE IN BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'S1PIB');
INSERT INTO master_nama_barang VALUES (2664, 'SAKLAR 1 PHOLE OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'S1POB');
INSERT INTO master_nama_barang VALUES (2665, 'SAKLAR 2 PHOLE IN BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'S2PIB');
INSERT INTO master_nama_barang VALUES (2666, 'SAKLAR 2 PHOLE OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'S2POB');
INSERT INTO master_nama_barang VALUES (2667, 'SAMBUNGAN POST', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SP');
INSERT INTO master_nama_barang VALUES (2668, 'SAVON CHAIR WHITE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SCW');
INSERT INTO master_nama_barang VALUES (2670, 'Saw 9,5 cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S9c');
INSERT INTO master_nama_barang VALUES (2671, 'SCAFFOLDING UK. 150 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SU1C');
INSERT INTO master_nama_barang VALUES (2672, 'SCAFFOLDING UK. 170 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SU1D');
INSERT INTO master_nama_barang VALUES (2673, 'SEILING FAN PLASTIK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SFP');
INSERT INTO master_nama_barang VALUES (2674, 'SEILING FAN STAINLES', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SFS');
INSERT INTO master_nama_barang VALUES (2675, 'SELANG MISTIFAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SM');
INSERT INTO master_nama_barang VALUES (2676, 'SILANGAN RODA STAGER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SRS');
INSERT INTO master_nama_barang VALUES (2677, 'SIRENE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SIREN');
INSERT INTO master_nama_barang VALUES (2678, 'SKUN 1,5 MM (-)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S1M');
INSERT INTO master_nama_barang VALUES (2679, 'SKUN 1,5 MM (+)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S1N');
INSERT INTO master_nama_barang VALUES (2761, 'UPPRIGHT POST 250 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP2C');
INSERT INTO master_nama_barang VALUES (2515, 'LAMPU HALOGEN MICRO TRAC 12V/50W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LHMT1');
INSERT INTO master_nama_barang VALUES (2516, 'LAMPU HPIT 250W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LH2');
INSERT INTO master_nama_barang VALUES (2517, 'LAMPU HPIT 400W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LH4');
INSERT INTO master_nama_barang VALUES (2518, 'LAMPU LED RANGKAIAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LLR');
INSERT INTO master_nama_barang VALUES (2319, 'BOHLAM SPOT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BS');
INSERT INTO master_nama_barang VALUES (2320, 'BOLA MERO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BM');
INSERT INTO master_nama_barang VALUES (2321, 'BOR LISTRIK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BL');
INSERT INTO master_nama_barang VALUES (2322, 'Bor Listrik Duduk', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BLD');
INSERT INTO master_nama_barang VALUES (2323, 'Bor Listrik Magnet', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BLM');
INSERT INTO master_nama_barang VALUES (2324, 'Bor Listrik Makita', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BLN');
INSERT INTO master_nama_barang VALUES (2325, 'Bor Listrk Duduk', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BLE');
INSERT INTO master_nama_barang VALUES (2326, 'Borcharger', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Borch');
INSERT INTO master_nama_barang VALUES (2327, 'Borcharger Bosch', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BB');
INSERT INTO master_nama_barang VALUES (2328, 'Borcharger Mactek', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000BN');
INSERT INTO master_nama_barang VALUES (2329, 'BOX LAMPU TL 20 W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'BLT2W');
INSERT INTO master_nama_barang VALUES (2330, 'BOX LAMPU TL 40 W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'BLT4W');
INSERT INTO master_nama_barang VALUES (2331, 'BOX MCB 1 PH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BM1P');
INSERT INTO master_nama_barang VALUES (2332, 'BOX MCB 3 PH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0BM3P');
INSERT INTO master_nama_barang VALUES (2366, 'COVER MERO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CM');
INSERT INTO master_nama_barang VALUES (2466, 'KUNCI PIPA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KP');
INSERT INTO master_nama_barang VALUES (2612, 'MESIN POMPA AIR "NASIONAL 125"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0MPA1');
INSERT INTO master_nama_barang VALUES (2720, 'STECKER MULTI K2 - K3', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SMK-K');
INSERT INTO master_nama_barang VALUES (2721, 'STECKER MULTI K3 - K2', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SMK-L');
INSERT INTO master_nama_barang VALUES (2722, 'STOP KONTAK AC', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SKA');
INSERT INTO master_nama_barang VALUES (2723, 'STOP KONTAK E1 INBOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SKEI');
INSERT INTO master_nama_barang VALUES (2724, 'STOP KONTAK P1 OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SKPOB');
INSERT INTO master_nama_barang VALUES (2725, 'STOP KONTAK P2 OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SKPOC');
INSERT INTO master_nama_barang VALUES (2726, 'STOP KONTAK P3 OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'SKPOD');
INSERT INTO master_nama_barang VALUES (2731, 'TANAMAN RAMBAT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TR');
INSERT INTO master_nama_barang VALUES (2732, 'Tang Ampere', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TA');
INSERT INTO master_nama_barang VALUES (2444, 'KIPAS ANGIN MASPION', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KAM');
INSERT INTO master_nama_barang VALUES (2445, 'KIPAS ANGIN TORNADO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KAT');
INSERT INTO master_nama_barang VALUES (2786, 'WASTE BASKET', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000WB');
INSERT INTO master_nama_barang VALUES (2787, 'WASTE BLACK BESI', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00WBB');
INSERT INTO master_nama_barang VALUES (2536, 'LAMPU SOROT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000LS');
INSERT INTO master_nama_barang VALUES (2537, 'LAMPU SPOT BARU (LONG ARM)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LSBA');
INSERT INTO master_nama_barang VALUES (2538, 'LAMPU SPOT LAMA (CLIP ARM)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LSLA');
INSERT INTO master_nama_barang VALUES (2565, 'Mata Bor Hole', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MBI');
INSERT INTO master_nama_barang VALUES (2566, 'Mata Bor Hole                  Saw 6,4cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MBHS6');
INSERT INTO master_nama_barang VALUES (2567, 'Mata Bor Hole                 Saw 1,5cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MBHS1');
INSERT INTO master_nama_barang VALUES (2568, 'MCB (HAGER) 3PH/63A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M6');
INSERT INTO master_nama_barang VALUES (2551, 'LAMPU XION T5 28W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LXT2');
INSERT INTO master_nama_barang VALUES (2569, 'MCB 1PH/10A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M1');
INSERT INTO master_nama_barang VALUES (2570, 'MCB 1PH/16A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M2');
INSERT INTO master_nama_barang VALUES (2571, 'MCB 1PH/20A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M7');
INSERT INTO master_nama_barang VALUES (2572, 'MCB 1PH/25A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M8');
INSERT INTO master_nama_barang VALUES (2573, 'MCB 1PH/2A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000M9');
INSERT INTO master_nama_barang VALUES (2574, 'MCB 1PH/32A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M10');
INSERT INTO master_nama_barang VALUES (2575, 'MCB 1PH/4A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M11');
INSERT INTO master_nama_barang VALUES (2576, 'MCB 1PH/6A/220V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M12');
INSERT INTO master_nama_barang VALUES (2577, 'MCB 3PH/10A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M13');
INSERT INTO master_nama_barang VALUES (2578, 'MCB 3PH/16A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M14');
INSERT INTO master_nama_barang VALUES (2579, 'MCB 3PH/20A/380V', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M15');
INSERT INTO master_nama_barang VALUES (2284, 'BARSTOOL KOTAK PUTIH', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00BKP');
INSERT INTO master_nama_barang VALUES (2692, 'SOFA DIETHELM ABU-ABU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SDA');
INSERT INTO master_nama_barang VALUES (2693, 'SOFA HITAM 1 SEATER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SH1S');
INSERT INTO master_nama_barang VALUES (2694, 'SOFA HITAM 2 SEATER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SH2S');
INSERT INTO master_nama_barang VALUES (2695, 'SOFA PUFF HITAM PANJANG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SPHP');
INSERT INTO master_nama_barang VALUES (2696, 'SOFA PUFF UK. 50x50 (KECIL)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SPU5');
INSERT INTO master_nama_barang VALUES (2697, 'SOFA PUTIH 1 SEATER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SP1S');
INSERT INTO master_nama_barang VALUES (2698, 'SOFA PUTIH 2 SEATER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0SP2S');
INSERT INTO master_nama_barang VALUES (2699, 'SOFA RING-O (EXS HONDA)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00SRH');
INSERT INTO master_nama_barang VALUES (2701, 'Solder Listrik', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SO');
INSERT INTO master_nama_barang VALUES (2702, 'SOLDER PUMP', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SQ');
INSERT INTO master_nama_barang VALUES (2797, 'Mobil Elf', 'B 7087 IU', '2014-08-14 21:19:49', 435, '2014-08-14 21:19:49', 435, '00KRE');
INSERT INTO master_nama_barang VALUES (2812, 'DEMPUL SANPOLAK', NULL, '2014-08-14 23:48:22', 435, '2014-08-14 23:48:22', 435, '000DE');
INSERT INTO master_nama_barang VALUES (2827, 'BESI BETON 8 MM', '-', '2014-08-16 13:25:06', 435, '2014-08-16 13:25:06', 435, 'BSBT2');
INSERT INTO master_nama_barang VALUES (2707, 'Spray Gun', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SH');
INSERT INTO master_nama_barang VALUES (2716, 'STATER S10', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SU');
INSERT INTO master_nama_barang VALUES (2533, 'LAMPU PLC 8W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LP8');
INSERT INTO master_nama_barang VALUES (2534, 'LAMPU RM 2X40W (BOX)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LR2');
INSERT INTO master_nama_barang VALUES (2798, 'Nissan Fuso', 'B 96666 JB', '2014-08-14 21:21:32', 435, '2014-08-14 21:21:32', 435, '00KRN');
INSERT INTO master_nama_barang VALUES (2813, 'PIPA Ukuran Diameter 1 CM', '-', '2014-08-16 13:01:15', 435, '2014-08-16 13:01:15', 435, '00PPA');
INSERT INTO master_nama_barang VALUES (2828, 'BESI CANAL UK 100x50x2.3x6 M', '-', '2014-08-16 13:26:25', 435, '2014-08-16 13:26:25', 435, '0BSC0');
INSERT INTO master_nama_barang VALUES (2535, 'LAMPU ROTARY/LAMPU SIRINE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LRS');
INSERT INTO master_nama_barang VALUES (2739, 'TANGGA KAYU 150 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0TK1C');
INSERT INTO master_nama_barang VALUES (2740, 'Tembakan', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Temba');
INSERT INTO master_nama_barang VALUES (2788, 'WASTE GREY PLASTIK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00WGP');
INSERT INTO master_nama_barang VALUES (2680, 'SKUN 10 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S1P');
INSERT INTO master_nama_barang VALUES (2662, 'Safety Belt', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SB');
INSERT INTO master_nama_barang VALUES (2681, 'SKUN 120 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00S1Q');
INSERT INTO master_nama_barang VALUES (2446, 'KLEM KABEL 10 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KK1M');
INSERT INTO master_nama_barang VALUES (2447, 'KLEM KABEL 8 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KK8M');
INSERT INTO master_nama_barang VALUES (2448, 'KULKAS (BAR FRIGE)', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KF');
INSERT INTO master_nama_barang VALUES (2449, 'KULKAS 1 PINTU MEDIUM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0K1PM');
INSERT INTO master_nama_barang VALUES (2450, 'KULKAS 2 PINTU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00K2P');
INSERT INTO master_nama_barang VALUES (2451, 'Kunci Inggris 10"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KI1');
INSERT INTO master_nama_barang VALUES (2452, 'Kunci Inggris 12"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KI2');
INSERT INTO master_nama_barang VALUES (2453, 'Kunci Inggris 15"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KI3');
INSERT INTO master_nama_barang VALUES (2454, 'Kunci Pas 10/11', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP1');
INSERT INTO master_nama_barang VALUES (2455, 'Kunci Pas 12/13', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KP9');
INSERT INTO master_nama_barang VALUES (2456, 'Kunci Pas 14/15', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KP10');
INSERT INTO master_nama_barang VALUES (2457, 'Kunci Pas 16/17', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KP11');
INSERT INTO master_nama_barang VALUES (2458, 'Kunci Pas 19/21', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KP12');
INSERT INTO master_nama_barang VALUES (2491, 'KUNCI SHOCK', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KV');
INSERT INTO master_nama_barang VALUES (2651, 'REVOLVING 20 KG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00R2K');
INSERT INTO master_nama_barang VALUES (2652, 'REVOLVING 500 KG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00R5K');
INSERT INTO master_nama_barang VALUES (2653, 'RODA SEAFOLDING', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000RS');
INSERT INTO master_nama_barang VALUES (2654, 'RODA STAGER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000RT');
INSERT INTO master_nama_barang VALUES (2655, 'ROUND COFFE POLOS D.70', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0RCPD');
INSERT INTO master_nama_barang VALUES (2376, 'DEALING TABLE GLASS PUTAR COFFEMO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'DTGPC');
INSERT INTO master_nama_barang VALUES (2656, 'ROUND COFFE TABLE BAR GLASS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'RCTBG');
INSERT INTO master_nama_barang VALUES (2657, 'ROUND COFFE TABLE D 60', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'RCTD6');
INSERT INTO master_nama_barang VALUES (2669, 'Saw 7,4cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000S7');
INSERT INTO master_nama_barang VALUES (2799, 'APV', ' B 2569 HI', '2014-08-14 22:44:29', 435, '2014-08-14 22:44:29', 435, '00KRA');
INSERT INTO master_nama_barang VALUES (2814, 'BESI', '-', '2014-08-16 13:02:55', 435, '2014-08-16 13:02:55', 435, '00BS0');
INSERT INTO master_nama_barang VALUES (2829, 'BESI KANAL UK 100 x 50 x 6 M', '-', '2014-08-16 13:28:09', 435, '2014-08-16 13:28:09', 435, '0BSCU');
INSERT INTO master_nama_barang VALUES (2361, 'COKLAT EMAS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CG');
INSERT INTO master_nama_barang VALUES (2362, 'COKLAT TUA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CT');
INSERT INTO master_nama_barang VALUES (2364, 'Compresor Listrik', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000CL');
INSERT INTO master_nama_barang VALUES (2365, 'COUNCIL CHAIR OFFICE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00CCO');
INSERT INTO master_nama_barang VALUES (2367, 'COYLE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'COYLE');
INSERT INTO master_nama_barang VALUES (2368, 'CROSS BRACE 200 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0CB2C');
INSERT INTO master_nama_barang VALUES (2369, 'CROSS BRACE 220 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0CB2D');
INSERT INTO master_nama_barang VALUES (2370, 'CRUISTIN 10 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00C1M');
INSERT INTO master_nama_barang VALUES (2371, 'CRUISTIN 16 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00C1N');
INSERT INTO master_nama_barang VALUES (2372, 'CRUISTIN 25 MM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00C2M');
INSERT INTO master_nama_barang VALUES (2373, 'DEALING TABLE 75', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00DT7');
INSERT INTO master_nama_barang VALUES (2374, 'DEALING TABLE GLASS D80 cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'DTGDc');
INSERT INTO master_nama_barang VALUES (2375, 'DEALING TABLE GLASS D90 cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'DTGDd');
INSERT INTO master_nama_barang VALUES (2378, 'DISPENSER', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'DISPE');
INSERT INTO master_nama_barang VALUES (2405, 'Gunting Plat', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000GP');
INSERT INTO master_nama_barang VALUES (2406, 'Gurinda Uk. 14"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00GU1');
INSERT INTO master_nama_barang VALUES (2407, 'HIJAU LUMUT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000HL');
INSERT INTO master_nama_barang VALUES (2408, 'HIJAU MUDA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000HM');
INSERT INTO master_nama_barang VALUES (2409, 'HIJAU PUPUS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000HP');
INSERT INTO master_nama_barang VALUES (2410, 'HIJAU TERANG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000HT');
INSERT INTO master_nama_barang VALUES (2411, 'HITAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'HITAM');
INSERT INTO master_nama_barang VALUES (2412, 'INTIC FAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000IF');
INSERT INTO master_nama_barang VALUES (2413, 'ISOLASI NITTO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000IN');
INSERT INTO master_nama_barang VALUES (2414, 'JACK MONO-STEREO', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000JM');
INSERT INTO master_nama_barang VALUES (2415, 'JACK RCA', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000JR');
INSERT INTO master_nama_barang VALUES (2416, 'KABEL HDMI', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KH');
INSERT INTO master_nama_barang VALUES (2417, 'KABEL NEON SEN 1 x 0,50 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KNS1x');
INSERT INTO master_nama_barang VALUES (2418, 'KABEL NYA 2 x 2,5 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN2x2');
INSERT INTO master_nama_barang VALUES (2419, 'KABEL NYAF 1 x 1,5 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN1x1');
INSERT INTO master_nama_barang VALUES (2421, 'KABEL NYM 4 x 10 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN4x1');
INSERT INTO master_nama_barang VALUES (2422, 'KABEL NYM 4 x 120 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN4x2');
INSERT INTO master_nama_barang VALUES (2423, 'KABEL NYM 4 x 16 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN4x3');
INSERT INTO master_nama_barang VALUES (2424, 'KABEL NYM 4 x 4 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN4x4');
INSERT INTO master_nama_barang VALUES (2425, 'KABEL NYM 4 x 6 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN4x6');
INSERT INTO master_nama_barang VALUES (2426, 'KABEL NYM 4 x 70 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN4x7');
INSERT INTO master_nama_barang VALUES (2427, 'KABEL NYM 4 x 95 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN4x9');
INSERT INTO master_nama_barang VALUES (2428, 'KABEL NYYHY 1 x 0,5 mm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KN1x0');
INSERT INTO master_nama_barang VALUES (2800, 'L 300', 'B 9141 S', '2014-08-14 22:45:03', 435, '2014-08-14 22:45:03', 435, '00KRL');
INSERT INTO master_nama_barang VALUES (2815, 'BESI AS RODA BECAK', '-', '2014-08-16 13:03:25', 435, '2014-08-16 13:03:25', 435, '00BS1');
INSERT INTO master_nama_barang VALUES (2830, 'BESI ELBOW 1/2"', '-', '2014-08-16 13:29:01', 435, '2014-08-16 13:29:01', 435, '00BSE');
INSERT INTO master_nama_barang VALUES (2469, 'Kunci Ring 14/15', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR3');
INSERT INTO master_nama_barang VALUES (2470, 'Kunci Ring 16/17', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR5');
INSERT INTO master_nama_barang VALUES (2471, 'Kunci Ring 18/19', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR6');
INSERT INTO master_nama_barang VALUES (2472, 'Kunci Ring 19/21', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR7');
INSERT INTO master_nama_barang VALUES (2473, 'Kunci Ring 20/22', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR8');
INSERT INTO master_nama_barang VALUES (2474, 'Kunci Ring 22/24', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00KR9');
INSERT INTO master_nama_barang VALUES (2475, 'Kunci Ring 24/27', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR10');
INSERT INTO master_nama_barang VALUES (2476, 'Kunci Ring 26/28', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR11');
INSERT INTO master_nama_barang VALUES (2477, 'Kunci Ring 27/29', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR12');
INSERT INTO master_nama_barang VALUES (2478, 'Kunci Ring 30/32', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR13');
INSERT INTO master_nama_barang VALUES (2479, 'Kunci Ring 6/7', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR14');
INSERT INTO master_nama_barang VALUES (2550, 'LAMPU XION T5 14W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LXT1');
INSERT INTO master_nama_barang VALUES (2480, 'Kunci Ring Pas 19', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KRP1');
INSERT INTO master_nama_barang VALUES (2481, 'Kunci Ring Pas 22', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KRP2');
INSERT INTO master_nama_barang VALUES (2482, 'Kunci Ring Pas 24', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KRP3');
INSERT INTO master_nama_barang VALUES (2483, 'Kunci Ring Pas 26', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KRP4');
INSERT INTO master_nama_barang VALUES (2484, 'Kunci Ring Pas 28', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KRP5');
INSERT INTO master_nama_barang VALUES (2485, 'Kunci Ring Pas 32', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KRP6');
INSERT INTO master_nama_barang VALUES (2486, 'Kunci Ring/Pas 10', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR15');
INSERT INTO master_nama_barang VALUES (2487, 'Kunci Ring/Pas 11', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR16');
INSERT INTO master_nama_barang VALUES (2488, 'Kunci Ring/Pas 12', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR17');
INSERT INTO master_nama_barang VALUES (2489, 'Kunci Ring/Pas 8', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR18');
INSERT INTO master_nama_barang VALUES (2745, 'Tembakan Staples 422 J', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0TS4J');
INSERT INTO master_nama_barang VALUES (2747, 'TIANG BARIELL STAINLESS', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00TBS');
INSERT INTO master_nama_barang VALUES (2748, 'TOMBOL SIRINE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TU');
INSERT INTO master_nama_barang VALUES (2749, 'TOP TABLE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TV');
INSERT INTO master_nama_barang VALUES (2750, 'TOPLES KUE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TM');
INSERT INTO master_nama_barang VALUES (2762, 'UPPRIGHT POST 30 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP3C');
INSERT INTO master_nama_barang VALUES (2763, 'UPPRIGHT POST 300 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP3D');
INSERT INTO master_nama_barang VALUES (2764, 'UPPRIGHT POST 350 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP3E');
INSERT INTO master_nama_barang VALUES (2765, 'UPPRIGHT POST 400 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP4C');
INSERT INTO master_nama_barang VALUES (2766, 'UPPRIGHT POST 450 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP4D');
INSERT INTO master_nama_barang VALUES (2767, 'UPPRIGHT POST 50 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP5D');
INSERT INTO master_nama_barang VALUES (2801, 'Engkel', 'B 9497 FJ', '2014-08-14 22:47:17', 435, '2014-08-14 22:47:17', 435, '00KRG');
INSERT INTO master_nama_barang VALUES (2816, 'BESI AS RODA MATIC', '-', '2014-08-16 13:05:10', 435, '2014-08-16 13:05:10', 435, '00BS2');
INSERT INTO master_nama_barang VALUES (2831, 'BESI ELBOW 1 "', '-', '2014-08-16 13:30:57', 435, '2014-08-16 13:30:57', 435, '0BSE1');
INSERT INTO master_nama_barang VALUES (2490, 'Kunci Ring/Pas 9', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KR19');
INSERT INTO master_nama_barang VALUES (2492, 'KUNCI SHOWCASE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KW');
INSERT INTO master_nama_barang VALUES (2493, 'KUNING', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'KUNIN');
INSERT INTO master_nama_barang VALUES (2494, 'KURSI BETAWI', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000KB');
INSERT INTO master_nama_barang VALUES (2495, 'KURSI PUTIH PETRA DINNING', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0KPPD');
INSERT INTO master_nama_barang VALUES (2496, 'LAMPU BOHLAM 18W "PANASONIC"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LB1');
INSERT INTO master_nama_barang VALUES (2497, 'LAMPU BOHLAM LED', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LBL');
INSERT INTO master_nama_barang VALUES (2498, 'LAMPU CABE', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000LC');
INSERT INTO master_nama_barang VALUES (2499, 'LAMPU CABE PEATASAN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LCP');
INSERT INTO master_nama_barang VALUES (2500, 'LAMPU DOWNLIGHT 12V/50W 7.5', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LD17');
INSERT INTO master_nama_barang VALUES (2501, 'LAMPU DOWNLIGHT 12V/50W 9.5', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LD19');
INSERT INTO master_nama_barang VALUES (2502, 'LAMPU DOWNLIGHT HALIDA 150W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LDH1');
INSERT INTO master_nama_barang VALUES (2503, 'LAMPU DOWNLIGHT HALIDA 70W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LDH7');
INSERT INTO master_nama_barang VALUES (2504, 'LAMPU EMERGENCY', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000LE');
INSERT INTO master_nama_barang VALUES (2505, 'LAMPU GANTUNG ACRILYC SEGI EMPAT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LGASE');
INSERT INTO master_nama_barang VALUES (2506, 'LAMPU GANTUNG ACRILYC SEGI ENAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LGASF');
INSERT INTO master_nama_barang VALUES (2507, 'LAMPU GANTUNG BULAT', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LGB');
INSERT INTO master_nama_barang VALUES (2508, 'LAMPU GANTUNG KAIN', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LGK');
INSERT INTO master_nama_barang VALUES (2509, 'LAMPU GANTUNG TEBAR SERIBU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LGTS');
INSERT INTO master_nama_barang VALUES (2510, 'LAMPU HALIDA 150W OUT BOW', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'LH1OB');
INSERT INTO master_nama_barang VALUES (2802, 'CAT NIPPE 470 SW', '-', '2014-08-14 23:41:27', 435, '2014-08-14 23:41:27', 435, '00CAT');
INSERT INTO master_nama_barang VALUES (2817, 'BESI AS RODA MOBIL', '-', '2014-08-16 13:05:35', 435, '2014-08-16 13:05:35', 435, '00BS3');
INSERT INTO master_nama_barang VALUES (2613, 'MESIN POMPA AIR TANAM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0MPAT');
INSERT INTO master_nama_barang VALUES (2614, 'Mesin Potong', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MQ');
INSERT INTO master_nama_barang VALUES (2615, 'Mesin potong kayu', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00Mpk');
INSERT INTO master_nama_barang VALUES (2531, 'LAMPU PIJAR 60W', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00LP6');
INSERT INTO master_nama_barang VALUES (2803, 'CAT NIPPE 222', '-', '2014-08-14 23:42:11', 435, '2014-08-14 23:42:11', 435, '00CA1');
INSERT INTO master_nama_barang VALUES (2818, 'BESI AS RODA MOBIL PANJANG 35 CM', '-', '2014-08-16 13:06:03', 435, '2014-08-16 13:06:03', 435, '00BS4');
INSERT INTO master_nama_barang VALUES (2540, 'LAMPU SPOT MP HIJAU', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LSMH');
INSERT INTO master_nama_barang VALUES (2541, 'LAMPU SPOT MP KUNING', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0LSMK');
INSERT INTO master_nama_barang VALUES (2700, 'SOFT BOARD', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000SC');
INSERT INTO master_nama_barang VALUES (2752, 'Truck', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Truck');
INSERT INTO master_nama_barang VALUES (2753, 'Truck Box', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TC');
INSERT INTO master_nama_barang VALUES (2754, 'TUTUP POST', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000TQ');
INSERT INTO master_nama_barang VALUES (2755, 'TV PLASMA 32" LG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0TP3L');
INSERT INTO master_nama_barang VALUES (2756, 'TV PLASMA 42" LG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0TP4L');
INSERT INTO master_nama_barang VALUES (2757, 'TV PLASMA 42" SAMSUNG', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0TP4S');
INSERT INTO master_nama_barang VALUES (2758, 'UPPRIGHT POST 100 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP1C');
INSERT INTO master_nama_barang VALUES (2759, 'UPPRIGHT POST 150 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP1D');
INSERT INTO master_nama_barang VALUES (2760, 'UPPRIGHT POST 200 Cm', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0UP2D');
INSERT INTO master_nama_barang VALUES (2591, 'Mero 100 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M1D');
INSERT INTO master_nama_barang VALUES (2592, 'Mero 200 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M2C');
INSERT INTO master_nama_barang VALUES (2593, 'Mero 25 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M2D');
INSERT INTO master_nama_barang VALUES (2594, 'Mero 35 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M3C');
INSERT INTO master_nama_barang VALUES (2595, 'Mero 50 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M5C');
INSERT INTO master_nama_barang VALUES (2596, 'Mero 70 CM', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00M7C');
INSERT INTO master_nama_barang VALUES (2597, 'Mesin Adjing', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MA');
INSERT INTO master_nama_barang VALUES (2598, 'Mesin Amplas', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000ME');
INSERT INTO master_nama_barang VALUES (2599, 'Mesin belah Acrylic', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MbA');
INSERT INTO master_nama_barang VALUES (2600, 'Mesin belah kayu 1 Phase', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'Mbk1P');
INSERT INTO master_nama_barang VALUES (2601, 'Mesin Belah Kayu 3 Phase', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, 'MBK3P');
INSERT INTO master_nama_barang VALUES (2602, 'Mesin Bor Duduk', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MBD');
INSERT INTO master_nama_barang VALUES (2603, 'Mesin Circle 4"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MC4');
INSERT INTO master_nama_barang VALUES (2604, 'Mesin Circle 6"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MC6');
INSERT INTO master_nama_barang VALUES (2605, 'Mesin Circle 9"', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MC9');
INSERT INTO master_nama_barang VALUES (2606, 'Mesin Genset Bensin', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MGB');
INSERT INTO master_nama_barang VALUES (2607, 'Mesin Gurindo Uk. 41', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0MGU4');
INSERT INTO master_nama_barang VALUES (2608, 'Mesin Jigsaw', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '000MJ');
INSERT INTO master_nama_barang VALUES (2609, 'Mesin Las Diesel', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '00MLD');
INSERT INTO master_nama_barang VALUES (2610, 'Mesin Las Travo Artika', '', '2014-07-21 19:32:40.662912', 435, '2014-07-21 19:32:40.662912', 435, '0MLTA');
INSERT INTO master_nama_barang VALUES (2804, 'CAT NIPPE 270', '-', '2014-08-14 23:42:33', 435, '2014-08-14 23:42:33', 435, '00CA2');
INSERT INTO master_nama_barang VALUES (2819, 'BESI BEHEL 11 MM', '-', '2014-08-16 13:06:40', 435, '2014-08-16 13:06:40', 435, '00BSB');
INSERT INTO master_nama_barang VALUES (2834, 'PANGGUNG CLASSIC', '-', '2014-08-19 10:15:27', 435, '2014-08-19 10:15:27', 435, '00PNG');


--
-- Name: master_nama_barang_mnb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_nama_barang_mnb_id_seq', 2834, true);


--
-- Data for Name: master_satuan_barang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_satuan_barang VALUES (19, 'BARREL', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (20, 'BKS', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (21, 'BOX', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (22, 'BTL', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (23, 'DUS', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (24, 'GALON', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (25, 'GLN', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (26, 'Kantong', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (27, 'KARUNG', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (28, 'KG', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (29, 'KLG', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (30, 'LBR', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (31, 'LITER', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (32, 'LSN', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (33, 'LTR', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (34, 'M', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (35, 'M2', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (36, 'M3', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (37, 'METER	', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (38, 'MOBIL', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (39, 'PACK', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (40, 'PAIL', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (41, 'PAK', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (42, 'PC', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (43, 'PCS	', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (44, 'POT', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (45, 'PSC', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (46, 'ROLL', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (47, 'SET	', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (49, 'STEL', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (50, 'TUBE', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (52, 'UNIT', '', true, '2014-07-15 23:41:02.483193', 435, '2014-07-15 23:41:02.483193', 435);
INSERT INTO master_satuan_barang VALUES (53, 'M''', NULL, true, '2014-07-15 23:41:48.625079', 435, '2014-07-15 23:41:48.625079', 435);
INSERT INTO master_satuan_barang VALUES (51, 'CM', '-', true, '2014-07-15 23:41:02.483193', 435, '2014-08-16 21:49:10', 435);
INSERT INTO master_satuan_barang VALUES (54, 'MM', '-', true, '2014-08-16 21:49:19', 435, '2014-08-16 21:49:19', 435);
INSERT INTO master_satuan_barang VALUES (48, 'IKAT', '-', true, '2014-07-15 23:41:02.483193', 435, '2014-08-16 21:53:01', 435);
INSERT INTO master_satuan_barang VALUES (55, 'BATANG', '-', true, '2014-08-16 22:09:44', 435, '2014-08-16 22:09:44', 435);


--
-- Name: master_satuan_barang_msb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_satuan_barang_msb_id_seq', 55, true);


--
-- Data for Name: master_tipe_barang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO master_tipe_barang VALUES (3, 'Habis Pakai', NULL, true, '08:37:10.891139', 435, '2014-05-01 08:38:47.356172', 435);
INSERT INTO master_tipe_barang VALUES (6, 'Inventaris Kant', 'Asset Tetap', true, '14:11:00', 435, '2014-08-16 22:32:40', 435);
INSERT INTO master_tipe_barang VALUES (1, 'Asset Tetap', '-', true, '08:37:10.891139', 435, '2014-08-17 00:04:13', 435);
INSERT INTO master_tipe_barang VALUES (8, 'Persediaan/Prop', 'Persediaan / Properti Investasi', true, '00:09:32', 435, '2014-08-17 00:09:32', 435);
INSERT INTO master_tipe_barang VALUES (9, 'Persediaan', 'Persediaan', true, '00:10:24', 435, '2014-08-17 00:10:24', 435);


--
-- Name: master_tipe_barang_mtb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('master_tipe_barang_mtb_id_seq', 9, true);


--
-- Data for Name: mcs_headers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mcs_headers VALUES (1, '2015-02-09 20:40:43.308', 'dei', 'MCS201502/1', 1, 10, '2015-02-09', 1, NULL, NULL, NULL);
INSERT INTO mcs_headers VALUES (3, '2015-02-10 00:19:21.145', 'dei', 'MO201502/3', 1, 11, '2015-02-10', 2, 'gggggggggggggggggg', NULL, NULL);
INSERT INTO mcs_headers VALUES (2, '2015-02-09 20:41:54.889', 'dei', 'MO201502/2', 4, 10, '2015-02-09', 2, 'test mo', NULL, NULL);
INSERT INTO mcs_headers VALUES (4, '2015-02-16 20:45:35.997', 'dei', 'MCS201502/4', 1, 8, '2015-02-16', 1, NULL, NULL, NULL);
INSERT INTO mcs_headers VALUES (5, '2015-02-16 22:49:31.398', 'dei', 'PO201502/5', 0, NULL, '2015-02-16', 3, 'my po first', NULL, NULL);
INSERT INTO mcs_headers VALUES (6, '2015-02-17 07:33:14.512', 'dei', 'PO201502/6', 0, NULL, '2015-02-17', 3, 'my po second', 2, NULL);


--
-- Name: mcs_headers_mcs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mcs_headers_mcs_id_seq', 1, true);


--
-- Data for Name: mcs_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mcs_items VALUES (60, '2015-02-09 20:40:43.317', 'dei', 1, 52, 'na', 1.00);
INSERT INTO mcs_items VALUES (61, '2015-02-09 20:40:43.329', 'dei', 1, 136, 'nb', 2.00);
INSERT INTO mcs_items VALUES (62, '2015-02-09 20:40:43.339', 'dei', 1, 170, 'nc', 3.00);
INSERT INTO mcs_items VALUES (63, '2015-02-09 20:41:54.898', 'dei', 2, 52, 'mna', 1.00);
INSERT INTO mcs_items VALUES (64, '2015-02-09 20:41:54.9', 'dei', 2, 136, 'mnb', 2.00);
INSERT INTO mcs_items VALUES (65, '2015-02-09 20:41:54.91', 'dei', 2, 170, 'mnc', 3.00);
INSERT INTO mcs_items VALUES (66, '2015-02-10 00:19:21.149', 'dei', 3, 4, 'nb', 1.00);
INSERT INTO mcs_items VALUES (67, '2015-02-10 00:19:21.16', 'dei', 3, 481, 'nd', 2.00);
INSERT INTO mcs_items VALUES (68, '2015-02-10 00:19:21.164', 'dei', 3, 7, 'ne', 3.00);
INSERT INTO mcs_items VALUES (69, '2015-02-10 00:24:29.322', 'dei', 3, 52, 'nf', 1.00);
INSERT INTO mcs_items VALUES (70, '2015-02-16 20:45:36.161', 'dei', 4, 136, 'mikro bus', 1000000.00);
INSERT INTO mcs_items VALUES (71, '2015-02-16 20:45:36.251', 'dei', 4, 21, 'troly kaye', 800000.00);
INSERT INTO mcs_items VALUES (72, '2015-02-16 20:45:36.292', 'dei', 4, 204, 'mobil', 9000000.00);
INSERT INTO mcs_items VALUES (73, '2015-02-16 20:45:36.331', 'dei', 4, 510, 'toples kue', 100000.00);
INSERT INTO mcs_items VALUES (74, '2015-02-16 22:49:31.4', 'dei', 5, 52, NULL, 1.00);
INSERT INTO mcs_items VALUES (75, '2015-02-16 22:49:31.404', 'dei', 5, 136, NULL, 2.00);
INSERT INTO mcs_items VALUES (76, '2015-02-16 22:49:31.405', 'dei', 5, 170, NULL, 3.00);
INSERT INTO mcs_items VALUES (77, '2015-02-17 07:33:14.516', 'dei', 6, 2, 'test', 1.00);
INSERT INTO mcs_items VALUES (78, '2015-02-17 07:33:14.52', 'dei', 6, 140, NULL, 1.00);


--
-- Name: mcs_items_mcs_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mcs_items_mcs_item_id_seq', 78, true);


--
-- Data for Name: mcs_status; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mcs_status VALUES (0, '2015-01-29 07:01:13.566', 'dei', 'Draft');
INSERT INTO mcs_status VALUES (1, '2015-01-29 07:01:15.819', 'dei', 'Sent');
INSERT INTO mcs_status VALUES (4, '2015-01-29 07:01:30.075', 'dei', 'Deleted');


--
-- Data for Name: mcs_transaction_types; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO mcs_transaction_types VALUES (2, '2015-02-03 07:47:05.709', 'dei', 'MO', 'MO');
INSERT INTO mcs_transaction_types VALUES (1, '2015-02-03 07:46:56.4', 'dei', 'MCS', 'MCS');
INSERT INTO mcs_transaction_types VALUES (3, '2015-02-16 22:19:06.365', 'dei', 'PO', 'PO');
INSERT INTO mcs_transaction_types VALUES (4, '2015-02-17 13:14:05.22', 'dei', 'BTB', 'BTB');


--
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO menus VALUES (1, '2015-01-12 07:41:55.138', 'dei', 'Create Quotation', 'Quotation', 'quotation', 'create_quotation', 'icon-gift', true);
INSERT INTO menus VALUES (3, '2015-01-12 08:13:10.248', 'dei', 'Create User', 'Administrator', 'administrator', 'create_user', 'icon-user', true);
INSERT INTO menus VALUES (4, '2015-01-12 08:13:21.079', 'postgres', 'Manage User', 'Administrator', 'administrator', 'manage_user', 'icon-user', true);
INSERT INTO menus VALUES (9, '2015-01-22 05:53:38.241', 'dei', 'MCS List', 'MCS', 'material_control_sheet', 'mcs_list', 'icon-tasks', true);
INSERT INTO menus VALUES (10, '2015-01-25 19:30:48.635', 'dei', 'New MCS', 'MCS', 'material_control_sheet', 'active_project_list', 'icon-tasks', true);
INSERT INTO menus VALUES (7, '2015-01-21 22:32:10.192', 'dei', 'List of Stock Keeping Unit', 'Logistic', 'logistic', 'stock_list', 'icon-barcode', true);
INSERT INTO menus VALUES (6, '2015-01-21 22:30:09.063', 'dei', 'New Stock Keeping Unit', 'Logistic', 'logistic', 'create_stock', 'icon-barcode', true);
INSERT INTO menus VALUES (11, '2015-02-01 05:55:29.499', 'dei', 'Stock Name', 'Logistic', 'logistic', 'create_stock_name', 'icon-barcode', true);
INSERT INTO menus VALUES (12, '2015-02-01 05:57:10.277', 'dei', 'Stock Name List', 'Logistic', 'logistic', 'stock_name_list', 'icon-barcode', false);
INSERT INTO menus VALUES (14, '2015-02-03 07:04:51.383', 'dei', 'MO', 'Logistic', 'mo', 'manage', 'icon-barcode', true);
INSERT INTO menus VALUES (13, '2015-02-03 07:04:10.392', 'dei', 'New MO', 'Logistic', 'mo', 'new_mo', 'icon-barcode', true);
INSERT INTO menus VALUES (15, '2015-02-05 23:52:59.083', 'dei', 'Create MO', 'Logistic', 'mo', 'create_mo', 'icon-barcode', false);
INSERT INTO menus VALUES (5, '2015-01-15 20:57:16.526', 'dei', 'Quotation List', 'Quotation', 'quotation', 'quotation_list', 'icon-gift', true);
INSERT INTO menus VALUES (16, '2015-02-16 22:08:42.585', 'dei', 'New PO', 'Purchase Order', 'po', 'new_po', 'icon-truck', true);
INSERT INTO menus VALUES (17, '2015-02-16 22:09:11.954', 'dei', 'PO List', 'Purchase Order', 'po', 'po_list', 'icon-truck', true);


--
-- Name: menus_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('menus_menu_id_seq', 17, true);


--
-- Data for Name: multi_company_default; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: multi_company_default_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('multi_company_default_id_seq', 1, false);


--
-- Data for Name: process_transition_group_rel; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: quotation_files; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO quotation_files VALUES (3, '2015-01-19 08:17:35.219', 'dei', 14, 'qf_14_3_teksi.png', '');
INSERT INTO quotation_files VALUES (4, '2015-01-19 12:52:17.252', 'dei', 16, 'qf_16_4_teksi.png', '');
INSERT INTO quotation_files VALUES (5, '2015-01-21 19:09:44.49', 'dei', 2, 'qf_2_5_streetfood.png', '');
INSERT INTO quotation_files VALUES (6, '2015-01-22 09:36:45.87', 'dei', 3, 'qf_3_6_000114_2014_02.pdf', '');
INSERT INTO quotation_files VALUES (7, '2015-01-22 09:59:42.722', 'dei', 4, 'qf_4_7_pieter_both.jpg', '');
INSERT INTO quotation_files VALUES (8, '2015-01-23 13:46:58.686', 'dei', 6, 'qf_6_8_IMG_20141117_001058.jpg', '');
INSERT INTO quotation_files VALUES (9, '2015-01-24 09:37:34.757', 'dei', 6, 'qf_6_9_Bnit5StCIAEMfCz.jpg', '');
INSERT INTO quotation_files VALUES (10, '2015-01-24 15:38:34.787', 'dei', 9, 'qf_9_10_BnisSgXCAAA-ZVo.jpg', '');
INSERT INTO quotation_files VALUES (11, '2015-02-04 20:30:19.623', 'dei', 11, 'qf_11_11_whitepaper_EN_e15_X8.pdf', 'sepatu');
INSERT INTO quotation_files VALUES (12, '2015-02-16 20:39:29.477', 'dei', 8, 'qf_8_12_teksi.png', 'keterangan file 1');
INSERT INTO quotation_files VALUES (13, '2015-02-16 20:39:50.055', 'dei', 8, 'qf_8_13_streetfood.png', 'street food');


--
-- Name: quotation_files_quotation_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('quotation_files_quotation_files_id_seq', 1, false);


--
-- Data for Name: quotation_products; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO quotation_products VALUES (82, '2015-01-19 12:59:19.693', 'dei', 16, 'Partisi Dua', '-', 10000000.00);
INSERT INTO quotation_products VALUES (83, '2015-01-20 07:41:24.811', 'dei', 16, 'electrical', 'electrical panggung+', 5000000.00);
INSERT INTO quotation_products VALUES (84, '2015-01-21 19:08:42.042', 'dei', 2, 'Partisi Dua Muka', '-', 10000000.00);
INSERT INTO quotation_products VALUES (85, '2015-01-22 09:35:55.989', 'dei', 3, 'Partisi 2 muka', '-', 10000000.00);
INSERT INTO quotation_products VALUES (86, '2015-01-22 09:56:57.703', 'dei', 4, 'Partisi 2 muka', 'desc', 10000000.00);
INSERT INTO quotation_products VALUES (87, '2015-01-22 09:58:05.629', 'dei', 4, 'Item', 'desc2', 7000000.00);
INSERT INTO quotation_products VALUES (88, '2015-01-23 13:42:26.91', 'dei', 6, 'Partisi Dua', '-', 10000000.00);
INSERT INTO quotation_products VALUES (89, '2015-02-03 08:04:27.145', 'dei', 10, 'Partisi Dua Muka', '', 10000000.00);
INSERT INTO quotation_products VALUES (90, '2015-02-04 20:29:09.284', 'dei', 11, 'Partisi Dua Pintu', '', 7000000.00);
INSERT INTO quotation_products VALUES (91, '2015-02-16 20:38:49.167', 'dei', 8, 'Partisi Dua', '-', 10000000.00);
INSERT INTO quotation_products VALUES (92, '2015-02-16 20:38:49.252', 'dei', 8, 'Dispenser air polytron', 'dc', 5000000.00);
INSERT INTO quotation_products VALUES (93, '2015-02-16 20:38:49.254', 'dei', 8, 'pg2', 'dc2', 20000000.00);


--
-- Name: quotation_products_quotation_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('quotation_products_quotation_product_id_seq', 93, true);


--
-- Data for Name: quotation_status; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO quotation_status VALUES (0, '2015-01-20 20:43:45.535', 'dei', 'Draft');
INSERT INTO quotation_status VALUES (1, '2015-01-20 20:43:55.07', 'dei', 'Sent');
INSERT INTO quotation_status VALUES (2, '2015-01-20 20:44:20.378', 'dei', 'Deleted');
INSERT INTO quotation_status VALUES (4, '2015-01-20 20:44:48.289', 'dei', 'Loss');
INSERT INTO quotation_status VALUES (3, '2015-01-20 20:44:23.99', 'dei', 'Win');
INSERT INTO quotation_status VALUES (5, '2015-01-20 20:44:57.982', 'dei', 'Final');


--
-- Name: quotation_status_quotation_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('quotation_status_quotation_status_id_seq', 5, true);


--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO quotations VALUES (1, '2015-01-21 19:00:00.22', 'dei', 'Q201501/1', 2, 0, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 2, 2, 2, NULL, NULL, NULL);
INSERT INTO quotations VALUES (9, '2015-01-23 22:07:21.014', 'dei', 'Q201501/9', 0, 0, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 2, 2, 2, NULL, NULL, NULL);
INSERT INTO quotations VALUES (6, '2015-01-23 13:35:55.138', 'dei', 'Q201501/6', 4, 1, '0', '2015-01-23', NULL, NULL, NULL, 'cash', 'stand', '5x5', true, 2, 3, '2015-01-30', '2015-02-02', '2015-01-27', '01:00:00', '2015-01-23', NULL, '2015-02-02', NULL, '2015-02-03', NULL, 1, NULL, 3, 1, 2, 'notes', NULL, NULL);
INSERT INTO quotations VALUES (2, '2015-01-21 19:08:41.998', 'dei', 'Q201501/2', 5, 0, '0', '2015-01-21', '11111', '1111111', NULL, 'cash', 'stand', '5x5', true, 2, 2, '2015-01-23', '2015-01-25', '2015-01-22', '06:00:00', '2015-01-23', '05:00:00', '2015-01-25', '23:00:00', '2015-01-26', '10:00:00', 2, NULL, 1, 3, 2, 'test', 300000.00, 500000.00);
INSERT INTO quotations VALUES (3, '2015-01-21 20:44:38.303', 'dei', 'Q201501/3', 3, 0, '0', '2015-01-21', NULL, NULL, NULL, NULL, NULL, NULL, false, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, 2, 2, NULL, NULL, NULL);
INSERT INTO quotations VALUES (4, '2015-01-22 09:54:37.581', 'dei', 'Q201501/4', 5, 0, '0', '2015-01-22', 'sales_number', 'contract', NULL, 'cash', 'tes', '8 x 8', true, 2, 3, '2015-01-23', '2015-01-25', '2015-01-22', '06:00:00', '2015-01-23', '07:00:00', '2015-01-25', '12:00:00', '2015-01-26', '06:00:00', 2, NULL, 3, 2, 2, 'catatan penting', 500000.00, NULL);
INSERT INTO quotations VALUES (5, '2015-01-23 13:35:28.866', 'dei', 'Q201501/5', 2, 0, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 2, 2, 2, NULL, NULL, NULL);
INSERT INTO quotations VALUES (7, '2015-01-23 21:17:20.668', 'dei', 'Q201501/7', 0, 0, '0', '2015-01-23', NULL, NULL, NULL, 'one week', 'stand', '5x5 m2', true, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 2, 2, 2, NULL, NULL, NULL);
INSERT INTO quotations VALUES (10, '2015-02-03 08:04:27.116', 'dei', 'Q201502/10', 5, 0, '0', '2015-02-03', '11111', 'contract number', NULL, 'cash', 'stand', '500ml', true, 1, 1, '2015-02-11', '2015-02-18', '2015-02-07', NULL, '2015-02-11', NULL, '2015-02-18', NULL, '2015-02-18', NULL, 1, NULL, 3, 3, 3, NULL, 500000.00, NULL);
INSERT INTO quotations VALUES (11, '2015-02-04 20:29:09.206', 'dei', 'Q201502/11', 5, 0, '0', '2015-02-04', 's201502', 'contract number', NULL, 'cash', 'stand', '5x5', true, 3, 3, '2015-02-27', '2015-03-02', '2015-02-25', NULL, '2015-02-27', NULL, '2015-03-02', NULL, '2015-03-02', NULL, 3, NULL, 1, 9, 9, NULL, NULL, NULL);
INSERT INTO quotations VALUES (8, '2015-01-23 21:19:45.139', 'dei', 'Q201501/8', 5, 0, '0', '2015-01-30', 's20150211', 'contract number1', NULL, 'one month', 'stage', '10 * 5 m2', true, 2, 3, '2015-02-28', '2015-03-02', '2015-02-26', NULL, '2015-02-28', NULL, '2015-03-02', NULL, '2015-03-02', NULL, 3, NULL, 8, 1, 3, 'test', NULL, NULL);


--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('quotations_quotation_id_seq', 10, true);


--
-- Data for Name: role_menu_maps; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO role_menu_maps VALUES (3, '2015-01-12 08:15:29.878', 'postgres', 1, 3);
INSERT INTO role_menu_maps VALUES (4, '2015-01-12 08:15:34.885', 'postgres', 1, 4);
INSERT INTO role_menu_maps VALUES (13, '2015-01-25 20:42:22.365', 'dei', 5, 8);
INSERT INTO role_menu_maps VALUES (14, '2015-01-25 20:42:28.313', 'dei', 5, 9);
INSERT INTO role_menu_maps VALUES (15, '2015-01-25 20:42:35.078', 'dei', 5, 10);
INSERT INTO role_menu_maps VALUES (16, '2015-01-29 06:33:58.187', 'dei', 6, 6);
INSERT INTO role_menu_maps VALUES (17, '2015-01-29 06:34:03.161', 'dei', 6, 7);
INSERT INTO role_menu_maps VALUES (18, '2015-01-31 20:37:14.069', 'dei', 1, 1);
INSERT INTO role_menu_maps VALUES (19, '2015-01-31 20:37:28.429', 'dei', 1, 5);
INSERT INTO role_menu_maps VALUES (20, '2015-01-31 20:37:33.392', 'dei', 1, 6);
INSERT INTO role_menu_maps VALUES (21, '2015-01-31 20:37:36.88', 'dei', 1, 7);
INSERT INTO role_menu_maps VALUES (22, '2015-01-31 20:37:48.783', 'dei', 1, 9);
INSERT INTO role_menu_maps VALUES (23, '2015-01-31 20:37:52.326', 'dei', 1, 10);
INSERT INTO role_menu_maps VALUES (10, '2015-01-23 13:14:39.986', 'dei', 2, 3);
INSERT INTO role_menu_maps VALUES (11, '2015-01-23 13:14:46.841', 'dei', 2, 4);
INSERT INTO role_menu_maps VALUES (25, '2015-02-01 05:57:34.074', 'dei', 1, 11);
INSERT INTO role_menu_maps VALUES (26, '2015-02-01 05:57:39.28', 'dei', 1, 12);
INSERT INTO role_menu_maps VALUES (27, '2015-02-03 07:05:09.078', 'dei', 1, 13);
INSERT INTO role_menu_maps VALUES (28, '2015-02-03 07:05:13.967', 'dei', 1, 14);
INSERT INTO role_menu_maps VALUES (29, '2015-02-05 23:53:21.266', 'dei', 1, 15);
INSERT INTO role_menu_maps VALUES (30, '2015-02-16 22:10:46.229', 'dei', 1, 16);
INSERT INTO role_menu_maps VALUES (31, '2015-02-16 22:10:52.848', 'dei', 1, 17);


--
-- Name: role_menu_maps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('role_menu_maps_id_seq', 31, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO roles VALUES (2, '2015-01-20 21:25:46.544', 'dei', 'Sales');
INSERT INTO roles VALUES (3, '2015-01-20 21:25:55.376', 'dei', 'Admin');
INSERT INTO roles VALUES (5, '2015-01-25 20:39:46.841', 'dei', 'Operation');
INSERT INTO roles VALUES (6, '2015-01-29 06:32:17.706', 'dei', 'Logistic');
INSERT INTO roles VALUES (1, '2015-01-12 07:43:51.491', 'dei', 'Su');


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('roles_role_id_seq', 6, true);


--
-- Data for Name: stock_brands; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO stock_brands VALUES (1, '2015-02-01 00:33:10.504', 'dei', 'Merk 1');
INSERT INTO stock_brands VALUES (2, '2015-02-01 00:33:10.504', 'dei', 'candra');
INSERT INTO stock_brands VALUES (3, '2015-02-01 00:33:10.504', 'dei', 'Sanyo');
INSERT INTO stock_brands VALUES (4, '2015-02-01 00:33:10.504', 'dei', 'ISUZU');
INSERT INTO stock_brands VALUES (5, '2015-02-01 00:33:10.504', 'dei', 'Chitose');
INSERT INTO stock_brands VALUES (6, '2015-02-01 00:33:10.504', 'dei', 'Honda');
INSERT INTO stock_brands VALUES (7, '2015-02-01 00:33:10.504', 'dei', 'Panasonic');
INSERT INTO stock_brands VALUES (9, '2015-02-01 00:33:10.504', 'dei', 'Philips');
INSERT INTO stock_brands VALUES (10, '2015-02-01 00:33:10.504', 'dei', 'LG');
INSERT INTO stock_brands VALUES (11, '2015-02-01 00:33:10.504', 'dei', 'Samsung');
INSERT INTO stock_brands VALUES (12, '2015-02-01 00:33:10.504', 'dei', 'Hino');
INSERT INTO stock_brands VALUES (13, '2015-02-01 00:33:10.504', 'dei', 'IBM');
INSERT INTO stock_brands VALUES (14, '2015-02-01 00:33:10.504', 'dei', 'Bosch');
INSERT INTO stock_brands VALUES (15, '2015-02-01 00:33:10.504', 'dei', 'Inbow');
INSERT INTO stock_brands VALUES (16, '2015-02-01 00:33:10.504', 'dei', 'Maktec');
INSERT INTO stock_brands VALUES (17, '2015-02-01 00:33:10.504', 'dei', 'NASIONAL');
INSERT INTO stock_brands VALUES (18, '2015-02-01 00:33:10.504', 'dei', 'Osram');
INSERT INTO stock_brands VALUES (19, '2015-02-01 00:33:10.504', 'dei', 'Bridgestone');
INSERT INTO stock_brands VALUES (20, '2015-02-01 00:33:10.504', 'dei', 'Dunlop');
INSERT INTO stock_brands VALUES (21, '2015-02-01 00:33:10.504', 'dei', 'MAKITA');
INSERT INTO stock_brands VALUES (22, '2015-02-01 00:33:10.504', 'dei', 'AVIAN');
INSERT INTO stock_brands VALUES (23, '2015-02-01 00:33:10.504', 'dei', 'Lumineuk EXPO');
INSERT INTO stock_brands VALUES (24, '2015-02-01 00:33:10.504', 'dei', 'Dana Paint');
INSERT INTO stock_brands VALUES (25, '2015-02-01 00:33:10.504', 'dei', 'Titanlux');
INSERT INTO stock_brands VALUES (26, '2015-02-01 00:33:10.504', 'dei', 'Nippon Paint');
INSERT INTO stock_brands VALUES (27, '2015-02-01 00:33:10.504', 'dei', 'Minilex');
INSERT INTO stock_brands VALUES (28, '2015-02-01 00:33:10.504', 'dei', 'Vinilex');
INSERT INTO stock_brands VALUES (29, '2015-02-01 00:33:10.504', 'dei', 'Toshiba');
INSERT INTO stock_brands VALUES (30, '2015-02-01 00:33:10.504', 'dei', 'Lenkote');
INSERT INTO stock_brands VALUES (31, '2015-02-01 00:33:10.504', 'dei', 'Dulux');
INSERT INTO stock_brands VALUES (32, '2015-02-01 00:33:10.504', 'dei', 'ABC');
INSERT INTO stock_brands VALUES (33, '2015-02-01 00:33:10.504', 'dei', 'Alkaline');
INSERT INTO stock_brands VALUES (34, '2015-02-01 00:33:10.504', 'dei', 'Motorola');
INSERT INTO stock_brands VALUES (35, '2015-02-01 00:33:10.504', 'dei', 'Hitachi');
INSERT INTO stock_brands VALUES (36, '2015-02-01 00:33:10.504', 'dei', 'Energizer');
INSERT INTO stock_brands VALUES (37, '2015-02-01 00:33:10.504', 'dei', 'Mowilex');
INSERT INTO stock_brands VALUES (38, '2015-02-01 00:33:10.504', 'dei', 'Nippe');
INSERT INTO stock_brands VALUES (39, '2015-02-01 00:33:10.504', 'dei', 'Novalux');
INSERT INTO stock_brands VALUES (40, '2015-02-01 00:33:10.504', 'dei', 'Pantone');
INSERT INTO stock_brands VALUES (41, '2015-02-01 00:33:10.504', 'dei', 'Renovo');
INSERT INTO stock_brands VALUES (42, '2015-02-01 00:33:10.504', 'dei', 'Toto');
INSERT INTO stock_brands VALUES (43, '2015-02-01 00:33:10.504', 'dei', 'Pioneer');
INSERT INTO stock_brands VALUES (44, '2015-02-01 00:33:10.504', 'dei', 'Yanma');
INSERT INTO stock_brands VALUES (45, '2015-02-01 00:33:10.504', 'dei', 'Sanwa');
INSERT INTO stock_brands VALUES (47, '2015-02-01 00:33:10.504', 'dei', 'Suzuki');
INSERT INTO stock_brands VALUES (48, '2015-02-01 00:33:10.504', 'dei', 'Acer');
INSERT INTO stock_brands VALUES (49, '2015-02-01 00:33:10.504', 'dei', 'Gree');
INSERT INTO stock_brands VALUES (50, '2015-02-01 00:33:10.504', 'dei', 'Haier');
INSERT INTO stock_brands VALUES (51, '2015-02-01 00:33:10.504', 'dei', 'Green Air');
INSERT INTO stock_brands VALUES (52, '2015-02-01 00:33:10.504', 'dei', 'Mitsubishi');
INSERT INTO stock_brands VALUES (53, '2015-02-01 00:33:10.504', 'dei', 'Akira');
INSERT INTO stock_brands VALUES (54, '2015-02-01 00:33:10.504', 'dei', 'National');
INSERT INTO stock_brands VALUES (55, '2015-02-01 00:33:10.504', 'dei', 'Toyota');
INSERT INTO stock_brands VALUES (56, '2015-02-01 00:33:10.504', 'dei', 'Isuzu');
INSERT INTO stock_brands VALUES (57, '2015-02-01 00:33:10.504', 'dei', 'Tanpa Merek');
INSERT INTO stock_brands VALUES (8, '2015-02-01 00:33:10.504', 'dei', 'Maspion');


--
-- Name: stock_brands_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('stock_brands_brand_id_seq', 1, false);


--
-- Data for Name: stock_groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO stock_groups VALUES (1, '2015-01-26 22:04:18.214', 'dei', 'HRD dan General Affair');
INSERT INTO stock_groups VALUES (2, '2015-01-26 22:04:18.214', 'dei', 'MATERIAL');
INSERT INTO stock_groups VALUES (3, '2015-01-26 22:04:18.214', 'dei', 'INVENTARIS KANTOR');
INSERT INTO stock_groups VALUES (4, '2015-01-26 22:04:18.214', 'dei', 'TRANSPORTASI/KENDARAAN');
INSERT INTO stock_groups VALUES (5, '2015-01-26 22:04:18.214', 'dei', 'FURNITURE');
INSERT INTO stock_groups VALUES (6, '2015-01-26 22:04:18.214', 'dei', 'SISTEM DAN AKSESORIS SISTEM');
INSERT INTO stock_groups VALUES (7, '2015-01-26 22:04:18.214', 'dei', 'LISTRIK/ELECTRIC');
INSERT INTO stock_groups VALUES (8, '2015-01-26 22:04:18.214', 'dei', 'MACHINE');
INSERT INTO stock_groups VALUES (9, '2015-01-26 22:04:18.214', 'dei', 'IT');
INSERT INTO stock_groups VALUES (10, '2015-01-26 22:04:18.214', 'dei', 'ATK');
INSERT INTO stock_groups VALUES (11, '2015-01-26 22:04:18.214', 'dei', 'PERLENGKAPAN');
INSERT INTO stock_groups VALUES (12, '2015-01-26 22:04:18.214', 'dei', 'BRGBEKAS');
INSERT INTO stock_groups VALUES (13, '2015-01-26 22:04:18.214', 'dei', 'ACRYLYC');
INSERT INTO stock_groups VALUES (14, '2015-01-26 22:04:18.214', 'dei', 'AMBALAN');
INSERT INTO stock_groups VALUES (15, '2015-01-26 22:04:18.214', 'dei', 'PEMBERDAYAAN');
INSERT INTO stock_groups VALUES (16, '2015-01-26 22:04:18.214', 'dei', 'MAINTENANCE/ALAT PRODUKSI');
INSERT INTO stock_groups VALUES (17, '2015-01-26 22:04:18.214', 'dei', 'KARPET');


--
-- Name: stock_groups_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('stock_groups_group_id_seq', 17, true);


--
-- Name: stock_name_stock_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('stock_name_stock_name_id_seq', 583, true);


--
-- Data for Name: stock_names; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO stock_names VALUES (1, '2015-01-21 22:14:00.804', 'dei', 'PAPAN');
INSERT INTO stock_names VALUES (2, '2015-01-21 22:14:00.804', 'dei', 'KERTAS');
INSERT INTO stock_names VALUES (3, '2015-01-21 22:14:00.804', 'dei', 'MINUMAN KALENG');
INSERT INTO stock_names VALUES (4, '2015-01-21 22:14:00.804', 'dei', 'KAWAT');
INSERT INTO stock_names VALUES (5, '2015-01-21 22:14:00.804', 'dei', 'PLYWOOD 2 ML');
INSERT INTO stock_names VALUES (6, '2015-01-21 22:14:00.804', 'dei', 'ALAT KATROL');
INSERT INTO stock_names VALUES (7, '2015-01-21 22:14:00.804', 'dei', 'MANAQUIN LADY FULL BODY BLACK');
INSERT INTO stock_names VALUES (8, '2015-01-21 22:14:00.804', 'dei', 'MANAQUIN LADY HALF BODY CREAM');
INSERT INTO stock_names VALUES (9, '2015-01-21 22:14:00.804', 'dei', 'MANAQUIN MAN FULBODY CREAM');
INSERT INTO stock_names VALUES (10, '2015-01-21 22:14:00.804', 'dei', 'MANAQUIN MAN FULL BODY BLACK');
INSERT INTO stock_names VALUES (11, '2015-01-21 22:14:00.804', 'dei', 'SKUN 16 MM');
INSERT INTO stock_names VALUES (12, '2015-01-21 22:14:00.804', 'dei', 'SKUN 25 MM');
INSERT INTO stock_names VALUES (13, '2015-01-21 22:14:00.804', 'dei', 'SKUN 35 MM');
INSERT INTO stock_names VALUES (14, '2015-01-21 22:14:00.804', 'dei', 'SKUN 50 MM');
INSERT INTO stock_names VALUES (15, '2015-01-21 22:14:00.804', 'dei', 'SKUN 70 MM');
INSERT INTO stock_names VALUES (16, '2015-01-21 22:14:00.804', 'dei', 'SKUN 95 MM');
INSERT INTO stock_names VALUES (17, '2015-01-21 22:14:00.804', 'dei', 'SLING PENGAMANAN HP');
INSERT INTO stock_names VALUES (18, '2015-01-21 22:14:00.804', 'dei', 'SMOKE GUN');
INSERT INTO stock_names VALUES (19, '2015-01-21 22:14:00.804', 'dei', 'SOFA CREAM MUDA 1 SEATER');
INSERT INTO stock_names VALUES (20, '2015-01-21 22:14:00.804', 'dei', 'SOFA CREAM MUDA 2 SEATER');
INSERT INTO stock_names VALUES (21, '2015-01-21 22:14:00.804', 'dei', 'TROLY KAYU');
INSERT INTO stock_names VALUES (22, '2015-01-21 22:14:00.804', 'dei', 'KABEL RCA');
INSERT INTO stock_names VALUES (23, '2015-01-21 22:14:00.804', 'dei', 'AIR CONDITIONER 1/2 PK');
INSERT INTO stock_names VALUES (24, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 315');
INSERT INTO stock_names VALUES (25, '2015-01-21 22:14:00.804', 'dei', 'BESI BEHEL  12 MM');
INSERT INTO stock_names VALUES (26, '2015-01-21 22:14:00.804', 'dei', 'AIR CONDITIONER 1 PK');
INSERT INTO stock_names VALUES (27, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 322');
INSERT INTO stock_names VALUES (28, '2015-01-21 22:14:00.804', 'dei', 'BESI BEHEL 13 MM');
INSERT INTO stock_names VALUES (29, '2015-01-21 22:14:00.804', 'dei', 'COMPRESOR BENSIN');
INSERT INTO stock_names VALUES (30, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 20/22');
INSERT INTO stock_names VALUES (31, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 22/24');
INSERT INTO stock_names VALUES (32, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 27/32');
INSERT INTO stock_names VALUES (33, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 30/32');
INSERT INTO stock_names VALUES (34, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 36');
INSERT INTO stock_names VALUES (35, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 6/7');
INSERT INTO stock_names VALUES (36, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 8/9');
INSERT INTO stock_names VALUES (37, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 10/11');
INSERT INTO stock_names VALUES (38, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 12/13');
INSERT INTO stock_names VALUES (39, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 500 CM');
INSERT INTO stock_names VALUES (40, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 600 CM');
INSERT INTO stock_names VALUES (41, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 610 CM');
INSERT INTO stock_names VALUES (42, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 7 BLH');
INSERT INTO stock_names VALUES (43, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 75 CM');
INSERT INTO stock_names VALUES (44, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST7 BLH');
INSERT INTO stock_names VALUES (45, '2015-01-21 22:14:00.804', 'dei', 'VACUM CLEANER');
INSERT INTO stock_names VALUES (46, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE  C');
INSERT INTO stock_names VALUES (47, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE A');
INSERT INTO stock_names VALUES (48, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE B');
INSERT INTO stock_names VALUES (49, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE D');
INSERT INTO stock_names VALUES (50, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE E');
INSERT INTO stock_names VALUES (51, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE F');
INSERT INTO stock_names VALUES (52, '2015-01-21 22:14:00.804', 'dei', 'AIR CONDITIONER 2 PK');
INSERT INTO stock_names VALUES (53, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 396');
INSERT INTO stock_names VALUES (54, '2015-01-21 22:14:00.804', 'dei', 'BESI BEHEL 14 MM');
INSERT INTO stock_names VALUES (55, '2015-01-21 22:14:00.804', 'dei', 'AIR CONDITIONER 1 1/2 PK');
INSERT INTO stock_names VALUES (56, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 470 DOFT');
INSERT INTO stock_names VALUES (57, '2015-01-21 22:14:00.804', 'dei', 'BESI BEHEL 15 MM');
INSERT INTO stock_names VALUES (58, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE G');
INSERT INTO stock_names VALUES (59, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE H');
INSERT INTO stock_names VALUES (60, '2015-01-21 22:14:00.804', 'dei', 'VOLUMA TYPE Z');
INSERT INTO stock_names VALUES (61, '2015-01-21 22:14:00.804', 'dei', 'WALL FAN PLASTIK');
INSERT INTO stock_names VALUES (62, '2015-01-21 22:14:00.804', 'dei', 'WALL FAN STAINLES');
INSERT INTO stock_names VALUES (63, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PLC 18W');
INSERT INTO stock_names VALUES (64, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HALIDA 70W OUT BOW');
INSERT INTO stock_names VALUES (65, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HALOGEN 150W HITAM');
INSERT INTO stock_names VALUES (66, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HALOGEN 150W PUTIH');
INSERT INTO stock_names VALUES (67, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HALOGEN 500W');
INSERT INTO stock_names VALUES (68, '2015-01-21 22:14:00.804', 'dei', 'STOP KONTAK P4 OUT BOW');
INSERT INTO stock_names VALUES (69, '2015-01-21 22:14:00.804', 'dei', 'TABUNG TL 20W');
INSERT INTO stock_names VALUES (70, '2015-01-21 22:14:00.804', 'dei', 'TABUNG TL 40W');
INSERT INTO stock_names VALUES (71, '2015-01-21 22:14:00.804', 'dei', 'TABUNG TL 40W 827 (WARM)');
INSERT INTO stock_names VALUES (72, '2015-01-21 22:14:00.804', 'dei', 'LAMPU MERCURY 160W');
INSERT INTO stock_names VALUES (73, '2015-01-21 22:14:00.804', 'dei', 'LAMPU MICRO HALOGEN LED 4W');
INSERT INTO stock_names VALUES (74, '2015-01-21 22:14:00.804', 'dei', 'LAMPU MICRO HALOGEN STICK 220V');
INSERT INTO stock_names VALUES (75, '2015-01-21 22:14:00.804', 'dei', 'LAMPU MP LED PUTIH');
INSERT INTO stock_names VALUES (76, '2015-01-21 22:14:00.804', 'dei', 'LAMPU NATAL LED');
INSERT INTO stock_names VALUES (77, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PAR');
INSERT INTO stock_names VALUES (78, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PIJAR 40W');
INSERT INTO stock_names VALUES (79, '2015-01-21 22:14:00.804', 'dei', 'AIR CONDITIONER 3/4 PK');
INSERT INTO stock_names VALUES (80, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 480 DOFT');
INSERT INTO stock_names VALUES (81, '2015-01-21 22:14:00.804', 'dei', 'BESI BEHEL 16 MM');
INSERT INTO stock_names VALUES (82, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PIJAR 5W BIRU');
INSERT INTO stock_names VALUES (83, '2015-01-21 22:14:00.804', 'dei', 'BARSTOOL PUTIH GLOSSY');
INSERT INTO stock_names VALUES (84, '2015-01-21 22:14:00.804', 'dei', 'BATREY BORCHARGER BOSH');
INSERT INTO stock_names VALUES (85, '2015-01-21 22:14:00.804', 'dei', 'BEAM CAKRAM');
INSERT INTO stock_names VALUES (86, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 100 CM');
INSERT INTO stock_names VALUES (87, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 136 CM');
INSERT INTO stock_names VALUES (88, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 16 CM');
INSERT INTO stock_names VALUES (89, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 200 CM');
INSERT INTO stock_names VALUES (90, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 206 CM');
INSERT INTO stock_names VALUES (91, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 21 CM');
INSERT INTO stock_names VALUES (92, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 25 CM');
INSERT INTO stock_names VALUES (93, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 276 CM');
INSERT INTO stock_names VALUES (94, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 300 CM');
INSERT INTO stock_names VALUES (95, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 31 CM');
INSERT INTO stock_names VALUES (96, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 350 CM');
INSERT INTO stock_names VALUES (97, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SPOT MP MERAH');
INSERT INTO stock_names VALUES (98, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SPOT MP PUTIH');
INSERT INTO stock_names VALUES (99, '2015-01-21 22:14:00.804', 'dei', 'LAMPU TAMAN D10');
INSERT INTO stock_names VALUES (100, '2015-01-21 22:14:00.804', 'dei', 'LAMPU TL BOX 20W');
INSERT INTO stock_names VALUES (101, '2015-01-21 22:14:00.804', 'dei', 'LAMPU TL BOX 40W');
INSERT INTO stock_names VALUES (102, '2015-01-21 22:14:00.804', 'dei', 'LAMPU TL RANGKAI 15W');
INSERT INTO stock_names VALUES (103, '2015-01-21 22:14:00.804', 'dei', 'LAMPU TL RANGKAI 20W');
INSERT INTO stock_names VALUES (104, '2015-01-21 22:14:00.804', 'dei', 'LAMPU TL RANGKAI 40W');
INSERT INTO stock_names VALUES (105, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PIJAR 5W KUNING');
INSERT INTO stock_names VALUES (106, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PIJAR 5W MERAH');
INSERT INTO stock_names VALUES (107, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PIJAR 5W PUTIH');
INSERT INTO stock_names VALUES (108, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 605 CM');
INSERT INTO stock_names VALUES (109, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 66 CM');
INSERT INTO stock_names VALUES (110, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION CB 100');
INSERT INTO stock_names VALUES (111, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION CB 150');
INSERT INTO stock_names VALUES (112, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION CB 200');
INSERT INTO stock_names VALUES (113, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION150 CM');
INSERT INTO stock_names VALUES (114, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION250 CM');
INSERT INTO stock_names VALUES (115, '2015-01-21 22:14:00.804', 'dei', 'BIRU MUDA');
INSERT INTO stock_names VALUES (116, '2015-01-21 22:14:00.804', 'dei', 'BIRU TUA');
INSERT INTO stock_names VALUES (117, '2015-01-21 22:14:00.804', 'dei', 'BIRU VICTOR');
INSERT INTO stock_names VALUES (118, '2015-01-21 22:14:00.804', 'dei', 'BLUMN CHAIR');
INSERT INTO stock_names VALUES (119, '2015-01-21 22:14:00.804', 'dei', 'BOHLAM HALIDA 70W');
INSERT INTO stock_names VALUES (120, '2015-01-21 22:14:00.804', 'dei', 'BOHLAM HPIT 250W (WARM)');
INSERT INTO stock_names VALUES (121, '2015-01-21 22:14:00.804', 'dei', 'BOHLAM MICRO HALOGEN 12V');
INSERT INTO stock_names VALUES (122, '2015-01-21 22:14:00.804', 'dei', 'BOHLAM MICRO HALOGEN 220V');
INSERT INTO stock_names VALUES (123, '2015-01-21 22:14:00.804', 'dei', 'TANG BUAYA');
INSERT INTO stock_names VALUES (124, '2015-01-21 22:14:00.804', 'dei', 'TANG FUSE');
INSERT INTO stock_names VALUES (125, '2015-01-21 22:14:00.804', 'dei', 'TANG KOMBINASI');
INSERT INTO stock_names VALUES (126, '2015-01-21 22:14:00.804', 'dei', 'TANG POTONG');
INSERT INTO stock_names VALUES (127, '2015-01-21 22:14:00.804', 'dei', 'TANG POTONG SLING');
INSERT INTO stock_names VALUES (128, '2015-01-21 22:14:00.804', 'dei', 'TANG SKUN');
INSERT INTO stock_names VALUES (129, '2015-01-21 22:14:00.804', 'dei', 'MESIN POTONG KAYU 3 PHASE');
INSERT INTO stock_names VALUES (130, '2015-01-21 22:14:00.804', 'dei', 'MESIN POTONG SYSTEM');
INSERT INTO stock_names VALUES (131, '2015-01-21 22:14:00.804', 'dei', 'MESIN ROUTER');
INSERT INTO stock_names VALUES (132, '2015-01-21 22:14:00.804', 'dei', 'MESIN ROUTER BESAR');
INSERT INTO stock_names VALUES (133, '2015-01-21 22:14:00.804', 'dei', 'MESIN ROUTER KECIL');
INSERT INTO stock_names VALUES (134, '2015-01-21 22:14:00.804', 'dei', 'MESIN SERUT');
INSERT INTO stock_names VALUES (135, '2015-01-21 22:14:00.804', 'dei', 'METERAN KAIN');
INSERT INTO stock_names VALUES (136, '2015-01-21 22:14:00.804', 'dei', 'MIKRO BUS');
INSERT INTO stock_names VALUES (137, '2015-01-21 22:14:00.804', 'dei', 'MINIVAN');
INSERT INTO stock_names VALUES (138, '2015-01-21 22:14:00.804', 'dei', 'MISTIFAN');
INSERT INTO stock_names VALUES (139, '2015-01-21 22:14:00.804', 'dei', 'DEALING TABLE GLASS STD D100 CM');
INSERT INTO stock_names VALUES (140, '2015-01-21 22:14:00.804', 'dei', 'DVD PLAYER');
INSERT INTO stock_names VALUES (141, '2015-01-21 22:14:00.804', 'dei', 'EASY CHAIR BLACK');
INSERT INTO stock_names VALUES (142, '2015-01-21 22:14:00.804', 'dei', 'EXAUS FAN');
INSERT INTO stock_names VALUES (143, '2015-01-21 22:14:00.804', 'dei', 'FISH BOWL');
INSERT INTO stock_names VALUES (144, '2015-01-21 22:14:00.804', 'dei', 'FITING HOLOGEN 150 W');
INSERT INTO stock_names VALUES (145, '2015-01-21 22:14:00.804', 'dei', 'FITING KERAMIK SPOT');
INSERT INTO stock_names VALUES (146, '2015-01-21 22:14:00.804', 'dei', 'FITING LAMPU GANTUNG');
INSERT INTO stock_names VALUES (147, '2015-01-21 22:14:00.804', 'dei', 'OBENG (-)');
INSERT INTO stock_names VALUES (148, '2015-01-21 22:14:00.804', 'dei', 'OBENG (+)');
INSERT INTO stock_names VALUES (149, '2015-01-21 22:14:00.804', 'dei', 'AC PORTABEL');
INSERT INTO stock_names VALUES (150, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 480 SB');
INSERT INTO stock_names VALUES (151, '2015-01-21 22:14:00.804', 'dei', 'BESI BETON');
INSERT INTO stock_names VALUES (152, '2015-01-21 22:14:00.804', 'dei', 'FITING MIKA BULAT DOWNLIGHT');
INSERT INTO stock_names VALUES (153, '2015-01-21 22:14:00.804', 'dei', 'FITING MIKA KOTAK DOWNLIGHT');
INSERT INTO stock_names VALUES (154, '2015-01-21 22:14:00.804', 'dei', 'FITING TEMPEL');
INSERT INTO stock_names VALUES (155, '2015-01-21 22:14:00.804', 'dei', 'FLASTER');
INSERT INTO stock_names VALUES (156, '2015-01-21 22:14:00.804', 'dei', 'FOLDING CHAIR (WHITE)');
INSERT INTO stock_names VALUES (157, '2015-01-21 22:14:00.804', 'dei', 'FOLDING CHAIR BLACK');
INSERT INTO stock_names VALUES (158, '2015-01-21 22:14:00.804', 'dei', 'FORKLIF');
INSERT INTO stock_names VALUES (159, '2015-01-21 22:14:00.804', 'dei', 'FUNCTION CHAIR STAINLESS');
INSERT INTO stock_names VALUES (160, '2015-01-21 22:14:00.804', 'dei', 'GARDEN CHAIR CELEBRITY');
INSERT INTO stock_names VALUES (161, '2015-01-21 22:14:00.804', 'dei', 'GARDEN CHAIR CELEBRITY (BESAR)');
INSERT INTO stock_names VALUES (162, '2015-01-21 22:14:00.804', 'dei', 'GERGAJI BESI');
INSERT INTO stock_names VALUES (163, '2015-01-21 22:14:00.804', 'dei', 'GLUE GUN');
INSERT INTO stock_names VALUES (164, '2015-01-21 22:14:00.804', 'dei', 'GREAT WALL BLACK CHAIR');
INSERT INTO stock_names VALUES (165, '2015-01-21 22:14:00.804', 'dei', 'GREAT WALL CHAIR RED');
INSERT INTO stock_names VALUES (166, '2015-01-21 22:14:00.804', 'dei', 'GREAT WALL PUTIH');
INSERT INTO stock_names VALUES (167, '2015-01-21 22:14:00.804', 'dei', 'GREAT WALL RED CHAIR');
INSERT INTO stock_names VALUES (168, '2015-01-21 22:14:00.804', 'dei', 'GREAT WALL WHITE');
INSERT INTO stock_names VALUES (169, '2015-01-21 22:14:00.804', 'dei', 'GULIA CHAIR WHITE');
INSERT INTO stock_names VALUES (170, '2015-01-21 22:14:00.804', 'dei', 'KACA CERMIN');
INSERT INTO stock_names VALUES (171, '2015-01-21 22:14:00.804', 'dei', 'LAMPU MICRO HALOGEN LED 1W');
INSERT INTO stock_names VALUES (172, '2015-01-21 22:14:00.804', 'dei', 'MONITOR');
INSERT INTO stock_names VALUES (173, '2015-01-21 22:14:00.804', 'dei', 'MOTOR');
INSERT INTO stock_names VALUES (174, '2015-01-21 22:14:00.804', 'dei', 'MULI TESTER');
INSERT INTO stock_names VALUES (175, '2015-01-21 22:14:00.804', 'dei', 'MULTITESTER');
INSERT INTO stock_names VALUES (176, '2015-01-21 22:14:00.804', 'dei', 'NH FUSE 100 A');
INSERT INTO stock_names VALUES (177, '2015-01-21 22:14:00.804', 'dei', 'OBENG TESTPEN');
INSERT INTO stock_names VALUES (178, '2015-01-21 22:14:00.804', 'dei', 'ORANGE');
INSERT INTO stock_names VALUES (179, '2015-01-21 22:14:00.804', 'dei', 'ORBIT CHAIR');
INSERT INTO stock_names VALUES (180, '2015-01-21 22:14:00.804', 'dei', 'OVEN / REGULATOR ACRYLIC');
INSERT INTO stock_names VALUES (181, '2015-01-21 22:14:00.804', 'dei', 'PARTISI 236 X 46,9');
INSERT INTO stock_names VALUES (182, '2015-01-21 22:14:00.804', 'dei', 'PARTISI 236 X 96,4');
INSERT INTO stock_names VALUES (183, '2015-01-21 22:14:00.804', 'dei', 'PATUNG MACAN');
INSERT INTO stock_names VALUES (184, '2015-01-21 22:14:00.804', 'dei', 'PAYUNG 3 SUSUN');
INSERT INTO stock_names VALUES (185, '2015-01-21 22:14:00.804', 'dei', 'PEMBATAS JALAN (CONE)');
INSERT INTO stock_names VALUES (186, '2015-01-21 22:14:00.804', 'dei', 'PENANGKAL PETIR');
INSERT INTO stock_names VALUES (187, '2015-01-21 22:14:00.804', 'dei', 'PEROSOTAN T 2,5 CM');
INSERT INTO stock_names VALUES (188, '2015-01-21 22:14:00.804', 'dei', 'PLASTIK CHAIR BLUE');
INSERT INTO stock_names VALUES (189, '2015-01-21 22:14:00.804', 'dei', 'PLASTIK CHAIR ORANGE');
INSERT INTO stock_names VALUES (190, '2015-01-21 22:14:00.804', 'dei', 'POHON MEHWA T 0,5');
INSERT INTO stock_names VALUES (191, '2015-01-21 22:14:00.804', 'dei', 'POHON MEHWA T 2,0');
INSERT INTO stock_names VALUES (192, '2015-01-21 22:14:00.804', 'dei', 'POHON MEHWA T 2,5');
INSERT INTO stock_names VALUES (193, '2015-01-21 22:14:00.804', 'dei', 'RAK BROSUR CRISS CROSS');
INSERT INTO stock_names VALUES (194, '2015-01-21 22:14:00.804', 'dei', 'RAK BROSUR STANDING');
INSERT INTO stock_names VALUES (195, '2015-01-21 22:14:00.804', 'dei', 'KABEL RGB/VGA');
INSERT INTO stock_names VALUES (196, '2015-01-21 22:14:00.804', 'dei', 'KABEL ROL');
INSERT INTO stock_names VALUES (197, '2015-01-21 22:14:00.804', 'dei', 'KABEL SENUR 2 X 0,23 MM');
INSERT INTO stock_names VALUES (198, '2015-01-21 22:14:00.804', 'dei', 'KABEL SENUR 2 X 0,50 MM');
INSERT INTO stock_names VALUES (199, '2015-01-21 22:14:00.804', 'dei', 'KABEL/TALI TIES 30 CM');
INSERT INTO stock_names VALUES (200, '2015-01-21 22:14:00.804', 'dei', 'KAKI KANVAS (HITAM)');
INSERT INTO stock_names VALUES (201, '2015-01-21 22:14:00.804', 'dei', 'KAP LAMPU MERCURY');
INSERT INTO stock_names VALUES (202, '2015-01-21 22:14:00.804', 'dei', 'KAP LAMPU TAMAN ANDONG');
INSERT INTO stock_names VALUES (203, '2015-01-21 22:14:00.804', 'dei', 'KAP LAMPU TAMAN BULAT');
INSERT INTO stock_names VALUES (204, '2015-01-21 22:14:00.804', 'dei', 'KENDARAAN RODA 4');
INSERT INTO stock_names VALUES (205, '2015-01-21 22:14:00.804', 'dei', 'KERANJANG ROTAN');
INSERT INTO stock_names VALUES (206, '2015-01-21 22:14:00.804', 'dei', 'KERANJANG SAMPAH PLASTIK');
INSERT INTO stock_names VALUES (207, '2015-01-21 22:14:00.804', 'dei', 'KIPAS ANGIN (KOTAK)');
INSERT INTO stock_names VALUES (208, '2015-01-21 22:14:00.804', 'dei', 'EIFFEL CHAIR (RED)');
INSERT INTO stock_names VALUES (209, '2015-01-21 22:14:00.804', 'dei', 'AC STANDING 1/2 PK');
INSERT INTO stock_names VALUES (210, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SPOT MP BIRU');
INSERT INTO stock_names VALUES (211, '2015-01-21 22:14:00.804', 'dei', 'KARPET ABU-ABU AWAN');
INSERT INTO stock_names VALUES (212, '2015-01-21 22:14:00.804', 'dei', 'KARPET ABU-ABU BINTIK');
INSERT INTO stock_names VALUES (213, '2015-01-21 22:14:00.804', 'dei', 'KARPET ABU-ABU MUDA');
INSERT INTO stock_names VALUES (214, '2015-01-21 22:14:00.804', 'dei', 'KARPET ABU-ABU TUA');
INSERT INTO stock_names VALUES (215, '2015-01-21 22:14:00.804', 'dei', 'AIR COOLER');
INSERT INTO stock_names VALUES (216, '2015-01-21 22:14:00.804', 'dei', 'ALAT PEMBOLONG BEAM');
INSERT INTO stock_names VALUES (217, '2015-01-21 22:14:00.804', 'dei', 'ALAT RIVERT');
INSERT INTO stock_names VALUES (218, '2015-01-21 22:14:00.804', 'dei', 'ALAT ROL ELECTRIK KRISBOW');
INSERT INTO stock_names VALUES (219, '2015-01-21 22:14:00.804', 'dei', 'ANTENA TV IN DOOR');
INSERT INTO stock_names VALUES (220, '2015-01-21 22:14:00.804', 'dei', 'ANTENA TV IN DOOR PF 5000');
INSERT INTO stock_names VALUES (221, '2015-01-21 22:14:00.804', 'dei', 'ARM WHITE CHAIR');
INSERT INTO stock_names VALUES (222, '2015-01-21 22:14:00.804', 'dei', 'ASBAK KACA');
INSERT INTO stock_names VALUES (223, '2015-01-21 22:14:00.804', 'dei', 'ASBAK KACA MEJA');
INSERT INTO stock_names VALUES (224, '2015-01-21 22:14:00.804', 'dei', 'ASBAK STAINLESS');
INSERT INTO stock_names VALUES (225, '2015-01-21 22:14:00.804', 'dei', 'BALAS DC 12V');
INSERT INTO stock_names VALUES (226, '2015-01-21 22:14:00.804', 'dei', 'BALAS DOWNLIGHT 12V PHILPS');
INSERT INTO stock_names VALUES (227, '2015-01-21 22:14:00.804', 'dei', 'BALAS DOWNLIGHT 12V VOSLOH');
INSERT INTO stock_names VALUES (228, '2015-01-21 22:14:00.804', 'dei', 'BALAS NEON SEN');
INSERT INTO stock_names VALUES (229, '2015-01-21 22:14:00.804', 'dei', 'BALAS TL 20 W');
INSERT INTO stock_names VALUES (230, '2015-01-21 22:14:00.804', 'dei', 'BALAS TL 40 W');
INSERT INTO stock_names VALUES (231, '2015-01-21 22:14:00.804', 'dei', 'BALDOR DINAMO');
INSERT INTO stock_names VALUES (232, '2015-01-21 22:14:00.804', 'dei', 'BARRIER HITAM');
INSERT INTO stock_names VALUES (233, '2015-01-21 22:14:00.804', 'dei', 'BARRIER STAINLESS');
INSERT INTO stock_names VALUES (234, '2015-01-21 22:14:00.804', 'dei', 'BARSTOL HITAM GLOSSY');
INSERT INTO stock_names VALUES (235, '2015-01-21 22:14:00.804', 'dei', 'BARSTOL KOTAK HITAM');
INSERT INTO stock_names VALUES (236, '2015-01-21 22:14:00.804', 'dei', 'BARSTOL PUTIH GLOSSY');
INSERT INTO stock_names VALUES (237, '2015-01-21 22:14:00.804', 'dei', 'BARSTOOL BLACK');
INSERT INTO stock_names VALUES (238, '2015-01-21 22:14:00.804', 'dei', 'MESIN LAS TRAVO RINHO');
INSERT INTO stock_names VALUES (239, '2015-01-21 22:14:00.804', 'dei', 'MEJA PAYUNG');
INSERT INTO stock_names VALUES (240, '2015-01-21 22:14:00.804', 'dei', 'MERAH BINTIK');
INSERT INTO stock_names VALUES (241, '2015-01-21 22:14:00.804', 'dei', 'MERAH TERANG');
INSERT INTO stock_names VALUES (242, '2015-01-21 22:14:00.804', 'dei', 'MERK MAKITA');
INSERT INTO stock_names VALUES (243, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 3 X 2,5 MM');
INSERT INTO stock_names VALUES (244, '2015-01-21 22:14:00.804', 'dei', 'MERO  150 CM');
INSERT INTO stock_names VALUES (245, '2015-01-21 22:14:00.804', 'dei', 'SPRAY GUN CAMPORT');
INSERT INTO stock_names VALUES (246, '2015-01-21 22:14:00.804', 'dei', 'SPRAY GUN TABUNG BAWAH');
INSERT INTO stock_names VALUES (247, '2015-01-21 22:14:00.804', 'dei', 'SPUYER MISTIFAN');
INSERT INTO stock_names VALUES (248, '2015-01-21 22:14:00.804', 'dei', 'STAGER UK. 70 CM');
INSERT INTO stock_names VALUES (249, '2015-01-21 22:14:00.804', 'dei', 'STAND HANGER BLACK');
INSERT INTO stock_names VALUES (250, '2015-01-21 22:14:00.804', 'dei', 'STAND HANGER SINGLE RAM');
INSERT INTO stock_names VALUES (251, '2015-01-21 22:14:00.804', 'dei', 'STAND HANGER STAINLESS HORIS');
INSERT INTO stock_names VALUES (252, '2015-01-21 22:14:00.804', 'dei', 'STAPLES FLEXI TANGAN');
INSERT INTO stock_names VALUES (253, '2015-01-21 22:14:00.804', 'dei', 'STATER S2');
INSERT INTO stock_names VALUES (254, '2015-01-21 22:14:00.804', 'dei', 'STECKER K2');
INSERT INTO stock_names VALUES (255, '2015-01-21 22:14:00.804', 'dei', 'STECKER K3');
INSERT INTO stock_names VALUES (256, '2015-01-21 22:14:00.804', 'dei', 'TEMBAKAN PAKU F-30');
INSERT INTO stock_names VALUES (257, '2015-01-21 22:14:00.804', 'dei', 'TEMBAKAN PAKU F-50');
INSERT INTO stock_names VALUES (258, '2015-01-21 22:14:00.804', 'dei', 'TEMBAKAN PAKU LAMINASI');
INSERT INTO stock_names VALUES (259, '2015-01-21 22:14:00.804', 'dei', 'TEMBAKAN SAMBUNG');
INSERT INTO stock_names VALUES (260, '2015-01-21 22:14:00.804', 'dei', 'TEMPAT TIDUR LIPAT');
INSERT INTO stock_names VALUES (261, '2015-01-21 22:14:00.804', 'dei', 'CANTOLAN CEILLING');
INSERT INTO stock_names VALUES (262, '2015-01-21 22:14:00.804', 'dei', 'CANTOLAN COUNTER');
INSERT INTO stock_names VALUES (263, '2015-01-21 22:14:00.804', 'dei', 'CAT WALK');
INSERT INTO stock_names VALUES (264, '2015-01-21 22:14:00.804', 'dei', 'CENTRIFUGAL FAN(BLOWER KEONG)');
INSERT INTO stock_names VALUES (265, '2015-01-21 22:14:00.804', 'dei', 'CHARGER BORCHARGER MACTEK');
INSERT INTO stock_names VALUES (266, '2015-01-21 22:14:00.804', 'dei', 'CHARGER BOSRCHARGER BOSH');
INSERT INTO stock_names VALUES (267, '2015-01-21 22:14:00.804', 'dei', 'CHITOSE CHAIR');
INSERT INTO stock_names VALUES (268, '2015-01-21 22:14:00.804', 'dei', 'CLASSY CHAIR CREAM');
INSERT INTO stock_names VALUES (269, '2015-01-21 22:14:00.804', 'dei', 'CLASSY CHAIR HITAM');
INSERT INTO stock_names VALUES (270, '2015-01-21 22:14:00.804', 'dei', 'CLICK MERO');
INSERT INTO stock_names VALUES (271, '2015-01-21 22:14:00.804', 'dei', 'COFFE TABLE EX. HONDA');
INSERT INTO stock_names VALUES (272, '2015-01-21 22:14:00.804', 'dei', 'COFFE TABLE UK.50X50X40');
INSERT INTO stock_names VALUES (273, '2015-01-21 22:14:00.804', 'dei', 'COFFE TABLE UK.90X60X40');
INSERT INTO stock_names VALUES (274, '2015-01-21 22:14:00.804', 'dei', 'MANAQUIN MAN HALF BODY CREAM');
INSERT INTO stock_names VALUES (275, '2015-01-21 22:14:00.804', 'dei', 'MANAQUIN MAN KALFL BODY BLACK');
INSERT INTO stock_names VALUES (276, '2015-01-21 22:14:00.804', 'dei', 'MATA BOR  HOLE');
INSERT INTO stock_names VALUES (277, '2015-01-21 22:14:00.804', 'dei', 'MCB 3PH/25A/380V');
INSERT INTO stock_names VALUES (278, '2015-01-21 22:14:00.804', 'dei', 'MCB 3PH/32A/380V');
INSERT INTO stock_names VALUES (279, '2015-01-21 22:14:00.804', 'dei', 'MCB 3PH/50A/380V');
INSERT INTO stock_names VALUES (280, '2015-01-21 22:14:00.804', 'dei', 'MEETING CHAIR');
INSERT INTO stock_names VALUES (281, '2015-01-21 22:14:00.804', 'dei', 'MEETING CHAIR DESIGNER');
INSERT INTO stock_names VALUES (282, '2015-01-21 22:14:00.804', 'dei', 'MEETING TABLE');
INSERT INTO stock_names VALUES (283, '2015-01-21 22:14:00.804', 'dei', 'SOLID');
INSERT INTO stock_names VALUES (284, '2015-01-21 22:14:00.804', 'dei', 'SPIRAL KABEL');
INSERT INTO stock_names VALUES (285, '2015-01-21 22:14:00.804', 'dei', 'SPLITER RCA');
INSERT INTO stock_names VALUES (286, '2015-01-21 22:14:00.804', 'dei', 'SPLITER VGA');
INSERT INTO stock_names VALUES (287, '2015-01-21 22:14:00.804', 'dei', 'LAMPU XION T5 8W');
INSERT INTO stock_names VALUES (288, '2015-01-21 22:14:00.804', 'dei', 'LAMPU/BOHLAM HALOGEN 150W');
INSERT INTO stock_names VALUES (289, '2015-01-21 22:14:00.804', 'dei', 'LAMPU/BOHLAM HALOGEN 300W');
INSERT INTO stock_names VALUES (290, '2015-01-21 22:14:00.804', 'dei', 'LAMPU/BOHLAM HALOGEN 500W');
INSERT INTO stock_names VALUES (291, '2015-01-21 22:14:00.804', 'dei', 'LOCKER 4 PINTU');
INSERT INTO stock_names VALUES (292, '2015-01-21 22:14:00.804', 'dei', 'LOCKER 6 PINTU');
INSERT INTO stock_names VALUES (293, '2015-01-21 22:14:00.804', 'dei', 'ACRYLIC ');
INSERT INTO stock_names VALUES (294, '2015-01-21 22:14:00.804', 'dei', 'CAFE CHAIR');
INSERT INTO stock_names VALUES (295, '2015-01-21 22:14:00.804', 'dei', 'CAT TEMBOK Q-LUC @25 KG');
INSERT INTO stock_names VALUES (296, '2015-01-21 22:14:00.804', 'dei', 'BESI BETON 6 MM');
INSERT INTO stock_names VALUES (297, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 400 CM');
INSERT INTO stock_names VALUES (298, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 450 CM');
INSERT INTO stock_names VALUES (299, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 50 CM');
INSERT INTO stock_names VALUES (300, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 500 CM');
INSERT INTO stock_names VALUES (301, '2015-01-21 22:14:00.804', 'dei', 'BEAM SECTION 600 CM');
INSERT INTO stock_names VALUES (302, '2015-01-21 22:14:00.804', 'dei', 'BRACKET PLASMA 19"');
INSERT INTO stock_names VALUES (303, '2015-01-21 22:14:00.804', 'dei', 'BRACKET PLASMA 42"');
INSERT INTO stock_names VALUES (304, '2015-01-21 22:14:00.804', 'dei', 'BREKER 100A/380V');
INSERT INTO stock_names VALUES (305, '2015-01-21 22:14:00.804', 'dei', 'BREKER 125A/380V');
INSERT INTO stock_names VALUES (306, '2015-01-21 22:14:00.804', 'dei', 'BREKER 160A/380V');
INSERT INTO stock_names VALUES (307, '2015-01-21 22:14:00.804', 'dei', 'BREKER 200A/380V');
INSERT INTO stock_names VALUES (308, '2015-01-21 22:14:00.804', 'dei', 'BREKER 250A/380V');
INSERT INTO stock_names VALUES (309, '2015-01-21 22:14:00.804', 'dei', 'BREKER 300A/380V');
INSERT INTO stock_names VALUES (310, '2015-01-21 22:14:00.804', 'dei', 'BREKER 30A/380V');
INSERT INTO stock_names VALUES (311, '2015-01-21 22:14:00.804', 'dei', 'BREKER 32A/380V');
INSERT INTO stock_names VALUES (312, '2015-01-21 22:14:00.804', 'dei', 'BREKER 500A/380V');
INSERT INTO stock_names VALUES (313, '2015-01-21 22:14:00.804', 'dei', 'BREKER 60A/380V');
INSERT INTO stock_names VALUES (314, '2015-01-21 22:14:00.804', 'dei', 'BREKER 63A/380V');
INSERT INTO stock_names VALUES (315, '2015-01-21 22:14:00.804', 'dei', 'BUS');
INSERT INTO stock_names VALUES (316, '2015-01-21 22:14:00.804', 'dei', 'ROUND COFFE TABLE D.50');
INSERT INTO stock_names VALUES (317, '2015-01-21 22:14:00.804', 'dei', 'ROUND TABLE HOLOGRAM');
INSERT INTO stock_names VALUES (318, '2015-01-21 22:14:00.804', 'dei', 'ROUND TABLE POLOS D 80');
INSERT INTO stock_names VALUES (319, '2015-01-21 22:14:00.804', 'dei', 'RUBBASE CHAIR BLACK');
INSERT INTO stock_names VALUES (320, '2015-01-21 22:14:00.804', 'dei', 'SAKLAR 1 PHOLE IN BOW');
INSERT INTO stock_names VALUES (321, '2015-01-21 22:14:00.804', 'dei', 'SAKLAR 1 PHOLE OUT BOW');
INSERT INTO stock_names VALUES (322, '2015-01-21 22:14:00.804', 'dei', 'SAKLAR 2 PHOLE IN BOW');
INSERT INTO stock_names VALUES (323, '2015-01-21 22:14:00.804', 'dei', 'SAKLAR 2 PHOLE OUT BOW');
INSERT INTO stock_names VALUES (324, '2015-01-21 22:14:00.804', 'dei', 'SAMBUNGAN POST');
INSERT INTO stock_names VALUES (325, '2015-01-21 22:14:00.804', 'dei', 'SAVON CHAIR WHITE');
INSERT INTO stock_names VALUES (326, '2015-01-21 22:14:00.804', 'dei', 'SAW 9,5 CM');
INSERT INTO stock_names VALUES (327, '2015-01-21 22:14:00.804', 'dei', 'SCAFFOLDING UK. 150 CM');
INSERT INTO stock_names VALUES (328, '2015-01-21 22:14:00.804', 'dei', 'SCAFFOLDING UK. 170 CM');
INSERT INTO stock_names VALUES (329, '2015-01-21 22:14:00.804', 'dei', 'SEILING FAN PLASTIK');
INSERT INTO stock_names VALUES (330, '2015-01-21 22:14:00.804', 'dei', 'SEILING FAN STAINLES');
INSERT INTO stock_names VALUES (331, '2015-01-21 22:14:00.804', 'dei', 'SELANG MISTIFAN');
INSERT INTO stock_names VALUES (332, '2015-01-21 22:14:00.804', 'dei', 'SILANGAN RODA STAGER');
INSERT INTO stock_names VALUES (333, '2015-01-21 22:14:00.804', 'dei', 'SIRENE');
INSERT INTO stock_names VALUES (334, '2015-01-21 22:14:00.804', 'dei', 'SKUN 1,5 MM (-)');
INSERT INTO stock_names VALUES (335, '2015-01-21 22:14:00.804', 'dei', 'SKUN 1,5 MM (+)');
INSERT INTO stock_names VALUES (336, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 250 CM');
INSERT INTO stock_names VALUES (337, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HALOGEN MICRO TRAC 12V/50W');
INSERT INTO stock_names VALUES (338, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HPIT 250W');
INSERT INTO stock_names VALUES (339, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HPIT 400W');
INSERT INTO stock_names VALUES (340, '2015-01-21 22:14:00.804', 'dei', 'LAMPU LED RANGKAIAN');
INSERT INTO stock_names VALUES (341, '2015-01-21 22:14:00.804', 'dei', 'BOHLAM SPOT');
INSERT INTO stock_names VALUES (342, '2015-01-21 22:14:00.804', 'dei', 'BOLA MERO');
INSERT INTO stock_names VALUES (343, '2015-01-21 22:14:00.804', 'dei', 'BOR LISTRIK');
INSERT INTO stock_names VALUES (344, '2015-01-21 22:14:00.804', 'dei', 'BOR LISTRIK DUDUK');
INSERT INTO stock_names VALUES (345, '2015-01-21 22:14:00.804', 'dei', 'BOR LISTRIK MAGNET');
INSERT INTO stock_names VALUES (346, '2015-01-21 22:14:00.804', 'dei', 'BOR LISTRIK MAKITA');
INSERT INTO stock_names VALUES (347, '2015-01-21 22:14:00.804', 'dei', 'BOR LISTRK DUDUK');
INSERT INTO stock_names VALUES (348, '2015-01-21 22:14:00.804', 'dei', 'BORCHARGER');
INSERT INTO stock_names VALUES (349, '2015-01-21 22:14:00.804', 'dei', 'BORCHARGER BOSCH');
INSERT INTO stock_names VALUES (350, '2015-01-21 22:14:00.804', 'dei', 'BORCHARGER MACTEK');
INSERT INTO stock_names VALUES (351, '2015-01-21 22:14:00.804', 'dei', 'BOX LAMPU TL 20 W');
INSERT INTO stock_names VALUES (352, '2015-01-21 22:14:00.804', 'dei', 'BOX LAMPU TL 40 W');
INSERT INTO stock_names VALUES (353, '2015-01-21 22:14:00.804', 'dei', 'BOX MCB 1 PH');
INSERT INTO stock_names VALUES (354, '2015-01-21 22:14:00.804', 'dei', 'BOX MCB 3 PH');
INSERT INTO stock_names VALUES (355, '2015-01-21 22:14:00.804', 'dei', 'COVER MERO');
INSERT INTO stock_names VALUES (356, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PIPA');
INSERT INTO stock_names VALUES (357, '2015-01-21 22:14:00.804', 'dei', 'MESIN POMPA AIR "NASIONAL 125"');
INSERT INTO stock_names VALUES (358, '2015-01-21 22:14:00.804', 'dei', 'STECKER MULTI K2 - K3');
INSERT INTO stock_names VALUES (359, '2015-01-21 22:14:00.804', 'dei', 'STECKER MULTI K3 - K2');
INSERT INTO stock_names VALUES (360, '2015-01-21 22:14:00.804', 'dei', 'STOP KONTAK AC');
INSERT INTO stock_names VALUES (361, '2015-01-21 22:14:00.804', 'dei', 'STOP KONTAK E1 INBOW');
INSERT INTO stock_names VALUES (362, '2015-01-21 22:14:00.804', 'dei', 'STOP KONTAK P1 OUT BOW');
INSERT INTO stock_names VALUES (363, '2015-01-21 22:14:00.804', 'dei', 'STOP KONTAK P2 OUT BOW');
INSERT INTO stock_names VALUES (364, '2015-01-21 22:14:00.804', 'dei', 'STOP KONTAK P3 OUT BOW');
INSERT INTO stock_names VALUES (365, '2015-01-21 22:14:00.804', 'dei', 'TANAMAN RAMBAT');
INSERT INTO stock_names VALUES (366, '2015-01-21 22:14:00.804', 'dei', 'TANG AMPERE');
INSERT INTO stock_names VALUES (367, '2015-01-21 22:14:00.804', 'dei', 'KIPAS ANGIN MASPION');
INSERT INTO stock_names VALUES (368, '2015-01-21 22:14:00.804', 'dei', 'KIPAS ANGIN TORNADO');
INSERT INTO stock_names VALUES (369, '2015-01-21 22:14:00.804', 'dei', 'WASTE BASKET');
INSERT INTO stock_names VALUES (370, '2015-01-21 22:14:00.804', 'dei', 'WASTE BLACK BESI');
INSERT INTO stock_names VALUES (371, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SOROT');
INSERT INTO stock_names VALUES (372, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SPOT BARU (LONG ARM)');
INSERT INTO stock_names VALUES (373, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SPOT LAMA (CLIP ARM)');
INSERT INTO stock_names VALUES (374, '2015-01-21 22:14:00.804', 'dei', 'MATA BOR HOLE');
INSERT INTO stock_names VALUES (375, '2015-01-21 22:14:00.804', 'dei', 'MATA BOR HOLE                  SAW 6,4CM');
INSERT INTO stock_names VALUES (376, '2015-01-21 22:14:00.804', 'dei', 'MATA BOR HOLE                 SAW 1,5CM');
INSERT INTO stock_names VALUES (377, '2015-01-21 22:14:00.804', 'dei', 'MCB (HAGER) 3PH/63A/380V');
INSERT INTO stock_names VALUES (378, '2015-01-21 22:14:00.804', 'dei', 'LAMPU XION T5 28W');
INSERT INTO stock_names VALUES (379, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/10A/220V');
INSERT INTO stock_names VALUES (380, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/16A/220V');
INSERT INTO stock_names VALUES (381, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/20A/220V');
INSERT INTO stock_names VALUES (382, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/25A/220V');
INSERT INTO stock_names VALUES (383, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/2A/220V');
INSERT INTO stock_names VALUES (384, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/32A/220V');
INSERT INTO stock_names VALUES (385, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/4A/220V');
INSERT INTO stock_names VALUES (386, '2015-01-21 22:14:00.804', 'dei', 'MCB 1PH/6A/220V');
INSERT INTO stock_names VALUES (387, '2015-01-21 22:14:00.804', 'dei', 'MCB 3PH/10A/380V');
INSERT INTO stock_names VALUES (388, '2015-01-21 22:14:00.804', 'dei', 'MCB 3PH/16A/380V');
INSERT INTO stock_names VALUES (389, '2015-01-21 22:14:00.804', 'dei', 'MCB 3PH/20A/380V');
INSERT INTO stock_names VALUES (390, '2015-01-21 22:14:00.804', 'dei', 'BARSTOOL KOTAK PUTIH');
INSERT INTO stock_names VALUES (391, '2015-01-21 22:14:00.804', 'dei', 'SOFA DIETHELM ABU-ABU');
INSERT INTO stock_names VALUES (392, '2015-01-21 22:14:00.804', 'dei', 'SOFA HITAM 1 SEATER');
INSERT INTO stock_names VALUES (393, '2015-01-21 22:14:00.804', 'dei', 'SOFA HITAM 2 SEATER');
INSERT INTO stock_names VALUES (394, '2015-01-21 22:14:00.804', 'dei', 'SOFA PUFF HITAM PANJANG');
INSERT INTO stock_names VALUES (395, '2015-01-21 22:14:00.804', 'dei', 'SOFA PUFF UK. 50X50 (KECIL)');
INSERT INTO stock_names VALUES (396, '2015-01-21 22:14:00.804', 'dei', 'SOFA PUTIH 1 SEATER');
INSERT INTO stock_names VALUES (397, '2015-01-21 22:14:00.804', 'dei', 'SOFA PUTIH 2 SEATER');
INSERT INTO stock_names VALUES (398, '2015-01-21 22:14:00.804', 'dei', 'SOFA RING-O (EXS HONDA)');
INSERT INTO stock_names VALUES (399, '2015-01-21 22:14:00.804', 'dei', 'SOLDER LISTRIK');
INSERT INTO stock_names VALUES (400, '2015-01-21 22:14:00.804', 'dei', 'SOLDER PUMP');
INSERT INTO stock_names VALUES (401, '2015-01-21 22:14:00.804', 'dei', 'MOBIL ELF');
INSERT INTO stock_names VALUES (402, '2015-01-21 22:14:00.804', 'dei', 'DEMPUL SANPOLAK');
INSERT INTO stock_names VALUES (403, '2015-01-21 22:14:00.804', 'dei', 'BESI BETON 8 MM');
INSERT INTO stock_names VALUES (404, '2015-01-21 22:14:00.804', 'dei', 'SPRAY GUN');
INSERT INTO stock_names VALUES (405, '2015-01-21 22:14:00.804', 'dei', 'STATER S10');
INSERT INTO stock_names VALUES (406, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PLC 8W');
INSERT INTO stock_names VALUES (407, '2015-01-21 22:14:00.804', 'dei', 'LAMPU RM 2X40W (BOX)');
INSERT INTO stock_names VALUES (408, '2015-01-21 22:14:00.804', 'dei', 'NISSAN FUSO');
INSERT INTO stock_names VALUES (409, '2015-01-21 22:14:00.804', 'dei', 'PIPA UKURAN DIAMETER 1 CM');
INSERT INTO stock_names VALUES (410, '2015-01-21 22:14:00.804', 'dei', 'BESI CANAL UK 100X50X2.3X6 M');
INSERT INTO stock_names VALUES (411, '2015-01-21 22:14:00.804', 'dei', 'LAMPU ROTARY/LAMPU SIRINE');
INSERT INTO stock_names VALUES (412, '2015-01-21 22:14:00.804', 'dei', 'TANGGA KAYU 150 CM');
INSERT INTO stock_names VALUES (413, '2015-01-21 22:14:00.804', 'dei', 'TEMBAKAN');
INSERT INTO stock_names VALUES (414, '2015-01-21 22:14:00.804', 'dei', 'WASTE GREY PLASTIK');
INSERT INTO stock_names VALUES (415, '2015-01-21 22:14:00.804', 'dei', 'SKUN 10 MM');
INSERT INTO stock_names VALUES (416, '2015-01-21 22:14:00.804', 'dei', 'SAFETY BELT');
INSERT INTO stock_names VALUES (417, '2015-01-21 22:14:00.804', 'dei', 'SKUN 120 MM');
INSERT INTO stock_names VALUES (418, '2015-01-21 22:14:00.804', 'dei', 'KLEM KABEL 10 MM');
INSERT INTO stock_names VALUES (419, '2015-01-21 22:14:00.804', 'dei', 'KLEM KABEL 8 MM');
INSERT INTO stock_names VALUES (420, '2015-01-21 22:14:00.804', 'dei', 'KULKAS (BAR FRIGE)');
INSERT INTO stock_names VALUES (421, '2015-01-21 22:14:00.804', 'dei', 'KULKAS 1 PINTU MEDIUM');
INSERT INTO stock_names VALUES (422, '2015-01-21 22:14:00.804', 'dei', 'KULKAS 2 PINTU');
INSERT INTO stock_names VALUES (423, '2015-01-21 22:14:00.804', 'dei', 'KUNCI INGGRIS 10"');
INSERT INTO stock_names VALUES (424, '2015-01-21 22:14:00.804', 'dei', 'KUNCI INGGRIS 12"');
INSERT INTO stock_names VALUES (425, '2015-01-21 22:14:00.804', 'dei', 'KUNCI INGGRIS 15"');
INSERT INTO stock_names VALUES (426, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 10/11');
INSERT INTO stock_names VALUES (427, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 12/13');
INSERT INTO stock_names VALUES (428, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 14/15');
INSERT INTO stock_names VALUES (429, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 16/17');
INSERT INTO stock_names VALUES (430, '2015-01-21 22:14:00.804', 'dei', 'KUNCI PAS 19/21');
INSERT INTO stock_names VALUES (431, '2015-01-21 22:14:00.804', 'dei', 'KUNCI SHOCK');
INSERT INTO stock_names VALUES (432, '2015-01-21 22:14:00.804', 'dei', 'REVOLVING 20 KG');
INSERT INTO stock_names VALUES (433, '2015-01-21 22:14:00.804', 'dei', 'REVOLVING 500 KG');
INSERT INTO stock_names VALUES (434, '2015-01-21 22:14:00.804', 'dei', 'RODA SEAFOLDING');
INSERT INTO stock_names VALUES (435, '2015-01-21 22:14:00.804', 'dei', 'RODA STAGER');
INSERT INTO stock_names VALUES (436, '2015-01-21 22:14:00.804', 'dei', 'ROUND COFFE POLOS D.70');
INSERT INTO stock_names VALUES (437, '2015-01-21 22:14:00.804', 'dei', 'DEALING TABLE GLASS PUTAR COFFEMO');
INSERT INTO stock_names VALUES (438, '2015-01-21 22:14:00.804', 'dei', 'ROUND COFFE TABLE BAR GLASS');
INSERT INTO stock_names VALUES (439, '2015-01-21 22:14:00.804', 'dei', 'ROUND COFFE TABLE D 60');
INSERT INTO stock_names VALUES (440, '2015-01-21 22:14:00.804', 'dei', 'SAW 7,4CM');
INSERT INTO stock_names VALUES (441, '2015-01-21 22:14:00.804', 'dei', 'APV');
INSERT INTO stock_names VALUES (442, '2015-01-21 22:14:00.804', 'dei', 'BESI');
INSERT INTO stock_names VALUES (443, '2015-01-21 22:14:00.804', 'dei', 'BESI KANAL UK 100 X 50 X 6 M');
INSERT INTO stock_names VALUES (444, '2015-01-21 22:14:00.804', 'dei', 'COKLAT EMAS');
INSERT INTO stock_names VALUES (445, '2015-01-21 22:14:00.804', 'dei', 'COKLAT TUA');
INSERT INTO stock_names VALUES (446, '2015-01-21 22:14:00.804', 'dei', 'COMPRESOR LISTRIK');
INSERT INTO stock_names VALUES (447, '2015-01-21 22:14:00.804', 'dei', 'COUNCIL CHAIR OFFICE');
INSERT INTO stock_names VALUES (448, '2015-01-21 22:14:00.804', 'dei', 'COYLE');
INSERT INTO stock_names VALUES (449, '2015-01-21 22:14:00.804', 'dei', 'CROSS BRACE 200 CM');
INSERT INTO stock_names VALUES (450, '2015-01-21 22:14:00.804', 'dei', 'CROSS BRACE 220 CM');
INSERT INTO stock_names VALUES (451, '2015-01-21 22:14:00.804', 'dei', 'CRUISTIN 10 MM');
INSERT INTO stock_names VALUES (452, '2015-01-21 22:14:00.804', 'dei', 'CRUISTIN 16 MM');
INSERT INTO stock_names VALUES (453, '2015-01-21 22:14:00.804', 'dei', 'CRUISTIN 25 MM');
INSERT INTO stock_names VALUES (454, '2015-01-21 22:14:00.804', 'dei', 'DEALING TABLE 75');
INSERT INTO stock_names VALUES (455, '2015-01-21 22:14:00.804', 'dei', 'DEALING TABLE GLASS D80 CM');
INSERT INTO stock_names VALUES (456, '2015-01-21 22:14:00.804', 'dei', 'DEALING TABLE GLASS D90 CM');
INSERT INTO stock_names VALUES (457, '2015-01-21 22:14:00.804', 'dei', 'DISPENSER');
INSERT INTO stock_names VALUES (458, '2015-01-21 22:14:00.804', 'dei', 'GUNTING PLAT');
INSERT INTO stock_names VALUES (459, '2015-01-21 22:14:00.804', 'dei', 'GURINDA UK. 14"');
INSERT INTO stock_names VALUES (460, '2015-01-21 22:14:00.804', 'dei', 'HIJAU LUMUT');
INSERT INTO stock_names VALUES (461, '2015-01-21 22:14:00.804', 'dei', 'HIJAU MUDA');
INSERT INTO stock_names VALUES (462, '2015-01-21 22:14:00.804', 'dei', 'HIJAU PUPUS');
INSERT INTO stock_names VALUES (463, '2015-01-21 22:14:00.804', 'dei', 'HIJAU TERANG');
INSERT INTO stock_names VALUES (464, '2015-01-21 22:14:00.804', 'dei', 'HITAM');
INSERT INTO stock_names VALUES (465, '2015-01-21 22:14:00.804', 'dei', 'INTIC FAN');
INSERT INTO stock_names VALUES (466, '2015-01-21 22:14:00.804', 'dei', 'ISOLASI NITTO');
INSERT INTO stock_names VALUES (467, '2015-01-21 22:14:00.804', 'dei', 'JACK MONO-STEREO');
INSERT INTO stock_names VALUES (468, '2015-01-21 22:14:00.804', 'dei', 'JACK RCA');
INSERT INTO stock_names VALUES (469, '2015-01-21 22:14:00.804', 'dei', 'KABEL HDMI');
INSERT INTO stock_names VALUES (470, '2015-01-21 22:14:00.804', 'dei', 'KABEL NEON SEN 1 X 0,50 MM');
INSERT INTO stock_names VALUES (471, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYA 2 X 2,5 MM');
INSERT INTO stock_names VALUES (472, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYAF 1 X 1,5 MM');
INSERT INTO stock_names VALUES (473, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 4 X 10 MM');
INSERT INTO stock_names VALUES (474, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 4 X 120 MM');
INSERT INTO stock_names VALUES (475, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 4 X 16 MM');
INSERT INTO stock_names VALUES (476, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 4 X 4 MM');
INSERT INTO stock_names VALUES (477, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 4 X 6 MM');
INSERT INTO stock_names VALUES (478, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 4 X 70 MM');
INSERT INTO stock_names VALUES (479, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYM 4 X 95 MM');
INSERT INTO stock_names VALUES (480, '2015-01-21 22:14:00.804', 'dei', 'KABEL NYYHY 1 X 0,5 MM');
INSERT INTO stock_names VALUES (481, '2015-01-21 22:14:00.804', 'dei', 'L 300');
INSERT INTO stock_names VALUES (482, '2015-01-21 22:14:00.804', 'dei', 'BESI AS RODA BECAK');
INSERT INTO stock_names VALUES (483, '2015-01-21 22:14:00.804', 'dei', 'BESI ELBOW 1/2"');
INSERT INTO stock_names VALUES (484, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 14/15');
INSERT INTO stock_names VALUES (485, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 16/17');
INSERT INTO stock_names VALUES (486, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 18/19');
INSERT INTO stock_names VALUES (487, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 19/21');
INSERT INTO stock_names VALUES (488, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 20/22');
INSERT INTO stock_names VALUES (489, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 22/24');
INSERT INTO stock_names VALUES (490, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 24/27');
INSERT INTO stock_names VALUES (491, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 26/28');
INSERT INTO stock_names VALUES (492, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 27/29');
INSERT INTO stock_names VALUES (493, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 30/32');
INSERT INTO stock_names VALUES (494, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING 6/7');
INSERT INTO stock_names VALUES (495, '2015-01-21 22:14:00.804', 'dei', 'LAMPU XION T5 14W');
INSERT INTO stock_names VALUES (496, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING PAS 19');
INSERT INTO stock_names VALUES (497, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING PAS 22');
INSERT INTO stock_names VALUES (498, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING PAS 24');
INSERT INTO stock_names VALUES (499, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING PAS 26');
INSERT INTO stock_names VALUES (500, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING PAS 28');
INSERT INTO stock_names VALUES (501, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING PAS 32');
INSERT INTO stock_names VALUES (502, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING/PAS 10');
INSERT INTO stock_names VALUES (503, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING/PAS 11');
INSERT INTO stock_names VALUES (504, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING/PAS 12');
INSERT INTO stock_names VALUES (505, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING/PAS 8');
INSERT INTO stock_names VALUES (506, '2015-01-21 22:14:00.804', 'dei', 'TEMBAKAN STAPLES 422 J');
INSERT INTO stock_names VALUES (507, '2015-01-21 22:14:00.804', 'dei', 'TIANG BARIELL STAINLESS');
INSERT INTO stock_names VALUES (508, '2015-01-21 22:14:00.804', 'dei', 'TOMBOL SIRINE');
INSERT INTO stock_names VALUES (509, '2015-01-21 22:14:00.804', 'dei', 'TOP TABLE');
INSERT INTO stock_names VALUES (510, '2015-01-21 22:14:00.804', 'dei', 'TOPLES KUE');
INSERT INTO stock_names VALUES (511, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 30 CM');
INSERT INTO stock_names VALUES (512, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 300 CM');
INSERT INTO stock_names VALUES (513, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 350 CM');
INSERT INTO stock_names VALUES (514, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 400 CM');
INSERT INTO stock_names VALUES (515, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 450 CM');
INSERT INTO stock_names VALUES (516, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 50 CM');
INSERT INTO stock_names VALUES (517, '2015-01-21 22:14:00.804', 'dei', 'ENGKEL');
INSERT INTO stock_names VALUES (518, '2015-01-21 22:14:00.804', 'dei', 'BESI AS RODA MATIC');
INSERT INTO stock_names VALUES (519, '2015-01-21 22:14:00.804', 'dei', 'BESI ELBOW 1 "');
INSERT INTO stock_names VALUES (520, '2015-01-21 22:14:00.804', 'dei', 'KUNCI RING/PAS 9');
INSERT INTO stock_names VALUES (521, '2015-01-21 22:14:00.804', 'dei', 'KUNCI SHOWCASE');
INSERT INTO stock_names VALUES (522, '2015-01-21 22:14:00.804', 'dei', 'KUNING');
INSERT INTO stock_names VALUES (523, '2015-01-21 22:14:00.804', 'dei', 'KURSI BETAWI');
INSERT INTO stock_names VALUES (524, '2015-01-21 22:14:00.804', 'dei', 'KURSI PUTIH PETRA DINNING');
INSERT INTO stock_names VALUES (525, '2015-01-21 22:14:00.804', 'dei', 'LAMPU BOHLAM 18W "PANASONIC"');
INSERT INTO stock_names VALUES (526, '2015-01-21 22:14:00.804', 'dei', 'LAMPU BOHLAM LED');
INSERT INTO stock_names VALUES (527, '2015-01-21 22:14:00.804', 'dei', 'LAMPU CABE');
INSERT INTO stock_names VALUES (528, '2015-01-21 22:14:00.804', 'dei', 'LAMPU CABE PEATASAN');
INSERT INTO stock_names VALUES (529, '2015-01-21 22:14:00.804', 'dei', 'LAMPU DOWNLIGHT 12V/50W 7.5');
INSERT INTO stock_names VALUES (530, '2015-01-21 22:14:00.804', 'dei', 'LAMPU DOWNLIGHT 12V/50W 9.5');
INSERT INTO stock_names VALUES (531, '2015-01-21 22:14:00.804', 'dei', 'LAMPU DOWNLIGHT HALIDA 150W');
INSERT INTO stock_names VALUES (532, '2015-01-21 22:14:00.804', 'dei', 'LAMPU DOWNLIGHT HALIDA 70W');
INSERT INTO stock_names VALUES (533, '2015-01-21 22:14:00.804', 'dei', 'LAMPU EMERGENCY');
INSERT INTO stock_names VALUES (534, '2015-01-21 22:14:00.804', 'dei', 'LAMPU GANTUNG ACRILYC SEGI EMPAT');
INSERT INTO stock_names VALUES (535, '2015-01-21 22:14:00.804', 'dei', 'LAMPU GANTUNG ACRILYC SEGI ENAM');
INSERT INTO stock_names VALUES (536, '2015-01-21 22:14:00.804', 'dei', 'LAMPU GANTUNG BULAT');
INSERT INTO stock_names VALUES (537, '2015-01-21 22:14:00.804', 'dei', 'LAMPU GANTUNG KAIN');
INSERT INTO stock_names VALUES (538, '2015-01-21 22:14:00.804', 'dei', 'LAMPU GANTUNG TEBAR SERIBU');
INSERT INTO stock_names VALUES (539, '2015-01-21 22:14:00.804', 'dei', 'LAMPU HALIDA 150W OUT BOW');
INSERT INTO stock_names VALUES (540, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 470 SW');
INSERT INTO stock_names VALUES (541, '2015-01-21 22:14:00.804', 'dei', 'BESI AS RODA MOBIL');
INSERT INTO stock_names VALUES (542, '2015-01-21 22:14:00.804', 'dei', 'MESIN POMPA AIR TANAM');
INSERT INTO stock_names VALUES (543, '2015-01-21 22:14:00.804', 'dei', 'MESIN POTONG');
INSERT INTO stock_names VALUES (544, '2015-01-21 22:14:00.804', 'dei', 'MESIN POTONG KAYU');
INSERT INTO stock_names VALUES (545, '2015-01-21 22:14:00.804', 'dei', 'LAMPU PIJAR 60W');
INSERT INTO stock_names VALUES (546, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 222');
INSERT INTO stock_names VALUES (547, '2015-01-21 22:14:00.804', 'dei', 'BESI AS RODA MOBIL PANJANG 35 CM');
INSERT INTO stock_names VALUES (548, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SPOT MP HIJAU');
INSERT INTO stock_names VALUES (549, '2015-01-21 22:14:00.804', 'dei', 'LAMPU SPOT MP KUNING');
INSERT INTO stock_names VALUES (550, '2015-01-21 22:14:00.804', 'dei', 'SOFT BOARD');
INSERT INTO stock_names VALUES (551, '2015-01-21 22:14:00.804', 'dei', 'TRUCK');
INSERT INTO stock_names VALUES (552, '2015-01-21 22:14:00.804', 'dei', 'TRUCK BOX');
INSERT INTO stock_names VALUES (553, '2015-01-21 22:14:00.804', 'dei', 'TUTUP POST');
INSERT INTO stock_names VALUES (554, '2015-01-21 22:14:00.804', 'dei', 'TV PLASMA 32" LG');
INSERT INTO stock_names VALUES (555, '2015-01-21 22:14:00.804', 'dei', 'TV PLASMA 42" LG');
INSERT INTO stock_names VALUES (556, '2015-01-21 22:14:00.804', 'dei', 'TV PLASMA 42" SAMSUNG');
INSERT INTO stock_names VALUES (557, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 100 CM');
INSERT INTO stock_names VALUES (558, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 150 CM');
INSERT INTO stock_names VALUES (559, '2015-01-21 22:14:00.804', 'dei', 'UPPRIGHT POST 200 CM');
INSERT INTO stock_names VALUES (560, '2015-01-21 22:14:00.804', 'dei', 'MERO 100 CM');
INSERT INTO stock_names VALUES (561, '2015-01-21 22:14:00.804', 'dei', 'MERO 200 CM');
INSERT INTO stock_names VALUES (562, '2015-01-21 22:14:00.804', 'dei', 'MERO 25 CM');
INSERT INTO stock_names VALUES (563, '2015-01-21 22:14:00.804', 'dei', 'MERO 35 CM');
INSERT INTO stock_names VALUES (564, '2015-01-21 22:14:00.804', 'dei', 'MERO 50 CM');
INSERT INTO stock_names VALUES (565, '2015-01-21 22:14:00.804', 'dei', 'MERO 70 CM');
INSERT INTO stock_names VALUES (566, '2015-01-21 22:14:00.804', 'dei', 'MESIN ADJING');
INSERT INTO stock_names VALUES (567, '2015-01-21 22:14:00.804', 'dei', 'MESIN AMPLAS');
INSERT INTO stock_names VALUES (568, '2015-01-21 22:14:00.804', 'dei', 'MESIN BELAH ACRYLIC');
INSERT INTO stock_names VALUES (569, '2015-01-21 22:14:00.804', 'dei', 'MESIN BELAH KAYU 1 PHASE');
INSERT INTO stock_names VALUES (570, '2015-01-21 22:14:00.804', 'dei', 'MESIN BELAH KAYU 3 PHASE');
INSERT INTO stock_names VALUES (571, '2015-01-21 22:14:00.804', 'dei', 'MESIN BOR DUDUK');
INSERT INTO stock_names VALUES (572, '2015-01-21 22:14:00.804', 'dei', 'MESIN CIRCLE 4"');
INSERT INTO stock_names VALUES (573, '2015-01-21 22:14:00.804', 'dei', 'MESIN CIRCLE 6"');
INSERT INTO stock_names VALUES (574, '2015-01-21 22:14:00.804', 'dei', 'MESIN CIRCLE 9"');
INSERT INTO stock_names VALUES (575, '2015-01-21 22:14:00.804', 'dei', 'MESIN GENSET BENSIN');
INSERT INTO stock_names VALUES (576, '2015-01-21 22:14:00.804', 'dei', 'MESIN GURINDO UK. 41');
INSERT INTO stock_names VALUES (577, '2015-01-21 22:14:00.804', 'dei', 'MESIN JIGSAW');
INSERT INTO stock_names VALUES (578, '2015-01-21 22:14:00.804', 'dei', 'MESIN LAS DIESEL');
INSERT INTO stock_names VALUES (579, '2015-01-21 22:14:00.804', 'dei', 'MESIN LAS TRAVO ARTIKA');
INSERT INTO stock_names VALUES (580, '2015-01-21 22:14:00.804', 'dei', 'CAT NIPPE 270');
INSERT INTO stock_names VALUES (581, '2015-01-21 22:14:00.804', 'dei', 'BESI BEHEL 11 MM');
INSERT INTO stock_names VALUES (582, '2015-01-21 22:14:00.804', 'dei', 'PANGGUNG CLASSIC');
INSERT INTO stock_names VALUES (583, '2015-02-01 07:46:20.795', 'dei', 'botol kaca');


--
-- Name: stock_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('stock_stock_id_seq', 583, true);


--
-- Data for Name: stock_types; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO stock_types VALUES (3, '2015-01-31 21:52:27.441', 'dei', 'Habis Pakai');
INSERT INTO stock_types VALUES (6, '2015-01-31 21:52:27.441', 'dei', 'Inventaris Kant');
INSERT INTO stock_types VALUES (1, '2015-01-31 21:52:27.441', 'dei', 'Asset Tetap');
INSERT INTO stock_types VALUES (8, '2015-01-31 21:52:27.441', 'dei', 'Persediaan/Prop');
INSERT INTO stock_types VALUES (9, '2015-01-31 21:52:27.441', 'dei', 'Persediaan');
INSERT INTO stock_types VALUES (0, '2015-01-31 23:03:58.651', 'dei', 'unclassified');


--
-- Data for Name: stock_units; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO stock_units VALUES (1, '2015-02-01 08:32:17.749', 'dei', 'BARREL');
INSERT INTO stock_units VALUES (2, '2015-02-01 08:32:17.749', 'dei', 'BKS');
INSERT INTO stock_units VALUES (3, '2015-02-01 08:32:17.749', 'dei', 'BOX');
INSERT INTO stock_units VALUES (4, '2015-02-01 08:32:17.749', 'dei', 'BTL');
INSERT INTO stock_units VALUES (5, '2015-02-01 08:32:17.749', 'dei', 'DUS');
INSERT INTO stock_units VALUES (6, '2015-02-01 08:32:17.749', 'dei', 'GALON');
INSERT INTO stock_units VALUES (7, '2015-02-01 08:32:17.749', 'dei', 'GLN');
INSERT INTO stock_units VALUES (8, '2015-02-01 08:32:17.749', 'dei', 'Kantong');
INSERT INTO stock_units VALUES (9, '2015-02-01 08:32:17.749', 'dei', 'KARUNG');
INSERT INTO stock_units VALUES (10, '2015-02-01 08:32:17.749', 'dei', 'KG');
INSERT INTO stock_units VALUES (11, '2015-02-01 08:32:17.749', 'dei', 'KLG');
INSERT INTO stock_units VALUES (12, '2015-02-01 08:32:17.749', 'dei', 'LBR');
INSERT INTO stock_units VALUES (13, '2015-02-01 08:32:17.749', 'dei', 'LITER');
INSERT INTO stock_units VALUES (14, '2015-02-01 08:32:17.749', 'dei', 'LSN');
INSERT INTO stock_units VALUES (15, '2015-02-01 08:32:17.749', 'dei', 'LTR');
INSERT INTO stock_units VALUES (16, '2015-02-01 08:32:17.749', 'dei', 'M');
INSERT INTO stock_units VALUES (17, '2015-02-01 08:32:17.749', 'dei', 'M2');
INSERT INTO stock_units VALUES (18, '2015-02-01 08:32:17.749', 'dei', 'M3');
INSERT INTO stock_units VALUES (19, '2015-02-01 08:32:17.749', 'dei', 'METER	');
INSERT INTO stock_units VALUES (20, '2015-02-01 08:32:17.749', 'dei', 'MOBIL');
INSERT INTO stock_units VALUES (21, '2015-02-01 08:32:17.749', 'dei', 'PACK');
INSERT INTO stock_units VALUES (22, '2015-02-01 08:32:17.749', 'dei', 'PAIL');
INSERT INTO stock_units VALUES (23, '2015-02-01 08:32:17.749', 'dei', 'PAK');
INSERT INTO stock_units VALUES (24, '2015-02-01 08:32:17.749', 'dei', 'PC');
INSERT INTO stock_units VALUES (25, '2015-02-01 08:32:17.749', 'dei', 'PCS	');
INSERT INTO stock_units VALUES (26, '2015-02-01 08:32:17.749', 'dei', 'POT');
INSERT INTO stock_units VALUES (27, '2015-02-01 08:32:17.749', 'dei', 'PSC');
INSERT INTO stock_units VALUES (28, '2015-02-01 08:32:17.749', 'dei', 'ROLL');
INSERT INTO stock_units VALUES (29, '2015-02-01 08:32:17.749', 'dei', 'SET	');
INSERT INTO stock_units VALUES (30, '2015-02-01 08:32:17.749', 'dei', 'STEL');
INSERT INTO stock_units VALUES (31, '2015-02-01 08:32:17.749', 'dei', 'TUBE');
INSERT INTO stock_units VALUES (32, '2015-02-01 08:32:17.749', 'dei', 'UNIT');
INSERT INTO stock_units VALUES (33, '2015-02-01 08:32:17.749', 'dei', 'M''');
INSERT INTO stock_units VALUES (34, '2015-02-01 08:32:17.749', 'dei', 'CM');
INSERT INTO stock_units VALUES (35, '2015-02-01 08:32:17.749', 'dei', 'MM');
INSERT INTO stock_units VALUES (36, '2015-02-01 08:32:17.749', 'dei', 'IKAT');
INSERT INTO stock_units VALUES (37, '2015-02-01 08:32:17.749', 'dei', 'BATANG');
INSERT INTO stock_units VALUES (0, '2015-02-04 19:19:38.495', 'dei', NULL);


--
-- Name: stock_units_stock_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('stock_units_stock_unit_id_seq', 37, true);


--
-- Data for Name: stocks; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO stocks VALUES (22, '2015-01-21 22:27:49.132', 'dei', NULL, 22, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (52, '2015-01-21 22:27:49.132', 'dei', NULL, 52, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (136, '2015-01-21 22:27:49.132', 'dei', NULL, 136, NULL, NULL, 4, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (170, '2015-01-21 22:27:49.132', 'dei', NULL, 170, '8mm', NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (2, '2015-01-21 22:27:49.132', 'dei', NULL, 2, NULL, NULL, 10, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (3, '2015-01-21 22:27:49.132', 'dei', NULL, 3, NULL, NULL, 1, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (7, '2015-01-21 22:27:49.132', 'dei', NULL, 7, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (481, '2015-01-21 22:27:49.132', 'dei', NULL, 481, NULL, NULL, 4, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (4, '2015-01-21 22:27:49.132', 'dei', NULL, 4, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (5, '2015-01-21 22:27:49.132', 'dei', NULL, 5, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (6, '2015-01-21 22:27:49.132', 'dei', NULL, 6, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (8, '2015-01-21 22:27:49.132', 'dei', NULL, 8, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (9, '2015-01-21 22:27:49.132', 'dei', NULL, 9, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (10, '2015-01-21 22:27:49.132', 'dei', NULL, 10, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (11, '2015-01-21 22:27:49.132', 'dei', NULL, 11, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (12, '2015-01-21 22:27:49.132', 'dei', NULL, 12, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (482, '2015-01-21 22:27:49.132', 'dei', NULL, 482, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (483, '2015-01-21 22:27:49.132', 'dei', NULL, 483, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (484, '2015-01-21 22:27:49.132', 'dei', NULL, 484, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (485, '2015-01-21 22:27:49.132', 'dei', NULL, 485, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (13, '2015-01-21 22:27:49.132', 'dei', NULL, 13, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (14, '2015-01-21 22:27:49.132', 'dei', NULL, 14, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (15, '2015-01-21 22:27:49.132', 'dei', NULL, 15, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (16, '2015-01-21 22:27:49.132', 'dei', NULL, 16, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (17, '2015-01-21 22:27:49.132', 'dei', NULL, 17, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (18, '2015-01-21 22:27:49.132', 'dei', NULL, 18, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (19, '2015-01-21 22:27:49.132', 'dei', NULL, 19, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (20, '2015-01-21 22:27:49.132', 'dei', NULL, 20, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (21, '2015-01-21 22:27:49.132', 'dei', NULL, 21, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (24, '2015-01-21 22:27:49.132', 'dei', NULL, 24, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (25, '2015-01-21 22:27:49.132', 'dei', NULL, 25, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (27, '2015-01-21 22:27:49.132', 'dei', NULL, 27, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (28, '2015-01-21 22:27:49.132', 'dei', NULL, 28, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (29, '2015-01-21 22:27:49.132', 'dei', NULL, 29, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (30, '2015-01-21 22:27:49.132', 'dei', NULL, 30, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (31, '2015-01-21 22:27:49.132', 'dei', NULL, 31, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (32, '2015-01-21 22:27:49.132', 'dei', NULL, 32, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (33, '2015-01-21 22:27:49.132', 'dei', NULL, 33, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (34, '2015-01-21 22:27:49.132', 'dei', NULL, 34, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (35, '2015-01-21 22:27:49.132', 'dei', NULL, 35, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (36, '2015-01-21 22:27:49.132', 'dei', NULL, 36, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (37, '2015-01-21 22:27:49.132', 'dei', NULL, 37, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (38, '2015-01-21 22:27:49.132', 'dei', NULL, 38, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (39, '2015-01-21 22:27:49.132', 'dei', NULL, 39, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (40, '2015-01-21 22:27:49.132', 'dei', NULL, 40, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (41, '2015-01-21 22:27:49.132', 'dei', NULL, 41, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (42, '2015-01-21 22:27:49.132', 'dei', NULL, 42, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (43, '2015-01-21 22:27:49.132', 'dei', NULL, 43, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (44, '2015-01-21 22:27:49.132', 'dei', NULL, 44, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (45, '2015-01-21 22:27:49.132', 'dei', NULL, 45, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (46, '2015-01-21 22:27:49.132', 'dei', NULL, 46, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (47, '2015-01-21 22:27:49.132', 'dei', NULL, 47, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (48, '2015-01-21 22:27:49.132', 'dei', NULL, 48, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (49, '2015-01-21 22:27:49.132', 'dei', NULL, 49, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (50, '2015-01-21 22:27:49.132', 'dei', NULL, 50, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (51, '2015-01-21 22:27:49.132', 'dei', NULL, 51, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (53, '2015-01-21 22:27:49.132', 'dei', NULL, 53, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (54, '2015-01-21 22:27:49.132', 'dei', NULL, 54, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (55, '2015-01-21 22:27:49.132', 'dei', NULL, 55, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (56, '2015-01-21 22:27:49.132', 'dei', NULL, 56, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (57, '2015-01-21 22:27:49.132', 'dei', NULL, 57, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (58, '2015-01-21 22:27:49.132', 'dei', NULL, 58, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (59, '2015-01-21 22:27:49.132', 'dei', NULL, 59, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (60, '2015-01-21 22:27:49.132', 'dei', NULL, 60, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (61, '2015-01-21 22:27:49.132', 'dei', NULL, 61, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (62, '2015-01-21 22:27:49.132', 'dei', NULL, 62, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (69, '2015-01-21 22:27:49.132', 'dei', NULL, 69, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (70, '2015-01-21 22:27:49.132', 'dei', NULL, 70, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (71, '2015-01-21 22:27:49.132', 'dei', NULL, 71, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (73, '2015-01-21 22:27:49.132', 'dei', NULL, 73, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (74, '2015-01-21 22:27:49.132', 'dei', NULL, 74, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (75, '2015-01-21 22:27:49.132', 'dei', NULL, 75, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (76, '2015-01-21 22:27:49.132', 'dei', NULL, 76, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (77, '2015-01-21 22:27:49.132', 'dei', NULL, 77, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (78, '2015-01-21 22:27:49.132', 'dei', NULL, 78, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (79, '2015-01-21 22:27:49.132', 'dei', NULL, 79, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (80, '2015-01-21 22:27:49.132', 'dei', NULL, 80, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (81, '2015-01-21 22:27:49.132', 'dei', NULL, 81, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (82, '2015-01-21 22:27:49.132', 'dei', NULL, 82, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (83, '2015-01-21 22:27:49.132', 'dei', NULL, 83, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (84, '2015-01-21 22:27:49.132', 'dei', NULL, 84, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (85, '2015-01-21 22:27:49.132', 'dei', NULL, 85, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (86, '2015-01-21 22:27:49.132', 'dei', NULL, 86, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (87, '2015-01-21 22:27:49.132', 'dei', NULL, 87, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (88, '2015-01-21 22:27:49.132', 'dei', NULL, 88, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (89, '2015-01-21 22:27:49.132', 'dei', NULL, 89, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (90, '2015-01-21 22:27:49.132', 'dei', NULL, 90, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (91, '2015-01-21 22:27:49.132', 'dei', NULL, 91, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (92, '2015-01-21 22:27:49.132', 'dei', NULL, 92, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (93, '2015-01-21 22:27:49.132', 'dei', NULL, 93, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (94, '2015-01-21 22:27:49.132', 'dei', NULL, 94, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (95, '2015-01-21 22:27:49.132', 'dei', NULL, 95, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (96, '2015-01-21 22:27:49.132', 'dei', NULL, 96, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (97, '2015-01-21 22:27:49.132', 'dei', NULL, 97, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (98, '2015-01-21 22:27:49.132', 'dei', NULL, 98, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (99, '2015-01-21 22:27:49.132', 'dei', NULL, 99, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (100, '2015-01-21 22:27:49.132', 'dei', NULL, 100, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (101, '2015-01-21 22:27:49.132', 'dei', NULL, 101, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (102, '2015-01-21 22:27:49.132', 'dei', NULL, 102, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (103, '2015-01-21 22:27:49.132', 'dei', NULL, 103, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (104, '2015-01-21 22:27:49.132', 'dei', NULL, 104, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (105, '2015-01-21 22:27:49.132', 'dei', NULL, 105, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (106, '2015-01-21 22:27:49.132', 'dei', NULL, 106, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (107, '2015-01-21 22:27:49.132', 'dei', NULL, 107, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (108, '2015-01-21 22:27:49.132', 'dei', NULL, 108, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (109, '2015-01-21 22:27:49.132', 'dei', NULL, 109, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (110, '2015-01-21 22:27:49.132', 'dei', NULL, 110, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (111, '2015-01-21 22:27:49.132', 'dei', NULL, 111, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (112, '2015-01-21 22:27:49.132', 'dei', NULL, 112, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (113, '2015-01-21 22:27:49.132', 'dei', NULL, 113, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (114, '2015-01-21 22:27:49.132', 'dei', NULL, 114, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (115, '2015-01-21 22:27:49.132', 'dei', NULL, 115, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (116, '2015-01-21 22:27:49.132', 'dei', NULL, 116, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (117, '2015-01-21 22:27:49.132', 'dei', NULL, 117, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (118, '2015-01-21 22:27:49.132', 'dei', NULL, 118, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (119, '2015-01-21 22:27:49.132', 'dei', NULL, 119, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (120, '2015-01-21 22:27:49.132', 'dei', NULL, 120, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (1, '2015-01-21 22:27:49.132', 'dei', NULL, 1, '10', 34, 2, NULL, 3, 57, 1);
INSERT INTO stocks VALUES (121, '2015-01-21 22:27:49.132', 'dei', NULL, 121, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (122, '2015-01-21 22:27:49.132', 'dei', NULL, 122, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (123, '2015-01-21 22:27:49.132', 'dei', NULL, 123, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (124, '2015-01-21 22:27:49.132', 'dei', NULL, 124, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (125, '2015-01-21 22:27:49.132', 'dei', NULL, 125, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (126, '2015-01-21 22:27:49.132', 'dei', NULL, 126, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (127, '2015-01-21 22:27:49.132', 'dei', NULL, 127, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (128, '2015-01-21 22:27:49.132', 'dei', NULL, 128, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (129, '2015-01-21 22:27:49.132', 'dei', NULL, 129, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (130, '2015-01-21 22:27:49.132', 'dei', NULL, 130, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (132, '2015-01-21 22:27:49.132', 'dei', NULL, 132, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (23, '2015-01-21 22:27:49.132', 'dei', NULL, 23, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (26, '2015-01-21 22:27:49.132', 'dei', NULL, 26, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (63, '2015-01-21 22:27:49.132', 'dei', NULL, 63, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (68, '2015-01-21 22:27:49.132', 'dei', NULL, 68, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (131, '2015-01-21 22:27:49.132', 'dei', NULL, 131, NULL, NULL, 9, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (64, '2015-01-21 22:27:49.132', 'dei', NULL, 64, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (65, '2015-01-21 22:27:49.132', 'dei', NULL, 65, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (66, '2015-01-21 22:27:49.132', 'dei', NULL, 66, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (133, '2015-01-21 22:27:49.132', 'dei', NULL, 133, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (134, '2015-01-21 22:27:49.132', 'dei', NULL, 134, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (135, '2015-01-21 22:27:49.132', 'dei', NULL, 135, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (137, '2015-01-21 22:27:49.132', 'dei', NULL, 137, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (138, '2015-01-21 22:27:49.132', 'dei', NULL, 138, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (139, '2015-01-21 22:27:49.132', 'dei', NULL, 139, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (140, '2015-01-21 22:27:49.132', 'dei', NULL, 140, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (141, '2015-01-21 22:27:49.132', 'dei', NULL, 141, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (142, '2015-01-21 22:27:49.132', 'dei', NULL, 142, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (143, '2015-01-21 22:27:49.132', 'dei', NULL, 143, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (144, '2015-01-21 22:27:49.132', 'dei', NULL, 144, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (145, '2015-01-21 22:27:49.132', 'dei', NULL, 145, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (146, '2015-01-21 22:27:49.132', 'dei', NULL, 146, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (147, '2015-01-21 22:27:49.132', 'dei', NULL, 147, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (148, '2015-01-21 22:27:49.132', 'dei', NULL, 148, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (149, '2015-01-21 22:27:49.132', 'dei', NULL, 149, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (150, '2015-01-21 22:27:49.132', 'dei', NULL, 150, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (151, '2015-01-21 22:27:49.132', 'dei', NULL, 151, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (152, '2015-01-21 22:27:49.132', 'dei', NULL, 152, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (153, '2015-01-21 22:27:49.132', 'dei', NULL, 153, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (154, '2015-01-21 22:27:49.132', 'dei', NULL, 154, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (155, '2015-01-21 22:27:49.132', 'dei', NULL, 155, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (156, '2015-01-21 22:27:49.132', 'dei', NULL, 156, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (157, '2015-01-21 22:27:49.132', 'dei', NULL, 157, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (158, '2015-01-21 22:27:49.132', 'dei', NULL, 158, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (159, '2015-01-21 22:27:49.132', 'dei', NULL, 159, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (160, '2015-01-21 22:27:49.132', 'dei', NULL, 160, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (161, '2015-01-21 22:27:49.132', 'dei', NULL, 161, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (162, '2015-01-21 22:27:49.132', 'dei', NULL, 162, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (163, '2015-01-21 22:27:49.132', 'dei', NULL, 163, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (164, '2015-01-21 22:27:49.132', 'dei', NULL, 164, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (165, '2015-01-21 22:27:49.132', 'dei', NULL, 165, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (166, '2015-01-21 22:27:49.132', 'dei', NULL, 166, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (167, '2015-01-21 22:27:49.132', 'dei', NULL, 167, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (168, '2015-01-21 22:27:49.132', 'dei', NULL, 168, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (169, '2015-01-21 22:27:49.132', 'dei', NULL, 169, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (171, '2015-01-21 22:27:49.132', 'dei', NULL, 171, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (172, '2015-01-21 22:27:49.132', 'dei', NULL, 172, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (173, '2015-01-21 22:27:49.132', 'dei', NULL, 173, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (174, '2015-01-21 22:27:49.132', 'dei', NULL, 174, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (175, '2015-01-21 22:27:49.132', 'dei', NULL, 175, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (176, '2015-01-21 22:27:49.132', 'dei', NULL, 176, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (177, '2015-01-21 22:27:49.132', 'dei', NULL, 177, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (178, '2015-01-21 22:27:49.132', 'dei', NULL, 178, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (179, '2015-01-21 22:27:49.132', 'dei', NULL, 179, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (180, '2015-01-21 22:27:49.132', 'dei', NULL, 180, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (181, '2015-01-21 22:27:49.132', 'dei', NULL, 181, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (182, '2015-01-21 22:27:49.132', 'dei', NULL, 182, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (183, '2015-01-21 22:27:49.132', 'dei', NULL, 183, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (184, '2015-01-21 22:27:49.132', 'dei', NULL, 184, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (185, '2015-01-21 22:27:49.132', 'dei', NULL, 185, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (186, '2015-01-21 22:27:49.132', 'dei', NULL, 186, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (187, '2015-01-21 22:27:49.132', 'dei', NULL, 187, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (188, '2015-01-21 22:27:49.132', 'dei', NULL, 188, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (189, '2015-01-21 22:27:49.132', 'dei', NULL, 189, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (190, '2015-01-21 22:27:49.132', 'dei', NULL, 190, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (191, '2015-01-21 22:27:49.132', 'dei', NULL, 191, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (192, '2015-01-21 22:27:49.132', 'dei', NULL, 192, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (193, '2015-01-21 22:27:49.132', 'dei', NULL, 193, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (194, '2015-01-21 22:27:49.132', 'dei', NULL, 194, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (195, '2015-01-21 22:27:49.132', 'dei', NULL, 195, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (196, '2015-01-21 22:27:49.132', 'dei', NULL, 196, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (197, '2015-01-21 22:27:49.132', 'dei', NULL, 197, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (198, '2015-01-21 22:27:49.132', 'dei', NULL, 198, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (199, '2015-01-21 22:27:49.132', 'dei', NULL, 199, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (200, '2015-01-21 22:27:49.132', 'dei', NULL, 200, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (201, '2015-01-21 22:27:49.132', 'dei', NULL, 201, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (202, '2015-01-21 22:27:49.132', 'dei', NULL, 202, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (203, '2015-01-21 22:27:49.132', 'dei', NULL, 203, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (204, '2015-01-21 22:27:49.132', 'dei', NULL, 204, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (205, '2015-01-21 22:27:49.132', 'dei', NULL, 205, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (206, '2015-01-21 22:27:49.132', 'dei', NULL, 206, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (207, '2015-01-21 22:27:49.132', 'dei', NULL, 207, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (208, '2015-01-21 22:27:49.132', 'dei', NULL, 208, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (209, '2015-01-21 22:27:49.132', 'dei', NULL, 209, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (210, '2015-01-21 22:27:49.132', 'dei', NULL, 210, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (211, '2015-01-21 22:27:49.132', 'dei', NULL, 211, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (212, '2015-01-21 22:27:49.132', 'dei', NULL, 212, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (213, '2015-01-21 22:27:49.132', 'dei', NULL, 213, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (214, '2015-01-21 22:27:49.132', 'dei', NULL, 214, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (215, '2015-01-21 22:27:49.132', 'dei', NULL, 215, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (216, '2015-01-21 22:27:49.132', 'dei', NULL, 216, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (217, '2015-01-21 22:27:49.132', 'dei', NULL, 217, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (218, '2015-01-21 22:27:49.132', 'dei', NULL, 218, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (219, '2015-01-21 22:27:49.132', 'dei', NULL, 219, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (220, '2015-01-21 22:27:49.132', 'dei', NULL, 220, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (221, '2015-01-21 22:27:49.132', 'dei', NULL, 221, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (222, '2015-01-21 22:27:49.132', 'dei', NULL, 222, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (223, '2015-01-21 22:27:49.132', 'dei', NULL, 223, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (224, '2015-01-21 22:27:49.132', 'dei', NULL, 224, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (225, '2015-01-21 22:27:49.132', 'dei', NULL, 225, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (226, '2015-01-21 22:27:49.132', 'dei', NULL, 226, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (227, '2015-01-21 22:27:49.132', 'dei', NULL, 227, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (228, '2015-01-21 22:27:49.132', 'dei', NULL, 228, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (229, '2015-01-21 22:27:49.132', 'dei', NULL, 229, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (230, '2015-01-21 22:27:49.132', 'dei', NULL, 230, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (231, '2015-01-21 22:27:49.132', 'dei', NULL, 231, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (232, '2015-01-21 22:27:49.132', 'dei', NULL, 232, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (233, '2015-01-21 22:27:49.132', 'dei', NULL, 233, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (234, '2015-01-21 22:27:49.132', 'dei', NULL, 234, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (235, '2015-01-21 22:27:49.132', 'dei', NULL, 235, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (236, '2015-01-21 22:27:49.132', 'dei', NULL, 236, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (237, '2015-01-21 22:27:49.132', 'dei', NULL, 237, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (238, '2015-01-21 22:27:49.132', 'dei', NULL, 238, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (239, '2015-01-21 22:27:49.132', 'dei', NULL, 239, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (240, '2015-01-21 22:27:49.132', 'dei', NULL, 240, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (241, '2015-01-21 22:27:49.132', 'dei', NULL, 241, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (242, '2015-01-21 22:27:49.132', 'dei', NULL, 242, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (243, '2015-01-21 22:27:49.132', 'dei', NULL, 243, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (244, '2015-01-21 22:27:49.132', 'dei', NULL, 244, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (245, '2015-01-21 22:27:49.132', 'dei', NULL, 245, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (246, '2015-01-21 22:27:49.132', 'dei', NULL, 246, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (247, '2015-01-21 22:27:49.132', 'dei', NULL, 247, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (248, '2015-01-21 22:27:49.132', 'dei', NULL, 248, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (249, '2015-01-21 22:27:49.132', 'dei', NULL, 249, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (250, '2015-01-21 22:27:49.132', 'dei', NULL, 250, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (251, '2015-01-21 22:27:49.132', 'dei', NULL, 251, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (252, '2015-01-21 22:27:49.132', 'dei', NULL, 252, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (253, '2015-01-21 22:27:49.132', 'dei', NULL, 253, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (254, '2015-01-21 22:27:49.132', 'dei', NULL, 254, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (255, '2015-01-21 22:27:49.132', 'dei', NULL, 255, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (256, '2015-01-21 22:27:49.132', 'dei', NULL, 256, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (257, '2015-01-21 22:27:49.132', 'dei', NULL, 257, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (258, '2015-01-21 22:27:49.132', 'dei', NULL, 258, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (259, '2015-01-21 22:27:49.132', 'dei', NULL, 259, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (260, '2015-01-21 22:27:49.132', 'dei', NULL, 260, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (261, '2015-01-21 22:27:49.132', 'dei', NULL, 261, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (262, '2015-01-21 22:27:49.132', 'dei', NULL, 262, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (263, '2015-01-21 22:27:49.132', 'dei', NULL, 263, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (264, '2015-01-21 22:27:49.132', 'dei', NULL, 264, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (265, '2015-01-21 22:27:49.132', 'dei', NULL, 265, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (266, '2015-01-21 22:27:49.132', 'dei', NULL, 266, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (267, '2015-01-21 22:27:49.132', 'dei', NULL, 267, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (268, '2015-01-21 22:27:49.132', 'dei', NULL, 268, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (269, '2015-01-21 22:27:49.132', 'dei', NULL, 269, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (270, '2015-01-21 22:27:49.132', 'dei', NULL, 270, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (271, '2015-01-21 22:27:49.132', 'dei', NULL, 271, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (272, '2015-01-21 22:27:49.132', 'dei', NULL, 272, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (273, '2015-01-21 22:27:49.132', 'dei', NULL, 273, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (274, '2015-01-21 22:27:49.132', 'dei', NULL, 274, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (275, '2015-01-21 22:27:49.132', 'dei', NULL, 275, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (276, '2015-01-21 22:27:49.132', 'dei', NULL, 276, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (277, '2015-01-21 22:27:49.132', 'dei', NULL, 277, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (278, '2015-01-21 22:27:49.132', 'dei', NULL, 278, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (279, '2015-01-21 22:27:49.132', 'dei', NULL, 279, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (280, '2015-01-21 22:27:49.132', 'dei', NULL, 280, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (281, '2015-01-21 22:27:49.132', 'dei', NULL, 281, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (282, '2015-01-21 22:27:49.132', 'dei', NULL, 282, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (283, '2015-01-21 22:27:49.132', 'dei', NULL, 283, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (284, '2015-01-21 22:27:49.132', 'dei', NULL, 284, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (285, '2015-01-21 22:27:49.132', 'dei', NULL, 285, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (286, '2015-01-21 22:27:49.132', 'dei', NULL, 286, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (287, '2015-01-21 22:27:49.132', 'dei', NULL, 287, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (288, '2015-01-21 22:27:49.132', 'dei', NULL, 288, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (289, '2015-01-21 22:27:49.132', 'dei', NULL, 289, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (290, '2015-01-21 22:27:49.132', 'dei', NULL, 290, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (291, '2015-01-21 22:27:49.132', 'dei', NULL, 291, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (292, '2015-01-21 22:27:49.132', 'dei', NULL, 292, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (293, '2015-01-21 22:27:49.132', 'dei', NULL, 293, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (294, '2015-01-21 22:27:49.132', 'dei', NULL, 294, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (295, '2015-01-21 22:27:49.132', 'dei', NULL, 295, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (296, '2015-01-21 22:27:49.132', 'dei', NULL, 296, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (297, '2015-01-21 22:27:49.132', 'dei', NULL, 297, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (298, '2015-01-21 22:27:49.132', 'dei', NULL, 298, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (299, '2015-01-21 22:27:49.132', 'dei', NULL, 299, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (300, '2015-01-21 22:27:49.132', 'dei', NULL, 300, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (301, '2015-01-21 22:27:49.132', 'dei', NULL, 301, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (302, '2015-01-21 22:27:49.132', 'dei', NULL, 302, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (303, '2015-01-21 22:27:49.132', 'dei', NULL, 303, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (304, '2015-01-21 22:27:49.132', 'dei', NULL, 304, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (305, '2015-01-21 22:27:49.132', 'dei', NULL, 305, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (306, '2015-01-21 22:27:49.132', 'dei', NULL, 306, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (307, '2015-01-21 22:27:49.132', 'dei', NULL, 307, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (308, '2015-01-21 22:27:49.132', 'dei', NULL, 308, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (309, '2015-01-21 22:27:49.132', 'dei', NULL, 309, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (310, '2015-01-21 22:27:49.132', 'dei', NULL, 310, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (311, '2015-01-21 22:27:49.132', 'dei', NULL, 311, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (312, '2015-01-21 22:27:49.132', 'dei', NULL, 312, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (313, '2015-01-21 22:27:49.132', 'dei', NULL, 313, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (314, '2015-01-21 22:27:49.132', 'dei', NULL, 314, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (315, '2015-01-21 22:27:49.132', 'dei', NULL, 315, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (316, '2015-01-21 22:27:49.132', 'dei', NULL, 316, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (317, '2015-01-21 22:27:49.132', 'dei', NULL, 317, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (318, '2015-01-21 22:27:49.132', 'dei', NULL, 318, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (319, '2015-01-21 22:27:49.132', 'dei', NULL, 319, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (320, '2015-01-21 22:27:49.132', 'dei', NULL, 320, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (321, '2015-01-21 22:27:49.132', 'dei', NULL, 321, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (322, '2015-01-21 22:27:49.132', 'dei', NULL, 322, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (323, '2015-01-21 22:27:49.132', 'dei', NULL, 323, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (324, '2015-01-21 22:27:49.132', 'dei', NULL, 324, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (325, '2015-01-21 22:27:49.132', 'dei', NULL, 325, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (326, '2015-01-21 22:27:49.132', 'dei', NULL, 326, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (327, '2015-01-21 22:27:49.132', 'dei', NULL, 327, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (328, '2015-01-21 22:27:49.132', 'dei', NULL, 328, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (329, '2015-01-21 22:27:49.132', 'dei', NULL, 329, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (330, '2015-01-21 22:27:49.132', 'dei', NULL, 330, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (331, '2015-01-21 22:27:49.132', 'dei', NULL, 331, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (332, '2015-01-21 22:27:49.132', 'dei', NULL, 332, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (333, '2015-01-21 22:27:49.132', 'dei', NULL, 333, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (334, '2015-01-21 22:27:49.132', 'dei', NULL, 334, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (335, '2015-01-21 22:27:49.132', 'dei', NULL, 335, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (336, '2015-01-21 22:27:49.132', 'dei', NULL, 336, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (337, '2015-01-21 22:27:49.132', 'dei', NULL, 337, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (338, '2015-01-21 22:27:49.132', 'dei', NULL, 338, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (339, '2015-01-21 22:27:49.132', 'dei', NULL, 339, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (340, '2015-01-21 22:27:49.132', 'dei', NULL, 340, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (341, '2015-01-21 22:27:49.132', 'dei', NULL, 341, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (342, '2015-01-21 22:27:49.132', 'dei', NULL, 342, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (343, '2015-01-21 22:27:49.132', 'dei', NULL, 343, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (344, '2015-01-21 22:27:49.132', 'dei', NULL, 344, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (345, '2015-01-21 22:27:49.132', 'dei', NULL, 345, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (346, '2015-01-21 22:27:49.132', 'dei', NULL, 346, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (347, '2015-01-21 22:27:49.132', 'dei', NULL, 347, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (348, '2015-01-21 22:27:49.132', 'dei', NULL, 348, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (349, '2015-01-21 22:27:49.132', 'dei', NULL, 349, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (350, '2015-01-21 22:27:49.132', 'dei', NULL, 350, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (351, '2015-01-21 22:27:49.132', 'dei', NULL, 351, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (352, '2015-01-21 22:27:49.132', 'dei', NULL, 352, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (353, '2015-01-21 22:27:49.132', 'dei', NULL, 353, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (354, '2015-01-21 22:27:49.132', 'dei', NULL, 354, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (355, '2015-01-21 22:27:49.132', 'dei', NULL, 355, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (356, '2015-01-21 22:27:49.132', 'dei', NULL, 356, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (357, '2015-01-21 22:27:49.132', 'dei', NULL, 357, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (358, '2015-01-21 22:27:49.132', 'dei', NULL, 358, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (359, '2015-01-21 22:27:49.132', 'dei', NULL, 359, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (360, '2015-01-21 22:27:49.132', 'dei', NULL, 360, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (361, '2015-01-21 22:27:49.132', 'dei', NULL, 361, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (362, '2015-01-21 22:27:49.132', 'dei', NULL, 362, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (363, '2015-01-21 22:27:49.132', 'dei', NULL, 363, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (364, '2015-01-21 22:27:49.132', 'dei', NULL, 364, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (365, '2015-01-21 22:27:49.132', 'dei', NULL, 365, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (366, '2015-01-21 22:27:49.132', 'dei', NULL, 366, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (367, '2015-01-21 22:27:49.132', 'dei', NULL, 367, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (368, '2015-01-21 22:27:49.132', 'dei', NULL, 368, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (369, '2015-01-21 22:27:49.132', 'dei', NULL, 369, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (370, '2015-01-21 22:27:49.132', 'dei', NULL, 370, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (371, '2015-01-21 22:27:49.132', 'dei', NULL, 371, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (372, '2015-01-21 22:27:49.132', 'dei', NULL, 372, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (373, '2015-01-21 22:27:49.132', 'dei', NULL, 373, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (374, '2015-01-21 22:27:49.132', 'dei', NULL, 374, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (375, '2015-01-21 22:27:49.132', 'dei', NULL, 375, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (376, '2015-01-21 22:27:49.132', 'dei', NULL, 376, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (377, '2015-01-21 22:27:49.132', 'dei', NULL, 377, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (378, '2015-01-21 22:27:49.132', 'dei', NULL, 378, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (379, '2015-01-21 22:27:49.132', 'dei', NULL, 379, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (380, '2015-01-21 22:27:49.132', 'dei', NULL, 380, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (381, '2015-01-21 22:27:49.132', 'dei', NULL, 381, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (382, '2015-01-21 22:27:49.132', 'dei', NULL, 382, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (383, '2015-01-21 22:27:49.132', 'dei', NULL, 383, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (384, '2015-01-21 22:27:49.132', 'dei', NULL, 384, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (385, '2015-01-21 22:27:49.132', 'dei', NULL, 385, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (386, '2015-01-21 22:27:49.132', 'dei', NULL, 386, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (387, '2015-01-21 22:27:49.132', 'dei', NULL, 387, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (388, '2015-01-21 22:27:49.132', 'dei', NULL, 388, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (389, '2015-01-21 22:27:49.132', 'dei', NULL, 389, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (390, '2015-01-21 22:27:49.132', 'dei', NULL, 390, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (391, '2015-01-21 22:27:49.132', 'dei', NULL, 391, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (392, '2015-01-21 22:27:49.132', 'dei', NULL, 392, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (393, '2015-01-21 22:27:49.132', 'dei', NULL, 393, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (394, '2015-01-21 22:27:49.132', 'dei', NULL, 394, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (395, '2015-01-21 22:27:49.132', 'dei', NULL, 395, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (396, '2015-01-21 22:27:49.132', 'dei', NULL, 396, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (397, '2015-01-21 22:27:49.132', 'dei', NULL, 397, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (398, '2015-01-21 22:27:49.132', 'dei', NULL, 398, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (399, '2015-01-21 22:27:49.132', 'dei', NULL, 399, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (400, '2015-01-21 22:27:49.132', 'dei', NULL, 400, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (401, '2015-01-21 22:27:49.132', 'dei', NULL, 401, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (402, '2015-01-21 22:27:49.132', 'dei', NULL, 402, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (403, '2015-01-21 22:27:49.132', 'dei', NULL, 403, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (404, '2015-01-21 22:27:49.132', 'dei', NULL, 404, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (405, '2015-01-21 22:27:49.132', 'dei', NULL, 405, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (406, '2015-01-21 22:27:49.132', 'dei', NULL, 406, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (407, '2015-01-21 22:27:49.132', 'dei', NULL, 407, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (408, '2015-01-21 22:27:49.132', 'dei', NULL, 408, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (409, '2015-01-21 22:27:49.132', 'dei', NULL, 409, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (410, '2015-01-21 22:27:49.132', 'dei', NULL, 410, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (411, '2015-01-21 22:27:49.132', 'dei', NULL, 411, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (412, '2015-01-21 22:27:49.132', 'dei', NULL, 412, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (413, '2015-01-21 22:27:49.132', 'dei', NULL, 413, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (414, '2015-01-21 22:27:49.132', 'dei', NULL, 414, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (415, '2015-01-21 22:27:49.132', 'dei', NULL, 415, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (416, '2015-01-21 22:27:49.132', 'dei', NULL, 416, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (417, '2015-01-21 22:27:49.132', 'dei', NULL, 417, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (418, '2015-01-21 22:27:49.132', 'dei', NULL, 418, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (419, '2015-01-21 22:27:49.132', 'dei', NULL, 419, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (420, '2015-01-21 22:27:49.132', 'dei', NULL, 420, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (421, '2015-01-21 22:27:49.132', 'dei', NULL, 421, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (422, '2015-01-21 22:27:49.132', 'dei', NULL, 422, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (423, '2015-01-21 22:27:49.132', 'dei', NULL, 423, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (424, '2015-01-21 22:27:49.132', 'dei', NULL, 424, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (425, '2015-01-21 22:27:49.132', 'dei', NULL, 425, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (426, '2015-01-21 22:27:49.132', 'dei', NULL, 426, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (427, '2015-01-21 22:27:49.132', 'dei', NULL, 427, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (428, '2015-01-21 22:27:49.132', 'dei', NULL, 428, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (429, '2015-01-21 22:27:49.132', 'dei', NULL, 429, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (430, '2015-01-21 22:27:49.132', 'dei', NULL, 430, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (431, '2015-01-21 22:27:49.132', 'dei', NULL, 431, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (432, '2015-01-21 22:27:49.132', 'dei', NULL, 432, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (433, '2015-01-21 22:27:49.132', 'dei', NULL, 433, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (434, '2015-01-21 22:27:49.132', 'dei', NULL, 434, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (435, '2015-01-21 22:27:49.132', 'dei', NULL, 435, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (436, '2015-01-21 22:27:49.132', 'dei', NULL, 436, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (437, '2015-01-21 22:27:49.132', 'dei', NULL, 437, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (438, '2015-01-21 22:27:49.132', 'dei', NULL, 438, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (439, '2015-01-21 22:27:49.132', 'dei', NULL, 439, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (440, '2015-01-21 22:27:49.132', 'dei', NULL, 440, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (441, '2015-01-21 22:27:49.132', 'dei', NULL, 441, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (442, '2015-01-21 22:27:49.132', 'dei', NULL, 442, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (443, '2015-01-21 22:27:49.132', 'dei', NULL, 443, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (444, '2015-01-21 22:27:49.132', 'dei', NULL, 444, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (445, '2015-01-21 22:27:49.132', 'dei', NULL, 445, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (446, '2015-01-21 22:27:49.132', 'dei', NULL, 446, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (447, '2015-01-21 22:27:49.132', 'dei', NULL, 447, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (448, '2015-01-21 22:27:49.132', 'dei', NULL, 448, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (449, '2015-01-21 22:27:49.132', 'dei', NULL, 449, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (450, '2015-01-21 22:27:49.132', 'dei', NULL, 450, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (451, '2015-01-21 22:27:49.132', 'dei', NULL, 451, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (452, '2015-01-21 22:27:49.132', 'dei', NULL, 452, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (453, '2015-01-21 22:27:49.132', 'dei', NULL, 453, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (454, '2015-01-21 22:27:49.132', 'dei', NULL, 454, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (455, '2015-01-21 22:27:49.132', 'dei', NULL, 455, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (456, '2015-01-21 22:27:49.132', 'dei', NULL, 456, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (457, '2015-01-21 22:27:49.132', 'dei', NULL, 457, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (458, '2015-01-21 22:27:49.132', 'dei', NULL, 458, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (459, '2015-01-21 22:27:49.132', 'dei', NULL, 459, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (460, '2015-01-21 22:27:49.132', 'dei', NULL, 460, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (461, '2015-01-21 22:27:49.132', 'dei', NULL, 461, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (462, '2015-01-21 22:27:49.132', 'dei', NULL, 462, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (463, '2015-01-21 22:27:49.132', 'dei', NULL, 463, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (464, '2015-01-21 22:27:49.132', 'dei', NULL, 464, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (465, '2015-01-21 22:27:49.132', 'dei', NULL, 465, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (466, '2015-01-21 22:27:49.132', 'dei', NULL, 466, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (467, '2015-01-21 22:27:49.132', 'dei', NULL, 467, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (468, '2015-01-21 22:27:49.132', 'dei', NULL, 468, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (469, '2015-01-21 22:27:49.132', 'dei', NULL, 469, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (470, '2015-01-21 22:27:49.132', 'dei', NULL, 470, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (471, '2015-01-21 22:27:49.132', 'dei', NULL, 471, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (472, '2015-01-21 22:27:49.132', 'dei', NULL, 472, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (473, '2015-01-21 22:27:49.132', 'dei', NULL, 473, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (474, '2015-01-21 22:27:49.132', 'dei', NULL, 474, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (475, '2015-01-21 22:27:49.132', 'dei', NULL, 475, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (476, '2015-01-21 22:27:49.132', 'dei', NULL, 476, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (477, '2015-01-21 22:27:49.132', 'dei', NULL, 477, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (478, '2015-01-21 22:27:49.132', 'dei', NULL, 478, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (479, '2015-01-21 22:27:49.132', 'dei', NULL, 479, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (480, '2015-01-21 22:27:49.132', 'dei', NULL, 480, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (486, '2015-01-21 22:27:49.132', 'dei', NULL, 486, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (487, '2015-01-21 22:27:49.132', 'dei', NULL, 487, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (488, '2015-01-21 22:27:49.132', 'dei', NULL, 488, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (489, '2015-01-21 22:27:49.132', 'dei', NULL, 489, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (490, '2015-01-21 22:27:49.132', 'dei', NULL, 490, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (491, '2015-01-21 22:27:49.132', 'dei', NULL, 491, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (492, '2015-01-21 22:27:49.132', 'dei', NULL, 492, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (493, '2015-01-21 22:27:49.132', 'dei', NULL, 493, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (494, '2015-01-21 22:27:49.132', 'dei', NULL, 494, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (495, '2015-01-21 22:27:49.132', 'dei', NULL, 495, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (496, '2015-01-21 22:27:49.132', 'dei', NULL, 496, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (497, '2015-01-21 22:27:49.132', 'dei', NULL, 497, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (498, '2015-01-21 22:27:49.132', 'dei', NULL, 498, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (499, '2015-01-21 22:27:49.132', 'dei', NULL, 499, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (500, '2015-01-21 22:27:49.132', 'dei', NULL, 500, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (501, '2015-01-21 22:27:49.132', 'dei', NULL, 501, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (502, '2015-01-21 22:27:49.132', 'dei', NULL, 502, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (503, '2015-01-21 22:27:49.132', 'dei', NULL, 503, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (504, '2015-01-21 22:27:49.132', 'dei', NULL, 504, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (505, '2015-01-21 22:27:49.132', 'dei', NULL, 505, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (506, '2015-01-21 22:27:49.132', 'dei', NULL, 506, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (507, '2015-01-21 22:27:49.132', 'dei', NULL, 507, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (508, '2015-01-21 22:27:49.132', 'dei', NULL, 508, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (509, '2015-01-21 22:27:49.132', 'dei', NULL, 509, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (510, '2015-01-21 22:27:49.132', 'dei', NULL, 510, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (511, '2015-01-21 22:27:49.132', 'dei', NULL, 511, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (512, '2015-01-21 22:27:49.132', 'dei', NULL, 512, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (513, '2015-01-21 22:27:49.132', 'dei', NULL, 513, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (514, '2015-01-21 22:27:49.132', 'dei', NULL, 514, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (515, '2015-01-21 22:27:49.132', 'dei', NULL, 515, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (516, '2015-01-21 22:27:49.132', 'dei', NULL, 516, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (517, '2015-01-21 22:27:49.132', 'dei', NULL, 517, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (518, '2015-01-21 22:27:49.132', 'dei', NULL, 518, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (519, '2015-01-21 22:27:49.132', 'dei', NULL, 519, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (520, '2015-01-21 22:27:49.132', 'dei', NULL, 520, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (521, '2015-01-21 22:27:49.132', 'dei', NULL, 521, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (522, '2015-01-21 22:27:49.132', 'dei', NULL, 522, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (523, '2015-01-21 22:27:49.132', 'dei', NULL, 523, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (524, '2015-01-21 22:27:49.132', 'dei', NULL, 524, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (525, '2015-01-21 22:27:49.132', 'dei', NULL, 525, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (526, '2015-01-21 22:27:49.132', 'dei', NULL, 526, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (527, '2015-01-21 22:27:49.132', 'dei', NULL, 527, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (528, '2015-01-21 22:27:49.132', 'dei', NULL, 528, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (529, '2015-01-21 22:27:49.132', 'dei', NULL, 529, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (530, '2015-01-21 22:27:49.132', 'dei', NULL, 530, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (531, '2015-01-21 22:27:49.132', 'dei', NULL, 531, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (532, '2015-01-21 22:27:49.132', 'dei', NULL, 532, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (533, '2015-01-21 22:27:49.132', 'dei', NULL, 533, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (534, '2015-01-21 22:27:49.132', 'dei', NULL, 534, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (535, '2015-01-21 22:27:49.132', 'dei', NULL, 535, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (536, '2015-01-21 22:27:49.132', 'dei', NULL, 536, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (537, '2015-01-21 22:27:49.132', 'dei', NULL, 537, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (538, '2015-01-21 22:27:49.132', 'dei', NULL, 538, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (539, '2015-01-21 22:27:49.132', 'dei', NULL, 539, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (540, '2015-01-21 22:27:49.132', 'dei', NULL, 540, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (541, '2015-01-21 22:27:49.132', 'dei', NULL, 541, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (542, '2015-01-21 22:27:49.132', 'dei', NULL, 542, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (543, '2015-01-21 22:27:49.132', 'dei', NULL, 543, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (544, '2015-01-21 22:27:49.132', 'dei', NULL, 544, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (545, '2015-01-21 22:27:49.132', 'dei', NULL, 545, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (546, '2015-01-21 22:27:49.132', 'dei', NULL, 546, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (547, '2015-01-21 22:27:49.132', 'dei', NULL, 547, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (548, '2015-01-21 22:27:49.132', 'dei', NULL, 548, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (549, '2015-01-21 22:27:49.132', 'dei', NULL, 549, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (550, '2015-01-21 22:27:49.132', 'dei', NULL, 550, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (551, '2015-01-21 22:27:49.132', 'dei', NULL, 551, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (552, '2015-01-21 22:27:49.132', 'dei', NULL, 552, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (553, '2015-01-21 22:27:49.132', 'dei', NULL, 553, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (554, '2015-01-21 22:27:49.132', 'dei', NULL, 554, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (555, '2015-01-21 22:27:49.132', 'dei', NULL, 555, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (556, '2015-01-21 22:27:49.132', 'dei', NULL, 556, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (557, '2015-01-21 22:27:49.132', 'dei', NULL, 557, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (558, '2015-01-21 22:27:49.132', 'dei', NULL, 558, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (559, '2015-01-21 22:27:49.132', 'dei', NULL, 559, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (560, '2015-01-21 22:27:49.132', 'dei', NULL, 560, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (561, '2015-01-21 22:27:49.132', 'dei', NULL, 561, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (562, '2015-01-21 22:27:49.132', 'dei', NULL, 562, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (563, '2015-01-21 22:27:49.132', 'dei', NULL, 563, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (564, '2015-01-21 22:27:49.132', 'dei', NULL, 564, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (565, '2015-01-21 22:27:49.132', 'dei', NULL, 565, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (566, '2015-01-21 22:27:49.132', 'dei', NULL, 566, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (567, '2015-01-21 22:27:49.132', 'dei', NULL, 567, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (568, '2015-01-21 22:27:49.132', 'dei', NULL, 568, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (569, '2015-01-21 22:27:49.132', 'dei', NULL, 569, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (570, '2015-01-21 22:27:49.132', 'dei', NULL, 570, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (571, '2015-01-21 22:27:49.132', 'dei', NULL, 571, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (572, '2015-01-21 22:27:49.132', 'dei', NULL, 572, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (573, '2015-01-21 22:27:49.132', 'dei', NULL, 573, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (574, '2015-01-21 22:27:49.132', 'dei', NULL, 574, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (575, '2015-01-21 22:27:49.132', 'dei', NULL, 575, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (576, '2015-01-21 22:27:49.132', 'dei', NULL, 576, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (582, '2015-01-21 22:27:49.132', 'dei', NULL, 582, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (581, '2015-01-21 22:27:49.132', 'dei', NULL, 581, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (580, '2015-01-21 22:27:49.132', 'dei', NULL, 580, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (579, '2015-01-21 22:27:49.132', 'dei', NULL, 579, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (578, '2015-01-21 22:27:49.132', 'dei', NULL, 578, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (577, '2015-01-21 22:27:49.132', 'dei', NULL, 577, NULL, NULL, 2, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (67, '2015-01-21 22:27:49.132', 'dei', NULL, 67, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (72, '2015-01-21 22:27:49.132', 'dei', NULL, 72, NULL, NULL, 7, NULL, NULL, NULL, 1);
INSERT INTO stocks VALUES (583, '2015-02-02 01:07:11.481', 'dei', 'bk01', 583, '500ml', NULL, 1, NULL, 9, 57, 1);


--
-- Data for Name: supplier_pics; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: supplier_pics_suplier_pic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('supplier_pics_suplier_pic_id_seq', 1, false);


--
-- Data for Name: supplier_stock_groups; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: supplier_stock_groups_supplier_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('supplier_stock_groups_supplier_stock_id_seq', 1, false);


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO suppliers VALUES (1, '2015-02-17 07:05:59.126', 'dei', 'SUP20150101', 'CV BATU ALAM', 'Jl. Nangka No. 3 Jakarta Selatan', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO suppliers VALUES (2, '2015-02-17 07:06:55.501', 'dei', 'SUP20150102', 'PT BIMA KOMPUTER', 'Jl. TP. Polem No. 11 Peunayong', NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('suppliers_supplier_id_seq', 2, true);


--
-- Data for Name: user_role_maps; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO user_role_maps VALUES (1, '2015-01-12 07:45:09.797', 'dei', 1, 1);
INSERT INTO user_role_maps VALUES (2, '2015-01-18 09:19:47.728', 'postgres', 2, 1);


--
-- Name: user_role_maps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_role_maps_id_seq', 2, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO users VALUES (3, '2015-01-20 22:30:54.425', 'dei', 'NIK12', 'budi.santoso', 'Budi Santoso', 'budi.santoso@gmail.com', '1', 2, 'Marketing');
INSERT INTO users VALUES (9, '2015-01-25 20:48:49.783', 'dei', '1111111111', 'operation', 'Bruce Operation Willis', 'bruce.operation.willis@gmail.com', '1', 5, 'Operation');
INSERT INTO users VALUES (8, '2015-01-23 21:09:33.432', 'dei', '19201292', 'maria', 'Maryam', 'maria@gmail.com', '1', 6, 'Marketing');
INSERT INTO users VALUES (1, '2015-01-04 17:21:15.788', 'postgres', NULL, 'dei', 'Ridei Karim', 'ridei@live.com', '1', 1, NULL);
INSERT INTO users VALUES (2, '2015-01-17 05:25:35.303', 'dei', NULL, 'admin', 'Administrator', 'admin@localhost', '1', 3, NULL);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_user_id_seq', 9, true);


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO venues VALUES (1, '2015-01-17 21:36:22.164', 'postgres', 'Jakarta International Expo', NULL, NULL, NULL, NULL, NULL);
INSERT INTO venues VALUES (2, '2015-01-17 21:36:33.076', 'postgres', 'Jakarta Convention Centre', NULL, NULL, NULL, NULL, NULL);
INSERT INTO venues VALUES (3, '2015-01-17 21:36:46.691', 'postgres', 'Jakarta Design Center', NULL, NULL, NULL, NULL, NULL);


--
-- Name: venues_venue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('venues_venue_id_seq', 3, true);


--
-- Data for Name: warehouses; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('warehouses_warehouse_id_seq', 1, false);


--
-- Name: customer_pics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customer_pics
    ADD CONSTRAINT customer_pics_pkey PRIMARY KEY (customer_pic_id);


--
-- Name: customers_customer_code_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_customer_code_key UNIQUE (customer_code);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- Name: loss_factors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY loss_factors
    ADD CONSTRAINT loss_factors_pkey PRIMARY KEY (loss_factor_id);


--
-- Name: master_barang_mbar_kode_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_barang
    ADD CONSTRAINT master_barang_mbar_kode_key UNIQUE (mbar_kode);


--
-- Name: master_barang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_barang
    ADD CONSTRAINT master_barang_pkey PRIMARY KEY (mbar_id);


--
-- Name: master_gudang_mg_nama_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_gudang
    ADD CONSTRAINT master_gudang_mg_nama_key UNIQUE (mg_nama);


--
-- Name: master_gudang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_gudang
    ADD CONSTRAINT master_gudang_pkey PRIMARY KEY (mg_id);


--
-- Name: master_jenis_barang_mjb_nama_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_jenis_barang
    ADD CONSTRAINT master_jenis_barang_mjb_nama_key UNIQUE (mjb_nama);


--
-- Name: master_jenis_barang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_jenis_barang
    ADD CONSTRAINT master_jenis_barang_pkey PRIMARY KEY (mjb_id);


--
-- Name: master_kelompok_barang_mkb_nama_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_kelompok_barang
    ADD CONSTRAINT master_kelompok_barang_mkb_nama_key UNIQUE (mkb_nama);


--
-- Name: master_kelompok_barang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_kelompok_barang
    ADD CONSTRAINT master_kelompok_barang_pkey PRIMARY KEY (mkb_id);


--
-- Name: master_merk_barang_mmb_nama_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_merk_barang
    ADD CONSTRAINT master_merk_barang_mmb_nama_key UNIQUE (mmb_nama);


--
-- Name: master_merk_barang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_merk_barang
    ADD CONSTRAINT master_merk_barang_pkey PRIMARY KEY (mmb_id);


--
-- Name: master_nama_barang_mnb_kode_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_nama_barang
    ADD CONSTRAINT master_nama_barang_mnb_kode_key UNIQUE (mnb_kode);


--
-- Name: master_nama_barang_mnb_nama_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_nama_barang
    ADD CONSTRAINT master_nama_barang_mnb_nama_key UNIQUE (mnb_nama);


--
-- Name: master_nama_barang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_nama_barang
    ADD CONSTRAINT master_nama_barang_pkey PRIMARY KEY (mnb_id);


--
-- Name: master_satuan_barang_msb_nama_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_satuan_barang
    ADD CONSTRAINT master_satuan_barang_msb_nama_key UNIQUE (msb_nama);


--
-- Name: master_satuan_barang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_satuan_barang
    ADD CONSTRAINT master_satuan_barang_pkey PRIMARY KEY (msb_id);


--
-- Name: master_tipe_barang_mtb_nama_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_tipe_barang
    ADD CONSTRAINT master_tipe_barang_mtb_nama_key UNIQUE (mtb_nama);


--
-- Name: master_tipe_barang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY master_tipe_barang
    ADD CONSTRAINT master_tipe_barang_pkey PRIMARY KEY (mtb_id);


--
-- Name: mcs_headers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mcs_headers
    ADD CONSTRAINT mcs_headers_pkey PRIMARY KEY (mcs_id);


--
-- Name: mcs_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mcs_items
    ADD CONSTRAINT mcs_items_pkey PRIMARY KEY (mcs_item_id);


--
-- Name: mcs_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mcs_status
    ADD CONSTRAINT mcs_status_pkey PRIMARY KEY (mcs_status_id);


--
-- Name: menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (menu_id);


--
-- Name: multi_company_default_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY multi_company_default
    ADD CONSTRAINT multi_company_default_pkey PRIMARY KEY (id);


--
-- Name: pkrml; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_menu_maps
    ADD CONSTRAINT pkrml UNIQUE (role_id, menu_id);


--
-- Name: process_transition_group_rel_tid_rid_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY process_transition_group_rel
    ADD CONSTRAINT process_transition_group_rel_tid_rid_key UNIQUE (tid, rid);


--
-- Name: quotation_file_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY quotation_files
    ADD CONSTRAINT quotation_file_pk PRIMARY KEY (quotation_files_id);


--
-- Name: quotation_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY quotation_products
    ADD CONSTRAINT quotation_products_pkey PRIMARY KEY (quotation_product_id);


--
-- Name: quotation_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY quotation_status
    ADD CONSTRAINT quotation_status_pkey PRIMARY KEY (quotation_status_id);


--
-- Name: quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (quotation_id);


--
-- Name: rmm_unq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_menu_maps
    ADD CONSTRAINT rmm_unq UNIQUE (role_id, menu_id);


--
-- Name: role_menu_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_menu_maps
    ADD CONSTRAINT role_menu_maps_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: stock_brands_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stock_brands
    ADD CONSTRAINT stock_brands_pkey PRIMARY KEY (brand_id);


--
-- Name: stock_group_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stock_groups
    ADD CONSTRAINT stock_group_pk PRIMARY KEY (group_id);


--
-- Name: stock_name_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stock_names
    ADD CONSTRAINT stock_name_pkey PRIMARY KEY (stock_name_id);


--
-- Name: stock_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stocks
    ADD CONSTRAINT stock_pkey PRIMARY KEY (stock_id);


--
-- Name: stock_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stock_types
    ADD CONSTRAINT stock_types_pkey PRIMARY KEY (type_id);


--
-- Name: stock_units_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stock_units
    ADD CONSTRAINT stock_units_pkey PRIMARY KEY (stock_unit_id);


--
-- Name: supgroupunique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY supplier_stock_groups
    ADD CONSTRAINT supgroupunique UNIQUE (supplier_id, group_id);


--
-- Name: supplier_pics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY supplier_pics
    ADD CONSTRAINT supplier_pics_pkey PRIMARY KEY (suplier_pic_id);


--
-- Name: supplier_stock_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY supplier_stock_groups
    ADD CONSTRAINT supplier_stock_groups_pkey PRIMARY KEY (supplier_stock_id);


--
-- Name: suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- Name: transaction_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mcs_transaction_types
    ADD CONSTRAINT transaction_types_pkey PRIMARY KEY (transaction_type_id);


--
-- Name: user_role_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_role_maps
    ADD CONSTRAINT user_role_maps_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users_register_number_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_register_number_key UNIQUE (register_number);


--
-- Name: users_userid_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_userid_key UNIQUE (userid);


--
-- Name: venues_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (venue_id);


--
-- Name: warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);


--
-- Name: fki_mcs_i_h_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_mcs_i_h_fk ON mcs_items USING btree (mcs_id);


--
-- Name: fki_mcs_item_stock; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_mcs_item_stock ON mcs_items USING btree (stock_id);


--
-- Name: fki_mcs_quotation; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_mcs_quotation ON mcs_headers USING btree (quotation_id);


--
-- Name: fki_mcs_status; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_mcs_status ON mcs_headers USING btree (mcs_status_id);


--
-- Name: fki_mttfk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_mttfk ON mcs_headers USING btree (transaction_type_id);


--
-- Name: fki_qp_q_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_qp_q_fk ON quotation_products USING btree (quotation_id);


--
-- Name: fki_quotation_loss_factor; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_quotation_loss_factor ON quotations USING btree (loss_factor_id);


--
-- Name: fki_quotation_status; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_quotation_status ON quotations USING btree (status);


--
-- Name: fki_quotations_file_to_quotations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_quotations_file_to_quotations ON quotation_files USING btree (quotation_id);


--
-- Name: fki_sgr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_sgr ON stocks USING btree (group_id);


--
-- Name: fki_snr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_snr ON stocks USING btree (stock_name_id);


--
-- Name: process_transition_group_rel_rid_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX process_transition_group_rel_rid_index ON process_transition_group_rel USING btree (rid);


--
-- Name: process_transition_group_rel_tid_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX process_transition_group_rel_tid_index ON process_transition_group_rel USING btree (tid);


--
-- Name: customer_pic_maps; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY customer_pics
    ADD CONSTRAINT customer_pic_maps FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mcs_i_h_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mcs_items
    ADD CONSTRAINT mcs_i_h_fk FOREIGN KEY (mcs_id) REFERENCES mcs_headers(mcs_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mcs_item_stock; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mcs_items
    ADD CONSTRAINT mcs_item_stock FOREIGN KEY (stock_id) REFERENCES stocks(stock_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: mcs_quotation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mcs_headers
    ADD CONSTRAINT mcs_quotation FOREIGN KEY (quotation_id) REFERENCES quotations(quotation_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: mcs_status; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mcs_headers
    ADD CONSTRAINT mcs_status FOREIGN KEY (mcs_status_id) REFERENCES mcs_status(mcs_status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: mttfk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mcs_headers
    ADD CONSTRAINT mttfk FOREIGN KEY (transaction_type_id) REFERENCES mcs_transaction_types(transaction_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: quotation_loss_factor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotations
    ADD CONSTRAINT quotation_loss_factor FOREIGN KEY (loss_factor_id) REFERENCES loss_factors(loss_factor_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: quotation_status; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotations
    ADD CONSTRAINT quotation_status FOREIGN KEY (status) REFERENCES quotation_status(quotation_status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sgr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks
    ADD CONSTRAINT sgr FOREIGN KEY (group_id) REFERENCES stock_groups(group_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: snr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks
    ADD CONSTRAINT snr FOREIGN KEY (stock_name_id) REFERENCES stock_names(stock_name_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: supplier_pic_maps; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY supplier_pics
    ADD CONSTRAINT supplier_pic_maps FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

