#Av: Jonas Örnfelt

create database if not exists lab6_schema;
use lab6_schema;

#Uppgift 1
/*
Skriv queries för att skapa tabeller och kolumner utifrån givet ERD (nedan). Använd lämpliga datatyper och constraints som bevarar databasens integritet.
Status för en order ska kunna vara "open", "processing", "sent" och "arrived at customer". Lägg till id eller dylikt som primary key där du tycker det behövs
och/eller hjälper.Redovisa queries.
*/
alter table Items drop foreign key items_ibfk_1;
alter table order_items drop foreign key order_items_ibfk_1;
alter table order_items drop foreign key order_items_ibfk_2;

drop table if exists item_category;
drop table if exists order_items;
drop table if exists customer_order;
drop table if exists Categories;
drop table if exists Items;
drop table if exists Logs;
drop table if exists Customers;
drop table if exists Orders;

create table Orders (status enum("Open", "Processing", "Sent", "Arrived at customer"),
created datetime, sent datetime, number int unsigned unique PRIMARY KEY);
create table Customers (name varchar(20) not null, email varchar(25) not null unique primary key, city varchar(20));
create table Logs(id INT unsigned PRIMARY KEY AUTO_INCREMENT, log_info text, date datetime not null);
create table Items (name varchar(20) not null unique, stock mediumint unsigned, price mediumint unsigned not null,
number int unsigned unique PRIMARY KEY, log_id int unsigned, foreign key(log_id) references Logs(id) on update cascade on delete cascade);
create table Categories(name varchar(20) not null unique PRIMARY KEY);

create table customer_order(c_email varchar(25) not null, o_num int unsigned not null,
foreign key(c_email) references Customers(email) on update cascade on delete cascade, foreign key(o_num) references Orders(number) on update cascade on delete cascade);
create table order_items(o_num int unsigned not null, i_num int unsigned not null, 
foreign key(o_num) references Orders(number) on update cascade on delete restrict, foreign key(i_num) references Items(number) on update cascade on delete restrict);
create table item_category(i_num int unsigned not null, c_name varchar(20) not null,
foreign key(i_num) references Items(number) on update cascade on delete cascade, foreign key(c_name) references Categories(name) on update cascade on delete cascade);

#Uppgift 2
/*
Skriv queries för att fylla på med innehåll. Minst 5 kunder och minst 10 beställningar.
Ett par av beställningarna ska ha flera olika varor och ett par av beställningarna ska ha innehålla flera av samma vara. Minst 5 kategorier av varor.
Varje vara ska vara kopplad till en eller flera kategorier. (Det kan vara enklare att använda t ex mockaroo eller liknande för att skapa innehåll om du
vill ha mycket innehåll.)
*/

insert into Orders(status, created, sent, number) values ("Arrived at customer", '2020-01-05 14:28:41', '2020-01-05 12:00:00', 1);
insert into Orders(status, created, sent, number) values ("Arrived at customer", '2020-01-08 11:54:23', '2020-01-08 13:00:00', 2);
insert into Orders(status, created, sent, number) values ("Arrived at customer", '2020-01-10 12:31:43', '2020-01-10 14:00:00', 3);
insert into Orders(status, created, sent, number) values ("Arrived at customer", '2020-01-11 13:33:11', '2020-01-11 12:00:00', 4);
insert into Orders(status, created, sent, number) values ("Arrived at customer", '2020-01-15 21:28:21', '2020-01-11 12:00:00', 5);
insert into Orders(status, created, sent, number) values ("Arrived at customer", '2020-01-28 22:28:17', '2020-01-11 14:00:00', 6);
insert into Orders(status, created, sent, number) values ("Sent", '2020-01-31 11:54:17', '2020-02-01 12:00:00', 7);
insert into Orders(status, created, sent, number) values ("Sent", '2020-01-31 18:28:17', '2020-02-01 13:05:00', 8);
insert into Orders(status, created, sent, number) values ("Processing", '2020-02-06 14:00:17', null, 9);
insert into Orders(status, created, sent, number) values ("Processing", '2020-02-06 13:37:37', null, 10);
insert into Orders(status, created, sent, number) values ("Open", '2020-02-07 18:12:15', null, 11);
insert into Orders(status, created, sent, number) values ("Open", '2020-02-07 21:28:17', null, 12);

