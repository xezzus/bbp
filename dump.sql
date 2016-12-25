--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET SESSION AUTHORIZATION DEFAULT;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET SESSION AUTHORIZATION 'bbp';

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bans; Type: TABLE; Schema: public; Owner: bbp
--

CREATE TABLE bans (
    id integer NOT NULL,
    ip inet NOT NULL,
    "time" integer NOT NULL
);


--
-- Name: bans_id_seq; Type: SEQUENCE; Schema: public; Owner: bbp
--

CREATE SEQUENCE bans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bbp
--

ALTER SEQUENCE bans_id_seq OWNED BY bans.id;


--
-- Name: devices; Type: TABLE; Schema: public; Owner: bbp
--

CREATE TABLE devices (
    phone_hash text NOT NULL,
    device_hash text NOT NULL,
    sms text DEFAULT 'test'::text,
    activated boolean DEFAULT false NOT NULL
);


--
-- Name: gps; Type: TABLE; Schema: public; Owner: bbp
--

CREATE TABLE gps (
    user_id text NOT NULL,
    used boolean DEFAULT false NOT NULL,
    latitude double precision,
    longitude double precision,
    "time" integer
);


--
-- Name: msg; Type: TABLE; Schema: public; Owner: bbp
--

CREATE TABLE msg (
    sender text NOT NULL,
    recipient text,
    code smallint,
    vehicle_number text NOT NULL,
    "time" integer NOT NULL,
    flag integer
);


--
-- Name: requests; Type: TABLE; Schema: public; Owner: bbp
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
-- Name: registration_id_seq; Type: SEQUENCE; Schema: public; Owner: bbp
--

CREATE SEQUENCE registration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bbp
--

ALTER SEQUENCE registration_id_seq OWNED BY requests.id;


--
-- Name: request_types; Type: TABLE; Schema: public; Owner: bbp
--

CREATE TABLE request_types (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: request_types_id_seq; Type: SEQUENCE; Schema: public; Owner: bbp
--

CREATE SEQUENCE request_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: request_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bbp
--

ALTER SEQUENCE request_types_id_seq OWNED BY request_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: bbp
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
-- Name: vehicle; Type: TABLE; Schema: public; Owner: bbp
--

CREATE TABLE vehicle (
    phone_hash text NOT NULL,
    number text NOT NULL,
    time_create integer NOT NULL
);


--
-- Name: bans id; Type: DEFAULT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY bans ALTER COLUMN id SET DEFAULT nextval('bans_id_seq'::regclass);


--
-- Name: request_types id; Type: DEFAULT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY request_types ALTER COLUMN id SET DEFAULT nextval('request_types_id_seq'::regclass);


--
-- Name: requests id; Type: DEFAULT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('registration_id_seq'::regclass);


--
-- Data for Name: bans; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY bans (id, ip, "time") FROM stdin;
\.


--
-- Name: bans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bbp
--

SELECT pg_catalog.setval('bans_id_seq', 1, false);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY devices (phone_hash, device_hash, sms, activated) FROM stdin;
$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	64959	t
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	22370	t
\.


--
-- Data for Name: gps; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY gps (user_id, used, latitude, longitude, "time") FROM stdin;
$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	t	1.32590199999999991	1.00657299999999994	1482192755
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	f	1.32590199999999991	1.00657299999999994	1482192877
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	f	1.32590199999999991	1.00657299999999994	1482192883
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	f	1.32590199999999991	1.00657299999999994	1482192885
$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	t	1.32590300000000005	1.00657400000000008	1482193092
\.


--
-- Data for Name: msg; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY msg (sender, recipient, code, vehicle_number, "time", flag) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	\N		1482671685	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	\N	A001AA152	1482671828	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	\N	A001AA152	1482671894	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	\N	A001AA152	1482671954	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	\N	A001AA152	1482671973	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	123	1482672312	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	123	1482672348	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	123	1482672350	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	123	1482672422	\N
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	\N	\N	123d	1482672426	\N
\.


--
-- Name: registration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bbp
--

SELECT pg_catalog.setval('registration_id_seq', 4, true);


--
-- Data for Name: request_types; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY request_types (id, name) FROM stdin;
1	registration
2	capture
3	activation
0	none
4	smssend
\.


--
-- Name: request_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bbp
--

SELECT pg_catalog.setval('request_types_id_seq', 3, true);


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY requests (id, "time", ip, device_hash, phone_hash, type) FROM stdin;
1	1482192594	165.225.66.56	$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	1
2	1482192641	165.225.66.56	$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	3
3	1482192786	165.225.66.56	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	1
4	1482192833	165.225.66.56	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	3
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY users (phone_hash, token, token_time_create, phone, rating, gps, msgid) FROM stdin;
$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	$2y$11$Mb4RYWT.GIU5evZZ.VOMoOCQJd3tfIBUy6YlsDaW.MkK6NkRKoeIO	1482193029	100	0	t	dI_tgmpogbE:APA91bGwlftEGM8tGf4kt6umzOqNPnH-1lPLkBc1OQl12qIT7he4G3XG2gt3bIPcL3evGvaKF9dPrdlufmNPb1YTCRnq8aNaG8Gw5qHwo_BMvmv31txRqhURj4E0kw5YD9mB5Uqqmv6r
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	$2y$11$ZWgqLt7AOYikhfjJ6Me/rOgqbwGikpShbj0TJVB5xay34NtFVZi3u	1482672222	200	0	t	\N
\.


--
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: bbp
--

COPY vehicle (phone_hash, number, time_create) FROM stdin;
$2a$07$lkjasdf897asdf897asdfux4jkRT69nD4.GQ4MALR7VogZX7KJdVG	A001AA152	1482192727
$2a$07$lkjasdf897asdf897asdfuOAvR32zR/bwRpP5t2GofZ9pOpQukQ4.	123	1482671778
\.


--
-- Name: bans bans_id; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY bans
    ADD CONSTRAINT bans_id PRIMARY KEY (id);


--
-- Name: devices devices_device_hash; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_device_hash UNIQUE (device_hash);


--
-- Name: devices devices_device_hash_phone_hash; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_device_hash_phone_hash UNIQUE (device_hash, phone_hash);


--
-- Name: devices devices_phone_hash; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash UNIQUE (phone_hash);


--
-- Name: devices devices_phone_hash_device_hash; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash_device_hash PRIMARY KEY (phone_hash, device_hash);


--
-- Name: request_types request_types_id; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_id PRIMARY KEY (id);


--
-- Name: request_types request_types_name; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_name UNIQUE (name);


--
-- Name: requests requests_id; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_id PRIMARY KEY (id);


--
-- Name: users users_phone_hash; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_phone_hash PRIMARY KEY (phone_hash);


--
-- Name: users users_token; Type: CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_token UNIQUE (token);


--
-- Name: bans_ip_time; Type: INDEX; Schema: public; Owner: bbp
--

CREATE INDEX bans_ip_time ON bans USING btree (ip, "time");


--
-- Name: vehicle_phone_hash; Type: INDEX; Schema: public; Owner: bbp
--

CREATE INDEX vehicle_phone_hash ON vehicle USING btree (phone_hash);


--
-- Name: devices devices_phone_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash_fkey FOREIGN KEY (phone_hash) REFERENCES users(phone_hash) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: requests requests_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: bbp
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_type_fkey FOREIGN KEY (type) REFERENCES request_types(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- PostgreSQL database dump complete
--

