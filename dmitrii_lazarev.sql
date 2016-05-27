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
-- Name: ips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ips (
    ip inet NOT NULL,
    ban integer DEFAULT 0 NOT NULL
);


ALTER TABLE ips OWNER TO postgres;

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
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY devices (phone_hash, device_hash, sms, sms_time, sms_counter, activated, ban, sms_counter_enter) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuft7CCV4XmqmfO00e2lvU7ynhfWkwcIi	$2a$07$lkjasdf897asdf897asdfuft7CCV4XmqmfO00e2lvU7ynhfWkwcIi	test	1464265616	5	f	1464352016	0
$2a$07$lkjasdf897asdf897asdfuMJ3FIfvzcvcVSkS6nPO3uf.sMLgjfTu	$2a$07$lkjasdf897asdf897asdfuwc7FSLxJj.2cJH2mEnIJayk.Nu6cvmW	test	1464267228	2	f	1464353628	0
$2a$07$lkjasdf897asdf897asdfuROeGMPFL5D4Zo7Ik8FulMlpnm/M/wme	$2a$07$lkjasdf897asdf897asdfuROeGMPFL5D4Zo7Ik8FulMlpnm/M/wme	test	1464267333	1	f	0	0
$2a$07$lkjasdf897asdf897asdfujDp8CwnqsGkR8/MUqbNqPyK7XtdAilK	$2a$07$lkjasdf897asdf897asdfujDp8CwnqsGkR8/MUqbNqPyK7XtdAilK	test	1464270220	1	f	0	0
$2a$07$lkjasdf897asdf897asdfuaaQGOAVfM3JakE7nBP5UP3MNzicZdie	$2a$07$lkjasdf897asdf897asdfuGGf5xNNfARhIRQr0NtWrFkeSXqN.Ucq	test	1464271006	1	f	0	0
$2a$07$lkjasdf897asdf897asdfuR4THLpTJrT0hrox8gmfoZ56801NAl1e	$2a$07$lkjasdf897asdf897asdfuz.R0GCKjSo4mfCfrgFFt7oEmkzKd12O	test	1464328875	1	f	0	0
$2a$07$lkjasdf897asdf897asdfuRj8t39KHDilgIxb8t3jWI8fJ5GVGRki	$2a$07$lkjasdf897asdf897asdfuJDtkXl/3ieTXKhr3tvb.n3JrBnrnK9m	test	1464333113	1	f	0	0
\.


--
-- Data for Name: ips; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ips (ip, ban) FROM stdin;
192.168.0.47	1464338853
192.168.0.1	1464343389
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (phone_hash, token, token_time_create, phone) FROM stdin;
$2a$07$lkjasdf897asdf897asdfuft7CCV4XmqmfO00e2lvU7ynhfWkwcIi	$2y$11$s0s/scQEj3FafIjln69.Ne6DQczXUvAHYLEQniKTcVADetPugUyWS	1464265409	ggg
$2a$07$lkjasdf897asdf897asdfuMJ3FIfvzcvcVSkS6nPO3uf.sMLgjfTu	\N	0	asdfasdf
$2a$07$lkjasdf897asdf897asdfuROeGMPFL5D4Zo7Ik8FulMlpnm/M/wme	\N	0	45
$2a$07$lkjasdf897asdf897asdfujDp8CwnqsGkR8/MUqbNqPyK7XtdAilK	\N	0	1111
$2a$07$lkjasdf897asdf897asdfuaaQGOAVfM3JakE7nBP5UP3MNzicZdie	\N	0	phone1
$2a$07$lkjasdf897asdf897asdfuR4THLpTJrT0hrox8gmfoZ56801NAl1e	\N	0	fdgsd
$2a$07$lkjasdf897asdf897asdfuRj8t39KHDilgIxb8t3jWI8fJ5GVGRki	\N	0	fdgsdf
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
-- Name: ips_ip; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ips
    ADD CONSTRAINT ips_ip PRIMARY KEY (ip);


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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

