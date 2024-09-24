#!/bin/bash

# CREATE DATABASE number_guess;

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

$PSQL "CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  user_name VARCHAR(22) UNIQUE NOT NULL
);"


$PSQL "CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  game_score INT NOT NULL,

  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);"

$PSQL "TRUNCATE TABLE users RESTART IDENTITY CASCADE;"

#* fake data
$PSQL "INSERT INTO users(user_name) VALUES
  ('BOB')
;"

$PSQL "INSERT INTO games(game_score, user_id) VALUES
  (19, 1),
  (69, 1),
  (12, 1),
  (3, 1),
  (9, 1),
  (69, 1)
;"