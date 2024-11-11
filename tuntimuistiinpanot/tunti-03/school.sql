DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS studentgroup CASCADE;
DROP TABLE IF EXISTS teacher CASCADE;
DROP TABLE IF EXISTS grade CASCADE;
DROP TABLE IF EXISTS course CASCADE;

CREATE TABLE teacher(
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    last_name VARCHAR(255) NULL,
    first_name VARCHAR(255) NULL,
    PRIMARY KEY(id)
);

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

CREATE TABLE course(
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
  studentgroup_id BIGINT NOT NULL REFERENCES studentgroup(id),
  teacher_id BIGINT NOT NULL REFERENCES teacher(id),
  PRIMARY KEY(id)
);

CREATE TABLE grade (
   student_id BIGINT NOT NULL REFERENCES student(id),
   course_id BIGINT NOT NULL REFERENCES course(id),
   grade VARCHAR(255) NOT NULL CHECK (grade = 'S' OR grade = 'ES' OR grade = 'S-' OR grade = 'S+'),
   PRIMARY KEY(student_id, course_id)
);

INSERT INTO teacher (last_name, first_name)
VALUES ('Mikko', 'Forsström');

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

INSERT INTO student (last_name, first_name, birthday, studentgroup_id) 
VALUES ('Oppilas 6', '6', '1978-03-21', 1);

INSERT INTO student (last_name, first_name, birthday, studentgroup_id) 
VALUES ('Oppilas 7', '7', '1978-03-21', 1);

INSERT INTO course (name, teacher_id, studentgroup_id)
VALUES ('SQL ja tietokannat', 1, 1);

INSERT INTO course (name, teacher_id, studentgroup_id)
VALUES ('C#', 1, 1);

INSERT INTO course (name, teacher_id, studentgroup_id)
VALUES ('HTML', 1, 1);


INSERT INTO grade (student_id, course_id, grade)
VALUES (1, 1, 'S+');

INSERT INTO grade (student_id, course_id, grade)
VALUES (2, 1, 'S-');