insert into Customers(name, email, city) values ("Jonas", 'jonas@mail.com', 'Visby');
insert into Customers(name, email, city) values ("Dan", 'dan@mail.com', 'Stockholm');
insert into Customers(name, email, city) values ("Eric", 'eric@mail.com', 'Visby');
insert into Customers(name, email, city) values ("Bella", 'bella@mail.com', 'Gothenburg');
insert into Customers(name, email, city) values ("Oliver", 'oliver@mail.com', 'Stockholm');
insert into Customers(name, email, city) values ("Sam", 'sam@mail.com', 'Stockholm');
select * from customers;

insert into Logs (date) values ('2020-01-05 14:31:12');
insert into Logs (date) values ('2020-01-08 21:54:23');
insert into Logs (date) values ('2020-01-10 21:31:43');
insert into Logs (date) values ('2020-01-11 16:22:12');
insert into Logs (date) values ('2020-01-15 17:12:11');
insert into Logs (date) values ('2020-01-28 18:13:12');
insert into Logs (date) values ('2020-02-01 21:11:19');
insert into Logs (date) values ('2020-02-01 22:31:18');
insert into Logs (date) values ('2020-02-03 15:31:15');
insert into Logs (date) values ('2020-02-04 11:31:14');
insert into Logs (date) values ('2020-02-05 14:05:11');
select * from Logs;

insert into Categories(name) values ("Enjoyment");
insert into Categories(name) values ("Clothes");
insert into Categories(name) values ("Kitchen");
insert into Categories(name) values ("Essentials");
insert into Categories(name) values ("Art");
insert into Categories(name) values ("Bathroom");

insert into Items (name, stock, price, number, log_id) values ("Book", 50, 149, 1, 1);
insert into Items (name, stock, price, number, log_id) values ("T-shirt with print", 100, 179, 2, 2);
insert into Items (name, stock, price, number, log_id) values ("Frying pan", 70, 350, 3, 3);
insert into Items (name, stock, price, number, log_id) values ("Coffee machine", 50, 1000, 4, 4);
insert into Items (name, stock, price, number, log_id) values ("Wallet", 75, 99, 5, 5);
insert into Items (name, stock, price, number, log_id) values ("Sweater", 150, 249, 6, 6);
insert into Items (name, stock, price, number, log_id) values ("Buddha statue", 100, 149, 7, 7);
insert into Items (name, stock, price, number, log_id) values ("Toothbrush", 55, 39, 8, 8);
insert into Items (name, stock, price, number, log_id) values ("Dvd", 150, 100, 9, 9);
insert into Items (name, stock, price, number, log_id) values ("Key ring", 25, 49, 10, 10);
insert into Items (name, stock, price, number, log_id) values ("Painting", 15, 500, 11, 11);

insert into item_category(i_num, c_name) values (1, "Enjoyment");
insert into item_category(i_num, c_name) values (2, "Clothes");
insert into item_category(i_num, c_name) values (3, "Kitchen");
insert into item_category(i_num, c_name) values (4, "Kitchen");
insert into item_category(i_num, c_name) values (5, "Essentials");
insert into item_category(i_num, c_name) values (6, "Clothes");
insert into item_category(i_num, c_name) values (7, "Art");
insert into item_category(i_num, c_name) values (8, "Bathroom");
insert into item_category(i_num, c_name) values (9, "Enjoyment");
insert into item_category(i_num, c_name) values (10, "Essentials");
insert into item_category(i_num, c_name) values (11, "Art");

insert into item_category(i_num, c_name) values (2, "Art");
insert into item_category(i_num, c_name) values (8, "Essentials");
insert into item_category(i_num, c_name) values (4, "Essentials");

