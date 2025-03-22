
DROP DATABASE IF EXISTS periodic_table;


CREATE DATABASE periodic_table;


\c periodic_table


CREATE TABLE elements (
  atomic_number SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  symbol VARCHAR(5) NOT NULL UNIQUE
);


CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(50) NOT NULL
);


INSERT INTO types (type) VALUES ('metal'), ('nonmetal'), ('metalloid');


CREATE TABLE properties (
  atomic_number INT PRIMARY KEY REFERENCES elements(atomic_number),
  atomic_mass DECIMAL NOT NULL,
  melting_point_celsius DECIMAL NOT NULL,
  boiling_point_celsius DECIMAL NOT NULL,
  type_id INT NOT NULL REFERENCES types(type_id)
);


INSERT INTO elements (atomic_number, name, symbol) VALUES
(1, 'Hydrogen', 'H'),
(2, 'Helium', 'He'),
(3, 'Lithium', 'Li'),
(4, 'Beryllium', 'Be'),
(5, 'Boron', 'B'),
(6, 'Carbon', 'C'),
(7, 'Nitrogen', 'N'),
(8, 'Oxygen', 'O'),
(9, 'Fluorine', 'F'),
(10, 'Neon', 'Ne');


INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES
(1, 1.008, -259.1, -252.9, (SELECT type_id FROM types WHERE type='nonmetal')),
(2, 4.0026, -272.2, -268.9, (SELECT type_id FROM types WHERE type='nonmetal')),
(3, 6.94, 180.5, 1342, (SELECT type_id FROM types WHERE type='metal')),
(4, 9.0122, 1287, 2469, (SELECT type_id FROM types WHERE type='metal')),
(5, 10.81, 2075, 4000, (SELECT type_id FROM types WHERE type='metalloid')),
(6, 12.011, 3550, 4827, (SELECT type_id FROM types WHERE type='nonmetal')),
(7, 14.007, -210.1, -195.8, (SELECT type_id FROM types WHERE type='nonmetal')),
(8, 15.999, -218.3, -182.9, (SELECT type_id FROM types WHERE type='nonmetal')),
(9, 18.998, -220, -188.1, (SELECT type_id FROM types WHERE type='nonmetal')),
(10, 20.18, -248.6, -246.1, (SELECT type_id FROM types WHERE type='nonmetal'));


DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;
