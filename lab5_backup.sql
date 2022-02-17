create database if not exists lab5_schema;
use lab5_schema;

#Uppgift 1
/* 
Tabellerna och kolumner ska vara:
a) Users (id, name)
b) Accounts (id, amount)
c) Transfers (id, account_id, amount, note, datetime)
d) Owners (user_id, account_id)
*/
drop table if exists users;
drop table if exists accounts;
drop table if exists transfers;
drop table if exists owners;

create table users (id INT unsigned PRIMARY KEY AUTO_INCREMENT, name varchar(20) not null unique);
create table accounts (id INT unsigned PRIMARY KEY AUTO_INCREMENT, amount int unsigned);
create table transfers (id INT unsigned PRIMARY KEY AUTO_INCREMENT, account_id int unsigned, amount int, note text, datetime date not null,
foreign key(account_id) references accounts(id) on update cascade on delete restrict);
create table owners (user_id int unsigned not null, account_id int unsigned not null, foreign key(user_id) references users(id) on update cascade on delete restrict,
foreign key(account_id) references accounts(id) on update cascade on delete restrict);

/* CONSTRAINT FK_account_id FOREIGN KEY (account_id) REFERENCES accounts(id) */
/* CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users(id) */
/* CONSTRAINT FK_owners_account_id FOREIGN KEY (account_id) REFERENCES accounts(id) */
    
#Uppgift 2
/* 
Skapa innehåll
Skriv och kör queries för att fylla på med minst 5 användare med minst två konton vardera. Välj godtyckliga
rimliga värden för belopp som finns för konton. Gör så att minst 3 konton har mer än en ägare.
*/

insert into users (name) values ("Jonas");
insert into users (name) values ("Thomas");
insert into users (name) values ("Caroline");
insert into users (name) values ("Oscar");
insert into users (name) values ("Bella");

insert into accounts (amount) values (1103);
insert into accounts (amount) values (16720);
insert into accounts (amount) values (14510);
insert into accounts (amount) values (13008);
insert into accounts (amount) values (14011);
insert into accounts (amount) values (15009);
insert into accounts (amount) values (20067);
insert into accounts (amount) values (25033);
insert into accounts (amount) values (35034);
insert into accounts (amount) values (55000);
insert into accounts (amount) values (65000);
insert into accounts (amount) values (70126);
insert into accounts (amount) values (88172);
insert into accounts (amount) values (10101);
insert into accounts (amount) values (10872);

insert into transfers (account_id, amount, note, datetime) values (1, 500, "Damsugare", "2019-12-20");
insert into transfers (account_id, amount, note, datetime) values (1, 300, "Damsugsfilter mm.", "2019-12-28");
insert into transfers (account_id, amount, note, datetime) values (2, 1000, "studiebidrag", "2019-11-25");
insert into transfers (account_id, amount, note, datetime) values (2, 500, "födelsedagspeng", "2019-12-11");
insert into transfers (account_id, amount, note, datetime) values (3, 3000, "Datorkomponent", "2019-07-05");
insert into transfers (account_id, amount, note, datetime) values (3, 5000, "Datorkomponent", "2019-07-11");
insert into transfers (account_id, amount, note, datetime) values (3, 2150, "Datorkomponent", "2019-07-13");
insert into transfers (account_id, amount, note, datetime) values (4, 2500, "Kamera", "2019-08-10");
insert into transfers (account_id, amount, note, datetime) values (4, 550, "Kameratillbehör", "2019-11-13");
insert into transfers (account_id, amount, note, datetime) values (5, 500, "Överföring till mamma", "2019-12-25");
insert into transfers (account_id, amount, note, datetime) values (5, 500, "Överföring till pappa", "2019-11-25");
insert into transfers (account_id, amount, note, datetime) values (6, 750, "Payex betalning", "2019-09-17");
insert into transfers (account_id, amount, note, datetime) values (6, 374, "ICA", "2019-10-01");
insert into transfers (account_id, amount, note, datetime) values (6, 499, "Damsugare", "2019-10-14");
insert into transfers (account_id, amount, note, datetime) values (7, 5000, "Kamera", "2019-10-17");
insert into transfers (account_id, amount, note, datetime) values (7, 412, "COOP", "2019-10-23");
insert into transfers (account_id, amount, note, datetime) values (8, 500, "Damsugare", "2019-10-25");
insert into transfers (account_id, amount, note, datetime) values (8, 239, "Faktura", "2019-11-02");
insert into transfers (account_id, amount, note, datetime) values (9, 359, "Damsugare", "2019-11-13");
insert into transfers (account_id, amount, note, datetime) values (9, 482, "ICA", "2019-11-16");
insert into transfers (account_id, amount, note, datetime) values (9, 845, "COOP", "2019-11-20");
insert into transfers (account_id, amount, note, datetime) values (10, 754, "Payex betalning", "2019-12-11");
insert into transfers (account_id, amount, note, datetime) values (10, 453, "Faktura", "2019-12-15");
insert into transfers (account_id, amount, note, datetime) values (11, 659, "ICA", "2019-12-17");
insert into transfers (account_id, amount, note, datetime) values (11, 790, "Mekonomen", "2019-12-20");
insert into transfers (account_id, amount, note, datetime) values (12, 150, "Faktura", "2020-01-01");
insert into transfers (account_id, amount, note, datetime) values (12, 699, "Stadium", "2020-01-02");
insert into transfers (account_id, amount, note, datetime) values (12, 500, "Faktura", "2020-01-07");
insert into transfers (account_id, amount, note, datetime) values (13, 392, "COOP", "2020-01-08");
insert into transfers (account_id, amount, note, datetime) values (13, 499, "Damsugare", "2020-01-11");
insert into transfers (account_id, amount, note, datetime) values (14, 2999, "Datorkomponent", "2020-01-13");
insert into transfers (account_id, amount, note, datetime) values (14, 5000, "Faktura", "2020-01-16");
insert into transfers (account_id, amount, note, datetime) values (15, 500, "Payex betalning", "2020-02-01");
insert into transfers (account_id, amount, note, datetime) values (15, 150, "Öjburgare", "2020-02-01");

