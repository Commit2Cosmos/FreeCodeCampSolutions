#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"


$PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;"
$PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;"
$PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;"


$PSQL "ALTER TABLE properties 
  ALTER COLUMN melting_point_celsius SET NOT NULL,
  ALTER COLUMN boiling_point_celsius SET NOT NULL
;"


$PSQL "ALTER TABLE elements
  ADD CONSTRAINT name_key UNIQUE (name),
  ADD CONSTRAINT symbol_key UNIQUE (symbol),

  ALTER COLUMN name SET NOT NULL,
  ALTER COLUMN symbol SET NOT NULL
;"


$PSQL "ALTER TABLE properties
  ADD CONSTRAINT fk_atomic_number
  FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number)
  ON DELETE CASCADE;
;"



$PSQL "CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(20) NOT NULL
);"


$PSQL "INSERT INTO types(type) VALUES
  ('nonmetal'),
  ('metal'),
  ('metalloid')
;"


$PSQL "ALTER TABLE properties
  ADD COLUMN type_id INT,
  ADD CONSTRAINT fk_type_id
  FOREIGN KEY (type_id) REFERENCES types(type_id)
;"


$PSQL "UPDATE properties p
  SET type_id = (
    SELECT t.type_id
    FROM types t
    WHERE t.type=p.type
  )
;"


$PSQL "ALTER TABLE properties
  ALTER COLUMN type_id SET NOT NULL
;"


$PSQL "ALTER TABLE properties DROP COLUMN type;"


$PSQL "UPDATE elements
  SET symbol=UPPER(LEFT(symbol,1)) || SUBSTRING(symbol,2,LENGTH(symbol))
;"



$PSQL "ALTER TABLE properties
  ALTER COLUMN atomic_mass TYPE DECIMAL
;"


$PSQL "UPDATE properties
  SET atomic_mass = TRIM(TRAILING '0' FROM atomic_mass::TEXT)::DECIMAL
;"



$PSQL "INSERT INTO elements VALUES
  (9, 'F', 'Fluorine'),
  (10, 'Ne', 'Neon')
;"


$PSQL "INSERT INTO properties VALUES
  (9, 18.998, '-220', '-188.1', 1),
  (10, 20.18, '-248.6', '-246.1', 1)
;"



$PSQL "DELETE FROM elements WHERE atomic_number=1000;"