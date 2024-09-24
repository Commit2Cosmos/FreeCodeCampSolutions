#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"


$PSQL "DROP TABLE IF EXISTS customers CASCADE;"
$PSQL "DROP TABLE IF EXISTS appointments CASCADE;"
$PSQL "DROP TABLE IF EXISTS services CASCADE;"


$PSQL "CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  phone VARCHAR(15) UNIQUE NOT NULL
);"


$PSQL "CREATE TABLE services (
  service_id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL
);"


$PSQL "CREATE TABLE appointments (
  appointment_id SERIAL PRIMARY KEY,

  customer_id INT NOT NULL,
  CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
      REFERENCES customers(customer_id),
  
  service_id INT NOT NULL,
  CONSTRAINT fk_sevice
    FOREIGN KEY (service_id)
      REFERENCES services(service_id),

  time VARCHAR(10) NOT NULL
);"


$PSQL "INSERT INTO services(name) VALUES
  ('cut'),
  ('color'),
  ('perm'),
  ('style'),
  ('trim')
;"