/*Konto med id = 3 har 3 ägare, id = 14 har 2 ägare, id = 15 har 2 ägare */
insert into owners(user_id, account_id) values (1,1);
insert into owners(user_id, account_id) values (1,2);
insert into owners(user_id, account_id) values (2,3);
insert into owners(user_id, account_id) values (2,4);
insert into owners(user_id, account_id) values (2,5);
insert into owners(user_id, account_id) values (3,6);
insert into owners(user_id, account_id) values (3,7);
insert into owners(user_id, account_id) values (3,8);
insert into owners(user_id, account_id) values (4,9);
insert into owners(user_id, account_id) values (4,10);
insert into owners(user_id, account_id) values (4,11);
insert into owners(user_id, account_id) values (5,12);
insert into owners(user_id, account_id) values (5,13);
insert into owners(user_id, account_id) values (5,14);
insert into owners(user_id, account_id) values (5,15);
insert into owners(user_id, account_id) values (4,14);
insert into owners(user_id, account_id) values (4,15);
insert into owners(user_id, account_id) values (1,3);
insert into owners(user_id, account_id) values (3,3);

#Uppgift 3
/*
Skapa en vy som innehålller kolumer med data från users och accounts som visar vilka konton som hör till en user och hur mycket pengar som finns på kontot.
Vi vill visa user_id, user_name, account_id och account_amount. Ska kunna användas med t ex SELECT * FROM users_accounts WHERE user = 3 ORDER BY user_id ASC;
eller SELECT user_id FROM users_accounts WHERE account_id = 7;
*/
drop view if exists users_accounts;

create view users_accounts as
select o.user_id as user_id, u.name as user_name, o.account_id as account_id, a.amount as account_amount from users as u
join owners as o on u.id = o.user_id
join accounts as a on o.account_id = a.id;

/*demonstration av vy */
select * from users_accounts;
select * from users_accounts where user_id = 3 order by user_id asc;
select user_id from users_accounts where account_id = 7;

#Uppgift 4
/*
Skriv en procedure som lägger till pengar till ett konto. Procedure ska ändra pengar på konto samt också lägga till en rad i transfers med notering om att det är
en insättning, på hur mycket och tid och datum för insättningen. Det ska endast gå att göra insättningar med positiva tal och till konton som redan finns.
Endast insättningar som är godkända ska loggas i transfers. Använd TRANSACTION och COMMIT så att det inte kan bli fel vid drift. Avsluta med ett SELECT som visar
på aktuell rad i transfers om allt gick igenom annars gör SELECT med ett status som är ett meddelande om "Error: acoount does not exist" eller
"Error: amount is not > 0" som sätts i procedure.
*/
drop procedure if exists deposit;

