DROP DATABASE IF EXISTS bal_db;

CREATE DATABASE bal_db;

USE bal_db;

CREATE TABLE student(
	id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(100),
	dob DATE,
    PRIMARY KEY(id)
);

SELECT * FROM student;