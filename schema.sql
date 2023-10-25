
/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(id integer NOT NULL default nextval('seq_id'),
 name varchar(100),
 date_of_birth date,
 escape_attempts int,
 neutered boolean,
 weight_kg decimal,
 primary key(id));

/* Add a column species of type string to your animals table. */

 ALTER TABLE animals ADD COLUMN species VARCHAR(50);

 --Create Table Named owners
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);