#!/bin/sh
# Funciones para realizar operaciones sobre diversos motores/aplicaciones

if (test ! -f "msip/test/dummy/.env") then {
  echo "Falta msip/test/dummy/.env"
  exit 1;
} fi;

bdusuario=`grep "BD_USUARIO=" msip/test/dummy/.env | sed -e "s/.*=//g"`
bdclave=`grep "BD_CLAVE=" msip/test/dummy/.env | sed -e "s/.*=//g"`

DEPURA=0
function ejecuta {
  echo "Por ejecutar: $@"
  if (test "$DEPURA" = "1") then {
    echo "ENTER para continuar"
    read;
  } fi;
  eval $@
}

function inicializa_imitando_msip {
  if (test "$1" = "") then {
    echo "Primer parámetro debe ser ruta a aplicación";
    exit 1;
  } fi;

  if (test "$1" != "msip/test/dummy/" -a ! -f $1/.env) then {
    cp $1/.env.plantilla $1/.env
    sed -i -e "s/BD_USUARIO=.*/BD_USUARIO=$bdusuario/g" $1/.env
    sed -i -e "s/BD_CLAVE=.*/BD_CLAVE=$bdclave/g" $1/.env
    base=`grep "BD_DES=" $1/.env | sed -e "s/.*=//g"`
    ejecuta createdb -h /var/www/var/run/postgresql -U $bdusuario $base
    (cd $1 && pwd && bundle && pwd && ./bin/rails db:drop db:create db:setup db:seed sip:indices)
  } fi;
}

function opera_aplicacion {
  inicializa_imitando_msip $1
}

function opera_motor {
  inicializa_imitando_msip $1/test/dummy/
}


for i in *; do 
  echo $i;
  if (test -f $i/Gemfile) then {
    if (test -f $i/test/dummy/package.json) then {
      opera_motor $i
    } else {
      opera_aplicacion $i
    } fi;
  } fi;
done


