/*Queries that provide answers to the questions from all projects.*/

Select * from animals where name like '%mon';
Select name from animals where date_of_birth between '20160101' and '20190101';
Select name from animals where neutered = true and escape_attempts < 3;
SELECT date_of_birth as "Date of Birth" FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, weight_kg FROM animals WHERE weight_kg > 10.5 ORDER BY weight_kg DESC;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Begin a transaction
BEGIN;

UPDATE animals SET species = 'unspecified';

-- Veryfying that change was made in the database
SELECT * FROM animals;

--Rollback the transaction
ROLLBACK;

--Verify that the transaction was successful
SELECT * FROM animals;

--Update the species colunm
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;

COMMIT;
SELECT * FROM animals;

--deleting all Records
BEGIN;
DELETE FROM animals;

--Rollback the transaction
ROLLBACK;

DELETE FROM animals WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;

--update and commit
UPDATE
    animals
SET
    weight_kg = weight_kg * -1;

ROLLBACK TO SP1;

UPDATE
    animals
SET
    weight_kg = weight_kg * -1
WHERE
    weight_kg < 0;

COMMIT;

 SELECT COUNT(*) FROM animals;

 SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

 SELECT AVG(weight_kg) FROM animals;
--group by comparism
 SELECT
    COUNT(*)
FROM
    animals;

SELECT
    COUNT(*)
FROM
    animals
WHERE
    escape_attempts = 0;

SELECT
    AVG(weight_kg)
FROM
    animals;

SELECT
    MAX(escape_attempts),
    neutered
FROM
    animals
GROUP BY
    neutered;

SELECT
    MIN(weight_kg)
FROM
    animals;

SELECT
    MAX(weight_kg)
FROM
    animals;

--Average escape attempt

SELECT
    AVG(escape_attempts)
FROM
    animals
WHERE
    date_of_birth BETWEEN 'Jan 01,1990'
    AND 'Dec 31,2000';


     SELECT a.name 
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name 
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name, a.name;

SELECT s.name, COUNT(a.id) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name 
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name 
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts=0;

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY COUNT(a.id) DESC


SELECT
    a.name
FROM
    animals a
    JOIN visits v ON a.id = v.animals_id
    JOIN vets ON vets.id = v.vets_id
WHERE
    vets.name = 'William Tatcher'
GROUP BY
    a.name
ORDER BY
    MAX(v.date_of_visit) DESC
LIMIT
    1;

SELECT
    a.name
FROM
    animals a
    JOIN visits v ON a.id = v.animals_id
    JOIN vets ON vets.id = v.vets_id
WHERE
    vets.name = 'Stephanie Mendez'
GROUP BY
    a.name;

SELECT
    v.name,
    species.name AS specialties
FROM
    vets v
    LEFT JOIN specializations s ON v.id = s.vet_id
    LEFT JOIN species ON species.id = s.species _id;

SELECT
    a.name
FROM
    animals a
    JOIN visits v ON a.id = v.animals_id
    JOIN vets ON vets.id = v.vets_id
WHERE
    v.date_of_visit BETWEEN 'Apr 1, 2020'
    AND 'Aug 30, 2020'
    AND vets.name = 'Stephanie Mendez';

SELECT
    a.name,
    COUNT(*)
FROM
    animals a
    JOIN visits v ON a.id = v.animals_id
    JOIN vets ON vets.id = v.vets_id
GROUP BY
    a.name
ORDER BY
    COUNT(*) DESC
LIMIT
    1;

SELECT
    a.name
FROM
    animals a
    JOIN visits v ON a.id = v.animals_id
    JOIN vets ON vets.id = v.vets_id
WHERE
    vets.name = 'Maisy Smith'
GROUP BY
    a.name
ORDER BY
    MIN(v.date_of_visit)
LIMIT
    1;

SELECT
    a.name AS animal_name,
    a.date_of_birth,
    a.escape_attempts,
    a.neutered,
    a.weight_kg,
    a.species_id,
    a.owner_id,
    ve.name AS vet_name,
    ve.age,
    date_of_graduation,
    v.date_of_visit
FROM
    animals a
    JOIN visits v ON a.id = v.animals_id
    JOIN vets ve ON ve.id = v.vets_id
WHERE
    v.date_of_visit = (
        SELECT
            date_of_visit
        FROM
            visits
        ORDER BY
            date_of_visit DESC
        LIMIT
            1
    );

SELECT
    COUNT(*) AS misfit_visits_count
FROM
    vets
    LEFT JOIN specializations s ON vets.id = s.vet_id
    JOIN visits v ON vets.id = v.vets_id
    JOIN animals a ON a.id = v.animals_id
    LEFT JOIN species ON species.id = s.species_id
WHERE
    s.vet_id IS NULL
    OR (
        a.species_id != species.name
        AND s.vet_id != (
            SELECT
                s.vet_id
            FROM
                specializations s
            GROUP BY
                s.vet_id
            HAVING
                COUNT(s.vet_id) = (
                    SELECT
                        MAX(count_id)
                    FROM
                        (
                            SELECT
                                COUNT(s.vet_id) AS count_id
                            FROM
                                specializations s
                            GROUP BY
                                s.vet_id
                        ) AS count_ids
                )
        )
    );

;

SELECT
    a.species_id AS recommended_specialty
FROM
    vets
    JOIN visits v ON vets.id = v.vets_id
    JOIN animals a ON a.id = v.animals_id
WHERE
    vets.name = 'Maisy Smith'
GROUP BY
    (a.species_id)
ORDER BY
    COUNT(a.species_id) DESC
LIMIT
    1;

    --performance audit
    -- Use EXPLAIN ANALYZE on the previous queries to check what is happening. Take screenshots of them - they will be necessary later.
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';