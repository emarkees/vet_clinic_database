/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES 
    ('Agumon', '2020-02-03', 10.23, true, 0),
    ('Gabumon', '2018-11-15', 8, true, 2),
    ('Pikachu', '2021-01-07', 15.04, false, 1),
    ('Devimon', '2017-05-12', 11, true, 5),
    ('Charmander', '2020-02-08', -11, false, 0),
    ('Plantmon', '2021-11-15', -5.7, true, 2),
    ('Squirtle', '1993-04-02', -12.13, false, 3),
    ('Angemon', '2005-06-12', -45, true, 1),
    ('Boarmon', '2005-06-07', 20.4, true, 7),
    ('Blossom', '1998-10-13', 17, true, 3),
    ('Ditto', '2022-05-14', 22, true, 4);


/* populate database for owners */
INSERT INTO owners (full_name, age)
VALUES 
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

/* populate database for species */

INSERT INTO species (name)
VALUES 
    ('Pokemon'),
    ('Digimon');

/* Update animals species_id */
UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
  END;


/* Update animals owner_id */

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');


/* Insert the following data for vets table */

INSERT INTO vets (name, age, date_of_graduation)
	VALUES 
		('William Tatcher', 45, '2000-04-23'),
		('Maisy Smith', 26, '2019-01-17'),
		('Stephanie Mendez', 64, '1981-05-04'),
		('Jack Harkness', 38, '2008-06-08');

/* Insert the following data for specializations table */

INSERT INTO specializations (vet_id, species_id)
	VALUES 
		((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
		((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
		((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),	(SELECT id FROM species WHERE name = 'Pokemon')),
		((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

/* Insert the following data for visits table */

INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Agunmon')), (SELECT id FROM vets WHERE name IN ('William Tatcher')), '2020-05-24'); 
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Agunmon')), (SELECT id FROM vets WHERE name IN ('Stephanie Mendez')), '2020-07-22');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Gabumon')), (SELECT id FROM vets WHERE name IN ('Jack Harkness')), '2021-02-02');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Pikachu')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2020-01-05');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Pikachu')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2020-03-08');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Pikachu')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2020-05-14');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Devimon')), (SELECT id FROM vets WHERE name IN ('Stephanie Mendez')), '2021-05-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Charmander')), (SELECT id FROM vets WHERE name IN ('Jack Harkness')), '2021-02-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Plantmon')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2019-12-21');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Plantmon')), (SELECT id FROM vets WHERE name IN ('William Tatcher')), '2020-08-10');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Plantmon')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2021-04-07');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Squirtle')), (SELECT id FROM vets WHERE name IN ('Stephanie Mendez')), '2019-09-29');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Angemon')), (SELECT id FROM vets WHERE name IN ('Jack Harkness')), '2020-10-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Angemon')), (SELECT id FROM vets WHERE name IN ('Jack Harkness')), '2020-11-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Boarmon')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2019-01-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Boarmon')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2019-05-15');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Boarmon')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2020-02-27');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Boarmon')), (SELECT id FROM vets WHERE name IN ('Maisy Smith')), '2020-08-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Blossom')), (SELECT id FROM vets WHERE name IN ('Stephanie Mendez')), '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name IN ('Blossom')), (SELECT id FROM vets WHERE name IN ('William Tatcher')), '2021-01-11');