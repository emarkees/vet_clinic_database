/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

/* Schema for owners table */

CREATE TABLE owners (
  id SERIAL NOT NULL PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  age INTEGER NOT NULL
);

/* Schema for species table */

CREATE TABLE species (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

/* modify animal table */

ALTER TABLE animals
ALTER COLUMN id SET DATA TYPE SERIAL PRIMARY KEY;

/* drop species column */
ALTER TABLE animals
DROP COLUMN species;

/* add species_id and owners_id for rerfrencing */

ALTER TABLE animals
ADD COLUMN species_id INTEGER,
ADD COLUMN owner_id INTEGER,
ADD CONSTRAINT fk_species
  FOREIGN KEY (species_id)
  REFERENCES species(id),
ADD CONSTRAINT fk_owners
  FOREIGN KEY (owner_id)
  REFERENCES owners(id);
