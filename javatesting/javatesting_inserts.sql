create database if not exists javatesting_schema;
use javatesting_schema;

CREATE USER 'student'@'localhost' IDENTIFIED BY 'password';

CREATE USER 'javatester'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
GRANT ALL ON javatesting_schema.* TO 'javatester'@'localhost';

create user 'jonas' IDENTIFIED WITH mysql_native_password BY 'password';

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

create table users (
	id INT unsigned not null primary key auto_increment,
	username VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	pass VARCHAR(50),
	birthdate DATE
);

insert into users (username, first_name, last_name, email, pass, birthdate) values ('bborton0', 'Boote', 'Borton', 'bborton0@ovh.net', '5d8a6836b346d54c753ae94cde0d500a0ce54479', '1977-06-05');
insert into users (username, first_name, last_name, email, pass, birthdate) values ('rfelix1', 'Raddy', 'Felix', 'rfelix1@diigo.com', 'a921148cd008f2c1b4a24e0a6336a580ae1b2755', '1964-06-01');
insert into users (username, first_name, last_name, email, pass, birthdate) values ('egladdifh2', 'Emmye', 'Gladdifh', 'egladdifh2@cbsnews.com', '8a4b26bc85477311cc649ac110034ecb5709a8dc', '1992-07-28');
insert into users (username, first_name, last_name, email, pass, birthdate) values ('shardin3', 'Stanton', 'Hardin', 'shardin3@soundcloud.com', 'c9d6f1e58cadf0be8ccc452e8c3f70b3b2590459', '1976-12-11');