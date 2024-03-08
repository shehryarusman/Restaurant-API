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
    name character varying(255) NOT NULL
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
    name character varying(255) NOT NULL
);


ALTER TABLE public.restaurants OWNER TO jak;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name public.citext,
    last_name public.citext,
    email public.citext NOT NULL,
    dob date,
    username public.citext,
    account_created date DEFAULT CURRENT_DATE NOT NULL,
    description character varying(1000),
    profile_picture_bucket_key text,
    verification_code character varying(5),
    verification_code_expiration date
);


ALTER TABLE public.users OWNER TO postgres;

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
-- Data for Name: dish_images; Type: TABLE DATA; Schema: public; Owner: jak
--

COPY public.dish_images (id, bucket_key, dish_id) FROM stdin;
\.


--
-- Data for Name: dishes; Type: TABLE DATA; Schema: public; Owner: jak
--

COPY public.dishes (id, name) FROM stdin;
df95563b-d9b3-4dca-a2ca-3aa9766b5f21	Verlasso Salmon
bcffa177-d80f-45ed-9d22-38745fb743de	Murray's Farm Turkey A La King
54fbcaa5-5b5f-4c56-ba8c-ad07da42f722	Louisiana Bronzed Catfish
0bcaa71f-d95e-4b82-8f5d-b1fadbc616b1	Country-Style Meatloaf
1d9991d4-8fbd-44b0-96a0-b1c496ac00ab	Ricotta Stuffed Shells
a93e0a49-f183-4ff1-b8c3-2ba4713d1f17	Pan-Seared Rainbow Trout
08c9eb28-b4ca-4ee6-afad-024430d7cc18	Spicy Lamb Bolognese
cf6206cd-458a-45b8-ad8f-afb1e64e07cb	Chicken-Fried Portobello Steak
6734ad3a-6d60-4a44-8e06-c8cfe4188413	Freebird Roasted Half Chicken
2caadc26-96ea-4a1a-9bf3-8a58b9019739	Spicy Thai Steak Salad
9b58036b-1735-4fd0-b19f-7c6ef583bc63	Butternut Squash Ravioli
24948ce3-2690-43a6-9116-4c32045b434d	Sakura Pork Shank
9d8b6c59-49cb-46d5-86d9-c70ef4aa4a4e	Vegan Cheeseburger
e66f5f46-5831-425b-896f-4b416bd24c8b	White Dog Double Cheddar Burger
5c37da62-8805-4452-908f-aa5eb9566ce2	Lo Mein
bded0cba-7ffa-4b46-b414-4515c426717d	Fried Rice
180c1ef2-382e-45a0-834a-50402c1b6978	General Tso's Tofu
97c147c6-d8f1-4579-9b43-7cc8747cfe6e	Eggplant w. Garlic Sauce
c42763b1-4ef4-470a-937f-8e23fcd9f29d	Stir Fried String Beans
c9f1c700-c0a8-488f-b379-df057be8b3f6	Bok Choy Stir Fried w. Sliced Garlic
cb8ef20b-0e48-4778-9018-c8859c8b5e01	Kung Pao Tofu
4ae0a1fb-ba04-404f-b8b2-1f0147abeb73	Mapo Tofu
6114f79e-563c-4603-b291-c72660bf43cc	General Tso's Chicken
e4af6696-4281-4370-bf95-5ed15d46eb5d	Sesame Chicken
cbe1d2be-8605-43da-98cd-579087c956d6	Kung Pao Chicken
508528b7-cb39-42e0-8ea0-b51e2e164bbc	Shredded Pork w. Garlic Sauce
04b8f392-813e-4605-8bdc-03c2a5442e8f	Sour & Spicy Egg Drop Soup
4966cb85-5fd5-410f-95e3-c03e4a17c20d	ABOMINABLE SNOWMAN MOCHA
f55de332-b48a-448f-af9b-b71c2438b600	PEPPERMINT WHITE CHOCOLATE COCOA
efae2e4a-9a5e-46de-9479-031f57b6b19f	COOKIE BUTTER CHAI LATTE (HOT OR ICED)
cb1191f6-9ca8-44e7-a900-665837f30bdc	Butterscotch Caramel Latte  (Hot or Iced)
f35e9d3d-87fd-48a9-9378-cd16c7690a29	HOLIDAY LEMONADE
b0b84035-78a1-476d-884a-221491cd3d49	STUFFED FRENCH TOAST LATTE
0eeb13f9-df89-4a53-87b3-327cdc9886da	BLUEBERRY LAVENDER LEMONADE
933f718a-a49e-43c9-a415-096dcdd121b2	HOT CHOCOLATE
e168bfd1-65a6-4182-b8a8-de4f38098f54	COFFEE | DECAF
a3fbcf3b-ab8d-4fcd-9232-945fc2f69c7a	FRESH BREWED ICED TEA
c5b5bd74-4b29-4d5d-90fa-6e278ba91e04	FRESH SQUEEZED LEMONADE
99b8a6ad-6fa7-4867-a917-3fe2eb7a1707	FRESH ORANGE JUICE
d7fbb07e-7a2d-4579-a03f-e7bfa07a4b20	JUICE
b6c11884-bcfb-4620-a766-19beeef37e6f	HARNEY & SONS HERBAL TEAS
ecc1b82f-3f86-4c6a-a663-fa53778320ca	TOM AND JERRY’S BREAKFAST “CHEESE” STEAK
da0fbe92-f054-4acc-9577-499c91f78c54	SCOOBY AND SHAGGY’S SCOOBY SNACK PANCAKES
5d01c977-0c02-48dc-aba4-2bdf371a4c9e	PORKY & PETUNIA’S BREAKFAST HASH
3cc748d5-cea8-4a1e-9df6-a07fd28fffe8	PEPE LE PEW AND PENELOPE’S PASSION PANCAKES
2e7e5053-dac4-4ebb-ade0-8db5ce5ae667	POPEYE AND OLIVE OILS FAVORITE SANDWICH
2120a51c-93f2-4e6b-baf7-19f2a3c95292	SPONGEBOB AND PATRICKS COCO-HUT SHRIMP BOWL
2aa6d7ea-8c35-4e42-b437-2110870a7749	TWO EGGS ANY STYLE
86b39b1f-9eb6-45fa-9cfc-75d358a44f37	HUEVOS RANCHEROS
f62f8ccf-31e6-4460-952e-02005143a537	SHRIMP & GRITS
46535bde-a991-42aa-bef7-21571cbdbb5e	CALIFORNIA DREAMS OMELETTE
2f818f11-17c9-4371-8cd5-fef1a2c1d3c6	ULTIMATE MEXI SCRAMBLE
72510895-c4f7-4ccf-8760-9161eab6d380	STUFFED CHALLAH FRENCH TOAST
46eab087-524e-4cf4-aa07-a39286fae1d4	CHICKEN & WAFFLE
4609df30-4729-4473-b06f-62da98bb9804	VEGGIE PATCH OMELETTE
485230aa-1da6-47d7-9c0e-17608582fcfd	TOFU SCRAMBLE
fe252ad0-9355-4c99-be2e-9132b02b604f	VEGETARIAN HUEVOS RANCHEROS
b80cdeda-85f7-4d19-8453-67be0311ede5	5 GRAIN BREAKFAST BOWL
aa6114ad-184b-4836-84dd-685369e064bd	PHILLY HOMETOWN OMELETTE
625dc41c-af66-4254-8893-4748f5f90c47	BREAKFAST TACOS
20ad9366-1929-4886-8651-2b90c9cb85a2	EGG SANDWICH
547bc0b6-c4a1-42d3-bd1e-ab3fe34e7a4d	BELLA VISTA OMELETTE
cf401d27-1f5b-4ee0-ba9a-976ed7bd9961	TERIYAKI SALMON BOWL
ac689aac-ddea-4516-a1d3-8afe84222f1a	JERK CHICKEN RICE BOWL
5ff00e06-3f94-46ef-b3d8-88e4981bb0eb	KOREAN CHICKEN KIMCHI BOWL
7af4a519-71be-4f1a-9f6b-173db9b9e091	VEGAN BOWL
4169c6d0-f630-4816-acff-b35b1d65a101	BUILD YOUR OWN BURGER
7b09fda3-19f6-4f5c-8896-34d58da3339e	CALI TURKEY
758154ec-d842-448c-b317-a0199a49f862	JERK SHRIMP TACOS
71d2a4b7-1d2c-4b12-817a-afe3750fee99	SANTA FE TURKEY BURGER
a1ec423b-799e-4d86-b8a5-009d91c2d57c	MEL'S CHICKEN SANDWICH
9f0e0be8-42da-47ec-a316-8b2c743c2a7b	HOUSE ANGUS BURGER
b61bfd3d-d7ce-44ab-ba32-c9a2526a5c72	SABRINA'S CHICKEN SALAD
09842b80-82b7-4569-8411-d764dbe10636	SOUP & 1⁄2 SANDWICH COMBO
8989a57d-df77-47c8-8132-df4816141e82	BUFFALO CHICKEN SANDWICH
8dc5cc65-f755-469f-9724-acb5feec5ddc	VEGGIE PHILLY CHEESESTEAK
dd4972fb-7dac-4e9a-a31d-723579d638bf	BAHN MI
e4bf0a8e-86bd-4dbe-be26-db210b341eac	JERK SHRIMP TACOS
1d2afcf3-f0db-4e9b-a703-c02b9c8ff1c7	CALI TURKEY
90921bd4-adb5-40c3-aa6c-209c1355e4d0	MEL'S CHICKEN SANDWICH
566c94dc-387f-4dfc-a707-897e08f353eb	SABRINA'S CHICKEN SALAD
43da6cb1-c96b-4243-9730-d8aec74adaf5	BUFFALO CHICKEN SANDWICH
5a93d5f7-44fa-4488-b693-94f7cfa4f39a	VEGGIE PHILLY CHEESESTEAK
c1339ea1-fe99-4580-b43b-92489f374faf	BAHN MI
4a690e03-45d0-4a37-b17f-556e2b8a4dfb	SANTA FE TURKEY BURGER
b112367e-cf2d-4d46-9d76-0fa9050adddb	BUILD YOUR OWN BURGER
c9fe0a6d-24c7-4c5f-a64d-c96a4e0e23f8	HOUSE ANGUS BURGER
92ff8b6f-3b55-4843-99e9-32a80b82c3b0	Mum Mum's Chicken Noodle Soup
785dd184-94bb-4d39-90a4-802ab0f26da2	Sabrina's Soup Of The Day
842a0fd8-690b-4e6a-a557-79aa7a638939	Sabrina's Field Salad
d76816b1-74f9-4ab1-9d9f-c5f9aca3be64	Buffalo Chicken Cobb Salad
7277261b-f29c-4b19-8e2c-319c266e0935	Greek Salad
90cbb1d9-4198-40c4-8200-c6256be4e345	Island Shrimp Salad
09be985c-5f7d-44a5-b164-7f34e848b620	Caesar Salad
e447003c-6593-4c0b-8a14-3a9d63a30f57	Pork Soup Dumpling (8)
dcee52e3-f896-451d-9df9-002a09233db7	 Scallion Pancake
0472674b-d57d-4067-870a-4af0f7c68cb7	 Authentic Fried Rice
d085d8de-d10d-405b-814d-6113c9039419	 Dan Dan Noodles
1fa1b0db-9a52-45e4-a34b-13c2c671f098	 General Tso's
80a8fa26-96b6-479e-bd4f-c33d5afd60a8	Roast Pork Bao (3)
33ceed4d-a5d5-4a9d-93b0-163d548c4a88	Crab & Pork Soup Dumpling (8)
020af66d-bd9c-4f90-ae52-1f1fa7f0107a	Spicy Pork Soup Dumpling (8)
8d1451f3-29bc-443e-b4dc-88488701532f	 Beef Lover's Quarrel
b9775503-90f8-4671-a898-1c90d12def44	Pan Fry Pork Soup Dumpling (6)
b8996d3c-f854-443d-9a15-0938b30b6295	 Beef Stuffed Scallion Pancake
8062e82c-f8b6-4bb0-b5c7-d356f6a7cf03	 Honey Vinegar Spare Ribs
1f4dd511-d3be-4815-92c0-c3c2e32afd19	 Pickled Daikon & Carrots
c8818efd-61c7-4a5c-ab33-1f419a28369e	Pork & Leek Dumpling (6)
a076dd4c-2a46-490d-b478-e4696ae3d747	Pan Fry Beef Dumpling (5)
a6b130e9-ce19-46db-84a7-4e1bb4ce9c61	Chicken & Mushroom Dumpling (6)
5aa2cd71-4873-4fc2-8138-73a4124d7e81	Truffle Edamame Dumpling (4)
d902ff53-47e9-45d4-860c-53bb11a327a9	Steamed Vegetable Dumpling (4)
5b8302a3-8d1c-48fe-b0a6-172d31bfdb7f	Pumpkin Tart (4)
663d9eae-26ef-4d48-9414-93c3a74fcbe3	Vegetable Spring Roll (2)
37634945-b9f6-4961-a7f7-0129ed1ab059	 Sesame Soy Brussels Sprouts
3a36666c-1d80-4e77-b056-7d4dfb6b424d	 Pickled Garlic Cucumber
dfcdaf31-febc-411c-bfeb-19e1521967ad	 Chili Oil Wonton
f326e1bf-0e71-4eed-b265-c538df166e64	Beef Dumplings (5)
405db794-7449-4d81-9c1e-f935127f6579	Vegetable Dumplings (4)
dbd67a38-8278-452b-9a19-d430b12ada01	Crystal Shrimp Dumpling (4)
756c05bc-b032-40fe-aef4-4e80af9d36f5	Extra Spicy Shrimp Dumpling (4)
eba02125-0dea-401f-95a7-acb466c63221	Pork & Shrimp Siu Mai (4)
cb374e22-0db8-4891-bf7d-2a18bcaf0332	Shrimp Siu Mai (4)
b85e01c8-96a0-46a1-a3d3-2d299a996229	Shrimp Cheung Fun (3)
285a803a-bf18-441a-b7e7-4d36bf21ad9d	 Chicken Feet
fa9f92ba-99d6-4173-81a0-a6a11415139c	Shrimp & Chive Dumpling (3)
d4636de4-e165-49ae-98d3-9d82ba309f0e	 Tofu Black Bean Sauce
d5530bcf-b4a5-4593-817d-4efc3c79bd2b	 Turnip Cakes
a4c918bc-bc52-4aa5-bd2e-b38d1ccf40a8	Vegetable Tofu Skin Roll (3)
92859a04-626d-444f-aa18-3f642bb52e8a	 Hong Kong Sticky Rice
4deab506-4d61-4000-a114-36e4d65f1e48	 Hot & Sour Soup
6f4e5568-1eff-495c-93f8-5fbdfa02ae1c	 Vegetable Tofu Soup
2b864638-38c6-402a-9d06-6feb690708a3	 West Lake Beef Soup
0108668a-ed3f-4404-9774-cea91e428f5a	 Mustard Green & Flounder Soup
5f1783d8-9c98-474d-bcb0-eb5e22ab71ad	 Shanghai Wonton Soup
8b1a4f37-3ee4-4a70-8722-73d602063ca8	 Steamed Lobster & Canton Noodle
e7322ec0-7672-4349-bb5d-9765bab9287b	 Stir-Fry Lo Mein
c4aba8aa-bddc-4241-9058-7533c7d2dcc4	 Lobster Sticky Rice
6af23fd3-577f-4b73-9a04-988518626b8d	 Crabmeat Mushroom Fried Rice
2d675ad3-45b7-4b41-94e6-a08186df5a72	LINGUINE & CLAMS
fd68212b-c2c8-4377-9269-1282ef19e078	 Stir-Fry Pad Thai
86eae356-6d19-4a86-904d-ad975b586394	 Stir-Fry Ho Fun
6b24ece1-8888-4660-a486-5e65b47bf5fc	 Singapore Mei Fun
5e5bcd35-6bce-444a-9e26-8ac083e94762	 Black Mushroom Bok Choi
d3f96258-c9a8-41c4-a088-3a8d374c5ed1	 Garlic Snow Pea Leaves
e8317bd7-847e-443c-be7d-6c9c379de49d	 Mapo Tofu
25e152e8-89e0-4e87-b3e3-320cc6184cf3	 String Beans & Mustard Green
7f8c2ff7-1788-4eb1-a814-ea5904f3eba0	 Eggplant Garlic Sauce
6fdb322e-dcb0-4584-9cf2-eb2590fb9dc2	 Shanghai Bok Choi
adca7e87-b1bb-4bc0-926c-23705ac04bc1	 Stir-Fry Brussels Sprouts
c3f66dad-0bbd-4bb2-b82a-b500698d89b5	 Stir-Fry Young Asparagus
25968cac-88c3-40be-ba9f-69e534f383f4	 Ginger Scallion Lobster
be6f46ab-23c0-47a7-8166-5c0c55582720	 Steamed Whole Fish
4aff8216-3012-47c3-990e-c7916f0d742f	 Sweet & Sour Whole Fish
7934c97d-d539-473e-91d2-bc5dd63410e9	 Typhoon Lobster
40d8ff4f-6251-4e8a-aad3-71eb949d0ea9	 Typhoon Jumbo Shrimp
b6a74815-15ae-4ee2-8d22-71b9b627a56f	 Ginger Scallion Fish Fillet
0cfd3ea2-7f4c-4cd0-adb3-2cb18dacc1dc	 Salt & Pepper Triple Seafood
9951e658-3580-4173-a26b-f436442fbc57	 Salt & Pepper Squid
cd374499-01e3-41f0-b386-ee17a60672a4	 Spicy Tofu Fish Fillet
3a48e24a-ddcd-468d-a73e-e471d6e4d953	 Honey Walnut Shrimp
fe60c76c-297a-44eb-99c3-e6b93380fb74	 Peking Duck
6646df8d-3f1e-49dc-9d2c-0e14e85529f7	 Pork Belly & Mustard Greens
5e57f6da-dd55-4dfe-b04a-16ed1b2607ee	 Sizzling Beef Short Rib
94e932d2-535f-434b-a7c5-a1984d7aff79	 Salt & Pepper Chicken Wings
4458991c-e17f-4333-a92c-21f5f4cdd21b	 Long Hot Style
cb978cdc-cb1d-40b8-893a-120f40d5d9e3	 Kung Pao Style
196e9643-a51e-4df0-8802-3643408157c0	 Mongolian Style
77a9954e-58f6-4610-b61a-4ab4d32e246c	SALMON BELLY
85dc98d1-9200-4e8a-9817-00e866cb75b5	1/2 DOZEN EAST COAST OYSTERS
6a27a18b-7c17-4ee1-8805-e7375147e490	BEEF CARPACCIO
0f2d1643-c49f-4197-82ba-6b829751f2ba	ARUGULA
6a457d71-f29a-4626-93b2-962bdb060cc2	HERB-CAESAR SALAD
591f2c2e-457c-4084-b92f-f1683bc2d70b	ROASTED BEETS
8cbc2c86-43ba-49af-97d7-d54ccc022340	CRISPY BRUSSEL SPROUTS
bc4b77cb-fbdc-47a9-8a80-0f6c8406d9cc	GRILLED OCTOPUS
bbcfd49d-5faa-48ec-a4c9-7bd25fffc2fc	CALAMARI
4877c1e1-db61-436d-84d4-1d77d63f1351	MUSSELS
3b3ae6ba-9f4a-4515-871a-586501c897db	BURRATA
b257015f-0fa9-4e6f-bf13-bddd1d3756aa	GRILLED ARTICHOKES
d971a699-7e36-4746-bba6-06e36a2e6d92	PAPARDELLE
35dd96ed-0b6e-4936-9f2d-303bb3bbcc90	SQUID INK SPAGHETTINI
44732768-ff4e-47ce-b186-1d97e63d6648	TORTELLONI
8d3f7e61-beb6-4414-8f6e-75eb5e087e7a	RAVIOLI
356ec2aa-b948-4479-86e2-7e1bc3b88458	GNOCCHI
1a66b985-bb35-4867-8c9a-d4f6399e51b4	CRISPY GNOCCHI
7789f542-177c-4ea0-9dc5-a396bba081d3	CACIO E PEPE
1702e551-b960-40c3-a49a-1cb1b9ed7f29	MAFALDINE
010fdf52-415d-45a6-9b3e-58b28b3eac03	RISOTTO
284f9d6b-bbb0-4ba6-a6f4-6d566400e2fa	AIRLINE CHICKEN
d82bd473-949d-44a1-b7b9-67031a3cf1a8	CHICKEN MILANESE
9ea3df9f-c9c2-41db-8d68-350c820b6ae7	MOULARD DUCK
a4f43090-9dbd-4126-9476-c3856e09b567	VEAL MEDALLIONS
020c9247-c15f-49eb-a978-e1397b2817a5	SHORT RIB
67ff55c0-d1a9-42cd-ae42-3ef65447506e	SALMON
64b2dae7-4d9c-4db2-81c7-71dab4d64974	BRANZINO
9d04337f-fcc8-4631-a6e8-f25be13234b0	Cumin Style Stir Fry
2ad8d5f3-c1bf-4f17-bb82-b1b72c95fd2f	Sichuan Cilantro Chicken
240020a6-eb39-48ed-a869-0aee45b7ab04	Mapo Tofu (Vegetarian)
c22923a6-fb47-4ae2-91e3-12f4448e0cc6	Spicy and Sour Shredded Potatoes
08d45342-6805-4d56-a91a-917a1219b284	夫妻肺片 Beef & Tripe In Chili Oil
c37c69ed-2b7e-4c0f-874c-8e34c9329f7a	Dumplings in Chili Oil
cc55ec8a-bb2c-4a3d-8cbb-cb7ffd0c35f4	West Lake Beef Soup
46a1bf2d-1b5e-4ea2-8f89-0a80c933c9f6	Vegetarian Dan Dan
5b093cb0-0569-4f08-ac7d-0f624c0a73c7	炒飯 Fried Rice
8b5bcde3-7d7f-4bb7-8107-3841d89f591b	Kung Pao Style (3).
03ec7105-8362-4ad6-8f5a-6ddc3d4b5f57	General Han's Chicken
1f86105b-f91f-4180-838a-f7383ff3a2e7	Eggplant w/Garlic Sauce
a759a5d3-8b31-4a64-ae12-72506d06f0e3	麻辣牛筋 Beef Tendons In Chili Oil
a75f16b2-038f-4c66-a894-2b9cf509e2e2	CHEESE BOARD
fafe5690-4cc0-43f0-87b6-465f28d85865	HEIRLOOM CARROTS
a7ed0bd3-e82d-4cb8-b7ba-b292fb27e32b	SQUASH SOUP
d5714c5f-daf7-4cf9-a37b-18d8acdc6524	HALF ROASTED CHICKEN
1b7d52fc-5a70-4681-b470-d62536cd5505	CRISPY BRUSSEL SPROUTS
294ce77c-a5f6-4646-aa1d-b997b2cca4d2	SWEET POTATO FRITTERS
b3f91f4e-c981-4970-8c22-90fa366b88ff	LATKE
ec55cdd5-4ec7-4515-a923-d56208c66198	FRENCH ONION SOUP
3eae54c1-5473-4f0c-a796-ea35ad1fb9c3	PUMPKIN AGNOLOTTI
a97a1b92-2289-4bbe-8154-142566442686	PETITE GRILLED STEAK
228c0f40-904a-4145-bcd1-766fc621a097	POMME PUREE
07d05ee5-833d-401b-a227-5ce98c508c04	CASTLE VALLEY CORNBREAD
1f885f43-8562-4245-8012-e3bc43245d83	FRIED MAITAKE MUSHROOMS
3c886cbb-f6eb-455d-90e3-8307524c2577	GEM SALAD
837c0c49-63ab-4c0b-98a0-174e7c2c0e06	GNOCCHI
78cdb23f-fa91-461f-8044-41b006f1d54c	BRAISED SHORT RIB
cc7d27ad-df00-4c8a-bd40-20408aedd701	MAC AND CHEESE
cbe770ce-b0b1-4b67-b6e3-8fe89a4aa939	BLISTERED SHISHITO PEPPERS
cdd5f194-4582-4a43-a31e-7b16ff630f7f	CALAMARI
2c44da5f-338c-4025-b42c-d9c114eab651	KALE SALAD
7170d82e-f559-476e-99f6-15726c054cea	BUCATINI BOLOGNESE
bda78459-50d7-45e5-81e2-6959c22161d6	GRILLED BRANZINO
9ecc62ee-4fd5-4061-a63f-5fb232bcf05e	WHIPPED RICOTTA
6d5ed09c-eefa-4fd9-9ab1-beea87e5ed5a	GRILLED STONE FRUIT SALAD
10e4ad1b-319f-4f11-a9dc-3ded6a0ec292	CO-OP BURGER
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, post_id, bucket_key) FROM stdin;
5a2b3bc0-7258-45f0-9fb2-7e7314a3f20e	8ff64ba6-da75-4534-a0a3-f7c9a1ef4d5c	post_images/31ab500fc5710621dedb27460b4634e2
\.


