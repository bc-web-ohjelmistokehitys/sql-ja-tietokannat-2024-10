CREATE TABLE student(
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    last_name VARCHAR(255) NULL,
    first_name VARCHAR(255) NULL,
    birthday DATE NOT NULL,
    studentgroup_id SMALLINT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE studentgroup(
    id SMALLINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL
);

ALTER TABLE
    studentgroup ADD PRIMARY KEY(id);

ALTER TABLE
    student ADD CONSTRAINT student_studentgroup_id_foreign FOREIGN KEY(studentgroup_id) REFERENCES studentgroup(id);

/*

'' vs "" on merkitsevä asia SQL:ssä.

*/

/*
// TODO: fix this because nönnö.
ALTER TABLE
    "student" ADD PRIMARY KEY("id");
*/


