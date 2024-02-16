--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

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
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: chat_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_membership (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    chat_id uuid NOT NULL,
    "timestamp" date DEFAULT now() NOT NULL
);


ALTER TABLE public.chat_membership OWNER TO postgres;

--
-- Name: chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chats (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title public.citext,
    "timestamp" date DEFAULT now() NOT NULL,
    expiration date
);


ALTER TABLE public.chats OWNER TO postgres;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    text public.citext NOT NULL,
    parent_id uuid NOT NULL,
    author_id uuid NOT NULL,
    "timestamp" date DEFAULT now() NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: connections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connections (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_a_id uuid NOT NULL,
    user_b_id uuid NOT NULL,
    a_following_b boolean DEFAULT false NOT NULL,
    b_following_a boolean DEFAULT false NOT NULL,
    "timestamp" date DEFAULT now() NOT NULL
);


ALTER TABLE public.connections OWNER TO postgres;

--
-- Name: cuisines; Type: TABLE; Schema: public; Owner: jak
--

CREATE TABLE public.cuisines (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.cuisines OWNER TO jak;

--
-- Name: dish_images; Type: TABLE; Schema: public; Owner: jak
--

CREATE TABLE public.dish_images (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    bucket_key text NOT NULL,
    dish_id uuid NOT NULL
);


ALTER TABLE public.dish_images OWNER TO jak;

--
-- Name: dishes; Type: TABLE; Schema: public; Owner: jak
--

CREATE TABLE public.dishes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    restaurant_id uuid NOT NULL
);


ALTER TABLE public.dishes OWNER TO jak;

--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    post_id uuid NOT NULL,
    bucket_key text NOT NULL
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: likeness; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likeness (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    content_id uuid NOT NULL,
    like_content boolean NOT NULL,
    user_id uuid NOT NULL,
    "timestamp" date DEFAULT now() NOT NULL
);


ALTER TABLE public.likeness OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    text public.citext NOT NULL,
    author_id uuid NOT NULL,
    chat_id uuid NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: notification_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    value character varying NOT NULL,
    "timestamp" date DEFAULT now() NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.notification_tokens OWNER TO postgres;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    text public.citext NOT NULL,
    author_id uuid NOT NULL,
    "timestamp" date DEFAULT now() NOT NULL
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: jak
--

CREATE TABLE public.restaurants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    cuisine_id uuid NOT NULL
);


ALTER TABLE public.restaurants OWNER TO jak;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name public.citext NOT NULL,
    last_name public.citext NOT NULL,
    email public.citext NOT NULL,
    password public.citext NOT NULL,
    dob date NOT NULL,
    email_verified boolean DEFAULT false NOT NULL,
    username public.citext NOT NULL,
    "timestamp" date DEFAULT CURRENT_DATE NOT NULL,
    description character varying(1000),
    profile_picture_bucket_key text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: chat_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_membership (id, user_id, chat_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chats (id, title, "timestamp", expiration) FROM stdin;
6e182467-3f52-44c7-a614-72369e6a62d9		2024-01-14	\N
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, text, parent_id, author_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: connections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.connections (id, user_a_id, user_b_id, a_following_b, b_following_a, "timestamp") FROM stdin;
\.


--
-- Data for Name: cuisines; Type: TABLE DATA; Schema: public; Owner: jak
--

COPY public.cuisines (id, name) FROM stdin;
42b07797-b32f-4d62-933f-54306bb7b958	thai
0d6d6340-a2e3-44ad-a408-cf7a3d55be63	italian
4767f2d3-6022-411c-a2d0-505d7a1edcfe	indian
8a94dc63-771e-48f3-a371-e0a24a9a442a	american
\.


--
-- Data for Name: dish_images; Type: TABLE DATA; Schema: public; Owner: jak
--

COPY public.dish_images (id, bucket_key, dish_id) FROM stdin;
\.


--
-- Data for Name: dishes; Type: TABLE DATA; Schema: public; Owner: jak
--

COPY public.dishes (id, name, restaurant_id) FROM stdin;
39ef8a40-49eb-4b3d-917c-3ffc74d2263e	cheese pizza	d345f3af-c4ca-491c-b902-fe1110abaf06
01a554c3-2b79-4110-832c-3b3d78a5014e	burger	0f0c8797-29d2-455d-b3e4-51b86dea2396
4b8dfc6d-53ea-4d52-86ac-57bd4e153251	mushroom pizza	2881fd64-81b5-4d67-86a0-022a8604ce39
16115543-1211-492e-abaf-a3c93906b7b0	chicken over rice	862ed54b-0c13-46d4-8936-94e04c799ff0
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, post_id, bucket_key) FROM stdin;
\.


