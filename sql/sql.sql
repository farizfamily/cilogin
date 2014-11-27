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