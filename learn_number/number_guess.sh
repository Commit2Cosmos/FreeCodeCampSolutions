#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"



#* User identification

echo "Enter your username:"

read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USERNAME';")

if [[ -z $USER_ID ]]; then
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."

  USER_ID=$($PSQL "INSERT INTO users(user_name) VALUES
    ('$USERNAME')
    RETURNING user_id
  ;")

  IFS=' ' read -r USER_ID <<< "$USER_ID"

else
  QUERY=$($PSQL "SELECT COUNT(g.game_score), MIN(g.game_score)
    FROM games g
    JOIN users u ON u.user_id = g.user_id
  ;")

  IFS='|' read -r NUM_GAMES BEST_SCORE <<< "$QUERY"

  echo "Welcome back, $USERNAME! You have played $NUM_GAMES games, and your best game took $BEST_SCORE guesses."
fi



#* Generate random number

SECRET_NUMBER=$((1 + $RANDOM % 1000))


#* Guessing prompt
echo -e "Guess the secret number between 1 and 1000:"

USER_GUESS=""


is_integer() {
  [[ "$1" =~ ^-?[0-9]+$ ]]
}

NUM_GUESSES=1

while true; do

  read USER_GUESS

  if is_integer "$USER_GUESS"; then
    if (($USER_GUESS==$SECRET_NUMBER)); then
      break
    elif (($USER_GUESS>$SECRET_NUMBER)); then
      echo -e "It's lower than that, guess again:"
    else
      echo -e "It's higher than that, guess again:"
    fi
    ((NUM_GUESSES++))
  else
    echo -e "That is not an integer, guess again:"
  fi

done


$PSQL "INSERT INTO games(game_score, user_id) VALUES
  ($NUM_GUESSES, $USER_ID)
;" > /dev/null

echo -e "You guessed it in $NUM_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

