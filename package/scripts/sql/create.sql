BEGIN ;

CREATE TABLE IF NOT EXISTS t_recipe (
    "identifier"    BIGINT PRIMARY KEY,
    "title"     	CHARACTER VARYING(128) NOT NULL,
    "description"   CHARACTER VARYING(512)
);

CREATE TABLE IF NOT EXISTS t_magazine (
    "identifier"    BIGINT PRIMARY KEY,
    "title"     	CHARACTER VARYING(128) NOT NULL,
    "description"   CHARACTER VARYING(512)
);

CREATE TABLE IF NOT EXISTS t_component (
    "identifier"    BIGINT PRIMARY KEY,
    "title"     	CHARACTER VARYING(128) NOT NULL,
    "description"   CHARACTER VARYING(512),
    "class"         CHARACTER VARYING(5122) NOT NULL,
    "container"     BOOLEAN DEFAULT FALSE
);

DROP  TABLE IF NOT EXISTS Users ();

DROP  TABLE IF NOT EXISTS Editeurs ();

DROP  TABLE IF NOT EXISTS Genres ();

DROP  TABLE IF NOT EXISTS Types ();

DROP  TABLE IF NOT EXISTS Personnes ();

DROP  TABLE IF NOT EXISTS Series ();

DROP  TABLE IF NOT EXISTS Tomes ();

DROP  TABLE IF NOT EXISTS SerieGenre ();

DROP  TABLE IF NOT EXISTS Travails ();

DROP  TABLE IF NOT EXISTS Roles ();

CREATE TABLE IF NOT EXISTS Users (
    "id"            BIGINT PRIMARY KEY,
    "name"     	    varchar(255) NOT NULL,
    "firstname"     varchar(255) NOT NULL,
    "sex"           char(1) NOT NULL,
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Editeurs (
    "id"            BIGINT PRIMARY KEY,
    "name"          varchar(255) NOT NULL,
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Genres (
    "id"            BIGINT PRIMARY KEY,
    "name"          varchar(255) NOT NULL,
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Types (
    "id"            BIGINT PRIMARY KEY,
    "name"          varchar(255) NOT NULL,
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Personnes (
    "id"            BIGINT PRIMARY KEY,
    "name"     	    varchar(255) NOT NULL,
    "firstname"     varchar(255) NOT NULL,
    "sex"           char(1) NOT NULL,
    "naissance"     datetime,
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Series (
    "id"            BIGINT PRIMARY KEY,
    "name"     	    varchar(255) NOT NULL,
    "volumes"       float (11) NOT NULL,
    "cover"         varchar(255) NOT NULL,
    "GenreId"       int(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS Tomes (
    "code"          varchar(13) PRIMARY KEY,
    "name"     	    varchar(255) NOT NULL,
    "volume"        float(11) NOT NULL,
    "pages"         int(11) NOT NULL,
    "date_VF"       datetime,
    "date_VO"       datetime,
    "resumer"       varchar(3000),
    "cover"         varchar(255) NOT NULL,
    "EditeurId"     int(11) NOT NULL,
    "SerieId"       int(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS SeriesGenres (
    "GenreId"       int(11) NOT NULL,
    "SerieId"       int(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS Travails (
    "PersonneId"    int(11) NOT NULL,
    "TomeCode"      varchar(13) NOT NULL
);


CREATE TABLE IF NOT EXISTS Roles (
    "id"            BIGINT PRIMARY KEY,
    "role"     	    varchar(255) NOT NULL,
    "cover"         varchar(255) NOT NULL,
);

ALTER TABLE SerieGenres
  ADD CONSTRAINT `SerieGenres_ibfk_1` FOREIGN KEY (`GenreId`) REFERENCES `Genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `SerieGenres_ibfk_2` FOREIGN KEY (`SerieId`) REFERENCES `Series` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Tomes
  ADD CONSTRAINT `Tomes_ibfk_1` FOREIGN KEY (`EditeurId`) REFERENCES `Editeurs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Tomes_ibfk_2` FOREIGN KEY (`SerieId`) REFERENCES `Series` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Travails
  ADD CONSTRAINT `Travails_ibfk_1` FOREIGN KEY (`PersonneId`) REFERENCES `Personnes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Travails_ibfk_2` FOREIGN KEY (`TomeCode`) REFERENCES `Tomes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Travails_ibfk_3` FOREIGN KEY (`RoleId`) REFERENCES `Roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

COMMIT ;
