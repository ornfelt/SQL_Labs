use lab3_schema;

#1
/* a) Skriv en query som visar vilken veckodag det kommer vara på den sista dagen nuvarande månad.
b) Skriv en query som visar vilken veckodag det kommer vara på den första dagen nästa månad. */

#a)
select dayname((select last_day("2020-01-01")));
select dayname((select last_day((select now()))));

#b)
select dayname((date_add(last_day("2020-01-15"), interval 1 day))) as first_day;

#2
/* Skriv en query som visar hur många dagar det gått sen 2018-09-03. (Terminsstart UU-HT-18.) */
select timestampdiff(day, "2018-09-03", now()) as Dagar_sen_terminsstart_HT_18;

#3
/* Skriv en procedure som när den anropas visar hur många minuter det är kvar till midnatt. */
drop procedure if exists midnight_countdown;

delimiter //
create procedure midnight_countdown()
begin
	select timestampdiff(minute, now(), (current_date()+interval 1 day)) as min_to_midnight;
end //
delimiter ;

call midnight_countdown();

#4
/* Skapa en vy som visar alla users som är födda i februari. */
drop view if exists born_in_february;

create view born_in_february as
select username as users_born_in_feb from users
where monthname(birthdate) = "February";
    
select * from born_in_february;

#5
/* Skriv en procedure som visar förnamn och efternamn på alla users som har födelsedag på given månad och dag. */
drop procedure if exists happy_birthday;

/*Följande procedure kan göras om till day() istället för dayname för att söka efter dag med siffror istället för veckodag */
delimiter //
create procedure happy_birthday(in month text, in day text)
begin
	select first_name, last_name from users
    where monthname(birthdate) = month and dayname(birthdate) = day;
end //
delimiter ;
 
 call happy_birthday("February", "Monday");

#6
/* För users gör en funktion som räknar ut ålder utifrån ett födelsedatum. Ska kunna användas med
t ex SELECT first_name, last_name, birthdate, age(birthdate) FROM users ORDER BY birthdate DESC; */
drop function if exists age;

/*Osäker om funktionen bör vara deterministisk eller ej */
age(birthdate)
delimiter //
create function age(birthdate date)
returns int
no sql
begin
	return (timestampdiff(year, birthdate, now()));
end //
delimiter ;

SELECT first_name, last_name, birthdate, age(birthdate) FROM users ORDER BY birthdate DESC;

#7
/* För users skriv triggers så att det inte går att lägga in, eller ändra till födelsedatum som ligger framåt i tiden. */
drop procedure if exists time_check;
drop trigger if exists time_trigger;
drop trigger if exists time_trigger_update;

delimiter //
create procedure time_check(in birthdate date)
no sql
begin
	if current_date() < birthdate then
    signal sqlstate '45000' set message_text = "Can't set birthdate to future date";
    end if;
end //
delimiter ;
	
delimiter //
create trigger time_trigger
before insert
on users
for each row
begin
	call time_check(NEW.birthdate);
end //

create trigger time_trigger_update
before update
on users
for each row
begin
	call time_check(NEW.birthdate);
end //
delimiter ;

insert into users (username, first_name, last_name, email, pass, birthdate) values
('futureMan', 'Future', 'Man', 'futureman@psu.edu', 'FuTuR3', '2020-02-12');
insert into users (username, first_name, last_name, email, pass, birthdate) values
('bobby', 'Bob', 'By', 'bobby@psu.edu', 'bobby33', '2020-01-12');
update users set birthdate = "2021-02-14" where id = 1;

#8
/* För orders skapa en vy som visar order-id för alla orders som är skickade men inte mottagna av kund.
I vyn ska finnas en kolumn, time_in_transit, som visar hur många timmar och minuter som gått sen ordern skickades. */
drop function if exists calc_time_in_transit;

delimiter //
create function calc_time_in_transit(date_sent datetime)
returns text
no sql
begin
	set @minsElapsed = (select timestampdiff(minute, date_sent, now()));
	return concat(floor(@minsElapsed/60), "h, ", mod(@minsElapsed,60), "m");
end //
delimiter ;

drop view if exists orders_sent_but_not_recieved;

create view orders_sent_but_not_recieved as
select id, calc_time_in_transit(sent_from_store) as time_in_transit from orders
where sent_from_store is not null and arrived_at_customer is null;

select * from orders_sent_but_not_recieved;

#9
/* För orders skapa en vy som visar de 5 orders som det var kortast tid mellan att de skickades tills att de
kom fram till kund. Sortera på tid i stigande ordning. Kortast tid övers. */
drop function if exists calc_time_for_arrival;

delimiter //
create function calc_time_for_arrival(date_sent datetime, date_arrived datetime)
returns int
no sql
begin
	set @minsElapsed = (select timestampdiff(minute, date_sent, date_arrived));
    /* mer detaljerad return-text som dock inte går att sortera med: return concat(floor(@minsElapsed/60), "h, ", mod(@minsElapsed,60), "m"); */
    return @minsElapsed;
end //
delimiter ;

drop view if exists fastest_delivery;

create view fastest_delivery as
select id, calc_time_for_arrival(sent_from_store, arrived_at_customer) as time_for_arrival from orders
where sent_from_store is not null and arrived_at_customer is not null
order by time_for_arrival asc
limit 5;

select * from fastest_delivery;
/*select to see if dates are correct for given id.*/
select sent_from_store, arrived_at_customer from orders where id = 328;
select sent_from_store, arrived_at_customer from orders where id = 14;

#10
/* För orders skapa en procedure som visar order-id, och en kolumn för "Status" där det står:
"Processing" för de orders som är mottagna men inte är skickade
"Sent" för de som är skickade men ej kommit fram till kund där det inte gått mer än 14 dagar
"Lost?" för de som är skickade men ej kommit fram till kund och där det gått mer än 14 dagar
"Fast" för de som kommit fram till kund inom 72 h
"Slow" för de som kommit fram med mer än 72 h i frakttid. */
drop function if exists min_in_transit;

/*Funktion som behövs vid ett case i proceduren order_status */
delimiter //
create function min_in_transit (date_sent datetime)
returns int 
no sql
begin
	return (select timestampdiff(minute, date_sent, now()));
end //
delimiter ;

drop procedure if exists order_status;

delimiter //
create procedure order_status ()
no sql
begin
	select id,
    case
		when received_at_store is not null and sent_from_store is null then "Processing"
        when sent_from_store is not null and arrived_at_customer is null then "Sent"
        when sent_from_store is not null and arrived_at_customer is null and min_in_transit(sent_from_store) > (1440*14) then "Lost?"
        when calc_time_for_arrival(sent_from_store, arrived_at_customer) <= (1440*3) then "Fast"
        when calc_time_for_arrival(sent_from_store, arrived_at_customer) > (1440*3) then "Slow"
        else "Other status"
	end as Status
        from orders;
end //
delimiter ;

call order_status;


    