insert into customer_order(c_email, o_num) values ("jonas@mail.com", 1);
insert into customer_order(c_email, o_num) values ("dan@mail.com", 2);
insert into customer_order(c_email, o_num) values ("eric@mail.com", 3);
insert into customer_order(c_email, o_num) values ("bella@mail.com", 4);
insert into customer_order(c_email, o_num) values ("oliver@mail.com", 5);
insert into customer_order(c_email, o_num) values ("sam@mail.com", 6);
insert into customer_order(c_email, o_num) values ("jonas@mail.com", 7);
insert into customer_order(c_email, o_num) values ("dan@mail.com", 8);
insert into customer_order(c_email, o_num) values ("eric@mail.com", 9);
insert into customer_order(c_email, o_num) values ("bella@mail.com", 10);
insert into customer_order(c_email, o_num) values ("oliver@mail.com", 11);
insert into customer_order(c_email, o_num) values ("sam@mail.com", 12);

insert into order_items(o_num, i_num) values (1, 1);
insert into order_items(o_num, i_num) values (1, 3);
insert into order_items(o_num, i_num) values (1, 3);
insert into order_items(o_num, i_num) values (2, 4);
insert into order_items(o_num, i_num) values (2, 8);
insert into order_items(o_num, i_num) values (3, 2);
insert into order_items(o_num, i_num) values (3, 9);
insert into order_items(o_num, i_num) values (3, 6);
insert into order_items(o_num, i_num) values (4, 5);
insert into order_items(o_num, i_num) values (5, 11);
insert into order_items(o_num, i_num) values (6, 1);
insert into order_items(o_num, i_num) values (7, 6);
insert into order_items(o_num, i_num) values (7, 9);
insert into order_items(o_num, i_num) values (7, 9);
insert into order_items(o_num, i_num) values (7, 9);
insert into order_items(o_num, i_num) values (8, 8);
insert into order_items(o_num, i_num) values (8, 10);
insert into order_items(o_num, i_num) values (9, 7);
insert into order_items(o_num, i_num) values (10, 7);
insert into order_items(o_num, i_num) values (10, 1);
insert into order_items(o_num, i_num) values (11, 3);
insert into order_items(o_num, i_num) values (12, 2);
insert into order_items(o_num, i_num) values (12, 4);


create table customer_order(c_email varchar(25) not null, o_num int unsigned not null,
foreign key(c_email) references Customers(email) on update cascade on delete restrict,
foreign key(o_num) references Orders(number) on update cascade on delete cascade);

#Uppgift 3
/*
Skapa en procedure som visar en item och vilka kategorier den tillhör. När proceduren körs ska även en rad i item-loggen läggas till med data om vilket
item som visades och när. Dessa behövs för att ta fram statistik för vilka varor som kunder kollar på. (Vi skulle kunna lägga till något om ip-nummer eller ett
sessions-id eller info om någon cookie-fil från kundes webbläsare här också. Med mera. Men så långt går vi inte för denna uppgift.)
*/
drop procedure if exists show_item;
drop procedure if exists item_log;

delimiter //
create procedure show_item(in id int unsigned)
begin
	declare itemName text default "";
    declare itemLog int default 0;
    set itemName := (select name from items where number = id);
    set itemLog := (select log_id from items where number = id);
	select i.name, c.name from Items as i 
    join item_category as ic on id = ic.i_num
    join categories as c on ic.c_name = c.name
    where i.number = id;
    update logs set log_info = concat(itemName, ' searched for at date: ', now()) where id = itemLog;
    update logs set date = now() where id = itemLog;
end //
delimiter ;

/*Demonstration för procedure */
call show_item(1);
select * from logs where id = last_insert_id();