--
-- Data for Name: likeness; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likeness (id, content_id, like_content, user_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, text, author_id, chat_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: notification_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_tokens (id, value, "timestamp", user_id) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, text, author_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: jak
--

COPY public.restaurants (id, name, cuisine_id) FROM stdin;
2881fd64-81b5-4d67-86a0-022a8604ce39	savas	0d6d6340-a2e3-44ad-a408-cf7a3d55be63
862ed54b-0c13-46d4-8936-94e04c799ff0	indian sizzler	4767f2d3-6022-411c-a2d0-505d7a1edcfe
0f0c8797-29d2-455d-b3e4-51b86dea2396	landmark	8a94dc63-771e-48f3-a371-e0a24a9a442a
63f95ba8-b5e5-4651-9c4f-3157547a9c9f	jj thai	42b07797-b32f-4d62-933f-54306bb7b958
d345f3af-c4ca-491c-b902-fe1110abaf06	pepes	0d6d6340-a2e3-44ad-a408-cf7a3d55be63
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password, dob, email_verified, username, "timestamp", description, profile_picture_bucket_key) FROM stdin;
6717eb17-6d5d-4d93-9112-753f9770dae6	John	Khachian	jakhachian@gmail.com	$argon2i$v=19$m=4096,t=3,p=1$khPV72K0hmK3rSVVbHM47Q$BdBLEUcmbK/C5fF1jVrre0KaaHtCgHH9GcUWBBEeTrY	1997-01-26	f	jak	2024-01-26	\N	\N
\.


--
-- Name: chat_membership chat_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_membership
    ADD CONSTRAINT chat_membership_pkey PRIMARY KEY (id);


--
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: connections connections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_pkey PRIMARY KEY (id);


--
-- Name: cuisines cuisines_pkey; Type: CONSTRAINT; Schema: public; Owner: jak
--

ALTER TABLE ONLY public.cuisines
    ADD CONSTRAINT cuisines_pkey PRIMARY KEY (id);


--
-- Name: dish_images dish_image_pkey; Type: CONSTRAINT; Schema: public; Owner: jak
--

ALTER TABLE ONLY public.dish_images
    ADD CONSTRAINT dish_image_pkey PRIMARY KEY (id);


--
-- Name: dishes dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: jak
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (id);


--
-- Name: images image_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT image_id_pkey PRIMARY KEY (id);


--
-- Name: likeness likeness_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likeness
    ADD CONSTRAINT likeness_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notification_tokens notification_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_tokens
    ADD CONSTRAINT notification_tokens_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: restaurants restaraunts_pkey; Type: CONSTRAINT; Schema: public; Owner: jak
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaraunts_pkey PRIMARY KEY (id);


--
-- Name: images unique_bucket_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT unique_bucket_key UNIQUE (bucket_key);


--
-- Name: chats unique_chat_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT unique_chat_id UNIQUE (id);


--
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: users unique_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_id UNIQUE (id);


--
-- Name: users unique_username; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: notification_tokens unique_value; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_tokens
    ADD CONSTRAINT unique_value UNIQUE (value);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: messages author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: chat_membership chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_membership
    ADD CONSTRAINT chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(id);


--
-- Name: messages chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(id);


--
-- Name: comments comments_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_author_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: connections connections_user_a_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_user_a_id_fkey FOREIGN KEY (user_a_id) REFERENCES public.users(id);


--
-- Name: connections connections_user_b_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_user_b_id_fkey FOREIGN KEY (user_b_id) REFERENCES public.users(id);


--
-- Name: restaurants cuisine_id_valid; Type: FK CONSTRAINT; Schema: public; Owner: jak
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT cuisine_id_valid FOREIGN KEY (cuisine_id) REFERENCES public.cuisines(id);


--
-- Name: dish_images dish_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: jak
--

ALTER TABLE ONLY public.dish_images
    ADD CONSTRAINT dish_id_fk FOREIGN KEY (dish_id) REFERENCES public.dishes(id);


--
-- Name: likeness likeness_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likeness
    ADD CONSTRAINT likeness_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: chat_membership member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_membership
    ADD CONSTRAINT member_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notification_tokens notification_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_tokens
    ADD CONSTRAINT notification_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: images post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: posts posts_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: dishes restaurant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: jak
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT restaurant_id_fk FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id);


--
-- PostgreSQL database dump complete
--

