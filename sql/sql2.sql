--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: customer_pics; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.customer_pics OWNER TO postgres;

--
-- Name: customer_pics_customer_pic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE customer_pics_customer_pic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_pics_customer_pic_id_seq OWNER TO postgres;

--
-- Name: customer_pics_customer_pic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE customer_pics_customer_pic_id_seq OWNED BY customer_pics.customer_pic_id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE customers_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customer_id_seq OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE customers_customer_id_seq OWNED BY customers.customer_id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE events_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_event_id_seq OWNER TO postgres;

--
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE events_event_id_seq OWNED BY events.event_id;


--
-- Name: menus; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.menus OWNER TO postgres;

--
-- Name: role_menu_maps; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role_menu_maps (
    id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    role_id integer,
    menu_id integer
);


ALTER TABLE public.role_menu_maps OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: head_menu; Type: VIEW; Schema: public; Owner: dei
--

CREATE VIEW head_menu AS
    SELECT DISTINCT a.user_id, d.menu_head, d.menu_name, d.module, d.action FROM ((users a JOIN role_menu_maps c USING (role_id)) JOIN menus d USING (menu_id));


ALTER TABLE public.head_menu OWNER TO dei;

--
-- Name: loss_factors; Type: TABLE; Schema: public; Owner: dei; Tablespace: 
--

CREATE TABLE loss_factors (
    loss_factor_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    loss_factor_name character varying,
    description character varying
);


ALTER TABLE public.loss_factors OWNER TO dei;

--
-- Name: loss_factors_loss_factor_id_seq; Type: SEQUENCE; Schema: public; Owner: dei
--

CREATE SEQUENCE loss_factors_loss_factor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loss_factors_loss_factor_id_seq OWNER TO dei;

--
-- Name: loss_factors_loss_factor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dei
--

ALTER SEQUENCE loss_factors_loss_factor_id_seq OWNED BY loss_factors.loss_factor_id;


--
-- Name: menu_head; Type: VIEW; Schema: public; Owner: dei
--

CREATE VIEW menu_head AS
    SELECT DISTINCT a.user_id, d.menu_head, CASE WHEN ((COALESCE(d.icon, ''::character varying))::text = ''::text) THEN 'icon-tasks'::character varying ELSE d.icon END AS icon FROM ((users a JOIN role_menu_maps c USING (role_id)) JOIN menus d USING (menu_id));


ALTER TABLE public.menu_head OWNER TO dei;

--
-- Name: menus_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE menus_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menus_menu_id_seq OWNER TO postgres;

--
-- Name: menus_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE menus_menu_id_seq OWNED BY menus.menu_id;


--
-- Name: quotation_files; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quotation_files (
    quotation_files_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    quotation_id integer,
    file_name character varying,
    description character varying
);


ALTER TABLE public.quotation_files OWNER TO postgres;

--
-- Name: quotation_files_quotation_files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quotation_files_quotation_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotation_files_quotation_files_id_seq OWNER TO postgres;

--
-- Name: quotation_files_quotation_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quotation_files_quotation_files_id_seq OWNED BY quotation_files.quotation_files_id;


