--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: bans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bans (
    id integer NOT NULL,
    ip inet NOT NULL,
    "time" integer NOT NULL
);


--
-- Name: bans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bans_id_seq OWNED BY bans.id;


--
-- Name: devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE devices (
    phone_hash text NOT NULL,
    device_hash text NOT NULL,
    sms text DEFAULT 'test'::text,
    activated boolean DEFAULT false NOT NULL
);


--
-- Name: requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE requests (
    id integer NOT NULL,
    "time" integer DEFAULT 0 NOT NULL,
    ip inet NOT NULL,
    device_hash text NOT NULL,
    phone_hash text NOT NULL,
    type smallint DEFAULT '0'::smallint NOT NULL
);


--
-- Name: registration_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE registration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE registration_id_seq OWNED BY requests.id;


--
-- Name: request_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE request_types (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: request_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE request_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: request_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE request_types_id_seq OWNED BY request_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    phone_hash text NOT NULL,
    token text,
    token_time_create integer DEFAULT 0 NOT NULL,
    phone text NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bans ALTER COLUMN id SET DEFAULT nextval('bans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY request_types ALTER COLUMN id SET DEFAULT nextval('request_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('registration_id_seq'::regclass);


--
-- Data for Name: bans; Type: TABLE DATA; Schema: public; Owner: -
--

COPY bans (id, ip, "time") FROM stdin;
\.


--
-- Name: bans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bans_id_seq', 8, true);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY devices (phone_hash, device_hash, sms, activated) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuD3UrSD4vJd6WxPUBAeq47oiR8yKVR7O	$2a$07$lkjasdf897asdf897asdfuD3UrSD4vJd6WxPUBAeq47oiR8yKVR7O	25391	f
$2a$07$lkjasdf897asdf897asdfuJxzQPUBS9I5xUr/gGuj.1AcJA2LdROW	$2a$07$lkjasdf897asdf897asdfuJxzQPUBS9I5xUr/gGuj.1AcJA2LdROW	65569	f
$2a$07$lkjasdf897asdf897asdfuvixkQ505cTQsO1qembXIQSijQcSzcYa	$2a$07$lkjasdf897asdf897asdfuvixkQ505cTQsO1qembXIQSijQcSzcYa	65527	f
$2a$07$lkjasdf897asdf897asdfuRT3/zPVFf3gvsEPEQsop4JGv1em1JLC	$2a$07$lkjasdf897asdf897asdfuRT3/zPVFf3gvsEPEQsop4JGv1em1JLC	17148	f
$2a$07$lkjasdf897asdf897asdfuYa/qqS/Km5M09Mv5d12Gyd7O9Ji4lzK	$2a$07$lkjasdf897asdf897asdfuYa/qqS/Km5M09Mv5d12Gyd7O9Ji4lzK	78998	f
\.


--
-- Name: registration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('registration_id_seq', 311, true);


--
-- Data for Name: request_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY request_types (id, name) FROM stdin;
1	registration
2	capture
3	activation
0	none
4	smssend
\.


--
-- Name: request_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('request_types_id_seq', 3, true);


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY requests (id, "time", ip, device_hash, phone_hash, type) FROM stdin;
307	1465924180	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuD3UrSD4vJd6WxPUBAeq47oiR8yKVR7O	$2a$07$lkjasdf897asdf897asdfuD3UrSD4vJd6WxPUBAeq47oiR8yKVR7O	1
308	1465924184	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuJxzQPUBS9I5xUr/gGuj.1AcJA2LdROW	$2a$07$lkjasdf897asdf897asdfuJxzQPUBS9I5xUr/gGuj.1AcJA2LdROW	1
309	1465924189	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuvixkQ505cTQsO1qembXIQSijQcSzcYa	$2a$07$lkjasdf897asdf897asdfuvixkQ505cTQsO1qembXIQSijQcSzcYa	1
310	1465924193	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuRT3/zPVFf3gvsEPEQsop4JGv1em1JLC	$2a$07$lkjasdf897asdf897asdfuRT3/zPVFf3gvsEPEQsop4JGv1em1JLC	1
311	1465924197	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuYa/qqS/Km5M09Mv5d12Gyd7O9Ji4lzK	$2a$07$lkjasdf897asdf897asdfuYa/qqS/Km5M09Mv5d12Gyd7O9Ji4lzK	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (phone_hash, token, token_time_create, phone) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuD3UrSD4vJd6WxPUBAeq47oiR8yKVR7O	\N	0	u1
$2a$07$lkjasdf897asdf897asdfuJxzQPUBS9I5xUr/gGuj.1AcJA2LdROW	\N	0	u2
$2a$07$lkjasdf897asdf897asdfuvixkQ505cTQsO1qembXIQSijQcSzcYa	\N	0	u3
$2a$07$lkjasdf897asdf897asdfuRT3/zPVFf3gvsEPEQsop4JGv1em1JLC	\N	0	u4
$2a$07$lkjasdf897asdf897asdfuYa/qqS/Km5M09Mv5d12Gyd7O9Ji4lzK	\N	0	u5
\.


--
-- Name: bans_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bans
    ADD CONSTRAINT bans_id PRIMARY KEY (id);


--
-- Name: devices_device_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_device_hash UNIQUE (device_hash);


--
-- Name: devices_device_hash_phone_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_device_hash_phone_hash UNIQUE (device_hash, phone_hash);


--
-- Name: devices_phone_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash UNIQUE (phone_hash);


--
-- Name: devices_phone_hash_device_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash_device_hash PRIMARY KEY (phone_hash, device_hash);


--
-- Name: request_types_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_id PRIMARY KEY (id);


--
-- Name: request_types_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_name UNIQUE (name);


--
-- Name: requests_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_id PRIMARY KEY (id);


--
-- Name: users_phone_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_phone_hash PRIMARY KEY (phone_hash);


--
-- Name: bans_ip_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bans_ip_time ON bans USING btree (ip, "time");


--
-- Name: devices_phone_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash_fkey FOREIGN KEY (phone_hash) REFERENCES users(phone_hash) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: requests_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_type_fkey FOREIGN KEY (type) REFERENCES request_types(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- PostgreSQL database dump complete
--

