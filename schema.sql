
/* Database schema to keep the structure of entire database. */
 CREATE TABLE animals(id serial,
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

--Create Table Named species
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

--modify animal table
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

--Create Table Named vets
CREATE TABLE vets (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

--Create Table Named specializations
CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
    vets_id INT REFERENCES vets(id),
    PRIMARY KEY (species_id, vets_id)
);


--Create Table Named visits
CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    date_of_visit DATE,
    PRIMARY KEY (animals_id, vets_id, date_of_visit)
);

----------------------------------------------------------    
/* 5-- Database performance Audit */

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Use EXPLAIN ANALYZE on the previous queries to check what is happening. Take screenshots of them - they will be necessary later.
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';


--First query
CREATE INDEX index_animal ON visits(animal_id);
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;

-- Second Query
CREATE INDEX ver_id_index ON visits(vet_id) INCLUDE ( animal_id, visits_date) WHERE vet_id=2;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

--Third Query
CREATE INDEX email_index ON owners(email);
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';