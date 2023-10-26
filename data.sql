/* Populate database with sample data. */

INSERT INTO animals values(default,'Agumon', '20200203', 0, true, 10.23 ),
 (default,'Gabumon', '20181115', 2, true, 8 ),
 (default,'Pikachu', '20210107', 1, false, 15.04 ),
 (default,'Devimon', '20170512', 5, true, 11 );

 INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutered,
        escape_attempts
    )
VALUES
    ('Charmander', 'Feb 8, 2020', -11, FALSE, 0),
    ('Plantmon', 'Nov 15, 2021', -5.7, TRUE, 2),
    ('Squirtle', 'Apr 2,1993', -12.13, FALSE, 3),
    ('Angemon', 'Jun 12 2005', -45, TRUE, 1),
    ('Boarmon', 'Jun 7, 2005', 20.4, TRUE, 7),
    ('Blossom', 'Oct 13, 1998', 17, TRUE, 3),
    ('Ditto', 'May 14, 2022', 22, TRUE, 4);

    INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

    INSERT INTO species (name) VALUES
    ('Pokemon'),
    ('Digimon');

    UPDATE animals a
SET species_id = s.id
FROM species s
WHERE (a.name LIKE '%mon' AND s.name = 'Digimon')
   OR (a.name NOT LIKE '%mon' AND s.name = 'Pokemon');

   UPDATE animals a
SET owner_id = o.id
FROM owners o
WHERE o.full_name IN ('Sam Smith', 'Jennifer Orwell', 'Bob', 'Melody Pond', 'Dean Winchester')
  AND (
    (a.name = 'Agumon' AND o.full_name = 'Sam Smith')
    OR (a.name IN ('Gabumon', 'Pikachu') AND o.full_name = 'Jennifer Orwell')
    OR (a.name IN ('Devimon', 'Plantmon') AND o.full_name = 'Bob')
    OR (a.name IN ('Charmander', 'Squirtle', 'Blossom') AND o.full_name = 'Melody Pond')
    OR (a.name IN ('Angemon', 'Boarmon') AND o.full_name = 'Dean Winchester')
  );

  --insert data for vets
  INSERT INTO vets (name, age, date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

  --insert data for specializations
  INSERT INTO specializations (species_id, vets_id) VALUES
  (1, 1),
  (1, 3),
  (2, 3),
  (2, 4);