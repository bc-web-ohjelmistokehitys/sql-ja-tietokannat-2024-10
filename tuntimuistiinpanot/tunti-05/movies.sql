DROP TABLE IF EXISTS movie CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS director CASCADE;
DROP TABLE IF EXISTS actor CASCADE;

CREATE TABLE movie (
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    duration SMALLINT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE person (
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE director(
    person_id BIGINT NOT NULL REFERENCES person(id),
    movie_id BIGINT NOT NULL REFERENCES movie(id),
    PRIMARY KEY(person_id, movie_id)
);


CREATE TABLE actor(
    person_id BIGINT NOT NULL REFERENCES person(id),
    movie_id BIGINT NOT NULL REFERENCES movie(id),
    acting varchar(255) NOT NULL,
    PRIMARY KEY(person_id, movie_id, acting)
);

INSERT INTO movie (title, duration)
VALUES ('Twilight 5000', 122);

INSERT INTO person (name) VALUES ('Stewart, Kristen');

INSERT INTO director (person_id, movie_id)
VALUES (1, 1);

INSERT INTO actor (person_id, movie_id, acting)
VALUES (1, 1, 'Bella'),
(1, 1, 'Edward'),
(1, 1, 'Jack');




/*
ikärajat eri maissat.

keyword
genret
    

user score

eri maiden ensi-illat

*/