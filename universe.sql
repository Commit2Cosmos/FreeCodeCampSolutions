--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(255) NOT NULL,
    mass bigint,
    apparentmagnitude numeric(5,3),
    numobject integer,
    isbiggerthansun boolean,
    isspherical boolean,
    xtra_info text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    name character varying(255) NOT NULL,
    mass bigint,
    apparentmagnitude numeric(5,3),
    numobject integer,
    isbiggerthansun boolean,
    isspherical boolean,
    planet_id integer NOT NULL,
    moon_id integer NOT NULL,
    xtra_info text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    name character varying(255) NOT NULL,
    mass bigint,
    apparentmagnitude numeric(5,3),
    numobject integer,
    isbiggerthansun boolean,
    isspherical boolean,
    star_id integer NOT NULL,
    galaxy_id integer DEFAULT 1,
    xtra_info text
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.star_id;


--
-- Name: other_heavenly_bodies; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.other_heavenly_bodies (
    name character varying(255) NOT NULL,
    mass bigint,
    apparentmagnitude numeric(5,3),
    numobject integer,
    isbiggerthansun boolean,
    isspherical boolean,
    other_heavenly_bodies_id integer DEFAULT nextval('public.star_id_seq'::regclass) NOT NULL
);


ALTER TABLE public.other_heavenly_bodies OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    name character varying(255) NOT NULL,
    mass bigint,
    apparentmagnitude numeric(5,3),
    numobject integer,
    isbiggerthansun boolean,
    isspherical boolean,
    star_id integer DEFAULT 1,
    planet_id integer NOT NULL,
    xtra_info text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 23081937137179238, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 7654567898765432, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (3, 'Canis Major dwarf', 987654567, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (4, 'Segue 1', 987678798789, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (5, 'Sag DEG', 987678798789, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (6, 'Large Magellanic Cloud', 987678798789, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES ('The Moon', NULL, 15.232, NULL, NULL, NULL, 31, 2, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 3, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 4, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 5, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 6, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 7, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 8, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 9, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 10, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 11, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 12, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 32, 13, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 14, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 15, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 16, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 17, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 18, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 19, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 20, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 21, NULL);
INSERT INTO public.moon VALUES ('Not The Mooon', NULL, -1.323, NULL, NULL, NULL, 33, 22, NULL);


--
-- Data for Name: other_heavenly_bodies; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.other_heavenly_bodies VALUES ('Proxima CC', NULL, NULL, NULL, NULL, NULL, 23);
INSERT INTO public.other_heavenly_bodies VALUES ('Proxima CC', NULL, NULL, NULL, NULL, NULL, 24);
INSERT INTO public.other_heavenly_bodies VALUES ('Proxima CC', NULL, NULL, NULL, NULL, NULL, 25);
INSERT INTO public.other_heavenly_bodies VALUES ('Proxima CC', NULL, NULL, NULL, NULL, NULL, 26);
INSERT INTO public.other_heavenly_bodies VALUES ('Proxima CC', NULL, NULL, NULL, NULL, NULL, 27);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 31, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 32, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 33, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 34, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 35, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 36, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 37, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 38, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 39, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 40, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 41, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 42, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 43, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 44, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 45, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 46, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 47, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 48, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 49, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 50, NULL);
INSERT INTO public.planet VALUES ('Earth', NULL, NULL, NULL, NULL, true, 1, 51, NULL);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES ('Sun', NULL, NULL, NULL, NULL, true, 13, 1, NULL);
INSERT INTO public.star VALUES ('Sun', NULL, NULL, NULL, NULL, true, 14, 1, NULL);
INSERT INTO public.star VALUES ('Sun', NULL, NULL, NULL, NULL, true, 15, 1, NULL);
INSERT INTO public.star VALUES ('Sun', NULL, NULL, NULL, NULL, true, 16, 1, NULL);
INSERT INTO public.star VALUES ('Sun', NULL, NULL, NULL, NULL, true, 17, 1, NULL);
INSERT INTO public.star VALUES ('Sun', NULL, NULL, NULL, NULL, true, 18, 1, NULL);
INSERT INTO public.star VALUES ('Sun', NULL, NULL, NULL, NULL, true, 19, 1, NULL);
INSERT INTO public.star VALUES ('I', NULL, NULL, NULL, NULL, true, 1, 1, NULL);
INSERT INTO public.star VALUES ('MeteorAGG211321', 323123400876, NULL, NULL, NULL, false, 20, 1, NULL);
INSERT INTO public.star VALUES ('MeteorAPF198072', 9876567876542, NULL, NULL, NULL, true, 21, 1, NULL);
INSERT INTO public.star VALUES ('MeteorAGCV', 323123400876, NULL, NULL, NULL, false, 22, 1, NULL);


--
-- Name: galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_id_seq', 6, true);


--
-- Name: moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_id_seq', 22, true);


--
-- Name: planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_id_seq', 51, true);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_id_seq', 27, true);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: other_heavenly_bodies other_heavenly_bodies_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.other_heavenly_bodies
    ADD CONSTRAINT other_heavenly_bodies_pkey PRIMARY KEY (other_heavenly_bodies_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy unique_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT unique_id UNIQUE (galaxy_id);


--
-- Name: moon unique_id_moon; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT unique_id_moon UNIQUE (moon_id);


--
-- Name: other_heavenly_bodies unique_id_other; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.other_heavenly_bodies
    ADD CONSTRAINT unique_id_other UNIQUE (other_heavenly_bodies_id);


--
-- Name: planet unique_id_planet; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT unique_id_planet UNIQUE (planet_id);


--
-- Name: star unique_id_star; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT unique_id_star UNIQUE (star_id);


--
-- Name: moon fk_moon_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_moon_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_planet_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star fk_star_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_star_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

