#Av: Jonas Örnfelt

create database if not exists lab6a_schema;
use lab6a_schema;

#Uppgift 1

alter table Items drop foreign key items_ibfk_1;
alter table order_items drop foreign key order_items_ibfk_1;
alter table order_items drop foreign key order_items_ibfk_2;

drop table if exists item_category;
drop table if exists order_items;
drop table if exists customer_order;

drop table if exists Author;
drop table if exists Post;
drop table if exists Comment;
drop table if exists Category;

create table Author (Name varchar(25), username varchar(20) unique not null PRIMARY KEY);

create table Post (id int unsigned primary key auto_increment, Subject varchar(25) not null, Content text not null, posted datetime, last_edit datetime);

create table Comment (id int unsigned primary key auto_increment, Name varchar(20) not null, Subject varchar(20), Content text not null, posted datetime);

create table Category(name varchar(20) not null unique PRIMARY KEY);

# Uppdateras PK så ändras FK från user_post
create table user_post(a_uname varchar(20) not null, p_id int unsigned unique not null,
foreign key(a_uname) references Author(username) on update cascade on delete cascade, foreign key(p_id) references Post(id) on update cascade on delete cascade);

create table post_category(p_id int unsigned, c_name varchar(20),
foreign key(p_id) references post(id) on update cascade on delete cascade, foreign key(c_name) references Category(name) on update cascade on delete cascade);

create table post_comment(p_id int unsigned, c_id int unsigned unique,
foreign key(p_id) references Post(id) on update cascade on delete set null, foreign key(c_id) references Comment(id) on update cascade on delete set null);

#Uppgift 2

insert into Author(Name, username) values ("Jonas", "jonas1");
insert into Author(Name, username) values ("Mark", "mark1");
insert into Author(Name, username) values ("Adam", "adam1");
insert into Author(Name, username) values ("Hans", "superhans");

insert into Comment (name, subject, content, posted) values ("jonas1", "Offended", "How could you do this...", '2020-01-20 14:31:12');
insert into Comment (name, subject, content, posted) values ("mark1", "Surprised", "Never seen something like this before!", '2020-01-21 14:31:12');
insert into Comment (name, subject, content, posted) values ("adam1", "Amazed", "This is amazing!", '2020-01-22 14:31:12');
insert into Comment (name, subject, content, posted) values ("superhans", "Stoned", "I just feel so good, this comment isn't related to the post lmao", '2020-01-23 14:31:12');
insert into Comment (name, subject, content, posted) values ("superhans", "Hungry", "Thist post made me soooo hungry", '2020-01-24 14:31:12');
insert into Comment (name, subject, content, posted) values ("mark1", "Warning", "I will report you if you post anything like this again!", '2020-01-25 14:31:12');
insert into Comment (name, subject, content, posted) values ("jonas1", "Stupid", "This feels ridiculous.", '2020-01-26 14:31:12');
insert into Comment (name, subject, content, posted) values ("mark1", "Flabbergasted", "I'm absolutely astonished!!", '2020-01-27 14:31:12');
insert into Comment (name, subject, content, posted) values ("superhans", "#ME2", "This has happend to me as well.", '2020-01-28 14:31:12');
insert into Comment (name, subject, content, posted) values ("adam1", "Amazed", "This is even more incredible than the last post I saw", '2020-01-29 14:31:12');
insert into Comment (name, subject, content, posted) values ("adam1", "Funny post", "Laughed so hard I got a serious stomach ache!", '2020-01-30 14:31:12');

select * from Comment;

insert into Category(name) values ("Enjoyment");
insert into Category(name) values ("Clothes");
insert into Category(name) values ("Food");
insert into Category(name) values ("Lifestyle");
insert into Category(name) values ("Art");
insert into Category(name) values ("Social life");
insert into Category(name) values ("News");
insert into Category(name) values ("Work");
insert into Category(name) values ("Inspiring");
insert into Category(name) values ("Animals");