delimiter //
create procedure deposit(in acc_id int unsigned, in dep_amount int unsigned)
begin
	start transaction;
    if acc_id in(select id from accounts) then
		if dep_amount > 0 then
			update accounts set amount = amount + dep_amount;
            insert into transfers (account_id, amount, note, datetime) values (acc_id, dep_amount, "Insättning", current_Date());
            select * from transfers where id = last_insert_id();
		Else select "Amount cannot be < 0" as Status;
		end if;
	Else select "Account id does not exist" as Status;
	end if;
    commit;
end //
delimiter ;

/*Queries för demonstration */
select amount from accounts where id = 1;
set sql_safe_updates = 0;
call deposit(1, 100);
call deposit(16, 100);
call deposit(15, 0);
set sql_safe_updates = 1;

#Uppgift 5
/*
withdraw(account_id, amount)
Skriv en procedure som tar ut pengar från ett konto. Procedure ska ändra mängd pengar på konto samt också lägga till en rad i transfers med notering om att det är
ett uttag, på hur mycket och tid och datum för uttaget. Uttaget ska anges som ett positivt tal när vi anropar SP men pengar på kontot ska minskas och i
transfers-loggen ska talet skrivas som negativt. Det ska inte gå att ta ut mer pengar än vad som finns på kontot. Använd TRANSACTION och COMMIT så att det inte kan
bli fel vid drift till exempel att det görs flera uttag samtidigt). Avsluta med ett SELECT som visar på aktuell rad i transfers om allt gick igenom annars gör SELECT
med ett status som är ett meddelande om "Error: acoount does not exist" eller "Error: amount is too large" eller "ERROR: amount is not > 0" som sätts i procedure.
*/
drop procedure if exists withdraw;

delimiter //
create procedure withdraw(in acc_id int unsigned, in wit_amount int)
begin
	start transaction;
    if acc_id in(select id from accounts) then
		if wit_amount > 0 then
				if (select amount from accounts where id = acc_id) > wit_amount then
					update accounts set amount = amount - wit_amount;
					insert into transfers (account_id, amount, note, datetime) values (acc_id, (wit_amount*-1), "Uttag", current_Date());
					select * from transfers where id = last_insert_id();
				else select "Not enough money on account" as Status;
                end if;
		else select "Withdrawal amount cannot be < 0. Enter the non negative value you want to withdraw." as Status;
		end if;
	else select "Account id does not exist" as Status;
	end if;
    commit;
end //
delimiter ;

/*Queries för demonstration */
select amount from accounts where id = 2;
set sql_safe_updates = 0;
call withdraw(2, 100);
call withdraw(15, -10);
call withdraw(16, 100);
set sql_safe_updates = 1;


#Uppgift 6
/*
show_transfers(account_id)
Skriv queries för att skapa en procedure, show_transfers(account_id), som listar alla transfers för ett angivet konto sorterade på datum och tid.
Senaste transfer överst.
*/
drop procedure if exists show_transfers;

delimiter //
create procedure show_transfers(in acc_id int unsigned)
begin
	if acc_id in(select id from accounts) then
		if acc_id in(select account_id from transfers) then
			select * from transfers where account_id = acc_id;
            else select "No transfers logged for this account" as Status;
            end if;
    else select "Account id does not exist" as Status;
    end if;
end //
delimiter ;
    
/*Queries för demonstration */
select amount from accounts where id = 2;
set sql_safe_updates = 0;
call show_transfers(1);
call show_transfers(2);
set sql_safe_updates = 1;
    
#Uppgift 7
/*
no_of_owners(account_id)
Skapa en funktion som returnerar antal ägare för ett kontonummer (account_id). Ska kunna användas i t ex
SELECT id, no_of_owners(id) AS no_of_owners,amount FROM Accounts ORDER BY no_of_owners DESC;
*/	
drop function if exists no_of_owners;

/* unsigned? */
delimiter //
create function no_of_owners(acc_id int unsigned)
returns int
no sql
begin
	return (select count(user_id) from owners where account_id = acc_id);
end //
delimiter ;

/*Demonstration för funktion*/
select id, no_of_owners(id) as no_of_owners, amount from accounts order by no_of_owners desc;

#Uppgift 8
/*
TRANSACTION et al
Skriv queries för att: (1) starta en transaktion, (2) göra en UPDATE, (3) sätta en SAVEPOINT, (4) göra en UPDATE, (5) göra en ROLLBACK till savepoint,
(6) en göra COMMIT. Som exempel kan någon användare och/eller konton läggas till eller olika insättningar och uttag. Lägg in SELECT och kommentarer
som tydligt visar och förklarar vad som händer och inte händer och varför.
*/