#Uppgift 4
/*
add_item_to_order(order_id, item_id, no_of_items)
Skapa en procedure som lägger till item(s) till en order. Antalet för vad som finns i lager för item ska också minskas med samma antal. Om no_of_items är fler
än vad som finns i lager ska högsta möjliga läggas till så att lager blir noll. Proceduren ska svara med ett status om hur många items som lagts till samt varna
eller upplysa om ifall antal inte blev så många som önskat. Finns inga items i lager ska det också ges upplysning om det. Kontroll måste också göras så att order-id
och item-id finns. Det ska bara gå att lägga till items till en order om den har shipping_status satt till "open". Proceduren svara med ett SELECT som ger ett
lämpligt och tydligt status.
*/
drop procedure if exists add_item_to_order;

delimiter //
create procedure add_item_to_order(in o_id int unsigned, in i_id int unsigned, in no_of_items int unsigned)
begin
	declare no_of_items_wanted int default 0;
    set no_of_items_wanted := no_of_items;
    start transaction;
    if o_id not in(select number from orders) then select concat("There is no order with id: ", o_id) as Status;
    else 
		if i_id not in(select number from items) then select concat("There is no item with id: ", i_id) as Status;
        else
			if (select status from orders where number = o_id) <> "Open" then select concat("Order: ", o_id, " has already been processed") as Status;
            else
				while no_of_items > 0 do
					if (select stock from items where number = i_id) > 0 then
						insert into order_items(o_num, i_num) values (o_id, i_id);
						update items set stock = (stock-1) where number = i_id;
						set no_of_items = no_of_items -1;
						if no_of_items = 0 then
							if (select stock from items where number = i_id) = 0 then select concat(no_of_items_wanted, " added to order. Warning: stock is now 0!") as Status;
							else select concat(no_of_items_wanted, " added to order") as Status;
							end if;
						end if;
						else select concat("No more items in stock, ", no_of_items, " out of ", no_of_items_wanted, " could not be added to order") as Status;
						set no_of_items = 0;
					end if;
				end while;
			end if;
		end if;
	end if;
    commit;
end //
delimiter ;

/*Queries för demonstration av procedure */
select stock from items where number = 11;
#Order har inte status "Open"
call add_item_to_order(1, 11, 16);
#o_id finns inte
call add_item_to_order(13, 9, 16);
#i_id finns inte
call add_item_to_order(12, 13, 16);
#dessa anrop fungerar
call add_item_to_order(12, 11, 5);
call add_item_to_order(12, 11, 16);
select * from order_items where o_num = 12;

/*Restore values */
update items set stock = 15 where number = 11;
delete from order_items where o_num = 12 and i_num = 11;

#Uppgift 5
/*
remove_item_from_order(order_id, item_id, no_of_items)
Skapa en procedure som tar bort items från en order och ökar lager för item med lika många som togs bort. Fler än vad som finns i order ska inte gå att ta bort.
Kontroll måste också göras så att order_id och item_id finns. Om antalet av en item i en order blir noll så ska kopplingen till ordern tas bort. Det ska bara gå
att ta bort items från en order om den har shipping_status satt till "open". Proceduren ska svara med SELECT och ett lämpligt och tydligt status. 
*/
drop procedure if exists remove_item_from_order;

delimiter //
create procedure remove_item_from_order(in o_id int unsigned, in i_id int unsigned, in no_of_items int)
begin
	declare no_of_items_wanted int default 0;
    set no_of_items_wanted := no_of_items;
    start transaction;
    if o_id not in(select number from orders) then select concat("There is no order with id: ", o_id) as Status;
    else 
		if i_id not in(select number from items) then select concat("There is no item with id: ", i_id) as Status;
        else
			if (select status from orders where number = o_id) <> "Open" then select concat("Order: ", o_id, " has already been processed") as Status;
            else
				while no_of_items > 0 do
					if i_id not in(select i_num from order_items where o_num = o_id) then select concat("Order: ", o_id, " contains no item with id: ", i_id); 
                    set no_of_items = 0;
                    else
						delete from order_items where o_num = o_id and i_num = i_id limit 1;
						update items set stock = (stock+1) where number = i_id;
						if i_id not in(select i_num from order_items where o_num = o_id) then
							if o_id not in(select o_num from order_items) then
								delete from customer_order where o_num = o_id;
								delete from orders where number = o_id;
								select concat("No more items in order: ", o_id, ". Order has been removed") as Status;
								set no_of_items = 0;
							else
								select concat("No more of the selected item is in order: ", o_id, ". However, there are other items remaining in the order.") as Status;
								set no_of_items = 0;
							end if;
						end if;
						set no_of_items = no_of_items -1;
						if no_of_items = 0 then
							select concat(no_of_items_wanted, " removed from order") as Status;
                        end if;
					end if;
				end while;
			end if;
		end if;
	end if;
    commit;
