#!/bin/bash

# Permissions: chmod u+x ./salon.sh ./create_db.sh

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~"

echo -e "\nWelcome to My Salon, how can I help you?"

echo -e $($PSQL "SELECT '\n' || s.service_id || ') ' || s.name AS formatted_name FROM services s;")

SERVICE_ID_SELECTED=""

while [[ -z $SERVICE_ID_SELECTED ]]; do

  read SERVICE_ID_SELECTED

  SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED;")

  if [[ -z $SERVICE_ID_SELECTED ]]; then
    echo -e "\nI could not find that service. What would you like today?"
    echo -e $($PSQL "SELECT '\n' || s.service_id || ') ' || s.name AS formatted_name FROM services s;")
  fi

done

echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

if [[ -z $CUSTOMER_ID ]]; then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  $PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');" > /dev/null
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
else
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id=$CUSTOMER_ID;")
fi


SERVICE_NAME=$($PSQL "SELECT s.name FROM services s WHERE service_id=$SERVICE_ID_SELECTED;")

echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
read SERVICE_TIME


$PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');" > /dev/null


echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."