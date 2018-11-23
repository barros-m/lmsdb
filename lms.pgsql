--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: add_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO requests(studentId, status)
VALUES (new.studentId, 'p');
return new;
end;
$$;


ALTER FUNCTION public.add_user() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: lecture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecture (
    lectureid integer NOT NULL,
    lecturename character varying(25)
);


ALTER TABLE public.lecture OWNER TO postgres;

--
-- Name: quizz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quizz (
    quizid integer NOT NULL,
    studentid integer NOT NULL,
    score double precision,
    lectureid integer NOT NULL
);


ALTER TABLE public.quizz OWNER TO postgres;

--
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests (
    studentid integer,
    status character(1)
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    studentid integer NOT NULL,
    lastname character varying(25),
    firstname character varying(25),
    email character varying(25),
    password character varying(25),
    grade double precision
);


ALTER TABLE public.student OWNER TO postgres;

--
-- Data for Name: lecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecture (lectureid, lecturename) FROM stdin;
\.


--
-- Data for Name: quizz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quizz (quizid, studentid, score, lectureid) FROM stdin;
\.


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requests (studentid, status) FROM stdin;
12345	p
819	p
7	p
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (studentid, lastname, firstname, email, password, grade) FROM stdin;
12345	Barros	Matheus	test@gmail.com	1234	100
89	test	jovem	jovem@gmail.com	jovem	90
819	test	jovem1	jovem@gmail.com	jovem	90
7	barros	enzo	enzo@gmail.com	jovem	90
\.


--
-- Name: lecture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecture
    ADD CONSTRAINT lecture_pkey PRIMARY KEY (lectureid);


--
-- Name: quizz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizz
    ADD CONSTRAINT quizz_pkey PRIMARY KEY (quizid, studentid, lectureid);


--
-- Name: student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (studentid);


--
-- Name: add_user_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER add_user_trigger AFTER INSERT ON public.student FOR EACH ROW EXECUTE PROCEDURE public.add_user();


--
-- Name: quizz_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizz
    ADD CONSTRAINT quizz_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.student(studentid);


--
-- Name: quizz_studentid_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizz
    ADD CONSTRAINT quizz_studentid_fkey1 FOREIGN KEY (studentid) REFERENCES public.lecture(lectureid);


--
-- Name: requests_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.student(studentid);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT USAGE ON SCHEMA public TO lms;


--
-- Name: TABLE lecture; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.lecture FROM PUBLIC;
REVOKE ALL ON TABLE public.lecture FROM postgres;
GRANT ALL ON TABLE public.lecture TO postgres;
GRANT ALL ON TABLE public.lecture TO lms;


--
-- Name: TABLE quizz; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.quizz FROM PUBLIC;
REVOKE ALL ON TABLE public.quizz FROM postgres;
GRANT ALL ON TABLE public.quizz TO postgres;
GRANT ALL ON TABLE public.quizz TO lms;


--
-- Name: TABLE requests; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.requests FROM PUBLIC;
REVOKE ALL ON TABLE public.requests FROM postgres;
GRANT ALL ON TABLE public.requests TO postgres;
GRANT ALL ON TABLE public.requests TO lms;


--
-- Name: TABLE student; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.student FROM PUBLIC;
REVOKE ALL ON TABLE public.student FROM postgres;
GRANT ALL ON TABLE public.student TO postgres;
GRANT ALL ON TABLE public.student TO lms;


--
-- PostgreSQL database dump complete
--

