--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10 (Homebrew)
-- Dumped by pg_dump version 14.10 (Homebrew)

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
-- Name: cuisines; Type: TABLE; Schema: public; Owner: alyquefarishta
--

CREATE TABLE public.cuisines (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.cuisines OWNER TO alyquefarishta;

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
-- Name: restaraunts; Type: TABLE; Schema: public; Owner: alyquefarishta
--

CREATE TABLE public.restaraunts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    cuisine_id uuid NOT NULL
);


ALTER TABLE public.restaraunts OWNER TO alyquefarishta;

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
8270ee53-3198-4c19-a0a7-c68e2dc31dda	6fd91f16-db4f-4064-bab4-cb0d45104462	6e182467-3f52-44c7-a614-72369e6a62d9	2024-01-14
b97c6408-c8cd-4bd4-903f-97e98cbd2ad3	77e5dbfe-7ec0-4b4b-a179-0ae003bddb53	6e182467-3f52-44c7-a614-72369e6a62d9	2024-01-14
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
-- Data for Name: cuisines; Type: TABLE DATA; Schema: public; Owner: alyquefarishta
--

COPY public.cuisines (id, name) FROM stdin;
42b07797-b32f-4d62-933f-54306bb7b958	thai
0d6d6340-a2e3-44ad-a408-cf7a3d55be63	italian
4767f2d3-6022-411c-a2d0-505d7a1edcfe	indian
8a94dc63-771e-48f3-a371-e0a24a9a442a	american
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
f2ee1ad8-77ac-4efa-bcb8-6daf2c04e456	cebbe7c5-4811-4fe0-9289-b91eba48ea5e	t	6fd91f16-db4f-4064-bab4-cb0d45104462	2022-04-09
fecc2e8d-7cda-4c99-be2b-e620574d296d	de96c979-5053-4050-8045-215776016512	t	6fd91f16-db4f-4064-bab4-cb0d45104462	2022-04-09
e28a84d9-6943-4941-8f93-d368708ee1ec	7276ea07-871c-4154-8217-fb372faf6bfd	t	6fd91f16-db4f-4064-bab4-cb0d45104462	2022-07-08
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, text, author_id, chat_id, "timestamp") FROM stdin;
51c8c382-6d4f-4600-bc77-d08b17bb4f74	Hello	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-09 16:25:00.15313
a3994c5e-90d8-4c81-a073-ce0259946359	Hi	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-09 16:25:10.087394
ca4d7b43-5444-4521-8bf5-7029d4538e31	Sup	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:54:47.036359
5717cd4f-f017-43e4-8418-61896d2db36c	Uh	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:54:58.351946
fcb6f791-70ea-4140-8eff-ca100b378b2b	That should have notified u	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:55:05.001347
78b417be-b414-401d-82ce-07cc79f96f06	Asdfasdf	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:55:31.697601
2ec8ebaf-3416-4264-af21-fa85248a9cf2	Gsdfgsdf	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:55:47.571864
a2f1450d-89f6-4229-ba1d-127c623c40ee	Sdfgsdfg	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:55:55.61528
6e732c5d-3e74-4903-a4f7-77bd590e8d66	Sdfgsdfg	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:58:10.832279
30f38ef4-3ac0-4119-8806-a8c9bc5572bb	Dfghdfgh	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 13:58:30.544343
d42df5aa-9a45-42e9-ac74-637ee43e17e3	Fghdfgh	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 14:01:21.090788
2ea5bc49-7664-4733-bc33-2a6dfcfa373b	Asdfadsf	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 14:02:10.703723
4064473f-479c-4736-a8fc-a0faba4e0b9d	He;oh	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 14:02:22.338446
9858e64e-dddd-4cd8-bae1-c957c7b4549f	Asdfasfd	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-07-10 14:07:41.234917
f48c26eb-799a-48e4-9572-da8010cb865b	This is the way	6fd91f16-db4f-4064-bab4-cb0d45104462	a4c4cf77-07ee-4b93-81d3-9d8dcfedb720	2022-09-12 14:15:08.927114
dd95b13d-beb4-48d7-9ee9-2c0cc89554ae	Jij	77e5dbfe-7ec0-4b4b-a179-0ae003bddb53	6e182467-3f52-44c7-a614-72369e6a62d9	2024-01-14 12:45:35.202373
\.


