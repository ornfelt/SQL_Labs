create database if not exists lab4_schema;

use lab4_schema;

#Uppgift 1

/* 
Foreign keys
Skriv queries (ALTER TABLE) för koppla ihop tabellerna med foreign_keys och ta med lämpliga val för vad som ska hända vid updates och deletes på PK:
departments-mangager till employees-id,
project-supervisor till employees-id
projectmembers-e_id till employees-id
projectmembers-p_id till projects-id
*/

alter table departments
add constraint fk_departments_manager_id
foreign key (manager)
references employees(id)
on update cascade
on delete restrict;

alter table projects
add constraint fk_projects_supervisor
foreign key (supervisor)
references employees(id)
on update cascade
on delete restrict;

alter table project_members
add constraint fk_project_members_e_id
foreign key (e_id)
references employees(id)
on update cascade
on delete restrict;

alter table project_members
add constraint fk_project_members_p_id
foreign key (p_id)
references employees(id)
on update cascade
on delete restrict;

#Uppgift 2

/* 
Skriv queries så att projects ändras (ALTER TABLE) så att varje project alltid har en supervisor, så att två projektnamn inte kan vara samma,
och så att det alltid måste finnas ett projektnamn.
*/

alter table projects 
drop constraint check_project_sv;
alter table projects 
drop constraint check_project_name;

alter table projects
add constraint check_project_sv
	check (supervisor is not null),
add constraint check_project_name
	check(name is not null),
add unique (name);
    
/* demonstration att constraints fungerar */    
insert into projects (name, description, supervisor, start_date, end_date) values ('newname', 'asd', null, '2015-12-24', null);
insert into projects (name, description, supervisor, start_date, end_date) values (null, 'whoo', 3, '2015-12-24', null);
insert into projects (name, description, supervisor, start_date, end_date) values ("Sql4life", 'whoo', 3, '2015-12-24', null);


#Uppgift 3
/* 
Ändra i DB så att alla anställda alltid är knutna till en avdelning. Ändra så att default för nya
anställda och för anställda utan dept ska vara "Training". Det ska inte kunna finnas anställda
utan avdelningar. Lägg också in att deparments måste ha ett namn och det namnet måste vara unikt samt att
varje department måste ha en manager.
*/

alter table employees
add constraint check_employee_department
	check (department is not null),
    alter department
	set default 4;

select department from employees;
insert into employees (title, first_name, last_name, login, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile) values ('mr', 'noDepTest', 'nope', 'noDep1',
'1972-08-21', 'mail@mail.com', 43268, '760-02-0962', '2011-07-23', '734-91-2778', '734-91-2778');
select department from employees where first_name = 'noDepTest';
    
alter table departments
drop constraint check_department_name, drop constraint check_department_manager;

alter table departments 
add constraint check_department_name
	check(department is not null),
add constraint check_department_manager
	check(manager is not null),
add unique(department);

#Uppgift 4
/* 
	Employees
Vi (eller kund) vet att det kommer göras många sökningar och sorteringar på efternamn.
Lägg därför in INDEX där. Användarnamn måste också spärras så inte två kan få samma.
*/

alter table employees
add index (last_name),
add unique(login);

#Uppgift 5
/*
Optimera datatyper
Skriv queries som ändrar (ALTER TABLE)  ett par av datatyperna till något som är effektivare:
 a) projects - name behöver inte vara VARCHAR(50). Ändra till något som är mer lagom.
b) departments - id kommer aldrig vara större heltal än 50. Skriv query för att byta till mer
lagom datatyp än INT.
c) employees - title - kan bara vara något av "dr", "mr", "ms", "mrs", "rev" eller "honorable".
Byt datatyp till ENUM.
d) employees - leta reda på ett par kolumner där vi alltid måste ha något värde och ändra schemat
så att vi inte längre kan lagra null-värden för dessa.
e) employees - det får inte kunna lagras dubletter av epostadress. Skriv query som ändrar
tabellstrukturen och query som visar att det inte längre går att lagra dubletter.
*/

select name from projects;

#a)
ALTER TABLE projects MODIFY COLUMN name varchar(25);
#b)
alter table departments modify column id mediumint(50); /*Medium int eller int? */
#c)
alter table employees modify column title enum("dr", "mr", "ms", "mrs", "rev", "honorable");
#d)
alter table employees
add constraint check_employee_birth_date
	check(birth_date is not null),
add constraint check_employee_start_date
	check(start_date is not null);
    
