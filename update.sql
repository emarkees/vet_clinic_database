-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)

INSERT INTO owners (full_name, email)
SELECT 'Owner ' || generate_series(1, 2500000), 'owner_' || generate_series(1, 2500000) || '@mail.com'
ON CONFLICT DO NOTHING;

explain analyze SELECT COUNT(*) FROM visits where vet_id = 4
--------------------------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(*) FROM visits where vet_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

--------------------------------------------------------------------------------------------------------------------------------------------
INDEXING SOL:
CREATE INDEX visits_vet_id_idx ON visits (vet_id);
CREATE INDEX owners_email_idx ON owners (email);