--
-- Name: quotations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quotations (
    quotation_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    quotation_number character varying,
    status integer DEFAULT 0,
    revision character varying,
    sales_number character varying,
    quotation_date date,
    contract_number character varying,
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


ALTER TABLE public.quotations OWNER TO postgres;

--
-- Name: quotation_list1; Type: VIEW; Schema: public; Owner: dei
--

CREATE VIEW quotation_list1 AS
    SELECT a.quotation_id, a.quotation_number, a.revision, a.show_day_from, a.show_day_to, b.customer_name, c.event_name, a.status FROM ((quotations a LEFT JOIN customers b USING (customer_id)) LEFT JOIN events c USING (event_id));


ALTER TABLE public.quotation_list1 OWNER TO dei;

--
-- Name: quotation_products; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.quotation_products OWNER TO postgres;

--
-- Name: quotation_products_quotation_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quotation_products_quotation_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotation_products_quotation_product_id_seq OWNER TO postgres;

--
-- Name: quotation_products_quotation_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quotation_products_quotation_product_id_seq OWNED BY quotation_products.quotation_product_id;


--
-- Name: quotation_status; Type: TABLE; Schema: public; Owner: dei; Tablespace: 
--

CREATE TABLE quotation_status (
    quotation_status_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    status_name character varying
);


ALTER TABLE public.quotation_status OWNER TO dei;

--
-- Name: quotation_status_quotation_status_id_seq; Type: SEQUENCE; Schema: public; Owner: dei
--

CREATE SEQUENCE quotation_status_quotation_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotation_status_quotation_status_id_seq OWNER TO dei;

--
-- Name: quotation_status_quotation_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dei
--

ALTER SEQUENCE quotation_status_quotation_status_id_seq OWNED BY quotation_status.quotation_status_id;


--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quotations_quotation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotations_quotation_id_seq OWNER TO postgres;

--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quotations_quotation_id_seq OWNED BY quotations.quotation_id;


--
-- Name: role_menu_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_menu_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_menu_maps_id_seq OWNER TO postgres;

--
-- Name: role_menu_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_menu_maps_id_seq OWNED BY role_menu_maps.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    role_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    role_name character varying
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE roles_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE roles_role_id_seq OWNED BY roles.role_id;


--
-- Name: supplier_pics; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.supplier_pics OWNER TO postgres;

--
-- Name: supplier_pics_suplier_pic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE supplier_pics_suplier_pic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supplier_pics_suplier_pic_id_seq OWNER TO postgres;

--
-- Name: supplier_pics_suplier_pic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE supplier_pics_suplier_pic_id_seq OWNED BY supplier_pics.suplier_pic_id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE suppliers_supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_supplier_id_seq OWNER TO postgres;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE suppliers_supplier_id_seq OWNED BY suppliers.supplier_id;


--
-- Name: user_role_maps; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_role_maps (
    id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    user_id integer,
    role_id integer
);


ALTER TABLE public.user_role_maps OWNER TO postgres;

--
-- Name: user_role_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_role_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_maps_id_seq OWNER TO postgres;

--
-- Name: user_role_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_role_maps_id_seq OWNED BY user_role_maps.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: v_quotation; Type: VIEW; Schema: public; Owner: dei
--

CREATE VIEW v_quotation AS
    SELECT CASE WHEN (quotations.official = true) THEN 'checked'::text ELSE ''::text END AS official2, quotations.quotation_id, quotations.time_stamp, quotations.created_by, quotations.quotation_number, quotations.status, quotations.revision, quotations.sales_number, quotations.quotation_date, quotations.contract_number, quotations.term_of_payment, quotations.construction_type, quotations.size, quotations.official, quotations.event_id, quotations.venue_id, quotations.show_day_from, quotations.show_day_to, quotations.move_in_from_date, quotations.move_in_from_time, quotations.move_in_to_date, quotations.move_in_to_time, quotations.move_out_from_date, quotations.move_out_from_time, quotations.move_out_to_date, quotations.move_out_to_time, quotations.customer_id, quotations.customer_contacts, quotations.project_executive, quotations.project_supervisor, quotations.designer, quotations.notes, quotations.fee, quotations.discount, b.full_address, b.phone, b.customer_contact_1, c.amount AS gross_total, ((c.amount + (COALESCE(quotations.fee, (0)::numeric) * ((-1))::numeric)) + (COALESCE(quotations.discount, (0)::numeric) * ((-1))::numeric)) AS nett_total FROM ((quotations JOIN customers b USING (customer_id)) JOIN (SELECT quotation_products.quotation_id, sum(quotation_products.amount) AS amount FROM quotation_products GROUP BY quotation_products.quotation_id) c USING (quotation_id));


ALTER TABLE public.v_quotation OWNER TO dei;

--
-- Name: venues; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.venues OWNER TO postgres;

--
-- Name: venues_venue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE venues_venue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venues_venue_id_seq OWNER TO postgres;

--
-- Name: venues_venue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE venues_venue_id_seq OWNED BY venues.venue_id;


--
-- Name: warehouses; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.warehouses OWNER TO postgres;

--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE warehouses_warehouse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warehouses_warehouse_id_seq OWNER TO postgres;

--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE warehouses_warehouse_id_seq OWNED BY warehouses.warehouse_id;


--
-- Name: customer_pic_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_pics ALTER COLUMN customer_pic_id SET DEFAULT nextval('customer_pics_customer_pic_id_seq'::regclass);


--
-- Name: customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customers ALTER COLUMN customer_id SET DEFAULT nextval('customers_customer_id_seq'::regclass);


--
-- Name: event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events ALTER COLUMN event_id SET DEFAULT nextval('events_event_id_seq'::regclass);


--
-- Name: loss_factor_id; Type: DEFAULT; Schema: public; Owner: dei
--

ALTER TABLE ONLY loss_factors ALTER COLUMN loss_factor_id SET DEFAULT nextval('loss_factors_loss_factor_id_seq'::regclass);


--
-- Name: menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menus ALTER COLUMN menu_id SET DEFAULT nextval('menus_menu_id_seq'::regclass);


--
-- Name: quotation_files_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotation_files ALTER COLUMN quotation_files_id SET DEFAULT nextval('quotation_files_quotation_files_id_seq'::regclass);


--
-- Name: quotation_product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotation_products ALTER COLUMN quotation_product_id SET DEFAULT nextval('quotation_products_quotation_product_id_seq'::regclass);


--
-- Name: quotation_status_id; Type: DEFAULT; Schema: public; Owner: dei
--

ALTER TABLE ONLY quotation_status ALTER COLUMN quotation_status_id SET DEFAULT nextval('quotation_status_quotation_status_id_seq'::regclass);


--
-- Name: quotation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotations ALTER COLUMN quotation_id SET DEFAULT nextval('quotations_quotation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_menu_maps ALTER COLUMN id SET DEFAULT nextval('role_menu_maps_id_seq'::regclass);


--
-- Name: role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles ALTER COLUMN role_id SET DEFAULT nextval('roles_role_id_seq'::regclass);


--
-- Name: suplier_pic_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier_pics ALTER COLUMN suplier_pic_id SET DEFAULT nextval('supplier_pics_suplier_pic_id_seq'::regclass);


--
-- Name: supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('suppliers_supplier_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role_maps ALTER COLUMN id SET DEFAULT nextval('user_role_maps_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: venue_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venues ALTER COLUMN venue_id SET DEFAULT nextval('venues_venue_id_seq'::regclass);


--
-- Name: warehouse_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY warehouses ALTER COLUMN warehouse_id SET DEFAULT nextval('warehouses_warehouse_id_seq'::regclass);


--
-- Data for Name: customer_pics; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: customer_pics_customer_pic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customer_pics_customer_pic_id_seq', 1, false);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customers VALUES (1, '2015-01-16 23:25:27.951', 'dei', 'C140101', 'Jaya Abadi', 'Jl. Bandengan', 1, 1, '3333', NULL, '1234', 'jaya@abadi.com', 'abadi.com', '2014-01-01', 'Jaka Tarbu', NULL, NULL, NULL, NULL, NULL);
INSERT INTO customers VALUES (2, '2015-01-16 23:26:17.802', 'dei', 'C140102', 'Tunas Jaya', 'Jl. Merbabu 2/30', 1, 1, '33334', NULL, '1233', 'tunas@jaya.com', 'jaya.com', '2014-01-01', 'Sebastian Gundala', NULL, NULL, NULL, NULL, NULL);
INSERT INTO customers VALUES (3, '2015-01-17 21:27:00.887', 'postgres', 'C140201', 'STARBUCKS COFFEE', 'Jl. Raya Tambun No. 3', 1, 1, '555666', NULL, '1235', 'cs@starbucks.com', NULL, '2015-01-01', 'Dunlop norisk', NULL, NULL, NULL, NULL, NULL);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customers_customer_id_seq', 3, true);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO events VALUES (1, '2015-01-17 21:27:57.967', 'postgres', 'Jakarta International Motor Show', 'JIMS', 'Automotive', NULL, NULL);
INSERT INTO events VALUES (2, '2015-01-17 21:28:27.569', 'postgres', 'Pameran Komputer', NULL, NULL, NULL, NULL);
INSERT INTO events VALUES (3, '2015-01-17 21:28:35.815', 'postgres', 'Event Besar', NULL, NULL, NULL, NULL);


--
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('events_event_id_seq', 3, true);


--
-- Data for Name: loss_factors; Type: TABLE DATA; Schema: public; Owner: dei
--

INSERT INTO loss_factors VALUES (1, '2015-01-20 20:42:00.002', 'dei', 'Price too high', NULL);
INSERT INTO loss_factors VALUES (2, '2015-01-20 20:42:15.569', 'dei', 'Design', NULL);


--
-- Name: loss_factors_loss_factor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dei
--

SELECT pg_catalog.setval('loss_factors_loss_factor_id_seq', 2, true);


--
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO menus VALUES (1, '2015-01-12 07:41:55.138', 'dei', 'Create Quotation', 'Quotation', 'quotation', 'create_quotation', 'icon-gift', true);
INSERT INTO menus VALUES (3, '2015-01-12 08:13:10.248', 'dei', 'Create User', 'Administrator', 'administrator', 'create_user', 'icon-user', true);
INSERT INTO menus VALUES (4, '2015-01-12 08:13:21.079', 'postgres', 'Manage User', 'Administrator', 'administrator', 'manage_user', 'icon-user', true);
INSERT INTO menus VALUES (5, '2015-01-15 20:57:16.526', 'dei', 'Quotation List', 'Quotation', 'quotation', 'quotation_list', 'icon-gift', false);


--
-- Name: menus_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('menus_menu_id_seq', 5, true);


--
-- Data for Name: quotation_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO quotation_files VALUES (3, '2015-01-19 08:17:35.219', 'dei', 14, 'qf_14_3_teksi.png', '');
INSERT INTO quotation_files VALUES (4, '2015-01-19 12:52:17.252', 'dei', 16, 'qf_16_4_teksi.png', '');


--
-- Name: quotation_files_quotation_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('quotation_files_quotation_files_id_seq', 1, false);


--
-- Data for Name: quotation_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO quotation_products VALUES (82, '2015-01-19 12:59:19.693', 'dei', 16, 'Partisi Dua', '-', 10000000.00);
INSERT INTO quotation_products VALUES (83, '2015-01-20 07:41:24.811', 'dei', 16, 'electrical', 'electrical panggung+', 5000000.00);


--
-- Name: quotation_products_quotation_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('quotation_products_quotation_product_id_seq', 83, true);


--
-- Data for Name: quotation_status; Type: TABLE DATA; Schema: public; Owner: dei
--

INSERT INTO quotation_status VALUES (0, '2015-01-20 20:43:45.535', 'dei', 'Draft');
INSERT INTO quotation_status VALUES (1, '2015-01-20 20:43:55.07', 'dei', 'Reserved');
INSERT INTO quotation_status VALUES (2, '2015-01-20 20:44:20.378', 'dei', 'Reserved');
INSERT INTO quotation_status VALUES (4, '2015-01-20 20:44:48.289', 'dei', 'Final');
INSERT INTO quotation_status VALUES (5, '2015-01-20 20:44:57.982', 'dei', 'Win');
INSERT INTO quotation_status VALUES (3, '2015-01-20 20:44:23.99', 'dei', 'Loss');


--
-- Name: quotation_status_quotation_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dei
--

SELECT pg_catalog.setval('quotation_status_quotation_status_id_seq', 5, true);


--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO quotations VALUES (15, '2015-01-18 19:09:51.953', 'dei', 'Q201501/15', 0, '0', NULL, '2015-01-18', '1111111', 'cash', 'stand', '5x5', NULL, 1, 1, '2015-01-01', '2015-01-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 1, NULL, NULL, NULL);
INSERT INTO quotations VALUES (14, '2015-01-18 17:26:14.113', 'dei', 'Q201501/14', 0, '0', NULL, '2015-01-18', '1111111', 'cash', 'stand', '5x5', NULL, 1, 1, '2015-01-01', '2015-01-03', '2015-01-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 1, 1, 1, NULL, 1.00, 2.00);
INSERT INTO quotations VALUES (17, '2015-01-20 07:45:27.451', 'dei', 'Q201501/17', 0, '0', NULL, '2015-02-01', 'faisal', NULL, NULL, NULL, NULL, 3, 3, '2015-02-07', '2015-02-09', '2015-01-20', '01:00:00', '2015-01-21', '18:00:00', NULL, NULL, NULL, NULL, 3, NULL, 1, 2, 1, 't', 1.00, 2.00);
INSERT INTO quotations VALUES (18, '2015-01-20 07:48:01.97', 'dei', 'Q201501/18', 0, '0', NULL, '2015-02-01', 'faisal', NULL, NULL, NULL, NULL, 3, 3, '2015-02-07', '2015-02-09', '2015-01-20', '01:00:00', '2015-01-21', '18:00:00', NULL, NULL, NULL, NULL, 3, NULL, 1, 2, 1, 't', 1.00, 2.00);
INSERT INTO quotations VALUES (19, '2015-01-20 07:49:25.242', 'dei', 'Q201501/19', 0, '0', NULL, '2015-02-01', 'faisal', NULL, NULL, NULL, true, 3, 3, '2015-02-07', '2015-02-09', '2015-01-20', '01:00:00', '2015-01-21', '18:00:00', NULL, NULL, NULL, NULL, 3, NULL, 1, 2, 1, 't', 1.00, 2.00);
INSERT INTO quotations VALUES (16, '2015-01-19 12:49:44.319', 'dei', 'Q201501/16', 0, '0', NULL, '2015-02-01', 'faisal', NULL, NULL, NULL, true, 3, 3, '2015-02-07', '2015-02-09', '2015-01-20', '01:00:00', '2015-01-21', '18:00:00', NULL, NULL, NULL, NULL, 3, NULL, 1, 2, 1, 'tx', 1000000.00, 2000000.00);


--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('quotations_quotation_id_seq', 10, true);


--
-- Data for Name: role_menu_maps; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO role_menu_maps VALUES (1, '2015-01-12 07:44:06.083', 'dei', 1, 1);
INSERT INTO role_menu_maps VALUES (2, '2015-01-12 07:44:15.135', 'dei', 1, 2);
INSERT INTO role_menu_maps VALUES (3, '2015-01-12 08:15:29.878', 'postgres', 1, 3);
INSERT INTO role_menu_maps VALUES (4, '2015-01-12 08:15:34.885', 'postgres', 1, 4);
INSERT INTO role_menu_maps VALUES (5, '2015-01-15 21:06:15.541', 'dei', 1, 5);


--
-- Name: role_menu_maps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_menu_maps_id_seq', 5, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles VALUES (1, '2015-01-12 07:43:51.491', 'dei', 'Superman');
INSERT INTO roles VALUES (2, '2015-01-20 21:25:46.544', 'dei', 'Sales');
INSERT INTO roles VALUES (3, '2015-01-20 21:25:55.376', 'dei', 'Admin');


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_role_id_seq', 3, true);


--
-- Data for Name: supplier_pics; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: supplier_pics_suplier_pic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('supplier_pics_suplier_pic_id_seq', 1, false);


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('suppliers_supplier_id_seq', 1, false);


--
-- Data for Name: user_role_maps; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_role_maps VALUES (1, '2015-01-12 07:45:09.797', 'dei', 1, 1);
INSERT INTO user_role_maps VALUES (2, '2015-01-18 09:19:47.728', 'postgres', 2, 1);


--
-- Name: user_role_maps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_role_maps_id_seq', 2, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users VALUES (2, '2015-01-17 05:25:35.303', 'dei', NULL, 'admin', 'Administrator', 'admin@localhost', '1', 1, NULL);
INSERT INTO users VALUES (1, '2015-01-04 17:21:15.788', 'postgres', NULL, 'dei', 'Ridei Karim', 'ridei@live.com', '1', 1, NULL);
INSERT INTO users VALUES (3, '2015-01-20 22:30:54.425', 'dei', 'NIK12', 'budi.santoso', 'Budi Santoso', 'budi.santoso@gmail.com', '1', 1, 'Marketing');


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_user_id_seq', 3, true);


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO venues VALUES (1, '2015-01-17 21:36:22.164', 'postgres', 'Jakarta International Expo', NULL, NULL, NULL, NULL, NULL);
INSERT INTO venues VALUES (2, '2015-01-17 21:36:33.076', 'postgres', 'Jakarta Convention Centre', NULL, NULL, NULL, NULL, NULL);
INSERT INTO venues VALUES (3, '2015-01-17 21:36:46.691', 'postgres', 'Jakarta Design Center', NULL, NULL, NULL, NULL, NULL);


--
-- Name: venues_venue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('venues_venue_id_seq', 3, true);


--
-- Data for Name: warehouses; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('warehouses_warehouse_id_seq', 1, false);


--
-- Name: customer_pics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer_pics
    ADD CONSTRAINT customer_pics_pkey PRIMARY KEY (customer_pic_id);


--
-- Name: customers_customer_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_customer_code_key UNIQUE (customer_code);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- Name: loss_factors_pkey; Type: CONSTRAINT; Schema: public; Owner: dei; Tablespace: 
--

ALTER TABLE ONLY loss_factors
    ADD CONSTRAINT loss_factors_pkey PRIMARY KEY (loss_factor_id);


--
-- Name: menus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (menu_id);


--
-- Name: quotation_file_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quotation_files
    ADD CONSTRAINT quotation_file_pk PRIMARY KEY (quotation_files_id);


--
-- Name: quotation_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quotation_products
    ADD CONSTRAINT quotation_products_pkey PRIMARY KEY (quotation_product_id);


--
-- Name: quotation_status_pkey; Type: CONSTRAINT; Schema: public; Owner: dei; Tablespace: 
--

ALTER TABLE ONLY quotation_status
    ADD CONSTRAINT quotation_status_pkey PRIMARY KEY (quotation_status_id);


--
-- Name: quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (quotation_id);


--
-- Name: role_menu_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role_menu_maps
    ADD CONSTRAINT role_menu_maps_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: supplier_pics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY supplier_pics
    ADD CONSTRAINT supplier_pics_pkey PRIMARY KEY (suplier_pic_id);


--
-- Name: suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- Name: user_role_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_role_maps
    ADD CONSTRAINT user_role_maps_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users_register_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_register_number_key UNIQUE (register_number);


--
-- Name: users_userid_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_userid_key UNIQUE (userid);


--
-- Name: venues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (venue_id);


--
-- Name: warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);


--
-- Name: fki_qp_q_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_qp_q_fk ON quotation_products USING btree (quotation_id);


--
-- Name: fki_quotations_file_to_quotations; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_quotations_file_to_quotations ON quotation_files USING btree (quotation_id);


--
-- Name: customer_pic_maps; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_pics
    ADD CONSTRAINT customer_pic_maps FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: qp_q_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotation_products
    ADD CONSTRAINT qp_q_fk FOREIGN KEY (quotation_id) REFERENCES quotations(quotation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: quotations_file_to_quotations; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotation_files
    ADD CONSTRAINT quotations_file_to_quotations FOREIGN KEY (quotation_id) REFERENCES quotations(quotation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: supplier_pic_maps; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier_pics
    ADD CONSTRAINT supplier_pic_maps FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

