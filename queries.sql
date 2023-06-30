/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, date_of_birth FROM animals WHERE weight_kg >= '10.5';
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified */
BEGIN;

UPDATE animals SET species = 'unspecified';

/* To verify changes */

SELECT * FROM animals; 

COMMIT;

/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon */

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

/* To verify changes */

SELECT * FROM animals;

COMMIT;

/* To delete all records in a transaction */

BEGIN;

DELETE FROM animals;

ROLLBACK;

/* To verify changes */

SELECT * FROM animals;

/* To delete all records in a transaction */

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2020-01-01';

SAVEPOINT del_dob_animals;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO SAVEPOINT del_dob_animals;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

/* How many animals are there? */

SELECT COUNT(*) AS total_animals FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) AS animals_without_escape_attempts FROM animals WHERE escape_attempts = 0;

/*What is the average weight of animals? */
SELECT AVG(weight_kg) AS average_weight_of_animals FROM animals;

/* Who escapes the most, neutered or not neutered animals? */

SELECT neutered, COUNT(*) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC
LIMIT 1;

/*What is the minimum and maximum weight of each type of animal? */

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/* query using JOIN */

/* What animals belong to Melody Pond? */

SELECT animals
  FROM animals
	JOIN owners ON animals.owner_id = owner_id
	WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */

SELECT animals
  FROM animals
  JOIN species ON animals.species_id = species_id
  WHERE species.name = 'pokemon';

/* List all owners and their animals in cluding those with no animals */

SELECT owners.full_name, animals.name  
  FROM owners
  LEFT JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species? */

SELECT species.name, COUNT(animals.id) AS animal_count
  FROM species
  LEFT JOIN animals ON species.id = animals.species_id
  GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/* Who owns the most animals? */

SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

