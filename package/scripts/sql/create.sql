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

CREATE TABLE IF NOT EXISTS Users (
    "id"            integer PRIMARY KEY,
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
    "id"            integer PRIMARY KEY,
    "name"          varchar(255) NOT NULL,
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Personnes (
    "id"            integer PRIMARY KEY,
    "name"     	    varchar(255) ,
    "firstname"     varchar(255) ,
    "sexe"           char(1) NOT NULL,
    "naissance"     date,
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Series (
    "id"            integer PRIMARY KEY,
    "name"     	    varchar(255) NOT NULL,
    "cover"         varchar(255) NOT NULL,
    "volumes"       float (11) NOT NULL,
    "GenreId"       integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Tomes (
    "code"          varchar(13) PRIMARY KEY,
    "name"     	    varchar(255) NOT NULL,
    "date_VF"       varchar(255),
    "date_VO"       varchar(255),
    "volume"        float(11) NOT NULL,
    "pages"         integer NOT NULL,
    "resumer"       date NOT NULL,
    "cover"         date NOT NULL,
    "EditeurId"     integer NOT NULL,
    "SerieId"       integer NOT NULL
);

CREATE TABLE IF NOT EXISTS SeriesGenres (
    "GenreId"       integer NOT NULL,
    "SerieId"       integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Travails (
    "PersonneId"    integer NOT NULL,
    "TomeCode"      varchar(13) NOT NULL
);


CREATE TABLE IF NOT EXISTS Roles (
    "id"            integer PRIMARY KEY,
    "role"     	    varchar(255) NOT NULL,
    "cover"         varchar(255) NOT NULL
);

ALTER TABLE SeriesGenres
  ADD CONSTRAINT SerieGenres_ibfk_1 FOREIGN KEY ("GenreId") REFERENCES Genres ("id") ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT SerieGenres_ibfk_2 FOREIGN KEY ("SerieId") REFERENCES Series ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Tomes
  ADD CONSTRAINT Tomes_ibfk_1 FOREIGN KEY ("EditeurId") REFERENCES Editeurs ("id") ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT Tomes_ibfk_2 FOREIGN KEY ("SerieId") REFERENCES Series ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Travails
  ADD CONSTRAINT Travails_ibfk_1 FOREIGN KEY ("PersonneId") REFERENCES Personnes ("id") ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT Travails_ibfk_2 FOREIGN KEY ("TomeCode") REFERENCES Tomes ("code") ON DELETE CASCADE ON UPDATE CASCADE;
  --ADD CONSTRAINT Travails_ibfk_3 FOREIGN KEY ("RoleId") REFERENCES Roles ("id") ON DELETE SET NULL ON UPDATE CASCADE;

COMMIT ;