end //
delimiter ;

/*Queries för demonstration av procedure */
select stock from items where number = 11;
#Order har inte status "Open"
call remove_item_from_order(1, 11, 16);
#o_id finns inte
call remove_item_from_order(13, 9, 16);
#i_id finns inte
call remove_item_from_order(12, 13, 16);
#order har inga items med valt id
call remove_item_from_order(12, 11, 16);

#dessa anrop fungerar - först anropas den tidigare proceduren add_item för att underlätta testning av denna procedure
call add_item_to_order(12, 11, 10);
call remove_item_from_order(12, 11, 5);
call remove_item_from_order(12, 11, 16);
select * from order_items where o_num = 12;

/*Restore values */
update items set stock = 15 where number = 11;
delete from order_items where o_num = 12 and i_num = 11;

#Uppgift 6
/*
order_new_items
För denna del ska en tabell skapas för att kunna hålla reda på vilka items som hamnat på noll. Sedan ska triggers skapas som håller order_new_items uppdaterad
utifrån vad som händer med INSERT och UPDATE på items-tabellen. Alla items som ligger på 2, 1 eller 0 som antal i lager ska finnas med i nya tabellen.
*/
drop table if exists order_new_items;
drop trigger if exists new_items_trigger_insert;
drop trigger if exists new_items_trigger_update;

create table order_new_items(i_num int unsigned unique,
foreign key(i_num) references Items(number) on update cascade on delete cascade);

delimiter //
create trigger new_items_trigger_insert
after insert
on Items
for each row
begin
	if NEW.stock < 3 then
	insert into order_new_items(i_num) values (NEW.number);
    end if;
end //
delimiter ;

delimiter //
create trigger new_items_trigger_update
after update
on Items
for each row
begin
	if OLD.stock > 2 then
    insert into order_new_items(i_num) values (NEW.number);
    else
		delete from order_new_items where i_num = NEW.number;
	end if;
end //
delimiter ;

select * from items;
insert into Logs(log_info, date) values (null, now());
insert into Items (name, stock, price, number, log_id) values ("Joggers", 2, 450, 12, 12);
insert into item_category(i_num, c_name) values (12, "Clothes");
insert into order_new_items(i_num) values ((select number from items where stock < 3));
select * from order_new_items;
update Items set stock = 1 where number = 12;
update Items set stock = 5 where number = 12;

insert into Logs(log_info, date) values (null, now());
insert into Items (name, stock, price, number, log_id) values ("Plain t-shirt", 2, 49, 13, 13);
insert into item_category(i_num, c_name) values (13, "Clothes");

#Uppgift 7
/*
total_cost(order_id)
Skapa en funktion som returnerar den totala kostnaden (för kund) för alla items i en order.
*/
drop function if exists total_cost;

delimiter //
create function total_cost(o_id int unsigned)
returns int
no sql
begin
	return (select sum(i.price) from items as i
	join order_items as oi on i.number = oi.i_num
	where oi.o_num = o_id);
end //
delimiter ;

/*Demonstration av funktion */
select i_num from order_items where o_num = 1;
select * from items;
select o_num from customer_order where c_email = 'jonas@mail.com';
select total_cost(o_num) from customer_order where c_email = 'jonas@mail.com' limit 1;