insert into post_category(p_id, c_name) values (1, "Social life");
insert into post_category(p_id, c_name) values (2, "Work");
insert into post_category(p_id, c_name) values (3, "Lifestyle");
insert into post_category(p_id, c_name) values (3, "Social life");
insert into post_category(p_id, c_name) values (4, "Enjoyment");
insert into post_category(p_id, c_name) values (4, "News");
insert into post_category(p_id, c_name) values (5, "Food");
insert into post_category(p_id, c_name) values (6, "Animals");
insert into post_category(p_id, c_name) values (7, "Food");
insert into post_category(p_id, c_name) values (7, "Lifestyle");
insert into post_category(p_id, c_name) values (7, "Inspiring");

insert into post_comment(p_id, c_id) values (1, 1);
insert into post_comment(p_id, c_id) values (2, 2);
insert into post_comment(p_id, c_id) values (3, 3);
insert into post_comment(p_id, c_id) values (4, 4);
insert into post_comment(p_id, c_id) values (5, 5);
insert into post_comment(p_id, c_id) values (6, 6);
insert into post_comment(p_id, c_id) values (7, 7);
insert into post_comment(p_id, c_id) values (8, 8);
insert into post_comment(p_id, c_id) values (8, 9);
insert into post_comment(p_id, c_id) values (6, 10);
insert into post_comment(p_id, c_id) values (6, 11);

insert into user_post(a_uname, p_id) values ("jonas1", 1);
insert into user_post(a_uname, p_id) values ("mark1", 2);
insert into user_post(a_uname, p_id) values ("adam1", 3);
insert into user_post(a_uname, p_id) values ("adam1", 4);
insert into user_post(a_uname, p_id) values ("superhans", 5);
insert into user_post(a_uname, p_id) values ("superhans", 6);
insert into user_post(a_uname, p_id) values ("mark1", 7);

select * from comment;
select * from post_comment;

#Uppgift 3
/* 
add_post(username, subject, content)
Skapa en procedure som lägger till en bloggpost för en skribent. 
*/
drop procedure if exists add_post;

delimiter //
create procedure add_post(in uname varchar(20), in subj varchar(25), in cont text)
begin
	insert into Post(Subject, Content, posted, last_edit) values (subj, cont, now(), now());
    insert into user_post(a_uname, p_id) values (uname, last_insert_id());
end //
delimiter ;


call add_post('jonas1', 'My best birthday', 'Had my best birthday ever today');
select * from post;

#Uppgift 4
/* 
delete_category(category_name)
Skapa en procedure som tar bort en kategori.
 */
 drop procedure if exists delete_category;
 
 delimiter //
 create procedure delete_category(in c_name text) /*text works? otherwise varchar(20) */
 begin
	delete from Category where name = c_name;
end //
delimiter ;
 
insert into Category(name) values ("New category");
select * from Category;
call delete_category("New category");
 
 #Uppgift 5
/* 
add_comment(post_id, name, subject, content)
Skapa en procedure som lägger till en kommentar till ett blogginlägg.
*/
drop procedure if exists add_comment;

delimiter //
create procedure add_comment(in post_id int unsigned, in u_name varchar(20), in subj varchar(20), in cont text)
begin
	start transaction;
	insert into Comment(name, subject, content, posted) values (u_name, subj, cont, now());
    insert into post_comment(p_id, c_id) values (post_id, last_insert_id());
    commit;
end //
delimiter ;


select * from comment;
select * from post_comment;
call add_comment(1, 'jonas1', "Hilarious stuff", "Really love this type of posts - keep it up!");


#Uppgift 7
/*
no_of_categories(post_id)
Skapa en funktion som returnerar hur många kategorier som är kopplade till ett blogginlägg.
*/
drop function if exists no_of_categories;

delimiter //
create function no_of_categories(post_id int unsigned)
returns int
no sql
begin
	return (select count(*) from post_category where p_id = post_id);
