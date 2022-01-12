CREATE DATABASE MOVIE;
USE movie;

CREATE TABLE movie (
	movie_id VARCHAR(20) NOT NULL PRIMARY KEY,
    movie_title VARCHAR(30) NOT NULL,
    plot_outline VARCHAR(100)
);

CREATE TABLE movie_detail (
	movie_id VARCHAR(20) NOT NULL PRIMARY KEY,
    release_year DATE NOT NULL,
    production_co_id VARCHAR(30) NOT NULL,	-- FOREIGN KEY
    genre VARCHAR(20) NOT NULL 
    CHECK(genre in ("horror", "comedy", "thriller", "action", "drama", "fantasy", "mystery", "romance", "western")),
    director_id VARCHAR(20) NOT NULL,	-- FOREIGN KEY
    actor_id VARCHAR(20) NOT NULL,	-- FOREIGN KEY
    movie_quote VARCHAR(100)
);

CREATE TABLE actor (
	actor_id VARCHAR(20) NOT NULL PRIMARY KEY,
    f_name VARCHAR(30) NOT NULL,
    l_name VARCHAR(30) NOT NULL,
    DOB DATE
);

CREATE TABLE actor_detail (
	actor_id VARCHAR(20) NOT NULL PRIMARY KEY,
    movie_id VARCHAR(20) NOT NULL,	-- FOREIGN KEY
    actor_role VARCHAR(30),
    CONSTRAINT movie_id_FK_actor_detail FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

ALTER TABLE movie_detail	-- CREATE FK 'ACTOR_ID' IN TABLE 'MOVIE_DETAIL'
ADD CONSTRAINT actor_id_FK_movie_detail FOREIGN KEY (actor_id) REFERENCES actor (actor_id);

CREATE TABLE director (
	director_id VARCHAR(20) NOT NULL PRIMARY KEY,
    f_name VARCHAR(30) NOT NULL,
    l_name VARCHAR(30) NOT NULL,
    DOB DATE
);

CREATE TABLE director_detail (
	director_id VARCHAR(20) NOT NULL PRIMARY KEY,
    movie_id VARCHAR(20) NOT NULL,	-- FOREIGN KEY
    director_actor_role VARCHAR(30),
    CONSTRAINT movie_id_FK_director_detail FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

ALTER TABLE movie_detail
ADD CONSTRAINT director_id_FK_movie_detail FOREIGN KEY (director_id) REFERENCES director (director_id);

CREATE TABLE production_co (
	production_co_id VARCHAR(20) NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(20)
);

CREATE TABLE production_co_detail (
	production_co_id VARCHAR(20) NOT NULL PRIMARY KEY,
    movie_id VARCHAR(20) NOT NULL, -- FOREIGN KEY
    director_id VARCHAR(20) NOT NULL,	-- FOREIGN KEY
    CONSTRAINT movie_id_FK_production_co_detail FOREIGN KEY (movie_id) REFERENCES movie (movie_id),
    CONSTRAINT director_id_FK_production_co_detail FOREIGN KEY (director_id) REFERENCES director (director_id)
);

ALTER TABLE movie_detail 
ADD CONSTRAINT production_co_id_FK_movie_detail FOREIGN KEY (production_co_id) REFERENCES production_co (production_co_id);

ALTER TABLE director_detail 
ADD COLUMN production_co_id VARCHAR(20) NOT NULL,
ADD CONSTRAINT production_co_id_director_detail FOREIGN KEY (production_co_id) REFERENCES production_co (production_co_id);

-- show columns from actor-- 
-- show columns from actor_detail
-- show columns from director
-- show columns from director_detail
-- show columns from movie
-- show columns from movie_detail
-- show columns from production_co
-- show columns from production_co_detail
-- show columns from production_co_detail
show columns from staffcustomer