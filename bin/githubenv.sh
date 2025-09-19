#!/bin/bash

# This script sets up PostgreSQL with the same configuration used in the GitHub
# Actions workflow
# of this repository (see .github/workflows/rubyonrails.yml)
# It includes installation, service setup, and environment configuration

# Install PostgreSQL 17 and required development libraries
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo 'deb http://apt.postgresql.org/pub/repos/apt/ noble-pgdg main' | sudo tee
/etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install -y postgresql-17 postgresql-client-17

sudo pg_createcluster 17 main --start

sudo sed -i "s|peer|md5|g" /etc/postgresql/17/main/pg_hba.conf

# Start PostgreSQL service
sudo service postgresql restart

# Create user and database as postgres user
sudo su - postgres -c "createuser -s rails"
sudo su - postgres -c "psql -c \"ALTER USER rails WITH PASSWORD 'password';\""
echo "*:*:*:rails:password" >> ~/.pgpass
chmod 0600 ~/.pgpass
createdb -U rails rails_test

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

bundle



echo "PostgreSQL environment configured successfully!"
echo "Database: $BD_PRUEBA"
echo "User: $BD_USUARIO"
echo "Database URL: $DATABASE_URL"
echo "Environment file location: $DIRAP/.env"

# RAILS_ENV=test bin/rails dbconsole
