--USER
drop table if exists user_seq;
create sequence user_seq start 1 increment by 1;

drop table if exists users cascade;
create table users
(
    id        bigint  not null,
    archive   boolean not null,
    email     varchar(255),
    name      varchar(255),
    password  varchar(255),
    role      varchar(255),
    bucket_id bigint,
    primary key (id)
);
-- BUCKET
drop sequence if exists bucket_seq;
create sequence bucket_seq start 1 increment by 1;

drop table if exists buckets cascade;
create table buckets
(
    id      bigint not null,
    user_id bigint,
    primary key (id)
);
--LINK BETWEEN BUCKET AND USER
alter table if exists buckets add constraint buckets_fk_user foreign key (user_id) references users;
alter table if exists users add constraint users_bucket foreign key (bucket_id) references buckets;

--CATEGORIES
drop sequence if exists category_seq;
create sequence categories_seq start with 1 increment by 1;

drop table if exists categories cascade;
create table categories
(
    id    bigint not null,
    title varchar(255),
    primary key (id)
);

--PRODUCTS
drop sequence if exists product_seq;
create sequence product_seq start 1 increment by 1;

drop table if exists products cascade;
create table products
(
    id    bigint not null,
    price numeric(38, 2),
    title varchar(255),
    primary key (id)
);

--PRODUCTS CATEGORIES
drop table if exists products_categories cascade;
create table products_categories
(
    product_id  bigint not null,
    category_id bigint not null
);

alter table if exists products_categories add constraint products_categories_fk_category foreign key (category_id) references categories;
alter table if exists products_categories add constraint products_categories_fk_product foreign key (product_id) references products;


-- BUCKET PRODUCTS
drop table if exists buckets_products cascade;
create table buckets_products
(
    bucket_id  bigint not null,
    product_id bigint not null
);

alter table if exists buckets_products add constraint buckets_products_fk_product foreign key (product_id) references products;
alter table if exists buckets_products add constraint buckets_products_fk_bucket foreign key (bucket_id) references buckets;

--ORDERS
drop sequence if exists order_seq;
create sequence order_seq start 1 increment by 1;

drop table if exists orders cascade;
create table orders
(
    id      bigint not null,
    address varchar(255),
    updated timestamp(6),
    created timestamp(6),
    status  varchar(255),
    sum     numeric(38, 2),
    user_id bigint,
    primary key (id)
);

alter table if exists orders add constraint order_fk_user foreign key (user_id) references users;


-- ORDER DETAILS
drop sequence if exists order_details_seq;
create sequence order_details_seq start 1 increment by 1;

drop table if exists orders_details cascade;
create table orders_details
(
    id         bigint not null,
    amount     numeric(38, 2),
    price      numeric(38, 2),
    order_id   bigint,
    product_id bigint,
    details_id bigint not null,
    primary key (id)
);

alter table if exists orders_details add constraint orders_details_fk_order foreign key (order_id) references orders;
alter table if exists orders_details add constraint orders_details_fk_products foreign key (product_id) references products;
alter table if exists orders_details add constraint orders_details_fk_details foreign key (details_id) references orders_details;
alter table if exists orders_details add constraint orders_details_un_details unique (details_id);
