#!/bin/sh
# Convierte de msip 2.3.0.alfa2  a 2.3.0.alfa3


for i in `git ls-tree -r main --name-only`; do
  excluye=1
  echo $i | grep -e ".js$" -e "coffee" > /dev/null
  if (test "$?" = "0") then {
    excluye=0
  } fi;
  if (test "$excluye" == "0") then {
    echo "Revisando $i";
    n=$i
    antn="";
    for j in msip_arregla_puntomontaje:Msip__Motor.arreglarPuntoMontaje \
      msip_arregla_puntoMontaje:Msip__Motor.arreglarPuntoMontaje \
      puntomontaje:puntoMontaje \
      MsipSerializarFormularioEnArreglo:Msip__Motor.serializarFormularioEnArreglo\
      MsipConvertirArregloAParam:Msip__Motor.convertirArregloAParam \
      MsipEnviarAjax:Msip__Motor.enviarAjax \
      MsipEnviarFormularioAjax:Msip__Motor.enviarFormularioAjax \
      MsipCalcularCambiosParaBitacora:Msip__Motor.calcularCambiosParaBitacora \
      MsipGuardarFormularioYRepintar:Msip__Motor.guardarFormularioYRepintar \
      MsipIniciar:Msip__Motor.iniciar \
      msip_envia_ajax_datos_ruta_y_pinta:Msip__Motor:enviarAjaxDatosRutaYPinta \
      msip_ubicacionpre_expandible_cambia_ids:Msip__Motor.cambiarIdUbicacionpreExpandible \
      msip_ubicacionpre_expandible_maneja_evento_busca_lugar::Msip__Motor.manejarEventoBuscarLugarUbicacionpreExpandible \
      msip_ubicacionpre_expandible_autocompleta_lugar::Msip__Motor.autocompletarLugarUbicacionpreExpandible \
      deshabilita_otros_sinohaymun:Msip__Motor.deshabilitarOtrosSinoHayMun \
      habilita_otros_sihaymun:Msip__Motor.habilitarOtrosSiHayMun \
      msip_ubicacionpre_fija_coordenadas:Msip__Motor.fijarCoordenadasUbicacionpreFija \
      msip_ubicacionpre_expandible_registra:Msip__Motor.registrarUbicacionpreExpandible_registra \
      MsipAutocompleta:Msip__Autocompleta \
      mr519ef_visual_a_texto:Mr519Gen__EditaFormulario.visualATexto \
      mr519ef_texto_a_visual:Mr519Gen__EditaFormulario.textoAVisual \
      mr519ef_prepara:Mr519Gen__EditaFormulario.preparar \
      mr519_gen_nombre_a_nombreinterno:Mr519Gen__Motor.nombreANombreInterno \
      mr519_gen_prepara_eventos_comunes:Mr519Gen__Motor.prepararEventosComunes \
      heb412_gen_completa_generarp:Heb412Gen__Motor.completarEnlacePlantilla \
      heb412_gen_eliminar_archivo:Heb412Gen__Motor.eliminarArchivo \
      heb412_gen_eliminar_directorio:Heb412Gen__Motor.eliminarDirectorio \
      cor1440_gen_rangoedadac_uno:Cor1440Gen__Motor.calculaColumnaRangoedadac \
      cor1440_gen_rangoedadac_tot:Cor1440Gen__Motor.calculaTotalRangoedadac \
      cor1440_gen_rangoedadac:Cor1440Gen__Motor.calculaTotalRangoedadac \
      root:window \
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