--
-- Data for Name: likeness; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likeness (id, content_id, like_content, user_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, text, author_id, "timestamp") FROM stdin;
8ff64ba6-da75-4534-a0a3-f7c9a1ef4d5c	This is a post	bf543839-fc0f-4087-8c22-3d0eb3b2a3eb	2024-03-08
\.


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: jak
--

COPY public.restaurants (id, name) FROM stdin;
12c3da38-d694-4e52-9320-52e0f7e21720	White Dog Cafe University City
10199537-9d3a-4f0a-ac03-25e07cdedcba	Chengdu Famous Food 成都名吃
80b08c32-80cd-487a-92a3-1a00b5c45b39	Sabrina's Cafe - University City
8f7dfeab-a59b-42ff-982f-b89dab57b86a	Dim Sum House by Jane G's - University City
e0e4af33-dcba-4e6a-9679-bcce2dc1b5fe	Ambrosia Ristorante BYOB
17bcce98-915c-4ee1-a57c-acb338634d40	CO-OP Restaurant & Bar
1c03de1e-18c4-4cef-add6-b43d8fca6a47	Stir Restaurant
892998eb-5136-4c27-a5b9-9ba0b817df39	Cotoletta Fitler Square
eb989ee6-aa4b-4d74-b8af-53d1079b4dd8	Rosy's Taco Bar
34af2b92-3b09-4bf6-9d9c-a9fe375d3124	Thai Singha House
f8d89d0b-0804-434a-91a1-01ed6f9d39ff	Stuff'D by Jannah Jewelz
92cc6117-696d-4cfa-a7cd-ffa5e1693b32	Erawan Thai Cuisine (Philadelphia)
79545490-370a-4fe0-8057-c2d3bdd39b3c	El Taco
4d1f327e-3b36-4a4d-aa02-0cebf9c174a2	Pod
a1d1ce5c-fdca-4f7f-930a-6703f4a39b41	Walnut Street Cafe
1eaf74c6-42bc-4e66-a086-b82af16a5cf7	Northside Dining Terrace
3350db23-78fd-4369-9d22-8e63794dd457	Tacos Don Memo
7ab4c512-7db4-40ef-896c-9b29f63671ca	Lucky Chinese & American Food Take Out
6b01ed68-06dd-48a2-98f8-ab7a5fa6d36b	DIG
f04417e7-59af-41dd-a2d0-608da9209faa	Bonchon University City
12066a53-9e29-43a1-9d6f-ebe7dd349fee	Kim's Oriental Foods
af1ebf99-077f-439f-8ad2-5305919f9fa8	NAM Vietnamese Kitchen
f6f165d2-96e6-438c-8532-618a45d87295	New Deck Tavern
dd0a748d-544e-41c3-92ef-25cd021df4fb	Spring Chinese Restaurant
555c673e-cbcc-4400-8b7e-f8779353ceb8	Chipotle Mexican Grill
7b4c772c-a281-435c-8c3c-65bd7d66fce6	Ochatto
c953cb74-7649-4979-8379-e2544b6d91ad	&pizza - UPenn
2820497e-1f3f-4451-ab1b-726899dc4836	Amma's South Indian Cuisine
ff5efec0-3072-4d65-bb9e-55feeee8d92c	Axis Pizza
a7932630-a175-4099-801e-e034f5717b32	Halal Cart
23a226a6-64fd-4662-8dd3-0b1574532e9b	Freshii
c9469464-5912-4347-9425-23cf7f28ecde	Greek Lady
4f65ad92-a70f-452d-ae26-e9f3d26881a7	New Delhi Indian Restaurant
ae05b723-0bf8-4860-b607-c2ef247d9ffc	Five Guys
06845fb5-bfaa-40a4-ba11-9271592d2777	Quality Taste Jamaican Restaurant & Jerk Hut
991dcf4b-58a3-4f7e-9bbb-fdb87cc59151	Ekta Indian Cuisine
4b60f5cb-db9e-4563-973f-6ba6ef84202c	Copabanana University City
5dd24ca4-cc1b-402b-9cbd-cd7d1369c19e	GAETANO’S PIZZA & STEAKS
7da643eb-5cec-4cd6-8253-6d2253bbba53	Rana Halal Cuisine
eb76d1cd-bbb3-47d3-949e-eb2da8c9e0b7	Raising Cane's Chicken Fingers
c8dc3490-f7be-407a-9a02-b3e8990e9310	Halal taste food cart
5a8d943e-37c3-49c7-b435-c2f1028c614c	McDonald's
c66f09de-26c6-4002-ae5f-1332f96ca1cd	QDOBA Mexican Eats
a1984aea-cb21-4d1b-9422-38846e5d7475	HOMEI Restaurant
dd1c371e-0966-4f13-ae45-6c5dbbbdbb57	Mission Taqueria @ Giant Riverwalk
809616bd-2901-4623-9766-153a9509b19f	Golden Lake Chinese Restaurant
75279f53-4032-42e3-b218-0e3e46ea06ed	Pete's Famous Pizza
55b5fe28-3ca1-4988-88bb-e7c385b1e5ef	Xi'an Sizzling Woks
14b78853-8fd5-474f-a3cb-2062f972dce1	Latao Hotpot and BBQ
4a8169c5-e870-4068-a0c6-7387f8d998c1	Jimmy John's
e92e281f-5600-4d66-8340-a9c4c2d98c7e	Birria City
c9c732e0-38aa-464a-a3dc-0c67d021ae65	Tataki Ramen & Sushi
1435f4e6-8882-4839-af74-41f816a23970	Delco Steaks
8eb432fa-0a5d-4ec5-9589-63e8d50fa54e	HipCityVeg
e2d1f9b4-620c-4678-9786-541301086287	Khaosan Thai Cuisine
5f1b2283-c022-43fb-891a-51c7eebd23f5	Wawa
72444425-6d37-484d-8e37-aa5b828ffcc7	Crown Fried Chicken
42a98395-68b7-4669-a4e5-fc98a4237d07	Shake Shack University City
62d217d2-29ea-48a9-92c6-5f974c706f50	Han Dynasty
480eb4d4-1afe-4275-b778-9baf044eadb3	Sang Kee Noodle House
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, dob, username, account_created, description, profile_picture_bucket_key, verification_code, verification_code_expiration) FROM stdin;
dea6de8c-9e33-4f83-b1db-cefce9fd6d4b	\N	\N	jkhachian@gmail.com	\N	\N	2024-03-01	\N	\N	76846	2024-03-01
b2a57cfb-1c98-44f4-8400-958078afe5ca	\N	\N	jaksawesome10@gmail.com	\N	\N	2024-03-08	\N	\N	83608	2024-03-08
bf543839-fc0f-4087-8c22-3d0eb3b2a3eb	John	Khachian	jakhachian@gmail.com	2002-08-11	jak	2024-03-01	\N	\N	02641	2024-03-08
\.


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
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


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

