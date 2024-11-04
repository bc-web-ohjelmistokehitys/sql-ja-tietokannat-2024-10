DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS studentgroup;

CREATE TABLE studentgroup(
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE student(
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    last_name VARCHAR(255) NULL,
    first_name VARCHAR(255) NULL,
    birthday DATE NOT NULL,
    /* todo! */
    studentgroup_id BIGINT NOT NULL REFERENCES studentgroup(id),
    PRIMARY KEY(id)
);

/* tämä saa id:n 1 koska me vain tiedämme sen */
INSERT INTO studentgroup (name) VALUES ('Testiryhmä');
INSERT INTO studentgroup (name) VALUES ('Testiryhmä 2');

INSERT INTO student (last_name, first_name, birthday, studentgroup_id) 
VALUES ('Forsström', 'Mikko', '1978-03-21', 1);

INSERT INTO student (last_name, first_name, birthday, studentgroup_id) 
VALUES ('Lohiposki', 'Gaylord', '1968-01-01', 1);

INSERT INTO student (last_name, first_name, birthday, studentgroup_id) 
VALUES ('Foo', 'Bar', '1978-03-21', 1);

INSERT INTO student (last_name, first_name, birthday, studentgroup_id) 
VALUES ('Lussen', 'Hofer', '1978-03-21', 2);