end //
delimiter ;

select * from post_category;
select no_of_categories(id) from post where id = 3;
select no_of_categories(id) from post where id = 7;

#Uppgift 8
/* 
no_of_comments(post_id)
Skapa en funktion som returnerar hur många kommentarer som är kopplade till ett blogginlägg.
*/
drop function if exists no_of_comments;

delimiter //
create function no_of_comments(post_id int unsigned)
returns int
no sql
begin
	return (select count(c_id) from post_comment where p_id = post_id);
end //
delimiter ;

select * from post_comment;
select no_of_comments(id) from post where id = 6;


#Uppgift 9
/* 
time_since_posting(datetime)
Skapa en funktion som tar ett datetime och returnerar en textsträng som talar om hur länge sedan givet datetime var. För inlägg som är skapade inom 1 h från
när funktionen körs ska den skriva ut "new" annars ska den skriva ut "less than 1 day" om det gått mindre än en dag och för övriga ska det skrivas ut hur
många dagar som gått sedan som inlägget skrevs ex , "1 day", "2 days", "132 days". Vill du göra en annan uträkning med tid utifrån andra alternativ är
det ok (så länge det är samma eller högre komplexitet).
*/
drop function time_since_posting;

delimiter //
create function time_since_posting(dt datetime, p_id int unsigned)
returns text
no sql
begin
	set @timeNow = now();
	set @minsElapsed = (select timestampdiff(minute, dt, @timeNow));
    set @postedTime = (select posted from post where id = p_id);
	return concat(floor(@minsElapsed/60), "h, ", mod(@minsElapsed,60), "m has passed since ", dt, 
    (case
		when (select timestampdiff(minute, @postedTime, @timeNow)) <= 60 then ", new"
        when (select timestampdiff(minute, @postedTime, @timeNow)) > 60 and (select timestampdiff(day, @postedTime, @timeNow)) < 1 then ", less than 1 day"
        when (select timestampdiff(day, @postedTime, @timeNow)) = 1 then ", 1 day"
        else concat(", ", (select timestampdiff(day, @postedTime, @timeNow)), " days")
	end));
end //
delimiter ;

insert into Post(Subject, Content, posted, last_edit) values ("New testing post", "A new post to test around with", '2020-02-10 14:00:00', '2020-02-10 14:00:00');
insert into Post(Subject, Content, posted, last_edit) values ("Second new testing post", "Another new post to test around with", '2020-02-10 18:00:00', '2020-02-10 18:00:00');

select time_since_posting(now(), last_insert_id());
select time_since_posting(now(), 1);
    
#Uppgift 10
/* 
all_posts
Skapa en vy all_posts som är lista med alla blogginlägg med kolumner för namn på bloggare, id för inlägg, rubrik använd även funktionen time_since_posting för att
visa hur gamla inlägg är. Visa även kolumner med värden för hur många kommentarer repektive hur många kategorier som är kopplade till varje blogginlägg.
Sortera på tid+datum för när de skapades, nyast överst.
*/
drop view if exists all_posts;

create view all_posts as
select a.Name as author_name, p.id as post_id, p.Subject as post_subject, time_since_posting(now(), p.id) as time_since_now,
count(pco.c_id) as amount_of_comments, count(pca.c_name) as amount_of_categories from author as a
join user_post as up on a.username = up.a_uname
join post as p on up.p_id = p.id
join post_comment as pco on p.id = pco.p_id
join post_category as pca on p.id = pca.p_id
group by p.id
order by p.posted;

select * from all_posts;

select a.Name as author_name, p.id as post_id, p.Subject as post_subject, time_since_posting(now(), p.id) as time_since_now from author as a
join user_post as up on a.username = up.a_uname
join post as p on up.p_id = p.id
group by p.id;

select * from post;
select * from user_post;
select * from post_comment;
select * from post_category;

