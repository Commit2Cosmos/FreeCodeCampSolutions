#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"


if [ -z "$1" ]; then
  echo "Please provide an element as an argument."
  exit 0
fi


INPUT_VAL=$1


is_integer() {
  [[ "$1" =~ ^-?[0-9]+$ ]]
}


# search for type based on type_id from properties in types table
if is_integer "$INPUT_VAL"; then
  QUERY=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type
    FROM elements e
    JOIN properties p ON e.atomic_number = p.atomic_number
    JOIN types t ON p.type_id = t.type_id
    WHERE e.atomic_number = $INPUT_VAL
    LIMIT 1
  ;")
else
  QUERY=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e
    JOIN properties p ON e.atomic_number = p.atomic_number
    JOIN types t ON p.type_id = t.type_id
    WHERE e.symbol = '$INPUT_VAL'
    OR e.name = '$INPUT_VAL'
    LIMIT 1
  ;")
fi


if [ -z "$QUERY" ]; then
  echo "I could not find that element in the database."
  exit 0
fi


IFS='|' read -r ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE <<< "$QUERY"

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."