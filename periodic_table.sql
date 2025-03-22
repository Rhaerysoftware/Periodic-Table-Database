-- Drop and recreate the database
DROP DATABASE IF EXISTS periodic_table;
CREATE DATABASE periodic_table;
\c periodic_table;



CREATE TABLE elements (
  atomic_number SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  symbol VARCHAR(5) NOT NULL UNIQUE,
  atomic_mass DECIMAL(6,3) NOT NULL
);


-- Create types table
CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(50) NOT NULL UNIQUE
);

-- Insert unique element types
INSERT INTO types (type) VALUES ('nonmetal'), ('noble gas'), ('metalloid')
ON CONFLICT (type) DO NOTHING;

-- Create properties table with type_id as a foreign key
CREATE TABLE properties (
  atomic_number INT PRIMARY KEY REFERENCES elements(atomic_number) ON DELETE CASCADE,
  atomic_mass DECIMAL(6,4) NOT NULL,
  melting_point_celsius DECIMAL NOT NULL,
  boiling_point_celsius DECIMAL NOT NULL,
  type_id INT NOT NULL REFERENCES types(type_id)
);

-- Insert elements
INSERT INTO elements (atomic_number, name, symbol, atomic_mass) VALUES
(1, 'Hydrogen', 'H', 1.008),
(2, 'Helium', 'He', 4.002),
(3, 'Lithium', 'Li', 6.94),
(4, 'Beryllium', 'Be', 9.012),
(5, 'Boron', 'B', 10.81),
(6, 'Carbon', 'C', 12.011),
(7, 'Nitrogen', 'N', 14.007),
(8, 'Oxygen', 'O', 15.999),
(9, 'Fluorine', 'F', 18.998),
(10, 'Neon', 'Ne', 20.18);

-- Insert properties
INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES
(1, 1.008, -259.1, -252.9, (SELECT type_id FROM types WHERE type='nonmetal')),
(2, 4.0026, -272.2, -268.9, (SELECT type_id FROM types WHERE type='noble gas')),
(3, 6.94, 180.5, 1342, (SELECT type_id FROM types WHERE type='metal')),
(4, 9.0122, 1287, 2469, (SELECT type_id FROM types WHERE type='metal')),
(5, 10.81, 2075, 4000, (SELECT type_id FROM types WHERE type='metalloid')),
(6, 12.011, 3550, 4827, (SELECT type_id FROM types WHERE type='nonmetal')),
(7, 14.007, -210.1, -195.8, (SELECT type_id FROM types WHERE type='nonmetal')),
(8, 15.999, -218.3, -182.9, (SELECT type_id FROM types WHERE type='nonmetal')),
(9, 18.998, -220, -188.1, (SELECT type_id FROM types WHERE type='nonmetal')),
(10, 20.18, -248.6, -246.1, (SELECT type_id FROM types WHERE type='noble gas'));

-- Delete non-existent element 1000 (if it was mistakenly added before)
DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;
