#Lab 1

CREATE TABLE Movies (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,    
  title TEXT NOT NULL,    
  year INTEGER NOT NULL,    
  rating INTEGER DEFAULT 1
);   

CREATE TABLE Genres (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,    
  name TEXT NOT NULL
);    

CREATE TABLE MoviesGenres (
  m_id INTEGER NOT NULL,   
  g_id INTEGER NOT NULL
);

ALTER TABLE MoviesGenres 
  ADD CONSTRAINT FK_Movies FOREIGN KEY (m_id) REFERENCES Movies(id);

ALTER TABLE MoviesGenres 
  ADD CONSTRAINT FK_Genres FOREIGN KEY (g_id) REFERENCES Genres(id);

INSERT INTO Movies (title, year, rating) VALUES    
  ("Star Wars - The Last Jedi", 2017, 9),   
  ("The Emoji Movie", 2016, 1),   
  ("The Matrix", 1999, 9),   
  ("The Shawshank Redemption", 1994, 10),   
  ("Titanic", 1997, 8),   
  ("Wargames", 1983, 7),   
  ("The Imitation Game", 2014, 8);  

INSERT INTO Genres (name) VALUES
  ("Action"),("Comedy"),("Drama"),("Sci-fi");     

INSERT INTO MoviesGenres VALUES
  (1, 1), (1, 2), (1,4),
  (2, 2), (2, 3),    
  (3, 1), (3, 4),    
  (4, 3),    
  (5, 3),(5, 4),    
  (6, 1),(6, 3);


create view MovieGenre as 
select Movies.title, Genres.name from MoviesGenres
join Movies on MoviesGenres.m_id = Movies.id
join Genres on MoviesGenres.g_id = Genres.id;

create view MovieGenre2 as 
select Movies.title, Genres.name as genre from MoviesGenres
join Movies on MoviesGenres.m_id = Movies.id
join Genres on MoviesGenres.g_id = Genres.id;

create view MoviesYears as 
select Movies.title, Movies.year from Movies;

create view TopRated as
select movies.title from movies
where movies.rating >= 9;

select * FROM new_schema.MoviesYears
order by title asc;

select * from new_schema.moviegenre;

select title from MovieGenre where name = "Sci-fi";

select title from MovieGenre2 where genre = "Sci-fi";

select * from TopRated;

/* ----------- */
/* f2-testing */
/* ----------- */

Delimiter //
create procedure movies()
begin
select * from Movies;
end //
Delimiter ;

set @topratinglimit = 9;
select @highestrating := (Select max(rating) from movies);

select @highestrating;

/* ----------- */
/* functions */
/* ----------- */

/* ----------- */
/* triggers */
/* ----------- */

/* trigger för att sätta årtal på film (första film skapades 1888, så kan inte va innan dess) */
Delimiter //
create trigger yearfix before insert on movies
for each row
if New.year < 1888 then set new.year = 1888;
end if;

drop procedure if exists validate_movie_year;
delimiter //
create procedure validate_movie_year(
	in year int
    )
    deterministic
    no sql
    begin 
    if year < 1888 then
		signal sqlstate "45000" set message_text = "no movies made before 1888";
        end if;
        end //
        delimiter ;

#F3

select now();
select time_to_sec((select now()));

alter table Genres add column last_edit timestamp;
select * from Genres where last_edit >= (now() - interval 15 minute);
select date(now()), month(now()), year("01-02-23");
select timestampdiff(day, "2019-12-24", now()) as Dagar_sen_julafton;
select dayname("2020-12-31");
select last_day("2020-02-21");
