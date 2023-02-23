#!/bin/bash
if [ -f .env ]
  then export $(grep -v '^#' .env | xargs)
else
  exit 'no env file found'
fi 

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE $DB_DATABASE;
    CREATE USER $DB_USERNAME WITH ENCRYPTED PASSWORD $DB_PASSWORD;
    GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE TO $DB_USERNAME;
EOSQL