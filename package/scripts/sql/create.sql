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
    "class"         CHARACTER VARYING(512) NOT NULL,
    "container"     BOOLEAN DEFAULT FALSE
);

COMMIT ;
