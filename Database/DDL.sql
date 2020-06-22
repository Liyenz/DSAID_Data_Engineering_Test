--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

-- Started on 2020-06-22 00:30:12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2840 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 24592)
-- Name: car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car (
    carid integer NOT NULL,
    isnew boolean,
    manufacturer character varying,
    modelname character varying,
    modelvariant character varying,
    serialnumber character varying,
    weight numeric,
    enginecapacity numeric,
    price numeric
);


ALTER TABLE public.car OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 24584)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customerid integer NOT NULL,
    customername character varying,
    customerphone character varying
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24600)
-- Name: purchaseorder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchaseorder (
    orderid integer NOT NULL,
    salespersonid integer,
    customerid integer,
    carid integer,
    transactiondatetime timestamp without time zone
);


ALTER TABLE public.purchaseorder OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 24576)
-- Name: salesperson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salesperson (
    salespersonid integer NOT NULL,
    salespersonname character varying
);


ALTER TABLE public.salesperson OWNER TO postgres;

--
-- TOC entry 2706 (class 2606 OID 24599)
-- Name: car car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT car_pkey PRIMARY KEY (carid);


--
-- TOC entry 2704 (class 2606 OID 24591)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customerid);


--
-- TOC entry 2708 (class 2606 OID 24604)
-- Name: purchaseorder purchaseorder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchaseorder
    ADD CONSTRAINT purchaseorder_pkey PRIMARY KEY (orderid);


--
-- TOC entry 2702 (class 2606 OID 24583)
-- Name: salesperson salesperson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salesperson
    ADD CONSTRAINT salesperson_pkey PRIMARY KEY (salespersonid);


-- Completed on 2020-06-22 00:30:13

--
-- PostgreSQL database dump complete
--

