#!/bin/sh

sing1="$1"
if (test "$sing1" = "") then {
  echo "Falta singular de prueba origen como primer parámetro";
  exit 1;
} fi;
plural1="$2"
if (test "$plural1" = "") then {
  echo "Falta plural de prueba origen como segundo parámetro";
  exit 1;
} fi;
sing2="$3"
if (test "$sing2" = "") then {
  echo "Falta singular de prueba destino como tercer parámetro";
  exit 1;
} fi;
plural2="$4"
if (test "$plural2" = "") then {
  echo "Falta plural de prueba destino como cuarto parámetro";
  exit 1;
} fi;
que="$5"
if (test "$que" = "") then {
  echo "Falta que (model o controller) como quinto parámetro";
  exit 1;
} fi;

ruta="$6"
if (test "$ruta" = "") then {
  echo "No se especificó una ruta (e.g sip/admin) se supondrá que no hay";
} else {
  ruta="$ruta/"
} fi;



sing1min=`echo "$sing1" |  tr '[:upper:]' '[:lower:]'`
sing1may=`echo "$sing1" |  tr '[:lower:]' '[:upper:]'`
sing1cap=`echo "$sing1" |  awk '{ print toupper( substr( $0, 1, 1 ) ) tolower(substr( $0, 2 )); }'`

plural1min=`echo "$plural1" |  tr '[:upper:]' '[:lower:]'`
plural1may=`echo "$plural1" |  tr '[:lower:]' '[:upper:]'`
plural1cap=`echo "$plural1" |  awk '{ print toupper( substr( $0, 1, 1 ) ) tolower(substr( $0, 2 )); }'`

sing2min=`echo "$sing2" |  tr '[:upper:]' '[:lower:]'`
sing2may=`echo "$sing2" |  tr '[:lower:]' '[:upper:]'`
sing2cap=`echo "$sing2" |  awk '{ print toupper( substr( $0, 1, 1 ) ) tolower(substr( $0, 2 )); }'`

plural2min=`echo "$plural2" |  tr '[:upper:]' '[:lower:]'`
plural2may=`echo "$plural2" |  tr '[:lower:]' '[:upper:]'`
plural2cap=`echo "$plural2" |  awk '{ print toupper( substr( $0, 1, 1 ) ) tolower(substr( $0, 2 )); }'`

#echo "OJO plural1min=$plural1min"
#echo "OJO plural2min=$plural2min"

if (test "$que" = "controller") then {
  rutaorig="test/${que}s/${ruta}${plural1min}_${que}_test.rb"
  rutadest="test/${que}s/${ruta}${plural2min}${cont}_test.rb"
} else {
  rutaorig="test/${que}s/${ruta}${sing1min}_test.rb"
  rutadest="test/${que}s/${ruta}${sing2min}_test.rb"
} fi;

if (test ! -f "$rutaorig") then {
  echo "No se encontró archivo en ruta origen: '$rutaorig'";
  exit 1;
} fi;

if (test -f "$rutadest") then {
  echo "Se encontró un archivo en ruta destino: $rutadest";
  echo -n "Seguro desea sobreescribir? (s para sobreescribir): "
  read r
  if (test "$r" != "s") then {
    exit 1;
  } fi;
} fi;


echo "Archivo origen $rutaorig";

cat $rutaorig |\
  sed -e "s/$plural1min/$plural2min/g" | \
  sed -e "s/$sing1min/$sing2min/g" | \
  sed -e "s/$plural1cap/$plural2cap/g" | \
  sed -e "s/$sing1cap/$sing2cap/g" | \
  sed -e "s/$plural1may/$plural2may/g" | \
  sed -e "s/$sing1may/$sing2may/g" | \
  cat > $rutadest
echo "Creado $rutadest "
