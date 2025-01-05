
# Para contribuir en en el desarrollo de msip

# I. Documentación de las fuentes

La generas con:

    bundle
    bundle exec yard

Y la ves en el directorio `yard_doc`

Para ejecutar un servidor que te permita verla a medida que modificas 
las fuentes ejecuta:

    bundle exec yard server --reload

Y revisala desde un navegador en el puerto 8808 del computador donde
ejecutaste, por ejemplo si fue localmente en <http://127.0.0.1:8808>


# II. Aplicación de prueba

Asegúrate de contar con los
[Requisitos](doc/requisitos.md)

## 1. Base de datos

### 1.1 Como superusuario crea un usuario en la base de datos

Como administrador de PostgreSQL (en adJ suele ser la cuenta
`_postgresql` crea un usuario para la base de datos (digamos `msipdes` 
que es usado en los ejemplos y archivos de configuración de manera 
predeterminada):

```sh
$ doas su - _postgresql
$ createuser -Upostgres -h /var/www/var/run/postgresql/ -s msipdes
$ psql -Upostgres -h /var/www/var/run/postgresql/
psql (16.2)
Type "help" for help.
postgres=# ALTER USER msipdes WITH PASSWORD 'nuevaclave';
postgres=# \q
$ exit
```

En el ejmplo anterior remplaza `nuevaclave` por la clave que le pondrás.

### 1.2 Como desarrollador crea base de datos

Desde tu cuenta de desarrollador en el sistema operativo, puedes facilitar 
la interacción con las bases de datos del usuario `msipdes` 
(o el que tengas) y que no solicite clave para operar, agregando 
el usuario y su clave al archivo `~/.pgpass`:
```
echo "*:*:*:msipdes:nuevaclave" >> ~/.pgpass
chmod 0600 ~/.pgpass 
```

Crea la base de datos para el modo de desarrollo que se llama
`msipdes_des` de manera predeterminada, o el nombre que prefieras (sugerimos 
que lo hagas con las herramientas de PostgreSQL pues en ocasiones esta 
operación no se logra completar solo con `rails`):
```sh
createdb -h /var/www/var/run/postgresql -U msipdes msipdes_des
```

## 2. Gemas

Asegura que puedes instalar las gemas requeridas por la aplicación,
no sólo configurando bundler para instalar gemas en un directorio
de la forma `/var/www/bundler-miusuario`, tanto de forma general (como se 
indica en el documento de
[Requisitos](https://gitlab.com/pasosdeJesus/msip/blob/main/doc/requisitos.md)
como de manera particular en el directorio del motor
(digamos que sea `$HOME/comp/rails/msip`) con:

```
cd $HOME/comp/rails/msip
mkdir .bundle
cat > .bundle/config <<EOF
---
BUNDLE_PATH: "/var/www/bundler-miusuario"
BUNDLE_DISABLE_SHARED_GEMS: "true"
EOF
```

Y ejecuta `bundle` desde el directorio de la aplicación de prueba (digamos
`$HOME/comp/rails/msip/test/dumy`):
```
cd $HOME/comp/rails/msip/test/dummy
bundle
```

# 3. Configuración con variables de ambiente

En el directorio de la aplicación copia la plantilla de configuración 
`.env.plantilla` en `.env` y modifícala la base de datos y su usuario:
```
$ cd test/dummy
$ cp .env.plantilla .env
$ vi .env
```
Con el editor remplaza:
* La clave de ejemplo que está en una línea de la forma `BD_CLAVE=aquilaclave`
* El usuario en la base de datos que está en una línea de la
  forma `BD_USUARIO=msipdes`.
* El nombre de la base en modo de desarrollo en una línea de la forma `BD_DES=msipdes_des`
* El nombre de la base en modo de pruebas en una línea de la forma `BD_PRUEBA=msipdes_prueba`

Y desde el mismo directorio `test/dummy` prepárala para operar (suponiendo
que ya creaste la base según se indicó en la sección 1.2):
```sh
bin/rails db:drop db:create db:setup db:seed msip:indices
```

# 4. Iniciar la aplicación de prueba

Para iniciar la aplicación te sugerimos usar el script `bin/corre` que
emplea el archivo `.env`, que debes editar antes para poner el puerto
en el que quieres correr la aplicación de prueba, lo encuentras en una 
línea de la forma `PUERTODES=3000` (si tienes un cortafuegos recuerda
abrir ese puerto) y en una línea de la forma `IPDES=127.0.0.1` pon
la IP del servidor donde operas.  Después ejecuta:
```
bin/corre
```
Al iniciar de esta forma se actualizarán indices, se borraran caches y
directorios con recursos HTML, CSS y Javascript (`public/msip/assets`) 
y se volveran a generar con sprockets.    
Si ya lo ejecutaste la primera vez, puedes obviar todas 
estas preparación e  iniciar más rápido con:
```
R=1 bin/corre
```

Usa la aplicación con un navegador en una URL que tenga
la IP y el puerto que configuraste (e.g. <http://192.168.10.1:3000/msip/>), 
puedes ingresar con el usuario `msip` y la clave `msip`

Si prefieres o necesitas SSL, empleando un certificado del cual dejas las 
llaves pública y privada en `tmp/llave-publica.crt` y 
`tmp/llave-privada.key`, configura `IPDES` y `PUERTODES` en `.env` con algo 
como:
```
PUERTODES=
```
y
```
IPDES="ssl://192.168.10.1:3000?key=tmp/llave-privada.key&cert=tmp/llave-publica.crt"
```