Start transaction;
update accounts set amount = 20000 where id = 2;
/*Ovanstående update sätter amount till 20000 för konto med id=2. Detta registreras som savepoint */
savepoint amount_savepoint;
select amount from accounts where id = 2;
/*Nu uppdateras amount till 10000 istället för samma konto */
update accounts set amount = 10000 where id = 2;
select amount from accounts where id = 2;
/*Amount-värdet rullar tillbaks till savepoint */
rollback to amount_savepoint;
/*När commit körs registreras det hela, och värdet blir alltså som det först sattes till: 20000 */
select amount from accounts where id = 2;
commit;
select amount from accounts where id = 2;

#Uppgift 9
/*
USERS
Skriv queries för att skapa login för tre USERS till MySQL (inte users för tabellerna med accounts):
a) De tre ska heta: kim, alex, app
b) Ge alla access (GRANT) så de kan göra SELECT och UPDATE på alla tabeller i DB för denna laboration
c) Ta bort (REVOKE) så att alex och app inte får göra UPDATE på users, accounts och owners.
d) Begränsa så att alex inte får göra mer än 200 queries per timme 
*/
drop user if exists 'Kim'@'localhost';
drop user if exists 'Alex'@'localhost';
drop user if exists 'App'@'localhost';

#a)
create user 'Kim'@'localhost' identified by 'SecurePass01';
create user 'Alex'@'localhost' identified by 'SecurePass02';
create user 'App'@'localhost' identified by 'SecurePass03';
#b)
/* old (* doesn't seem to work)
grant select, update on lab5_schema.* to 'Kim'@'localhost'; 
grant select, update on lab5_schema.* to 'Alex'@'localhost';
grant select, update on lab5_schema.* to 'App'@'localhost'; */

grant select, update on lab5_schema.accounts to 'Alex'@'localhost';
grant select, update on lab5_schema.accounts to 'App'@'localhost';
grant select, update on lab5_schema.accounts to 'Kim'@'localhost';
grant select, update on lab5_schema.users to 'Alex'@'localhost';
grant select, update on lab5_schema.users to 'App'@'localhost';
grant select, update on lab5_schema.users to 'Kim'@'localhost';
grant select, update on lab5_schema.owners to 'Alex'@'localhost';
grant select, update on lab5_schema.owners to 'App'@'localhost';
grant select, update on lab5_schema.owners to 'Kim'@'localhost';
grant select, update on lab5_schema.transfers to 'Alex'@'localhost';
grant select, update on lab5_schema.transfers to 'App'@'localhost';
grant select, update on lab5_schema.transfers to 'Kim'@'localhost';

#c)
revoke update on lab5_schema.users from 'Alex'@'localhost';
revoke update on lab5_schema.users from 'App'@'localhost';
revoke update on lab5_schema.accounts from 'Alex'@'localhost';
revoke update on lab5_schema.accounts from 'App'@'localhost';
revoke update on lab5_schema.owners from 'Alex'@'localhost';
revoke update on lab5_schema.owners from 'App'@'localhost';
#d)
alter user 'Alex'@'localhost' with max_queries_per_hour 200;

#Uppgift 10
/*
ROLES
Skriv queries för att skapa roller för att administrera databasen:
a) De ska heta: db_read (kan bara göra SELECT (alla tabeller i DB), db_write (kan göra INSERT och UPDATE (alla tabeller i DB),
db_sproc (får köra de sproc som vi implementerat ovan)
b) Tilldela db_read till Alex, db_write till Kim och db_sproc till app.
c) Skriv query för att lista rättigheter för Kim.
d) Skriv query för att lista rättigheter för db_write
*/
drop role if exists db_read;
drop role if exists db_write;
drop role if exists db_sproc;

#a)
create role 'db_read';
create role 'db_write';
create role 'db_sproc';

grant select on *.* to 'db_read';
grant insert, update on *.* to 'db_write';
grant execute on procedure lab5_schema.deposit to 'db_sproc';
grant execute on procedure lab5_schema.withdraw to 'db_sproc';
grant execute on procedure lab5_schema.show_transfers to 'db_sproc';

#b)
grant 'db_read' to 'Alex'@'localhost';
grant 'db_write' to 'Kim'@'localhost';
grant 'db_sproc' to 'App'@'localhost';

#c)
show grants for 'Kim'@'localhost';
#d)
show grants for 'db_write';