/* demonstration för enum och constraints */
insert into employees (title, first_name, last_name, login, department, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('test', 'Creighton', 'Trowl', 'ctrowl4',
7, '1972-08-21', 'ctrowl4@ifeng.com', 43268, '760-02-0962', '2011-07-23', '734-91-2778', '734-91-2778', null);
insert into employees (title, first_name, last_name, login, department, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('Ms', 'Creighton', 'Trowl', 'ctrowl4',
7, null, 'ctrowl4@ifeng.com', 43268, '760-02-0962', '2011-07-23', null, '734-91-2778', null);
insert into employees (title, first_name, last_name, login, department, birth_date, email, salary,	
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('Ms', 'Creighton', 'Trowl', 'ctrowl4',
7, '1972-08-21', 'ctrowl4@ifeng.com', 43268, '760-02-0962', null, '734-91-2778', '734-91-2778', null);

#e)
alter table employees
add constraint check_employee_mail
	check(email is not null);
/* demonstration för constraint av mail */
insert into employees (title, first_name, last_name, login, department, birth_date, email, salary,
phone_work, start_date, phone_home, phone_mobile, hr_notes) values ('mr', 'Creighton', 'Trowl', 'ctrowl4',
7, '1972-08-21', null, 43268, '760-02-0962', '2011-07-23', '734-91-2778', '734-91-2778', null);

#Uppgift 6
/*
Skapa en vy som ger avdelningsnamn, minsta lön, högsta lön, medellön och antal anställda för varje avdelning.
*/
drop view if exists salary_data_dept;

create view salary_data_dept as
select department, calc_lowest_sal(id), calc_highest_sal(id), calc_middle_sal(id) from departments;

select * from salary_data_dept;

/*functions for the view */
drop function if exists calc_lowest_sal;
drop function if exists calc_highest_sal;
drop function if exists calc_middle_sal;

delimiter //
create function calc_lowest_sal(dep int)
returns int
no sql
begin
	set @lowestSal = (select salary from employees where department = dep order by salary asc limit 1);
	return @lowestSal;
end //
delimiter ;

delimiter //
create function calc_highest_sal(dep int)
returns int
no sql
begin
	set @highestSal = (select salary from employees where department = dep order by salary desc limit 1);
	return @highestSal;
end //
delimiter ;

delimiter //
create function calc_middle_sal(dep int)
returns int
no sql
begin
	set @middleSal = (select sum(salary) from employees where department = dep) / (select count(salary) from
    employees where department = dep);
	return @middleSal;
end //
delimiter ;

#Uppgift 7
/* 
Skapa en funktion som utifrån födelsedatum ger svaren "more than 5 years" för de som har mer än 5 (hela)
år kvar tills de fyller 65, för de som har mellan 5 och 1 år svarar funktionen hur många år det är kvar
 ex "3 years left", för de som fyller detta år men ännu inte fyllt svarar funktionen "Up for retirement"
 och för de som är äldre än 65 så svarar funktionen "Retired".
Skapa sedan en vy som listar anställda med titel, förnamn, efternamn, ålder, födelsedag och avdelning de
¨jobbar på samt deras retirement_status. Sortera på avdelning och sedan födelsedatum. Visa bara de som är
55 år eller äldre.
*/
drop view if exists retirement_status;
drop function if exists calc_emp_age;
drop function if exists calc_retirement_status;

create view retirement_status as
select e.title, e.first_name, e.last_name, calc_emp_age(e.birth_date) as age, e.birth_date, d.department,
calc_retirement_status(e.birth_date) as retirement_status from employees as e
join departments as d on d.id = e.department
where calc_emp_age(birth_date) >= 55;

select * from retirement_status;

select d.department from employees as e
join departments as d on e.department = d.id;

delimiter //
create function calc_retirement_status(birthDate Date)
returns text
no sql
begin
	set @retDate = (date_add(birthDate, interval 65 year));
    set @yearsLeft = (select timestampdiff(year, current_Date(), @retDate));
    set @returnText = (case
			when @yearsLeft < 0 or calc_emp_age(birthDate) >= 65 then "Retired"
            when @yearsLeft = 0 then "Up for retirement"
			when @yearsLeft >= 5 then "more than 5 years"
			when @yearsLeft < 5 then concat(@yearsLeft, " years left")
			else "Other status"
		end);
	return @returnText;
end //
delimiter ;

select first_name, calc_retirement_status(birth_date) as ret_status from employees;

delimiter //
create function calc_emp_age(birthDate Date)
returns int
no sql
begin
	set @empAge = (timestampdiff(year, birthDate, current_Date()));
    return @empAge;
end //
delimiter ;

#Uppgift 8
/* 
Skapa tabell: total_salary
Skapa en tabell för summan av löner, lägg in nuvarande värde (gör SELECT SUM(salary)...) och lägg till
triggers på anställdas löner så att summan av löner alltid stämmer i nya tabellen.
Tabellen ska också ha ett fält för last_update som visar när den senast uppdaterades.
Testa och visa med några UPDATE och INSERT av anställda att det fungerar. (Detta skulle kunna spara resurser
för DB om vi har många anställda och ofta ställer frågor kring summan av löner. Med detta upplägg så
behöver vi inte göra den potentiellt tunga summeringen av alla löner utan det räcker med att göra en
enkel uppslagning i den alltid uppdaterade total_salary.)
*/
drop table if exists total_salary;
drop trigger if exists salary_trigger_insert;
drop trigger if exists salary_trigger_update;

create table total_salary(id INT PRIMARY KEY AUTO_INCREMENT, salary_sum int, last_update datetime);
insert into total_salary (salary_sum, last_update) values ((select sum(salary) from employees), now());

select * from total_salary;

delimiter //
create trigger salary_trigger_insert
after insert
on employees
for each row
begin
	update total_salary set salary_sum = (select sum(salary) from employees);
    update total_salary set last_update = now();
end //
create trigger salary_trigger_update
after update
on employees
for each row
begin
	update total_salary set salary_sum = (select sum(salary) from employees);
    update total_salary set last_update = now();
end //
delimiter ;

SET SQL_SAFE_UPDATES = 0;
insert into employees (title, first_name, last_name, login, department,
birth_date, email, salary, phone_work, start_date, phone_home, phone_mobile, hr_notes) values
('Ms', 'user', 'new', 'newuser1', 7, '1972-08-21', 'newuser1@ifeng.com', 30000, '760-02-0962',
'2011-07-23', null, '734-91-2778', null);
SET SQL_SAFE_UPDATES = 1;

select * from total_salary;
update employees set salary = 40000 where id = last_insert_id();

SET SQL_SAFE_UPDATES = 0;
insert into employees (title, first_name, last_name, login, department,
birth_date, email, salary, phone_work, start_date, phone_home, phone_mobile, hr_notes) values
('Ms', 'user2', 'new2', 'newuser2', 7, '1972-08-21', 'newuser2@ifeng.com', 35000, '760-02-0962',
'2011-07-23', null, '734-91-2778', null);
SET SQL_SAFE_UPDATES = 1;

select * from total_salary;
update employees set salary = 38000 where id = last_insert_id();

#Uppgift 9
/*
Flytta hr_notes
a) Skriv queries för att skapa en tabell och flytta allt innehåll i hr_notes till den nya tabellen samt
koppla den nya tabellen till employees-id med foreign keys. Ta sedan bort kolumnen för hr_notes från
employees. (Spara era queries för redovisningen. Det räcker inte att visa nya tabellerna utan det
krävs att ni redovisar vilka queries som behöver köras för att skapa dem.)
b) Skriv query som visar efternamn, förnamn, hr_notes för alla anställda utifrån den nya tabellen.
*/
drop table if exists hr_notes;

create table notes_hr(id INT PRIMARY KEY AUTO_INCREMENT, hr_note text);

insert into notes_hr (hr_note) select hr_notes from employees;
select * from notes_hr;

alter table employees drop column hr_note_id;
ALTER TABLE employees ADD hr_note_id int;

alter table employees
add constraint fk_hr_note_id
foreign key (hr_note_id)
references notes_hr(id)
on update cascade
on delete restrict;

select hr_note_id from employees;

insert into employees (hr_note_id) select notes_hr.id from notes_hr;

SET SQL_SAFE_UPDATES = 0;
update employees inner join notes_hr on employees.id = notes_hr.id
set employees.hr_note_id = notes_hr.id;
SET SQL_SAFE_UPDATES = 1;

alter table employees drop column hr_notes;

select e.first_name, e.last_name, hr.hr_note as hr_notes from employees as e
join notes_hr as hr on e.hr_note_id = hr.id;

select * from employees;

#Uppgift 10
/*
Skriv kod för trigger som gör att löner begränsas så att det inte går att sänka lönen för en anställd
och inte går att höja med mer än 10%. */
drop trigger if exists sal_decrease_limiter;
drop trigger if exists salary_increase_limiter;

delimiter //
create trigger sal_decrease_limiter
before update
on employees
for each row
begin
	if NEW.salary < OLD.salary then
    signal sqlstate '45000' set message_text = "Can't decrease salary";
    end if;
end //
create trigger sal_increase_limiter
before update
on employees
for each row
begin
	if NEW.salary > (1.1*OLD.salary) then
    signal sqlstate '45000' set message_text = "Can't increase salary with more than 10%";
    end if;
end //
delimiter ;

SET SQL_SAFE_UPDATES = 0;
update employees set salary = 100 where id = 1;
/*Demonstration för increase trigger - id: 1 har 40508 i salary och går inte att uppdateras till > 44558.
id: 48 har 27031 i salary och går inte att uppdateras till > 29734.
*/
select salary from employees where id = 1; 
select salary from employees where id = 48; 
update employees set salary = 44559 where id = 1;
update employees set salary = 29735 where id = 48;


