--Database - MySQL

--IMDB Design a DB for IMDB 
--1. Movie should have multiple media(Video or Image) 

--Movie Schema 
CREATE TABLE movies (
movie_id INT NOT NULL,
name TEXT,
PRIMARY KEY (movie_id)
);


INSERT INTO movies VALUES(1, "Kaithi");
INSERT INTO movies VALUES(2, "Mannadu");
INSERT INTO movies VALUES(3, "Thani Oruvan");


--Media Schema
CREATE TABLE media (
id INT NOT NULL,
video_url TEXT,
image_url TEXT,
movie_id INT,
PRIMARY KEY (id),
FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);


INSERT INTO media VALUES(1, "https://kaithi/img1.jpg", "https://kaithi/vido1.mp4", 1);
INSERT INTO media VALUES(2, "https://kaithi/img2.jpg", "https://kaithi/vido2.mp4", 1);
INSERT INTO media VALUES(3, "https://kaithi/img3.jpg", "https://kaithi/vido3.mp4", 1);

INSERT INTO media VALUES(4, "https://thanioruvan/img1.jpg", "https://thanioruvan/video1.mp4", 3);
INSERT INTO media VALUES(5, "https://thanioruvan/img2.jpg", "https://thanioruvan/video2.mp4", 3);
INSERT INTO media VALUES(6, "https://thanioruvan/img3.jpg", "https://thanioruvan/video3.mp4", 3);

INSERT INTO media VALUES(7, "https://mannadu/img1.jpg", "https://mannadu/video1.mp4", 2);
INSERT INTO media VALUES(8, "https://mannadu/img2.jpg", "https://mannadu/video2.mp4", 2);
INSERT INTO media VALUES(9, "https://mannadu/img3.jpg", "https://mannadu/video3.mp4", 2);

--Showing movies name along with respective media types
SELECT ROW_NUMBER() Over (Order by movies.name) As [S.N.], media.id, movies.name, media.image_url, media.video_url, media.movie_id FROM media 
INNER JOIN movies ON media.movie_id = movies.movie_id;



--2. Movie can belongs to multiple Genre 

--Movie Schema 
CREATE TABLE movies (
movie_id INT NOT NULL,
name TEXT,
PRIMARY KEY (movie_id)
);

INSERT INTO movies VALUES(1, "Kaithi");
INSERT INTO movies VALUES(2, "Mannadu");
INSERT INTO movies VALUES(3, "Thani Oruvan");
INSERT INTO movies VALUES(4, "Varisu");
INSERT INTO movies VALUES(5, "Thunivu");

