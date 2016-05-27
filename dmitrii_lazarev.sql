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

