#!/bin/bash
set -e

# Wait for PostgreSQL to be ready
until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USERNAME"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

# Create the database if it doesn't exist
psql -v ON_ERROR_STOP=1 --username "$DB_USERNAME" --host "$DB_HOST" --port "$DB_PORT" <<-EOSQL
  CREATE DATABASE IF NOT EXISTS "$DB_DATABASE";
  GRANT ALL PRIVILEGES ON DATABASE "$DB_DATABASE" TO "$DB_USERNAME";
EOSQL

echo "Database $DB_DATABASE created and privileges granted to $DB_USERNAME."
