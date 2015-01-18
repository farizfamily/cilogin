--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'WIN1252';
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
-- Name: customer_pics_customer_pic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customer_pics_customer_pic_id_seq', 1, false);


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
    email character varying,
    website character varying,
    customer_since date
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
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customers_customer_id_seq', 2, true);


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
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('events_event_id_seq', 1, false);


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
    userrole character varying,
    dept character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: head_menu; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW head_menu AS
    SELECT a.user_id, d.menu_head, d.menu_name, d.module, d.action FROM (((users a JOIN user_role_maps b USING (user_id)) JOIN role_menu_maps c USING (role_id)) JOIN menus d USING (menu_id));


ALTER TABLE public.head_menu OWNER TO postgres;

--
-- Name: menu_head; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW menu_head AS
    SELECT DISTINCT a.user_id, d.menu_head, CASE WHEN ((COALESCE(d.icon, ''::character varying))::text = ''::text) THEN 'icon-tasks'::character varying ELSE d.icon END AS icon FROM (((users a JOIN user_role_maps b USING (user_id)) JOIN role_menu_maps c USING (role_id)) JOIN menus d USING (menu_id));


ALTER TABLE public.menu_head OWNER TO postgres;

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
-- Name: menus_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('menus_menu_id_seq', 5, true);


--
-- Name: quotations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quotations (
    quotation_id integer NOT NULL,
    time_stamp timestamp without time zone DEFAULT now(),
    created_by character varying DEFAULT "current_user"(),
    quotation_number character varying,
    status integer,
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
    notes text
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
-- Name: quotation_products_quotation_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('quotation_products_quotation_product_id_seq', 73, true);


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
-- Name: quotations_quotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('quotations_quotation_id_seq', 10, true);


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
-- Name: role_menu_maps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_menu_maps_id_seq', 5, true);


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
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_role_id_seq', 1, true);


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
-- Name: supplier_pics_suplier_pic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('supplier_pics_suplier_pic_id_seq', 1, false);


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
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('suppliers_supplier_id_seq', 1, false);


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
-- Name: user_role_maps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_role_maps_id_seq', 1, true);


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
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_user_id_seq', 2, true);


--
-- Name: v_quotation; Type: VIEW; Schema: public; Owner: dei
--

CREATE VIEW v_quotation AS
    SELECT quotations.quotation_id, quotations.time_stamp, quotations.created_by, quotations.quotation_number, quotations.status, quotations.revision, quotations.sales_number, quotations.quotation_date, quotations.contract_number, quotations.term_of_payment, quotations.construction_type, quotations.size, CASE WHEN (quotations.official = true) THEN 'checked'::text ELSE ''::text END AS official, quotations.event_id, quotations.venue_id, quotations.show_day_from, quotations.show_day_to, quotations.move_in_from_date, quotations.move_in_to_date, quotations.move_out_from_date, quotations.move_out_to_date, quotations.customer_id, quotations.customer_contacts, quotations.project_executive, quotations.project_supervisor, quotations.designer, quotations.notes FROM quotations;


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
-- Name: venues_venue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('venues_venue_id_seq', 1, false);


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
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('warehouses_warehouse_id_seq', 1, false);


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
-- Name: menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menus ALTER COLUMN menu_id SET DEFAULT nextval('menus_menu_id_seq'::regclass);


--
-- Name: quotation_product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quotation_products ALTER COLUMN quotation_product_id SET DEFAULT nextval('quotation_products_quotation_product_id_seq'::regclass);


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
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customers VALUES (1, '2015-01-16 23:25:27.951', 'dei', 'C140101', 'Jaya Abadi', 'Jl. Bandengan', 1, 1, 'jaya@abadi.com', 'abadi.com', '2014-01-01');
INSERT INTO customers VALUES (2, '2015-01-16 23:26:17.802', 'dei', 'C140102', 'Tunas Jaya', 'Jl. Merbabu 2/30', 1, 1, 'tunas@jaya.com', 'jaya.com', '2014-01-01');


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO menus VALUES (1, '2015-01-12 07:41:55.138', 'dei', 'Create Quotation', 'Quotation', 'quotation', 'create_quotation', 'icon-gift', true);
INSERT INTO menus VALUES (2, '2015-01-12 07:42:30.811', 'dei', 'Manage Quotation', 'Quotation', 'quotation', 'manage_quotation', 'icon-gift', true);
INSERT INTO menus VALUES (3, '2015-01-12 08:13:10.248', 'dei', 'Create User', 'Administrator', 'administrator', 'create_user', 'icon-user', true);
INSERT INTO menus VALUES (4, '2015-01-12 08:13:21.079', 'postgres', 'Manage User', 'Administrator', 'administrator', 'manage_user', 'icon-user', true);
INSERT INTO menus VALUES (5, '2015-01-15 20:57:16.526', 'dei', 'Quotation List', 'Quotation', 'quotation', 'quotation_list', 'icon-gift', false);


--
-- Data for Name: quotation_products; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: role_menu_maps; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO role_menu_maps VALUES (1, '2015-01-12 07:44:06.083', 'dei', 1, 1);
INSERT INTO role_menu_maps VALUES (2, '2015-01-12 07:44:15.135', 'dei', 1, 2);
INSERT INTO role_menu_maps VALUES (3, '2015-01-12 08:15:29.878', 'postgres', 1, 3);
INSERT INTO role_menu_maps VALUES (4, '2015-01-12 08:15:34.885', 'postgres', 1, 4);
INSERT INTO role_menu_maps VALUES (5, '2015-01-15 21:06:15.541', 'dei', 1, 5);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles VALUES (1, '2015-01-12 07:43:51.491', 'dei', 'Superman');


--
-- Data for Name: supplier_pics; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_role_maps; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_role_maps VALUES (1, '2015-01-12 07:45:09.797', 'dei', 1, 1);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users VALUES (1, '2015-01-04 17:21:15.788', 'postgres', NULL, 'dei', 'Ridei Karim', 'ridei@live.com', '1', NULL, NULL);
INSERT INTO users VALUES (2, '2015-01-17 05:25:35.303', 'dei', NULL, 'admin', 'Administrator', 'admin@localhost', '1', NULL, NULL);


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: warehouses; Type: TABLE DATA; Schema: public; Owner: postgres
--



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
-- Name: menus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (menu_id);


--
-- Name: quotation_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quotation_products
    ADD CONSTRAINT quotation_products_pkey PRIMARY KEY (quotation_product_id);


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

