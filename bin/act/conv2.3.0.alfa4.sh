#!/bin/sh
# Convierte de msip 2.3.0.alfa3  a 2.3.0.alfa4
# Mejorando nomenclatura

for i in `git ls-tree -r main --name-only`; do
  excluye=1
  echo $i | grep -e ".js$" -e "html" > /dev/null
  if (test "$?" = "0") then {
    excluye=0
  } fi;
  if (test "$excluye" == "0") then {
    n=$i
    antn="";
    for j in ajaxRecibeJson:recibirJsonAjax \
      completaEnlace:completarEnlace \
      escapaHtml:escaparHtml \
      intentaEliminarFila:intentarEliminarFila \
      llenaSelectConAJAX:llenarSelectConAjax \
      llenarSelectConAjax2:llenarSelectConAjax \
      registraCambiosParaBitacora:registrarCambiosParaBitacora \
      ; do
      antes=`echo $j | sed -e 's/:.*//g'`;
      despues=`echo $j | sed -e 's/.*://g'`;
      grep "$antes" $n > /dev/null;
      if (test "$?" = "0") then {
        if (test "$antn" != "$n") then {
          echo "";
          echo -n "Remplazando en $n: ";
          antn=$n
        } fi;
        echo -n " $antes"
        sed -i -e "s/$antes/$despues/g" $n;
      } fi;
    done;
  } fi;
done;
echo "";
