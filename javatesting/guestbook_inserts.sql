create database if not exists GuestBook;
use GuestBook;

GRANT ALL ON GuestBook.* TO 'javatester'@'localhost';

create table guest_book_entries (
	id INT unsigned not null primary key auto_increment,
	name VARCHAR(50),
	email VARCHAR(50),
	Page VARCHAR(50),
	Comment VARCHAR(50)
);

insert into guest_book_entries (name, email, Page, Comment) values ('Johnny', 'johny@gmail.com', 'www.johnnygod.com', "I'm the best");
insert into guest_book_entries (name, email, Page, Comment) values ('Carl', 'carl@gmail.com', 'www.carl.com', "I'm the worst");
insert into guest_book_entries (name, email, Page, Comment) values ('Anna', 'anna@gmail.com', 'www.anna.com', "I'm cool");
insert into guest_book_entries (name, email, Page, Comment) values ('Shae', 'shae@gmail.com', 'www.shae.com', "I love Tyrion");