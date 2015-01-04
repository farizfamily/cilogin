
drop table if exists users;
CREATE TABLE users (
user_id serial primary key,
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
role_id serial primary key,
time_stamp timestamp default now(),
created_by varchar default  current_user,
role_name varchar
);

drop table if exists menus ;
create table menus (
menu_id serial primary key,
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
customer_id serial primary key,
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
customer_pic_id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,		--+
customer_id int not null,
pic_name varchar,
role_id varchar,
religion varchar, -- because religoion can be very vary
birthday date,
fix_phone varchar,
mobile_phone varchar,
email varchar
);

ALTER TABLE ONLY customer_pics
    ADD CONSTRAINT customer_pic_maps FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

--------------------------------------------------	--+


-- related to --------------------------------------------+
drop table if exists suppliers;				--+
create table suppliers  (
supplier_id serial primary key,
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
suplier_pic_id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,		--+
supplier_id int,
pic_name varchar,
fix_phone varchar,
extensions varchar,
mobile_phone varchar,					--+
email varchar
);
alter table supplier_pics    ADD CONSTRAINT supplier_pic_maps FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
----------------------------------------------------	--+		

drop table if exists events;
create table  events ( 
event_id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
event_name varchar,
industry varchar,
email varchar,
website varchar
);

drop table if exists venues;
create table venues (
venue_id serial primary key,
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
warehouse_id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
warehouse_name varchar,
adress varchar,
province int,
city int,
fix_phone varchar,
mobile_phone varchar
);

-- quotation
-- quotation status 
-- created, this the first when user entry, it just saved not more
-- ok, 
	-- since only approved quotation entered to system, then ok means the quotation in force, 
	-- once quotation status turn into ok, then the user only have one chance to update to become win or loss status
-- win
-- loss

drop table if exists quotations ;
create table quotations (
quotation_id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
quotation_number varchar,
status int, -- start from 1 means draft, 2 means in force, 3 win, 4 loss
revision varchar,
sales_number varchar, -- fill this column means the quotation turn into sales
quotation_date date,
contract_number varchar,
term_of_payment varchar,
construction_type varchar,
size varchar,
official boolean,
event_id integer,
venue_id integer,
show_day_from timestamp,
show_day_to timestamp,
move_in_from timestamp,
move_in_to timestamp,
move_out_from timestamp,
move_out_to timestamp,
customer_id integer,
customer_contacts varchar,
project_executive integer,
project_supervisor integer,
designer integer,
notes text
);

drop table if exists quotation_products ;
create table quotation_products (
quotation_product_id serial primary key,
time_stamp timestamp default now(),
created_by varchar default current_user,
quotation_id int,
product_group varchar,
description varchar,
amount numeric(20,2)
);


