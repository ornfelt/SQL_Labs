#Lab 2
    
use lab2_schema;
    
#1    
/* Skapa en vy med en kolumn för username och en kolumn
med number_of_friends där det är uträknat hur många vänner de har. */
drop view if exists userNumFriends;

create view userNumFriends as
select u.username as user, count(f.u_id) as AmountOfFriends from friends as f
join users as u
on u.id = f.u_id
group by u.username;

select * from userNumFriends;

#2
/* Skapa en vy med användarnamn (username) och namnen på deras kompisar. Ska t ex gå att göra
SELECT friendname FROM friends_list WHERE username = "arya" för att få ut lista med vänner till Arya. */
drop view if exists userFriendNames;

create view userFriendNames as
select u.username as user, fN.username as user_friend from friends f
join users u
on u.id = f.u_id
join users fN
on fN.id = f.f_id;

select * from userFriendNames;

#3
/* Skapa en procedure så att call user_email();
ger en lista med epost, fname och lname för alla användare i DB. */
drop procedure if exists user_email;

delimiter //
create procedure user_email()
deterministic
begin 
	select fname as FirstName, lname as LastName, email from users;
end //
delimiter ;

call user_email();

#4
/*Skapa en procedure som lägger till en hobby i tabellen hobbies. */
drop procedure if exists add_Hobby;

delimiter //
create procedure add_Hobby(
	in newHobby text)
    begin
		insert into hobbies (name) values (newHobby);
    end //
    delimiter ;
    
call add_Hobby("testHobby");
Call add_hobby("Fishing");
Call add_hobby("Beer drinking");
select * from hobbies;
    
#5
/* Skapa en procedure som lägger till en user. För alla nya användare som läggs till ska
även läggas till en koppling så att de får hobbyn "Swords". */
drop procedure if exists add_user;

DELIMITER //
CREATE PROCEDURE add_user(IN username varchar(16), IN pass varchar(255), 
IN email varchar(255),IN fname varchar(32),IN lname varchar(32),IN age INT)
BEGIN
INSERT INTO users (username, pass, email, fname, lname, age) VALUES (username, pass, email, fname, lname, age);
INSERT INTO usershobbies(u_id, h_id) values (LAST_INSERT_ID(),1);
END //
DELIMITER ;

CALL add_user("thehound", "killMountain","hound@live.com", "Sandor", "Clegane", 42);
CALL add_user("themountain", "killAll","mountain@live.com", "Gregor", "Clegane", 45);
call add_user("tormund", "iLoveMeat!", "Tormund", "Giantsbane", "tormund@example.com", 33);

select * from users;
    
#6
/* Skapa en stored procedure för att ta bort en användare */
drop procedure if exists deleteUser;
    
    delimiter //
	create procedure deleteUser(
	in user_id int)
	begin
		delete usershobbies,friends, friends2 from usershobbies 
        inner join friends on friends.u_id = usershobbies.u_id
        inner join friends as friends2 on friends2.f_id = usershobbies.u_id
        where usershobbies.u_id = user_id;
        delete from users where users.id = user_id;
	end //
	delimiter ;
    
    /* Demonstration. Tar bort önskad användare genom call.
    Kör sedan Select * För att kolla att användaren är borta.
	*/
    set @lastUserId = last_insert_id();
    call deleteUser(@lastUserId);
    call deleteUser(7);
    
	select * from users;
    select * from userfriendnames;
    
#7
/* Vid lagring av nya vänner så måste det ligga två poster för att sambanden ska fungera. 
Skriv en procedure som tar två användar-id och lagrar (id_a, id_b) och (id_b,id_a) i tabellen för Friends. */
drop procedure if exists add_friendship;

delimiter //
create procedure add_friendship(
	in id_a int, id_b int)
    begin
		insert into friends (u_id, f_id) values (id_a, id_b), (id_b, id_a);
	end //
    delimiter ;
    
/* create friendship between arya and sam */
call add_friendship(1, 7);
select * from userFriendNames;

#8
/* Gör triggers som innan insert och update kontrollerar att ålder på användare är 11 eller mer än 11.
Om ålder är satt till mindre än 11 så ska ett meddelande skrivas ut. */
drop trigger if exists agecheck;

DELIMITER //
CREATE PROCEDURE agecheck(IN age INT)
DETERMINISTIC
NO SQL
BEGIN
IF age < 11
THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ålder lägre än 11';
END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER age_insert_trigger
BEFORE INSERT
ON users
FOR EACH ROW
BEGIN
    CALL agecheck(NEW.age);
END//

CREATE TRIGGER age_update_trigger
BEFORE UPDATE
ON users
FOR EACH ROW
BEGIN
    CALL agecheck(NEW.age);
END//
DELIMITER ;

/* tests for triggers */
call add_user("tommen", "WannaBeKing2", "Tommen", "Lannister", "tommen@example.com", 10);
call add_user("tommen", "WannaBeKing2", "Tommen", "Lannister", "tommen@example.com", 11);
update users set age = 10 where id = 1;
update users set age = 11 where id = 1;
select * from users;
call deleteUser(last_insert_id());

#9
/* Gör en funktion som returnerar en hälsningsfras tillsammans med användarens förnamn (att använda vid
t.ex. vid mailutskick). Ska kunna köras i exempelvis SELECT email, greeting(fname) FROM users; */
drop function if exists greeting;

delimiter //
create function greeting (
	name varchar(32))
    returns text deterministic
    begin
		declare returnText text;
        set returnText = concat("Welcome ", name, ". I wish you good fortune in the wars to come.");
        return returnText;
	end //
    delimiter ;
    
select email, greeting(fname) from users;

#10 
/* gör en procedure som för en användare ger en lista med som mest 3 st användare (username) som
den inte är kompis men som någon av den användarens kompisar är kompis med. */
drop procedure if exists suggest_friends;
    
    delimiter //
	create procedure suggest_friends(
	in userName text)
    begin
		set @userNameId := (select users.id from users where users.username = userName);
        select distinct userName, u.username as SuggestedFriends from users as u
        join friends as f
        on u.id = f.f_id and u.id != @userNameId
        where f.u_id in (select f2.f_id from friends as f2 where f2.u_id = @userNameId) and f.f_id not in
        (select f3.f_id from friends as f3 where f3.u_id = @userNameId)
        limit 3;
	end //
    delimiter ;
    
    call suggest_friends("jorah");
    call suggest_friends("dragons");
    select * from users;
    
    select * from userfriendnames;
    
    