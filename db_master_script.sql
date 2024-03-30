-- Database: nelo_db

/*
DROP DATABASE IF EXISTS nelo_db;
CREATE DATABASE nelo_db
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	ROLLBACK TRANSACTION;
*/
BEGIN TRANSACTION;

	DROP TABLE IF EXISTS public.clubs_sports_users;
	DROP TABLE IF EXISTS public.players;
	DROP TABLE IF EXISTS public.coaches_categories;
	DROP TABLE IF EXISTS public.coaches;
	DROP TABLE IF EXISTS public.categories;
	DROP TABLE IF EXISTS public.lines;
    DROP TABLE IF EXISTS public.clubs_sports;
	DROP TABLE IF EXISTS public.clubs;
    DROP TABLE IF EXISTS public.sports;
	DROP TABLE IF EXISTS public.users;

    CREATE TABLE IF NOT EXISTS public.clubs
    (
        club_id SMALLSERIAL PRIMARY KEY,
        description VARCHAR(100) NOT NULL,
        logo_url TEXT,
        active BOOLEAN NOT NULL DEFAULT true
    );

    CREATE TABLE IF NOT EXISTS public.sports
    (
        sport_id SMALLSERIAL PRIMARY KEY,
        description VARCHAR(100) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS public.clubs_sports
    (
		club_sport_id SMALLSERIAL PRIMARY KEY,
        club_id SMALLINT NOT NULL,
        sport_id SMALLINT NOT NULL,
        CONSTRAINT club_id FOREIGN KEY (club_id) REFERENCES public.clubs (club_id) MATCH SIMPLE,
        CONSTRAINT sport_id FOREIGN KEY (sport_id) REFERENCES public.sports (sport_id) MATCH SIMPLE
    );

    CREATE TABLE IF NOT EXISTS public.lines
    (
        line_id SMALLSERIAL PRIMARY KEY,
		club_sport_id SMALLINT NOT NULL,
        description VARCHAR(100) NOT NULL,
		gender VARCHAR(100) NOT NULL,
		CHECK (gender IN ('Female', 'Male', 'Mix')),
        division VARCHAR(100) NOT NULL,
		CONSTRAINT club_sport_id FOREIGN KEY (club_sport_id) REFERENCES public.clubs_sports (club_sport_id) MATCH SIMPLE
    );
	
	CREATE TABLE IF NOT EXISTS public.users
    (
        user_id SMALLSERIAL PRIMARY KEY,
        email TEXT NOT NULL,
        pwd_hash VARCHAR(128) NOT NULL,
		first_name VARCHAR(100) NOT NULL,
		last_name VARCHAR(100) NOT NULL,
		active BOOL NOT NULL DEFAULT TRUE
    );
	
	CREATE TABLE IF NOT EXISTS public.clubs_sports_users
    (
		club_sport_user_id SMALLSERIAL PRIMARY KEY,
        club_sport_id SMALLINT NOT NULL,
        user_id SMALLINT NOT NULL,
        CONSTRAINT club_sport_id FOREIGN KEY (club_sport_id) REFERENCES public.clubs_sports (club_sport_id) MATCH SIMPLE,
        CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users (user_id) MATCH SIMPLE
    );
	
	CREATE TABLE IF NOT EXISTS public.coaches
    (
        coach_id SMALLSERIAL PRIMARY KEY,
		club_sport_id SMALLINT,
		first_name VARCHAR(100) NOT NULL,
		last_name VARCHAR(100) NOT NULL,
		phone VARCHAR(100),
		salary INT,
		email TEXT,
		active BOOL NOT NULL DEFAULT TRUE,
		CONSTRAINT club_sport_id FOREIGN KEY (club_sport_id) REFERENCES public.clubs_sports (club_sport_id) MATCH SIMPLE
    );
	
	CREATE TABLE IF NOT EXISTS public.categories
    (
        category_id SMALLSERIAL PRIMARY KEY,
		club_sport_id SMALLINT NOT NULL,
		line_id SMALLINT,
		description VARCHAR(100) NOT NULL,
		gender VARCHAR(100) NOT NULL,
		CHECK (gender IN ('Female', 'Male', 'Mix')),
		division VARCHAR(100),
		active BOOL NOT NULL DEFAULT TRUE,
		CONSTRAINT club_sport_id FOREIGN KEY (club_sport_id) REFERENCES public.clubs_sports (club_sport_id) MATCH SIMPLE,
		CONSTRAINT line_id FOREIGN KEY (line_id) REFERENCES public.lines (line_id) MATCH SIMPLE
    );
	
	CREATE TABLE IF NOT EXISTS public.coaches_categories
    (
        coach_category_id SMALLSERIAL PRIMARY KEY,
		coach_id SMALLINT NOT NULL,
		category_id SMALLINT NOT NULL,
		role VARCHAR(100) NOT NULL,
		CONSTRAINT coach_id FOREIGN KEY (coach_id) REFERENCES public.coaches (coach_id) MATCH SIMPLE,
		CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.categories (category_id) MATCH SIMPLE
    );
	
	CREATE TABLE IF NOT EXISTS public.players
    (
        player_id SERIAL PRIMARY KEY,
		first_name VARCHAR(100) NOT NULL,
		last_name VARCHAR(100) NOT NULL,
		birth DATE NOT NULL,
		gender VARCHAR(100) NOT NULL,
		CHECK (gender IN ('Female', 'Male', 'Other')),
		competitor_id VARCHAR(100), -- this is the ID as player of the competition (at first it's gonna be entered manually)
		club_member_id VARCHAR(100), -- this is the ID as member of the club
		position VARCHAR(100),
		citizen_id VARCHAR(100), -- this is the ID as citizen of the country
		phone VARCHAR(100),
		sec_phone VARCHAR(100),
		email TEXT,
		active BOOL NOT NULL DEFAULT TRUE,
		club_sport_id SMALLINT NOT NULL,
		category_id SMALLINT NOT NULL,
		CONSTRAINT club_sport_id FOREIGN KEY (club_sport_id) REFERENCES public.clubs_sports (club_sport_id) MATCH SIMPLE,
		CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.categories (category_id) MATCH SIMPLE
    );

COMMIT TRANSACTION;

-- INSERTS FOR TESTING

BEGIN TRANSACTION;

	INSERT INTO public.clubs (description) VALUES ('Ferro Carril Oeste');
	INSERT INTO public.clubs (description) VALUES ('San Cirano');

	INSERT INTO public.sports (description) VALUES ('Hockey');
	INSERT INTO public.sports (description) VALUES ('Futbol');
	INSERT INTO public.sports (description) VALUES ('Rugby');
	
	INSERT INTO public.clubs_sports (club_id, sport_id) VALUES (1, 1);
	INSERT INTO public.clubs_sports (club_id, sport_id) VALUES (1, 2);
	INSERT INTO public.clubs_sports (club_id, sport_id) VALUES (2, 1);
	INSERT INTO public.clubs_sports (club_id, sport_id) VALUES (2, 3);

	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira A', 'Female', 1, 'B');
	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira B', 'Female', 1, 'E');
	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira C', 'Female', 1, 'F');
	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira D', 'Female', 1, 'G');
	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira A', 'Male', 1, 'B');
	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira B', 'Male', 1, 'C');
	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira A', 'Female', 3, 'B');
	INSERT INTO public.lines (description, gender, club_sport_id, division) VALUES ('Tira B', 'Female', 3, 'E');
	
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Primera', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Intermedia', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Quinta', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Sexta', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Septima', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Octava', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Novena', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Decima', 'Female', 1, 1, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Primera', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Intermedia', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Quinta', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Sexta', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Septima', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Octava', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Novena', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Decima', 'Male', 1, 5, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Primera', 'Male', 1, 7, 'C');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Intermedia', 'Male', 1, 7, 'C');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Primera', 'Female', 3, 6, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Intermedia', 'Female', 3, 6, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Quinta', 'Female', 3, 7, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Sexta', 'Female', 3, 7, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Septima', 'Female', 3, 7, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Octava', 'Female', 3, 7, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Novena', 'Female', 3, 7, 'B');
	INSERT INTO public.categories (description, gender, club_sport_id, line_id, division) VALUES ('Decima', 'Female', 3, 7, 'B');
	
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Nelo Marcelo', 'Ramos');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Matias', 'Colunga');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Leonardo', 'Izraelevitch');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Camilo', 'Fernandez');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Roberto', 'De Bianchetti');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Fabian', 'Jeanneret');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Agustin', 'Artieda');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Emanuel', 'Castillo');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Natalia', 'Torres');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Eugenia', 'Nimo');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Marcelo', 'D''Amore');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (1, 'Rodolfo', 'Rivarola');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (3, 'Ivan', 'Moise');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (3, 'Gabriel', 'Ruderman');
	INSERT INTO public.coaches (club_sport_id, first_name, last_name) VALUES (3, 'Matias', 'Tripicchio');
	
	INSERT INTO public.coaches_categories (category_id, coach_id, role) VALUES (1, 5, 'DT');
	INSERT INTO public.coaches_categories (category_id, coach_id, role) VALUES (1, 6, 'PF');
	INSERT INTO public.coaches_categories (category_id, coach_id, role) VALUES (1, 7, 'Ayte');
	INSERT INTO public.coaches_categories (category_id, coach_id, role) VALUES (2, 5, 'DT');
	INSERT INTO public.coaches_categories (category_id, coach_id, role) VALUES (2, 8, 'PF');
	INSERT INTO public.coaches_categories (category_id, coach_id, role) VALUES (2, 7, 'Ayte');
	
	INSERT INTO public.players (first_name, last_name, birth, gender, club_sport_id, category_id) VALUES ('Julian', 'Gonzalez Chiquirrin', '1996-04-25', 'Male', 1, 18);
	INSERT INTO public.players (first_name, last_name, birth, gender, club_sport_id, category_id) VALUES ('Gabriel', 'Ruderman', '1996-02-01', 'Male', 1, 17);
	
	CREATE EXTENSION IF NOT EXISTS pgcrypto;
	INSERT INTO public.users (email, pwd_hash, first_name, last_name) VALUES ('julian.gchiquirrin@gmail.com', crypt('1234', gen_salt('bf')), 'Julian', 'Gonzalez Chiquirrin');
	INSERT INTO public.users (email, pwd_hash, first_name, last_name) VALUES ('gab.ruderman@gmail.com', crypt('1234', gen_salt('bf')), 'Gabriel', 'Ruderman');
	
	INSERT INTO public.clubs_sports_users (user_id, club_sport_id) VALUES (1, 1);
	INSERT INTO public.clubs_sports_users (user_id, club_sport_id) VALUES (1, 3);
	INSERT INTO public.clubs_sports_users (user_id, club_sport_id) VALUES (2, 1);
	INSERT INTO public.clubs_sports_users (user_id, club_sport_id) VALUES (2, 3);
	
COMMIT TRANSACTION;