#Uppgift 8
/*
view_order(order_id)
Skapa en procedure som visar en order med en rad för varje item där pris för item, hur många items det är och vad totala priset för raden blir.
*/
drop function if exists cost_for_items;
drop procedure if exists view_order;

delimiter //
create function cost_for_items(i_id int unsigned, no_of_items int unsigned)
returns int
no sql
begin
	return ((select price from items where number = i_id)*no_of_items);
end //
delimiter ;

delimiter //
create procedure view_order(in o_id int unsigned)
begin
	select i.name as item_name, i.price as item_price, count(*) as amount_of_items,
    cost_for_items(oi.i_num, count(oi.i_num)) as items_total_cost from items as i
    join order_items as oi on oi.i_num = i.number
    where oi.o_num = o_id
    group by i.name;
end //
delimiter ;

/*Demonstration för ny procedure */
select i_num from order_items where o_num = 1;
select price from items;
call view_order(2);

#Uppgift 9
/*
orders_summary(n)
Skapa en procedure som visar totala värdet för alla beställningar som är gjorda från idag och n antal dagar bakåt i tid.
*/
drop procedure if exists orders_summary;

delimiter //
create procedure orders_summary(in n int unsigned)
begin
	select sum(total_cost(o.number)) as orders_summary_since_n from orders as o
    where created > (select date_sub(current_date(), interval n day));
end //
delimiter ;

/*Demonstration  */
select price from items;
select * from orders where created > (select date_sub(current_date(), interval 5 day));
/*ovanstående ger orders 9-12*/
call view_order(9);
/*1976: 149+ 149*2 + 350 + 1179*/
select 149 + 149*2 + 350 + 1179 as am_I_correct;
call orders_summary(5);

#Uppgift 10
/*
hot_items
Skapa en vy för vilka items som är populärast genom att analysera item_log. Av de senaste 100 raderna i
item_log plocka ut de tre items som är med flest gånger. I vyn ska det finnas kolumner för
item-id, item-name samt en räknare (view_count) för hur många gånger de visats.
*/

/*Behövde tänka om gällande tabell för logs. Tidigare fanns det bara en log per item. Logs-tabellen behöver tömmas på innehåll för att denne ska kunna sammarbeta med
nya show_item proceduren nedan */
drop table if exists item_logs;
alter table Items drop foreign key items_ibfk_1;
alter table items drop column log_id;
/*Logs-tabellen är likadan som tidigare, men behöver tömmas */
drop table logs;
create table Logs(id INT unsigned PRIMARY KEY AUTO_INCREMENT, log_info text, date datetime not null);

create table item_logs (i_num int unsigned, logs_id int unsigned,
foreign key(i_num) references Items(number) on update cascade on delete restrict);

/*ny show_item procedure (från uppgift 3) */
drop procedure if exists new_show_item;

delimiter //
create procedure new_show_item(in id int unsigned)
begin
	declare itemName text default "";
    set itemName := (select name from items where number = id);
	select i.name, c.name from Items as i 
    join item_category as ic on id = ic.i_num
    join categories as c on ic.c_name = c.name
    where i.number = id;
    insert into logs (log_info, date) values (concat(itemName, ' searched for at date: ', now()), now());
    insert into item_logs (i_num, logs_id) values (id, last_insert_id());
end //
delimiter ;

/*Kör nya show_item med ett par items så att vyn ska ha data att utgå från */
call new_show_item(1);
call new_show_item(2);
call new_show_item(3);
call new_show_item(4);
call new_show_item(5);
select * from logs;

drop view if exists hot_items;
drop view if exists last_100_logs;

/*MYSQL har inte support för kombination av IN och LIMIT. En till vy skapas för att kringgå detta */
create view last_100_logs as
select i_num from item_logs limit 100;

create view hot_items as
select i.number as item_id, i.name as item_name, count(*) as view_count from items as i
join item_logs as il on i.number = il.i_num
join logs as l on il.logs_id = l.id
where i.number in(select i_num from last_100_logs)
group by i.number
order by view_count desc
limit 3;

/*Demonstration för hot_items */
select * from hot_items;
