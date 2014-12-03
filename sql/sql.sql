drop table if exists users;
CREATE TABLE users (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
register_number varchar unique,
userid varchar unique,
username varchar,
email varchar,
passw varchar,
userrole varchar,
dept varchar
);

insert into users  ( userid,username,email,passw) values ('dei','Ridei Karim','ridei@live.com','1');

drop table if exists roles;
create table roles (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default  current_user,
role_name varchar
);

drop table if exists menus ;
create table menus (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
menu_name varchar,
menu_head varchar,
module varchar,
"action" varchar
);

drop table if exists role_menu_maps ;
create table role_menu_maps (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
role_id int,
menu_id int
);

drop table if exists user_role_maps;
create table user_role_maps (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
user_id int,
role_id int
);

---------------------------------------------		--+
drop table if exists customers;
create table customers (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
customer_code varchar not null unique,			--+
customer_name varchar not null,
full_address varchar(1000),				--+
province int,
city int,
email varchar,
website varchar,
customer_since date
);
							--+
drop table if exists customer_pics;
create table customer_pics (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,		--+
customer_id int not null,
pic_name varchar,
role varchar,
religion varchar, -- because religoion can be very vary
birthday date,
fix_phone varchar,
mobile_phone varchar,
email varchar
);
--------------------------------------------------	--+


-- related to --------------------------------------------+
drop table if exists suppliers;				--+
create table suppliers  (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,		--+
supplier_code varchar,
supplier_name varchar,
address varchar,
province int,						--+
city int,
fix_phone varchar,
fax varchar,
mobile_phone varchar,
email varchar,
website varchar
);
							--+
drop table if exists supplier_pics;
create table supplier_pics (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,		--+
supplier_id int,
pic_name varchar,
fix_phone varchar,
extensions varchar,
mobile_phone varchar,					--+
email varchar
);
----------------------------------------------------	--+		

drop table if exists events;
create table  events ( 
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
event_name varchar,
industry varchar,
email varchar,
website varchar
);

drop table if exists venues;
create table venues (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
venue_name varchar,
address varchar,
province int,
city int,
email varchar,
website varchar
);

drop table if exists warehouses ;
create table warehouses (
id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
warehouse_name varchar,
adress varchar,
province int,
city int,
fix_phone varchar,
mobile_phone varchar
);