--
-- Data for Name: notification_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_tokens (id, value, "timestamp", user_id) FROM stdin;
aef28e26-c28b-4523-a436-f9e8f4b1df58	ExponentPushToken[HUiUUBMk15i5oYOOMf2LM0]	2022-07-10	6fd91f16-db4f-4064-bab4-cb0d45104462
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, text, author_id, "timestamp") FROM stdin;
4f4b2933-c56e-404b-b0ee-3dba3d670219	Hello World	6fd91f16-db4f-4064-bab4-cb0d45104462	2021-12-07
de96c979-5053-4050-8045-215776016512	Hello world	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	2021-12-30
2d765abf-aa52-402f-91bd-2573b1bc2eae	Hello venus	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	2021-12-30
cebbe7c5-4811-4fe0-9289-b91eba48ea5e	Hello saturn	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	2021-12-30
fefec32f-bfdd-4dc3-85b2-325d0c9cfd2b	Bye saturn	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	2021-12-30
9bf2462a-9dcd-49cb-8a92-b1c195f9dd89	Bye venus	0a102be7-92a1-4d13-bfab-6ac15cbae4aa	2021-12-30
e6ec4170-0781-47b4-990f-8aebeee4d5cf	What a cool leaf	6fd91f16-db4f-4064-bab4-cb0d45104462	2022-02-04
\.


--
-- Data for Name: restaraunts; Type: TABLE DATA; Schema: public; Owner: alyquefarishta
--

COPY public.restaraunts (id, name, cuisine_id) FROM stdin;
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
0a102be7-92a1-4d13-bfab-6ac15cbae4aa	not-john	khachian	postgres@jak.bz	$argon2i$v=19$m=4096,t=3,p=1$kjFX3O3QR1IABZjAuz18wg$S/tMW9VxwroNIWGLBRAnOY/4oeQiwgDI9/koc8AhSGc	2008-12-05	f	notjak	2021-12-30	\N	\N
6fd91f16-db4f-4064-bab4-cb0d45104462	john	khachian	postgressawesome10@gmail.com	$argon2i$v=19$m=4096,t=3,p=1$q36GqcTHII+oNE+CSiR36A$ZMQalfUSZQuxa0Vkyl5xiurvSFDn/CaIyV1oLKuBi00	2002-08-11	f	jak	2021-12-06		\N
711b8042-c4a8-4e1c-98e8-576b47824ed5	randomFirstName	randomLastName	email@email.com	$argon2i$v=19$m=4096,t=3,p=1$tbkKrZfP8RjoqtTEVSfBPg$StTxtGxxx03NKS7r8c+oRDIu6GivIAXyPP7JxIH8kbg	1995-11-23	f	randomUsername	2022-05-10	\N	\N
77e5dbfe-7ec0-4b4b-a179-0ae003bddb53	Test	Testtttt	minhal@gay.com	$argon2i$v=19$m=4096,t=3,p=1$41U9X09LP9aSxKBPFMlsUQ$ACudK1CepRGX7TKv4vMe/cKAE6Cay7NOLTsv6zqKu4Y	1999-01-14	f	minhalgay	2024-01-14	\N	\N
91193ebd-1e80-47cd-8faa-06027d65482b	Sjhfd	Dsfkj	dfhjs@kdhsf.com	$argon2i$v=19$m=4096,t=3,p=1$Y5etNLz5hg51fpXPmSIlkQ$lWqhg/HFg8KjI/xxjiKNpN0INla6CzYBqVCcWpz5A5s	2010-01-14	f	ksjdhf	2024-01-14	\N	\N
ebd482ba-b2a8-4e1f-834a-92e75a80dffd	Minkle	Vakkil	bear@bull.com	$argon2i$v=19$m=4096,t=3,p=1$ZLxB2zqwld2DMhC1H75p6A$A9qZ1FiBqsUeQM6S4wjaZBaFbu2be68a4nRIHXO6N5w	2004-02-28	f	bullishbear	2024-02-02	\N	\N
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
-- Name: cuisines cuisines_pkey; Type: CONSTRAINT; Schema: public; Owner: alyquefarishta
--

ALTER TABLE ONLY public.cuisines
    ADD CONSTRAINT cuisines_pkey PRIMARY KEY (id);


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
-- Name: restaraunts restaraunts_pkey; Type: CONSTRAINT; Schema: public; Owner: alyquefarishta
--

ALTER TABLE ONLY public.restaraunts
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
-- Name: restaraunts cuisine_id_valid; Type: FK CONSTRAINT; Schema: public; Owner: alyquefarishta
--

ALTER TABLE ONLY public.restaraunts
    ADD CONSTRAINT cuisine_id_valid FOREIGN KEY (cuisine_id) REFERENCES public.cuisines(id);


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
-- PostgreSQL database dump complete
--

