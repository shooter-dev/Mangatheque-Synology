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
    "cover"         varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Tomes (
    "code"          varchar(13) PRIMARY KEY,
    "name"     	    varchar(255) NOT NULL,
    "volume"        float(11) NOT NULL,
    "pages"         int(11) NOT NULL,
    "date_VF"       datetime,
    "date_VO"       datetime,
    "resumer"       varchar(3000)
    "cover"         varchar(255) NOT NULL
);




COMMIT ;
