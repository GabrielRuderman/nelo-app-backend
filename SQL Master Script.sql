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
	
-- ROLLBACK TRANSACTION;
*/
BEGIN TRANSACTION;

	DROP TABLE IF EXISTS public.clubs_sports_users;
	DROP TABLE IF EXISTS public.players;
	DROP TABLE IF EXISTS public.coaches_categories;
	DROP TABLE IF EXISTS public.coaches;
	DROP TABLE IF EXISTS public.categories;
    DROP TABLE IF EXISTS public.clubs_sports;
	DROP TABLE IF EXISTS public.clubs;
    DROP TABLE IF EXISTS public.sports;
    DROP TABLE IF EXISTS public.lines;
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
        description VARCHAR(100) NOT NULL,
        division VARCHAR(100) NOT NULL
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
		role VARCHAR(100) NOT NULL,
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
		CHECK (gender IN ('female', 'male', 'other')),
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
INSERT INTO public.sports (description) VALUES ('Rugby');

-- TODO: habria que agregarle para que GENERO / CLUB / DEPORTE / USUARIO? se corresponde cada tira
INSERT INTO public.lines (description, division) VALUES ('Tira A', 'B');
INSERT INTO public.lines (description, division) VALUES ('Tira B', 'E');
INSERT INTO public.lines (description, division) VALUES ('Tira C', 'F');
INSERT INTO public.lines (description, division) VALUES ('Tira D', 'G');

COMMIT TRANSACTION;