--Movie_Genre Schema
CREATE TABLE movie_genre (

movie_id INT NOT NULL,
genre_id INT NOT NULL,
FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

INSERT INTO movie_genre VALUES(1, 1);
INSERT INTO movie_genre VALUES(1, 4);
INSERT INTO movie_genre VALUES(1, 7);

INSERT INTO movie_genre VALUES(2, 2);
INSERT INTO movie_genre VALUES(2, 3);
INSERT INTO movie_genre VALUES(2, 7);

INSERT INTO movie_genre VALUES(3, 7);
INSERT INTO movie_genre VALUES(3, 5);
INSERT INTO movie_genre VALUES(3, 1);

INSERT INTO movie_genre VALUES(4, 6);
INSERT INTO movie_genre VALUES(4, 5);
INSERT INTO movie_genre VALUES(4, 1);

INSERT INTO movie_genre VALUES(5, 4);
INSERT INTO movie_genre VALUES(5, 7);
INSERT INTO movie_genre VALUES(5, 1);

--Genre Schema
CREATE TABLE genre(
genre_id INT NOT NULL,
genre_name TEXT,
PRIMARY KEY (genre_id)
);

INSERT INTO genre VALUES (1,"Action");
INSERT INTO genre VALUES (2,"Adventure");
INSERT INTO genre VALUES (3,"Comedy");
INSERT INTO genre VALUES (4,"Crime");
INSERT INTO genre VALUES (5,"Drama");
INSERT INTO genre VALUES (6,"Romance");
INSERT INTO genre VALUES (7,"Thriller");

--Showing all moviews with their multiple generes
SELECT movies.movie_id, movies.name, genre.genre_name FROM movies
INNER JOIN movie_genre ON movies.movie_id = movie_genre.movie_id
INNER JOIN genre ON genre.genre_id = movie_genre.genre_id;


--3. Movie can have multiple reviews and Review can belongs to a user 

--Movie Schema 
CREATE TABLE movies (
movie_id INT NOT NULL,
movie_name TEXT,
PRIMARY KEY (movie_id)
);

INSERT INTO movies VALUES(1, "Kaithi");
INSERT INTO movies VALUES(2, "Mannadu");
INSERT INTO movies VALUES(3, "Thani Oruvan");


--Review Schema
CREATE TABLE reviews (
review_id INT NOT NULL,
status  TEXT,
PRIMARY KEY (review_id)
);

INSERT INTO reviews VALUES (1, "Bad");
INSERT INTO reviews VALUES (2, "Good");
INSERT INTO reviews VALUES (3, "Very Good");
INSERT INTO reviews VALUES (4, "Excellent");

--User Schema
CREATE TABLE users(
user_id INT NOT NULL,
name TEXT,
PRIMARY KEY (user_id)
);


INSERT INTO users VALUES(1, "Ajith");
INSERT INTO users VALUES(2, "Ragu");
INSERT INTO users VALUES(3, "Tony");
INSERT INTO users VALUES(4, "Akshay");

--Movie_Review_user Schema
CREATE TABLE movie_review_users (
movie_id INT NOT NULL,
review_id INT NOT NULL,
user_id INT NOT NULL,
FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
FOREIGN KEY (review_id) REFERENCES reviews(review_id),
FOREIGN KEY (user_id) REFERENCES users(user_id)
);


INSERT INTO movie_review_users VALUES(1, 1, 4);
INSERT INTO movie_review_users VALUES(1, 3, 3);

INSERT INTO movie_review_users VALUES(2, 3,1);
INSERT INTO movie_review_users VALUES(2, 4,2);

INSERT INTO movie_review_users VALUES(3, 4,2);
INSERT INTO movie_review_users VALUES(3, 2,3);


--Showing all movies with their reviews and respective users
SELECT ROW_NUMBER() Over (Order by users.name) As [S.N.], movies.movie_name, reviews.status, users.name FROM movies
INNER JOIN movie_review_users ON movies.movie_id = movie_review_users.movie_id
INNER JOIN reviews ON  reviews.review_id = movie_review_users.review_id
INNER JOIN users ON users.user_id = movie_review_users.user_id;


--4. Artist can have multiple skills 

--Artist Schema
CREATE TABLE artists (
artist_id INT NOT NULL,
artist_name TEXT,
PRIMARY KEY (artist_id)
);

INSERT INTO artists VALUES (1, "Kamal");
INSERT INTO artists VALUES (2, "Vijay");
INSERT INTO artists VALUES (3, "Ajith");
INSERT INTO artists VALUES (4, "Vadivelu");

--Skill Schema
CREATE TABLE skills (
skill_id INT NOT NULL,
skill_name TEXT,
PRIMARY KEY (skill_id)
);

INSERT INTO skills VALUES (1, "Acting");
INSERT INTO skills VALUES (2, "Dance");
INSERT INTO skills VALUES (3, "Singer");
INSERT INTO skills VALUES (4, "Comedy");
INSERT INTO skills VALUES (5, "Stunt");
INSERT INTO skills VALUES (6, "Directing");


--Artist_Skill Schema

CREATE TABLE artist_skills (
artist_id INT NOT NULL,
skill_id INT NOT NULL,
FOREIGN KEY (artist_id) REFERENCES artists(artist_id),
FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

INSERT INTO artist_skills VALUES (1,1);
INSERT INTO artist_skills VALUES (1,6);
INSERT INTO artist_skills VALUES (1,2);

INSERT INTO artist_skills VALUES (2,2);
INSERT INTO artist_skills VALUES (2,3);
INSERT INTO artist_skills VALUES (2,1);

INSERT INTO artist_skills VALUES (3,1);
INSERT INTO artist_skills VALUES (3,5);

INSERT INTO artist_skills VALUES (4,4);
INSERT INTO artist_skills VALUES (4,3);

--Showing Artists all their mutltiple Skills
SELECT ROW_NUMBER() Over (Order by artists.artist_name) As [S.N.], artists.artist_name, skills.skill_name FROM artists
INNER JOIN artist_skills ON artists.artist_id = artist_skills.artist_id
INNER JOIN skills ON skills.skill_id = artist_skills.skill_id;


--5. Artist can perform multiple role in a single film


--Artist Schema
CREATE TABLE artists (
artist_id INT NOT NULL,
artist_name TEXT,
PRIMARY KEY (artist_id)
);

INSERT INTO artists VALUES (1, "Kamal");
INSERT INTO artists VALUES (2, "Vijay");
INSERT INTO artists VALUES (3, "Surya");
INSERT INTO artists VALUES (4, "Vikram");


--Role Schema

CREATE TABLE roles (
role_id INT NOT NULL,
role_name TEXT,
PRIMARY KEY (role_id)
);

INSERT INTO roles VALUES (1, "Agent");
INSERT INTO roles VALUES (2, "Father");
INSERT INTO roles VALUES (3, "Megician");
INSERT INTO roles VALUES (4, "Doctor");
INSERT INTO roles VALUES (5, "Son");
INSERT INTO roles VALUES (6, "Father");
INSERT INTO roles VALUES (7, "Body Builder");
INSERT INTO roles VALUES (8, "Model");
INSERT INTO roles VALUES (9, "prisoner");
INSERT INTO roles VALUES (10, "Activist");

--Film Schema

CREATE TABLE films (
film_id INT NOT NULL,
film_name TEXT,
PRIMARY KEY (film_id)
);

INSERT INTO films VALUES (1, "Vikram");
INSERT INTO films VALUES (2, "Mersal");
INSERT INTO films VALUES (3, "Kathi");
INSERT INTO films VALUES (4, "Vaaranam Aayiram");
INSERT INTO films VALUES (5, "I");

--ARTIST_ROLE_FILM Schema

CREATE TABLE artist_role_films (
artist_id INT NOT NULL,
role_id INT NOT NULL,
film_id INT NOT NULL,
FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
FOREIGN KEY (role_id) REFERENCES roles(role_id),
FOREIGN KEY (film_id) REFERENCES films(film_id)
);

INSERT INTO artist_role_films VALUES (1,1,1);
INSERT INTO artist_role_films VALUES (1,2,1);
INSERT INTO artist_role_films VALUES (2,3,2);
INSERT INTO artist_role_films VALUES (2,4,2);
INSERT INTO artist_role_films VALUES (3,5,4);
INSERT INTO artist_role_films VALUES (3,6,4);
INSERT INTO artist_role_films VALUES (4,7,5);
INSERT INTO artist_role_films VALUES (4,8,5);
INSERT INTO artist_role_films VALUES (2,9,3);
INSERT INTO artist_role_films VALUES (2,10,3);

--Showing all the Artists multiple roles in a film
SELECT ROW_NUMBER() OVER (ORDER BY artists.artist_name) AS [S.N], films.film_name, roles.role_name, artists.artist_name FROM artists
INNER JOIN artist_role_films ON  artists.artist_id = artist_role_films.artist_id
INNER JOIN roles ON roles.role_id = artist_role_films.role_id
INNER JOIN films ON films.film_id = artist_role_films.film_id;
