--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

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
-- Name: gps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gps (
    user_id text NOT NULL,
    used boolean DEFAULT false NOT NULL,
    latitude double precision,
    longitude double precision,
    "time" integer
);


--
-- Name: msg; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE msg (
    sender text NOT NULL,
    recipient text,
    code smallint NOT NULL,
    vehicle_number text NOT NULL,
    "time" integer NOT NULL
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
    phone text NOT NULL,
    rating integer DEFAULT 0 NOT NULL,
    gps boolean DEFAULT false NOT NULL,
    msgid text
);


--
-- Name: vehicle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE vehicle (
    phone_hash text NOT NULL,
    number text NOT NULL,
    time_create integer NOT NULL
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

SELECT pg_catalog.setval('bans_id_seq', 41, true);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY devices (phone_hash, device_hash, sms, activated) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuMBFmoC1fbYsyc90xJRbrA32DUQGp1Uu	$2a$07$lkjasdf897asdf897asdfuMBFmoC1fbYsyc90xJRbrA32DUQGp1Uu	20220	f
$2a$07$lkjasdf897asdf897asdfuESvzI1NPt3nzH.S.kqz4ZGBWjyeFDP2	$2a$07$lkjasdf897asdf897asdfuESvzI1NPt3nzH.S.kqz4ZGBWjyeFDP2	40959	f
$2a$07$lkjasdf897asdf897asdfuft7CCV4XmqmfO00e2lvU7ynhfWkwcIi	$2a$07$lkjasdf897asdf897asdfuft7CCV4XmqmfO00e2lvU7ynhfWkwcIi	84680	t
$2a$07$lkjasdf897asdf897asdfueGgqKz8FJGSwttTi0kTchBakzbpewBq	$2a$07$lkjasdf897asdf897asdfueGgqKz8FJGSwttTi0kTchBakzbpewBq	74329	t
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	45679	t
\.


--
-- Data for Name: gps; Type: TABLE DATA; Schema: public; Owner: -
--

COPY gps (user_id, used, latitude, longitude, "time") FROM stdin;
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	t	51.6726859999999988	39.2040440000000032	1467733671
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	t	51.6726859999999988	39.2050440000000009	1467733675
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	t	51.6726859999999988	39.2060439999999986	1467733678
$2a$07$lkjasdf897asdf897asdfuft7CCV4XmqmfO00e2lvU7ynhfWkwcIi	t	51.6751209999999972	39.2061360000000008	1467734318
$2a$07$lkjasdf897asdf897asdfueGgqKz8FJGSwttTi0kTchBakzbpewBq	t	51.6747820000000004	39.1990869999999987	1467734973
$2a$07$lkjasdf897asdf897asdfueGgqKz8FJGSwttTi0kTchBakzbpewBq	t	51.6751280000000008	39.2062110000000033	1467735201
\.


--
-- Data for Name: msg; Type: TABLE DATA; Schema: public; Owner: -
--

COPY msg (sender, recipient, code, vehicle_number, "time") FROM stdin;
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	\N	1	dfgh	1468479963
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	\N	1	dfgh	1468479989
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	\N	1	dfgh	1468479989
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	\N	1	dfgh	1468479990
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	\N	1	dfgh	1468479990
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	\N	1	dfgh	1468479991
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	\N	1	dfgh	1468479991
\.


--
-- Name: registration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('registration_id_seq', 367, true);


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
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (phone_hash, token, token_time_create, phone, rating, gps, msgid) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuMBFmoC1fbYsyc90xJRbrA32DUQGp1Uu	\N	0	df	0	f	\N
$2a$07$lkjasdf897asdf897asdfuESvzI1NPt3nzH.S.kqz4ZGBWjyeFDP2	\N	0		0	f	\N
$2a$07$lkjasdf897asdf897asdfueGgqKz8FJGSwttTi0kTchBakzbpewBq	$2y$11$Oy4BToZ1i7kU/kwJ3HBPVuw53ovOsJoX0levNs2wtYFvgt1e5dDpG	1467735184	ddd	0	t	\N
$2a$07$lkjasdf897asdf897asdfuft7CCV4XmqmfO00e2lvU7ynhfWkwcIi	$2y$11$ZFImMJRQy/nrzPVgohR/9OZz5fsc3qLSDPpFLoPKgjBcIW4dgHeym	1468424519	ggg	0	t	\N
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	$2y$11$kCZ62l6EDbg9zMeptXV3QOap58hAbdzVe4syMvucJY5itmat6qefO	1468480441	www	1	t	123
\.


--
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: -
--

COPY vehicle (phone_hash, number, time_create) FROM stdin;
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	123	1466965450
$2a$07$lkjasdf897asdf897asdfueS14JzzxMUqcanIrpHcuuArUo6j0f8G	F45g67	1466966193
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
-- Name: users_token; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_token UNIQUE (token);


--
-- Name: bans_ip_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bans_ip_time ON bans USING btree (ip, "time");


--
-- Name: vehicle_phone_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vehicle_phone_hash ON vehicle USING btree (phone_hash);


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
