#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

while IFS="|" read -r ATOMIC_NUMBER ATOMIC_MASS; do
  echo "Updating atomic_number=$ATOMIC_NUMBER, atomic_mass=$ATOMIC_MASS"
  $PSQL "UPDATE properties SET atomic_mass = ROUND($ATOMIC_MASS::NUMERIC, 4) WHERE atomic_number = $ATOMIC_NUMBER;"
done < atomic_mass.txt
