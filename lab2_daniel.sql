CREATE DATABASE lab2;

use lab2;

/* DB2-VT20-L2-skal */
/* Senast ändrad/uppdaterad 191211 */

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


# Lab 2

# Uppgift 1
Create View all_users as
SELECT u.username, Count(u.id) AS number_of_friends FROM users AS u
Join friends AS F
ON u.id = f.u_id
GROUP BY u.username;

/*
Demonstration Uppgift 1
Kod nedan hämtar allt från vyn all_users
*/

SELECT * FROM all_users;

# Uppgift 2

Create View friends_list AS
SELECT u.id AS userID, u.username, uFriend.username AS friendname FROM users AS u
Join friends AS f
ON u.id = f.u_id
-- Self Join för att kunna visa vännens namn
Join users AS uFriend
ON f.f_id = uFriend.id;

/*
Demonstration
Kod nedan hämtar ut alla vänner till jsnow
*/

SELECT friendname FROM friends_list WHERE username = "jsnow";

# Uppgift 3

DELIMITER //
CREATE PROCEDURE user_email()
BEGIN
SELECT u.email, u.fname, u.lname FROM users AS u;
END //
DELIMITER ;

/*
Demonstration
Kod nedan kallar på den lagrade proceduren
*/

CALL user_email();

# Uppgift 4
/*
Skapar en procedur där med hobby varchar
som inparameter och lägger in det i hobbiestabellen
*/

DROP PROCEDURE IF EXISTS add_hobby;
DELIMITER //
CREATE PROCEDURE add_hobby(IN hobby varchar(32))
BEGIN
INSERT INTO hobbies (name) VALUES (hobby);
END //
DELIMITER ;

Call add_hobby("Fishing");
Call add_hobby("Beer drinking");
Call add_hobby("Dragon Slaying");

/*
Demonstration
Hämtar tabellen när vi lagt till nya hobbies
*/

SELECT * FROM hobbies;

# Uppgift 5
/*
Skapar Procedur med inparametrar för skapande av ny användare.
Proceduren lägger även till Last_Insert_ID() i userhobbies och sätter h_id
till 1, vilket är "Swords".
*/

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
CALL add_user("nedStark", "goodguy","stark@live.com", "Eddard", "Stark", 47);

/*
Demonstration
Hämtar ut uppgifter om användare som har Swords som hobby.
*/

SELECT u.id, u.username, u.email, u.fname, u.lname, h.name AS hobby FROM users AS u
Join usershobbies AS uh
ON u.id = uh.u_id
Join hobbies as h
ON h.id = uh.h_id
WHERE (h.name ="Swords");

# Uppgift 6

/* SKa gå att effektivisera med JOIN*/
DELIMITER //
CREATE PROCEDURE delete_user(IN id INT)
BEGIN
DELETE FROM usershobbies AS h
WHERE h.u_id = id;
DELETE FROM friends AS f
WHERE f.u_id = id;
DELETE FROM users AS u
WHERE u.id = id;
END //
DELIMITER ;

/*
Demonstration. Tar bort önskad användare genom call
Kör sedan Select * För att kolla att användaren är borta.
I detta fall tar vi bort den nyligen tillagda användaren nedStark
*/
CALL delete_user(10);

SELECT * FROM users;

# Uppgift 7

DELIMITER //
CREATE PROCEDURE add_friendship(IN id_a INT, IN id_b INT)
BEGIN
INSERT INTO FRIENDS (u_id, f_id) values (id_a, id_b);
INSERT INTO FRIENDS (u_id, f_id) values (id_b, id_a);
END //
DELIMITER ;

/*
Demonstration
Lägger till vänsambandet mellan Arya och The Hound
*/

Call add_friendship(1,8);

SELECT friendname FROM friends_list WHERE username = "arya";

# Uppgift 8

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
DELIMITER ;


DELIMITER //
CREATE TRIGGER age_update_trigger
BEFORE UPDATE
ON users
FOR EACH ROW
BEGIN
    CALL agecheck(NEW.age);
END//
DELIMITER ;

/* 
Demonstration
Försöker lägga till användare som är under 11. Får då felmeddelande att ålder är för låg.
*/

CALL add_user("2young", "notoldenough","young@live.com", "Not", "Old", 10);

Select * From users;

# Uppgift 9

DELIMITER //
CREATE FUNCTION greeting(fname varchar(32))
RETURNS varchar(32) DETERMINISTIC
BEGIN
RETURN Concat('Välkommen', ' ', fname);
END//
DELIMITER ;


/* Hämtar email och hälsnings meddelande från users*/
SELECT email, greeting(fname) AS greetings FROM users; 



