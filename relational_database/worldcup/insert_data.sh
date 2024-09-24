#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


#* TABLE STRUCTURE

$($PSQL "DROP TABLE IF EXISTS games;")
$($PSQL "DROP TABLE IF EXISTS teams;")

$($PSQL "CREATE TABLE teams (
  team_id SERIAL PRIMARY KEY,
  name VARCHAR(60) UNIQUE NOT NULL
);")

$($PSQL "CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  year INT NOT NULL,
  round VARCHAR(60) NOT NULL,

  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL,

  winner_id INT NOT NULL,
  CONSTRAINT fk_winner
    FOREIGN KEY (winner_id)
      REFERENCES teams(team_id),

  opponent_id INT NOT NULL,
  CONSTRAINT fk_opponent
    FOREIGN KEY (opponent_id)
      REFERENCES teams(team_id)
);")


#* FILL OUT TABLE

#* add team names to db
$($PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;")

TEMP_FILE="temp.txt"
INPUT_FILE="games.csv"

cut -d "," -f 3-4 "$INPUT_FILE" | tail -n +2 | tr "," "\n" | sort | uniq > "$TEMP_FILE"

while IFS= read line
do
  $($PSQL "INSERT INTO teams(name) VALUES ('$line');")
done < "$TEMP_FILE"

echo "Teams inserted"

rm "$TEMP_FILE"

tail -n +2 "$INPUT_FILE" > "$TEMP_FILE"

while IFS="," read year round winner opponent winner_goals opponent_goals
do
  winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner';")
  opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent';")


  $($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id)
    VALUES ($year, '$round', $winner_goals, $opponent_goals, $winner_id, $opponent_id);")
done < "$TEMP_FILE"

echo "Games inserted"