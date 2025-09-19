#!/bin/bash

# This script sets up PostgreSQL with the same configuration used in the GitHub
# Actions workflow
# of this repository (see .github/workflows/rubyonrails.yml)
# It includes installation, service setup, and environment configuration

# Install PostgreSQL and required development libraries
sudo apt update
sudo apt install -y postgresql postgresql-contrib libpq-dev

# Start PostgreSQL service
sudo service postgresql start

# Create user and database as postgres user
sudo su - postgres -c "psql -c \"CREATE USER rails WITH PASSWORD 'password';\"
-c \"CREATE DATABASE rails_test OWNER rails;\""

# Setup environment configuration
cd "$(dirname "$0")/../test/dummy" || exit 1
cp .env.github .env

# Modify .env file with local paths and settings
DIRAP=$(pwd)
sed -i "s|/home/runner/work/msip/msip/|${DIRAP}/|g" .env
sed -i "s|export BD_SERVIDOR=.*|export BD_SERVIDOR=localhost|" .env
sed -i "s|export DATABASE_URL=.*|export
DATABASE_URL=\"postgres://rails:password@localhost:5432/rails_test\"|" .env
echo "export RAILS_ENV=test" >> .env

# Source the environment file
source .env

echo "PostgreSQL environment configured successfully!"
echo "Database: $BD_PRUEBA"
echo "User: $BD_USUARIO"
echo "Database URL: $DATABASE_URL"
echo "Environment file location: $DIRAP/.env"

