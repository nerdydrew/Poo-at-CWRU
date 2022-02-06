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
-- Name: building_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.building_type_enum AS ENUM (
    'academic',
    'administrative',
    'athletic',
    'other',
    'residential',
    'restaurant'
);


--
-- Name: gender_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gender_enum AS ENUM (
    'male',
    'female',
    'any'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: buildings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buildings (
    id bigint NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    blurb character varying,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    building_type public.building_type_enum,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buildings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buildings_id_seq OWNED BY public.buildings.id;


--
-- Name: floors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.floors (
    id bigint NOT NULL,
    name text,
    slug text NOT NULL,
    level smallint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    building_id bigint NOT NULL
);


--
-- Name: floors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.floors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: floors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.floors_id_seq OWNED BY public.floors.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    toilet_id bigint,
    "user" character varying NOT NULL,
    cleanliness integer,
    location integer,
    wifi integer,
    writing integer,
    traffic integer,
    toilet_paper integer,
    overall integer NOT NULL,
    comments character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: toilets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.toilets (
    id bigint NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    gender public.gender_enum NOT NULL,
    building_id bigint NOT NULL,
    floor_id bigint NOT NULL,
    stalls integer,
    urinals integer,
    sinks integer,
    comments text,
    creator text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: toilets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.toilets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: toilets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.toilets_id_seq OWNED BY public.toilets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    case_id character varying NOT NULL,
    gender public.gender_enum,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: buildings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buildings ALTER COLUMN id SET DEFAULT nextval('public.buildings_id_seq'::regclass);


--
-- Name: floors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.floors ALTER COLUMN id SET DEFAULT nextval('public.floors_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: toilets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.toilets ALTER COLUMN id SET DEFAULT nextval('public.toilets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (id);


--
-- Name: floors floors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.floors
    ADD CONSTRAINT floors_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: toilets toilets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.toilets
    ADD CONSTRAINT toilets_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_buildings_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_buildings_on_name ON public.buildings USING btree (name);


--
-- Name: index_buildings_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_buildings_on_slug ON public.buildings USING btree (slug);


--
-- Name: index_floors_on_building_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_floors_on_building_id ON public.floors USING btree (building_id);


--
-- Name: index_floors_on_building_id_and_level; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_floors_on_building_id_and_level ON public.floors USING btree (building_id, level);


--
-- Name: index_floors_on_building_id_and_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_floors_on_building_id_and_slug ON public.floors USING btree (building_id, slug);


--
-- Name: index_reviews_on_toilet_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_toilet_id ON public.reviews USING btree (toilet_id);


--
-- Name: index_reviews_on_toilet_id_and_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_reviews_on_toilet_id_and_user ON public.reviews USING btree (toilet_id, "user");


--
-- Name: index_toilets_on_building_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_toilets_on_building_id ON public.toilets USING btree (building_id);


--
-- Name: index_toilets_on_building_id_and_floor_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_toilets_on_building_id_and_floor_id_and_name ON public.toilets USING btree (building_id, floor_id, name);


--
-- Name: index_toilets_on_building_id_and_floor_id_and_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_toilets_on_building_id_and_floor_id_and_slug ON public.toilets USING btree (building_id, floor_id, slug);


--
-- Name: index_toilets_on_floor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_toilets_on_floor_id ON public.toilets USING btree (floor_id);


--
-- Name: index_users_on_case_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_case_id ON public.users USING btree (case_id);


--
-- Name: floors fk_rails_ae3c731da8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.floors
    ADD CONSTRAINT fk_rails_ae3c731da8 FOREIGN KEY (building_id) REFERENCES public.buildings(id);


--
-- Name: reviews fk_rails_ea6bcaa95e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_ea6bcaa95e FOREIGN KEY (toilet_id) REFERENCES public.toilets(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20181219021446'),
('20181219172002'),
('20181219174507'),
('20181219212741'),
('20181220162921'),
('20181220192723'),
('20181224033157');


