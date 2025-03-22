#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

tail -n +2 atomic_mass.txt | while IFS="|" read -r ATOMIC_NUMBER ATOMIC_MASS
do
  
  ATOMIC_NUMBER=$(echo "$ATOMIC_NUMBER" | xargs)
  ATOMIC_MASS=$(echo "$ATOMIC_MASS" | xargs)

  
  if [[ "$ATOMIC_NUMBER" =~ ^[0-9]+$ ]] && [[ "$ATOMIC_MASS" =~ ^[0-9]+(\.[0-9]+)?$ ]]
  then
    echo "Updating atomic_mass for atomic_number=$ATOMIC_NUMBER to $ATOMIC_MASS"
    $PSQL "UPDATE properties SET atomic_mass=$ATOMIC_MASS WHERE atomic_number=$ATOMIC_NUMBER;"
  fi
done
