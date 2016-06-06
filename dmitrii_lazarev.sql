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
-- Name: devices; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE devices OWNER TO postgres;

--
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE requests (
    id integer NOT NULL,
    "time" integer DEFAULT 0 NOT NULL,
    ip inet NOT NULL,
    device_hash text NOT NULL,
    phone_hash text NOT NULL,
    power smallint DEFAULT '1'::smallint NOT NULL,
    type smallint DEFAULT '0'::smallint NOT NULL
);


ALTER TABLE requests OWNER TO postgres;

--
-- Name: registration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE registration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE registration_id_seq OWNER TO postgres;

--
-- Name: registration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE registration_id_seq OWNED BY requests.id;


--
-- Name: request_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE request_types (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE request_types OWNER TO postgres;

--
-- Name: request_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE request_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE request_types_id_seq OWNER TO postgres;

--
-- Name: request_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE request_types_id_seq OWNED BY request_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    phone_hash text NOT NULL,
    token text,
    token_time_create integer DEFAULT 0 NOT NULL,
    phone text NOT NULL
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_types ALTER COLUMN id SET DEFAULT nextval('request_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('registration_id_seq'::regclass);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY devices (phone_hash, device_hash, sms, sms_time, sms_counter, activated, ban, sms_counter_enter) FROM stdin;
\.


--
-- Name: registration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('registration_id_seq', 240, true);


--
-- Data for Name: request_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY request_types (id, name) FROM stdin;
1	registration
2	capture
3	activation
0	none
\.


--
-- Name: request_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('request_types_id_seq', 3, true);


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY requests (id, "time", ip, device_hash, phone_hash, power, type) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (phone_hash, token, token_time_create, phone) FROM stdin;
\.


--
-- Name: devices_device_hash; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_device_hash UNIQUE (device_hash);


--
-- Name: devices_phone_hash; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash UNIQUE (phone_hash);


--
-- Name: devices_phone_hash_device_hash; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash_device_hash PRIMARY KEY (phone_hash, device_hash);


--
-- Name: request_types_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_id PRIMARY KEY (id);


--
-- Name: request_types_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_types
    ADD CONSTRAINT request_types_name UNIQUE (name);


--
-- Name: requests_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_id PRIMARY KEY (id);


--
-- Name: users_phone_hash; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_phone_hash PRIMARY KEY (phone_hash);


--
-- Name: devices_phone_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_phone_hash_fkey FOREIGN KEY (phone_hash) REFERENCES users(phone_hash) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: requests_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_type_fkey FOREIGN KEY (type) REFERENCES request_types(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


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

