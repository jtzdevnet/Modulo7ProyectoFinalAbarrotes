PGDMP      )                |            db_abarrotes    16.3    16.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            	           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            
           1262    16762    db_abarrotes    DATABASE     �   CREATE DATABASE db_abarrotes WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE db_abarrotes;
                postgres    false            �            1259    16772    clients    TABLE     0  CREATE TABLE public.clients (
    client_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    address text NOT NULL,
    area text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    postal_code text NOT NULL
);
    DROP TABLE public.clients;
       public         heap    postgres    false            �            1259    16771    clients_client_id_seq    SEQUENCE     �   ALTER TABLE public.clients ALTER COLUMN client_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clients_client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    16781    orders    TABLE     ^   CREATE TABLE public.orders (
    order_id integer NOT NULL,
    client_id integer NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    16779    orders_order_id_seq    SEQUENCE     �   ALTER TABLE public.orders ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    16764    products    TABLE     �   CREATE TABLE public.products (
    product_id integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    sku text NOT NULL,
    descr text
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    16763    products_product_id_seq    SEQUENCE     �   ALTER TABLE public.products ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    16786    sales    TABLE     �   CREATE TABLE public.sales (
    sale_id integer NOT NULL,
    product_id integer NOT NULL,
    order_id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    quantity integer
);
    DROP TABLE public.sales;
       public         heap    postgres    false            �            1259    16815    sales_sale_id_seq    SEQUENCE     �   ALTER TABLE public.sales ALTER COLUMN sale_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sales_sale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221                       0    16772    clients 
   TABLE DATA           z   COPY public.clients (client_id, first_name, last_name, email, phone, address, area, city, state, postal_code) FROM stdin;
    public          postgres    false    218   !                 0    16781    orders 
   TABLE DATA           5   COPY public.orders (order_id, client_id) FROM stdin;
    public          postgres    false    220   B$       �          0    16764    products 
   TABLE DATA           G   COPY public.products (product_id, name, price, sku, descr) FROM stdin;
    public          postgres    false    216   �$                 0    16786    sales 
   TABLE DATA           U   COPY public.sales (sale_id, product_id, order_id, "timestamp", quantity) FROM stdin;
    public          postgres    false    221   -*                  0    0    clients_client_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.clients_client_id_seq', 12, true);
          public          postgres    false    217                       0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 19, true);
          public          postgres    false    219                       0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 12, true);
          public          postgres    false    215                       0    0    sales_sale_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.sales_sale_id_seq', 11, true);
          public          postgres    false    222            c           2606    16778    clients clients_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);
 >   ALTER TABLE ONLY public.clients DROP CONSTRAINT clients_pkey;
       public            postgres    false    218            f           2606    16785    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    220            a           2606    16768    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    216            j           2606    16790    sales sales_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (sale_id);
 :   ALTER TABLE ONLY public.sales DROP CONSTRAINT sales_pkey;
       public            postgres    false    221            d           1259    16796 	   client_id    INDEX     A   CREATE INDEX client_id ON public.orders USING btree (client_id);
    DROP INDEX public.client_id;
       public            postgres    false    220            g           1259    16808    order_id    INDEX     >   CREATE INDEX order_id ON public.sales USING btree (order_id);
    DROP INDEX public.order_id;
       public            postgres    false    221            h           1259    16802 
   product_id    INDEX     B   CREATE INDEX product_id ON public.sales USING btree (product_id);
    DROP INDEX public.product_id;
       public            postgres    false    221            k           2606    16791    orders client_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES public.clients(client_id) NOT VALID;
 :   ALTER TABLE ONLY public.orders DROP CONSTRAINT client_id;
       public          postgres    false    220    4707    218            l           2606    16803    sales order_id    FK CONSTRAINT        ALTER TABLE ONLY public.sales
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES public.orders(order_id) NOT VALID;
 8   ALTER TABLE ONLY public.sales DROP CONSTRAINT order_id;
       public          postgres    false    220    4710    221            m           2606    16797    sales product_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.products(product_id) NOT VALID;
 :   ALTER TABLE ONLY public.sales DROP CONSTRAINT product_id;
       public          postgres    false    216    221    4705                '  x�uTMo�8=�~� ��D}ݪi�l��6A�(z��lL�"��hl�o��C�@��c;T��HÀ�(�o�͛�&?m	���ٙ,y5�`����@ڤ��(��D�Bd9����4���~��:����@2�#OpAF��)e�%9tvrV;�e<�������42�|�Z�ʺ�:�2>ｚ�'����u�O�cHQ4i�<~��q�vʻ�A���E���j����E^�YR��_�|�&F��v�~y�;7�T-oN�ɥ@)�+�B�ǿuﶓ�=Ms!$��I�g=�|k�ߞu�6+�2�pF�:?(����㲕ҲE�sJX�QZ,D[^+;)XW5\���nԆ��W3�ܱ:�3���ۄ5Q�������>��8���t������U�"ͱ�g�g�F�6%���kc�=m\���qX,��
j��R9,W��T���㙁�8��Ï����5YTUT��'�G��״�re���y�3�J��N��;~G0q:,���mlX�V�ͺ}����o�)J\��`���v{��e���}��W�v�>|��u�eIw�>$��j�����=O�lP�l���	�-������&�Й��N���m#�DdKG�Y>e4Wx`�-��/�,1�K	�jÂ^:fd���`��`����n���.<�����􈞫�H,����\��8pXi�9�T/+)ēn9���r���[7��"2�91�c��j���0pԽq���S���g����'�f�����ز"��ƙ8���1q}:�D^�R�!���W,
��m���K>�I�����         =   x�ʻ� ���y���]����U%
5�6�i˶�MH�����&;���5ĩ��H�p�      �   �  x��W=o9��_��:A�r���{�r�erl�׌v)��Tȥp�I�"E�.��X�pW�ZG	RYˏ�̛7o��Ŕ�#Y���J���4�����=y�
*d�dٜɽ��$�J/u�ɔ�Vj(�"Q�}Tr��V+��>��z�uA����<���F�Z9%�,\�B�s�;9ɰ3[|{F���E��h��w����11��We��V������p��VWTjKa(�Gy2xp'�V���p4�d���\:_�D��TI�J���|�ݖB���V�W���I%�-�uf�e�s7�s��q��UH�<�����,83����6"�\;K ;��\2e{�!���g�]�7M�0NG�����y��p�z�-����b 0x�dX9�U�@�d2d�;�L{@.�	K+��3��/�.eH-U^� ��?�E�	Gp� �����p
8���!2&5�6Z%8q ��Q��&An�O��V�U¥��@�/opt(w�˸'��*3�F8�C�^F?�8Fԋ2Ί�s1�\�\'���s����L�j٬X�ڟ��TΓE�ڸ�,�����8l����<ۖ�l=���Q�{����й�KWG���V��̄2�WK���%��O���-vH�z.��'���|���=�>��0��,��e�~ ��p�1b =��@���GQ�#֤�!wOy���x��K1���\�&�,����]��h�H��!iZ��������S`���m�̦�Oۤ��EDXK�8�C	��k|�͊X�7�����^M-��w��>+���7��U�&fF�*�S�&{zR6�z8x%f���c1�f�?5Li�S��l�X����&��|��/�/����ֵr����d������)�^U��Mћ������zEM8�W����Dh��7?� ���?���A�;��>A����	@w��Y�-�P����̽��y2��j��$�$^O�+i8�����m�i�4T6ڸ;�B'�����o cq�%9`r&����<�H��-�;N�P��x�����b'.���n���h�I%m�V�8��^�t=�}�?��`܎\s� �x�Mv~��{�<vP� Q�_��i�`�gv]>��h�! �N[$�����j$=� u�L�������8Amˬth.c��irI"Qww�T�3�gbvy}�M/'W��yU>m��P�1�pK=<j�A0�K�_!���r���C���5���N?`~�]�s��9�H?l�S2�\���	�+LM��(	������IS�Ơ;�ꉎ�RL3��3Ş6���)g<�"�y���tl��<�'Α�*��8����[�`� ���� �7Ӎ;U�4hg��p�R<3�Y17�t�����FT"^;oO�E�+ ��h0|����            x��ϻ1�ښ"���>�d�9rN����� m������KK��R�嘼����,[d�p�O]}TJ1b nJ����n��SȻ�6��)�q0���ߡZ�+z��|xr`΍'h�^D��8     