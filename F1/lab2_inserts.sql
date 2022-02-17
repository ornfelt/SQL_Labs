#Lab 2

/* DB2-VT20-L2-skal */
/* Senast ändrad/uppdaterad 191211 */

create database if not exists lab2_schema;
use lab2_schema;
drop table if exists friends;
drop table if exists usershobbies;
drop table if exists hobbies;
drop table if exists users;

create table users (
  id int primary key auto_increment,
  username varchar(16) unique not null,
  pass varchar(255),
  email varchar(255) unique not null,
  fname varchar(32),
  lname varchar(32),
  age INT not null
);
 
create table friends (
  u_id int,
  f_id int,
  foreign key (u_id) references users(id),
  foreign key (f_id) references users(id)
);

create table hobbies (
  id int primary key auto_increment,
  name varchar(32) unique
);

create table usershobbies (
  u_id int,
  h_id int,
  foreign key (u_id) references users(id),
  foreign key (h_id) references hobbies(id)
);

insert into users (username, pass, email, fname, lname, age) values ('arya', 'XPlgTwYDBD', 'arya@example.com', 'Arya', 'Stark','15'); # 1
insert into users (username, pass, email, fname, lname, age) values ('jsnow', 'ojPgMdpezTDr', 'snow@example.com', 'Jon', 'Snow','20'); # 2
insert into users (username, pass, email, fname, lname, age) values ('sansa', 'sy3NCbR', 'sansa_stark@example.com', 'Sansa', 'Stark','18'); # 3
insert into users (username, pass, email, fname, lname, age) values ('dragons', 'VkDvqBIeq', 'daenerys@example.com', 'Daenerys', 'Targaryan', '20'); # 4
insert into users (username, pass, email, fname, lname, age) values ('theimp', 'jlEpzx5PY3A', 'theimp@example.com', 'Tyrion', 'Lannister', '36'); # 5
insert into users (username, pass, email, fname, lname, age) values ('jorah', 'GezN4CzXkjI', 'iamjorah@example.com', 'Jorah', 'Mormont', '48'); # 6
insert into users (username, pass, email, fname, lname, age) values ('sam', 'Rk3eHqoNmwp', 'iheartbooks@example.com', 'Samwell', 'Tarly', '21'); # 7

insert into hobbies (name) values ('Swords'); # 1
insert into hobbies (name) values ('Books'); # 2
insert into hobbies (name) values ('Gold'); # 3
insert into hobbies (name) values ('Dragons'); # 4

insert into friends (u_id, f_id) values 
	(1, 2), (1, 3),
	(2, 1), (2, 3), (2, 4), (2, 5), (2, 7),
	(3, 1), (3, 2),
	(4, 2), (4, 5), (4, 6),
	(5, 2), (5, 3), (5, 4), (5, 6),
	(6, 4), (6, 5),
	(7, 2);

 
insert into usershobbies (u_id, h_id) values 
	(1, 1),
	(2, 1), (2, 4),
	(3, 2), (2, 3),
	(4, 1), (4, 4),
	(5, 2), (5, 3), (5, 4),
	(6, 1), (6, 3),
	(7, 2);
    
    select * from users;