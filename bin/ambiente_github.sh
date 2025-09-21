#!/bin/bash

# Este script pepara un codspace de github con PostgreSQL y la misma 
# configuración de un workflow Github Action para este repositorio
# (see .github/workflows/rubyonrails.yml)

# pdftoppm en poppler-utils
sudo apt install poppler-utils

# Instala PostgreSQL 17 y las librerías requeridas
if (test ! -f /etc/postgresql/17/main/pg_hba.conf) then {
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	echo 'deb http://apt.postgresql.org/pub/repos/apt/ noble-pgdg main' | sudo tee /etc/apt/sources.list.d/pgdg.list
	sudo apt update
	sudo apt install -y postgresql-17 postgresql-client-17

	sudo locale-gen es_CO.UTF-8 && sudo update-locale

	sudo pg_createcluster 17 main --start
	sudo sed -i "s|local.*all.*all.*peer|local all all md5|g" /etc/postgresql/17/main/pg_hba.conf
} fi;

sudo service postgresql status | grep online
if (test "$?" != "0") then {
	# Start PostgreSQL service
	sudo service postgresql start
} fi;

# Crea usuario y base de datos como usuario postgres
sudo su - postgres -c "createuser -s rails"
sudo su - postgres -c "psql -c \"ALTER USER rails WITH PASSWORD 'password';\""
echo "*:*:*:rails:password" >> ~/.pgpass
chmod 0600 ~/.pgpass
createdb -U rails rails_test

# Configura el ambiente
cd "$(dirname "$0")/../test/dummy" || exit 1
cp .env.github .env

# Modifica el archivo .env con rutas locales y configuraciones
DIRAP=$(pwd)
sed -i "s|/home/runner/work/msip/msip/|${DIRAP}/|g" .env
sed -i "s|export BD_SERVIDOR=.*|export BD_SERVIDOR=localhost|" .env
sed -i "s|export DATABASE_URL=.*|export
DATABASE_URL=\"postgres://rails:password@localhost:5432/rails_test\"|" .env
echo "export RAILS_ENV=test" >> .env

# Ejecuta el archivo con variables de ambiente
source .env

bundle

echo "¡Ambiente configurado con exito!"
echo "Base de datos: $BD_PRUEBA"
echo "Usuario: $BD_USUARIO"
echo "URL de la base de datos: $DATABASE_URL"
echo "Localización del archivo de ambiente: $DIRAP/.env"

# RAILS_ENV=test bin/rails dbconsole
