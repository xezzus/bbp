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
-- Name: devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE devices (
    phone_hash text NOT NULL,
    device_hash text NOT NULL,
    sms text DEFAULT 'test'::text,
    sms_time integer DEFAULT 0 NOT NULL,
    sms_counter integer DEFAULT 0 NOT NULL,
    activated boolean DEFAULT false NOT NULL,
    ban integer DEFAULT 0 NOT NULL,
    sms_counter_enter smallint DEFAULT '0'::smallint NOT NULL
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
    power smallint DEFAULT '1'::smallint NOT NULL,
    type smallint DEFAULT '0'::smallint NOT NULL,
    time_ban integer DEFAULT 0 NOT NULL
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

ALTER TABLE ONLY request_types ALTER COLUMN id SET DEFAULT nextval('request_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('registration_id_seq'::regclass);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY devices (phone_hash, device_hash, sms, sms_time, sms_counter, activated, ban, sms_counter_enter) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	55395	1465725535	8	f	0	0
$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	73897	1465371431	8	f	0	0
\.


--
-- Name: registration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('registration_id_seq', 259, true);


--
-- Data for Name: request_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY request_types (id, name) FROM stdin;
1	registration
2	capture
3	activation
0	none
\.


--
-- Name: request_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('request_types_id_seq', 3, true);


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY requests (id, "time", ip, device_hash, phone_hash, power, type, time_ban) FROM stdin;
241	1465371298	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
242	1465371327	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
243	1465371328	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
244	1465371329	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
245	1465371329	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
246	1465371330	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
247	1465371392	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
248	1465371431	192.168.0.47	$2a$07$lkjasdf897asdf897asdfu2Xaw4ur7ZiSKvt2kCiwJvf92eChgjiu	$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	1	1	0
249	1465561901	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
250	1465725495	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
251	1465725497	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
252	1465725498	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
253	1465725499	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
254	1465725500	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
255	1465725500	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
256	1465725535	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	0
259	1465725827	192.168.0.47	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	1	1	1465812227
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (phone_hash, token, token_time_create, phone) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuMO9NuBYVlimHpINQjyTMuFJ79idYf/W	\N	0	dsfg
$2a$07$lkjasdf897asdf897asdfuUbNpNJrAPphjaCEI205.GeIwpQudIM.	\N	0	asdf
\.


--
-- Name: devices_device_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_device_hash UNIQUE (device_hash);


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

