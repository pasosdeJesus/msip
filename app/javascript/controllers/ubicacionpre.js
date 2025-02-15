export default class Msip__Ubicacionpre {
  /*
   * Librería de funciones comunes para ubicacionpre.
   *
   * Aunque no es un controlador lo dejamos dentro del directorio
   * controllers para aprovechar método de msip para compartir controladores
   * Stimulus de motores.
   *
   * Como su nombre no termina en _controller no será incluido en
   * `controllers/index.js`
   *
   * Desde controladores stimulus o javascript ES6 importelo con
   *
   *  import Msip__Ubicacionpre from "../msip/ubicacionpre"
   *
   * Use funciones por ejemplo con
   *
   *  Msip__Ubicacionpre.cambiarIdUbicacionpreExpandible(campoubi, cocoonid)
   */


  // Cambia id de los campoubi relacionados con el control de ubicacionpre
  // expandible en 2 filas, que tengan id 0.
  static cambiarIdUbicacionpreExpandible(campoubi, cocoonid) {
    control = $('#ubicacionpre-' + campoubi + '-0').parent()
    control.find('#ubicacionpre-' + campoubi + '-0').attr('id',
      'ubicacionpre-' + campoubi + '-'+ cocoonid)
    control.find('#resto-' + campoubi + '-0').attr('id',
      'resto-' + campoubi + '-'+ cocoonid)
    control.find('#restocp-' + campoubi + '-0').attr('id',
      'restocp-' + campoubi + '-'+ cocoonid)
    b = control.find('button[data-bs-target$=' + campoubi + '-0]')
    console.log(b.attr('data-bs-target'))
    b.attr('data-bs-target',
      '#resto-' + campoubi + '-' + cocoonid + ',#restocp-' + campoubi + '-' +
      cocoonid)
  }


  static manejarEventoBuscarLugarUbicacionpreExpandible(e) {
    ubicacionpre = $(this).closest('.ubicacionpre')
    if (ubicacionpre.length != 1) {
      alert('No se encontró ubicacionpre para ' +
        $(this).attr('id'))
    }

    epais = ubicacionpre.find('[id$=pais_id]')
    pais = +epais.val()
    dep = +ubicacionpre.find('[id$=departamento_id]').val()
    mun = +ubicacionpre.find('[id$=municipio_id]').val()
    clas = +ubicacionpre.find('[id$=centropoblado_id]').val()
    ubi = [pais, dep, mun, clas]
    Msip__Ubicacionpre.buscarLugarUbicacionpreExpandible($(this), ubi)
  }


  static buscarLugarUbicacionpreExpandible(s, ubi) {
    Msip__Motor.arreglarPuntoMontaje()
    cnom = s.attr('id')
    v = $("#" + cnom).data('autocompleta')
    if (v != 1 && v != "no"){
      $("#" + cnom).data('autocompleta', 1)
      // Buscamos un div con clase div_ubicacionpre dentro del cual
      // están tanto el campo ubicacionpre_id como el campo
      // ubicacionpre_texto
      ubipre = s.closest('.div_ubicacionpre')
      if (typeof ubipre == 'undefined'){
        alert('No se ubico .div_ubicacionpre')
        return
      }
      if ($(ubipre).find("[id$='ubicacionpre_id']").length != 1) {
        alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_id')
        return
      }
      if ($(ubipre).find("[id$='_lugar']").length != 1) {
        alert('Dentro de .div_ubicacionpre no se ubicó _lugar')
        return
      }
      var campo = document.querySelector("#" + cnom)
      // Cada vez que llegue quitar eventlistener si ya fue inicializado
      var n = new AutocompletaAjaxCampotexto(campo, window.puntoMontaje +
        "ubicacionespre_lugar.json" + '?pais=' + ubi[0] +
        '&dep=' + ubi[1] + '&mun=' + ubi[2] + '&clas=' + ubi[3] + '&',
        'fuente-lugar', function (event, nomop, idop, otrosop) {
          Msip__Motor.autocompletarLugarUbicacionpreExpandible(otrosop['centropoblado_id'],
            otrosop['tsitio_id'], otrosop['lugar'],
            otrosop['sitio'], otrosop['latitud'], otrosop['longitud'],
            ubipre)
          event.stopPropagation()
          event.preventDefault()
        }.bind(n)
      )
      n.iniciar()
    }
    return
  }

  static autocompletarLugarUbicacionpreExpandible(centropoblado_id, tsit, lug, sit, lat, lon, ubipre){
    Msip__Motor.arreglarPuntoMontaje()
    ubipre.parent().find('[id$=_centropoblado_id]').val(centropoblado_id)
    ubipre.find('[id$=_lugar]').val(lug)
    ubipre.find('[id$=_sitio]').val(sit)
    if (lat != 0 && lat != null){
      ubipre.find('[id$=_latitud]').val(lat)
    }
    if (lon != 0 && lon != null){
      ubipre.find('[id$=_longitud]').val(lon)
    }
    if (tsit != null){
      ubipre.find('[id$=_tsitio_id]').val(tsit)
    }
    $(document).trigger("msip:autocompletada-ubicacionpre")
    return
  }


  static deshabilitarOtrosSinoHayMun(e, campoubi){
    ubp = $(e.target).closest('.ubicacionpre')
    lugar = ubp.find('[id$='+campoubi+'_lugar]')
    sitio = ubp.find('[id$='+campoubi+'_sitio]')
    tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
    latitud = ubp.find('[id$='+campoubi+'_latitud]')
    longitud = ubp.find('[id$='+campoubi+'_longitud]')
    lugar.val("")
    lugar.attr('disabled', true)
    sitio.val(null)
    sitio.attr('disabled', true)
    tsitio.val(3)
    tsitio.attr('disabled', true)
    latitud.val("")
    latitud.attr('disabled', true)
    longitud.val("")
    longitud.attr('disabled', true)
  }

  static habilitarOtrosSiHayMun(e, tipo, campoubi){
    ubp = $(e.target).closest('.ubicacionpre')
    lugar = ubp.find('[id$='+campoubi+'_lugar]')
    sitio = ubp.find('[id$='+campoubi+'_sitio]')
    tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
    latitud = ubp.find('[id$='+campoubi+'_latitud]')
    longitud = ubp.find('[id$='+campoubi+'_longitud]')
    if(tipo == 1){
      lugar.attr('disabled', false)
      tsitio.attr('disabled', false)
    }
    if(tipo == 2){
      sitio.attr('disabled', false)
      latitud.attr('disabled', false)
      longitud.attr('disabled', false)
    }
  }


  static fijarCoordenadasUbicacionpreFija(e, campoubi, elemento, ubi_plural){
    ubp = $(e.target).closest('.ubicacionpre')
    latitud = ubp.find('[id$='+campoubi+'_latitud]')
    longitud = ubp.find('[id$='+campoubi+'_longitud]')

    id = Number.parseInt($(elemento).val(), 10) // evita eventual XSS
    $.getJSON(window.puntoMontaje + "admin/" + ubi_plural +".json", function(o){
      ubi = o.filter(function(item){
        return item.id == id
      })
      if(ubi[0]){
        if(ubi[0].latitud){
          latitud.val(ubi[0].latitud)
          longitud.val(ubi[0].longitud)
        }
      }else{
        latitud.val(null)
        longitud.val(null)
      }
    });
  }


  // iniid Inicio de identificacion por ejemplo 'caso_migracion_attributes'
  // campoubi Identificación particular del que se registra por ejemplo 'salida'
  //    (teniendo en cuenta que haya campos para el mismo, por ejemplo
  //    uno terminado en salida_lugar).
  // fcamdep Función opcional por llamar cuando cambie el departamento
  // fcammun Función opcional por llamar cuando cambie el municipio
  static registrarUbicacionpreExpandible(
    iniid, campoubi, fcamdep = null, fcammun = null
  ) {
    Msip__Motor.arreglarPuntoMontaje()

    // Buscador en campo lugar
    $(document).on('focusin',
      'input[id^=' + iniid + '][id$=_' + campoubi + '_lugar]',
      Msip__Motor.manejarEventoBuscarLugarUbicacionpreExpandible
    )

    // Cambia coordenadas al cambiar pais
    $(document).on('change',
      '[id^=' + iniid + '][id$=' + campoubi + '_pais_id]', function (evento) {
        Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "paises")
        Msip__Motor.deshabilitarOtrosSinoHayMun(evento, campoubi)
      }
    )

    // Cambia coordenadas y deshabilita otros campos al cambiar departamento
    $(document).on('change',
      '[id^=' + iniid + '][id$=' + campoubi + '_departamento_id]',
      function (evento) {
        if($(this).val() == "") {
          ubp = $(evento.target).closest('.ubicacionpre')
          let epais = ubp.find('[id$='+campoubi+'_pais_id]')
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, epais, "paises")
        } else {
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "departamentos")
        }
        Msip__Motor.deshabilitarOtrosSinoHayMun(evento, campoubi)
        if (fcamdep) {
          fcamdep()
        }
      })

    // Cambia coordenadas y habilita otros campos al cambiar municipio
    $(document).on('change',
      '[id^=' + iniid + '][id$=' + campoubi + '_municipio_id]',
      function (evento) {
        if($(this).val() == '') {
          ubp = $(evento.target).closest('.ubicacionpre')
          dep = ubp.find('[id$='+campoubi+'_departamento_id]')
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, dep, "departamentos")
          Msip__Motor.deshabilitarOtrosSinoHayMun(evento, campoubi)
        }else{
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "municipios")
          Msip__Motor.habilitarOtrosSiHayMun(evento, 1, campoubi)
        }
        if (fcammun) {
          fcammun()
        }
      })

    // Cambia coordenadas y habilita otros campos al cambiar centro poblado
    $(document).on('change',
      '[id^=' + iniid + '][id$=' + campoubi + '_centropoblado_id]',
      function (evento) {
        if($(this).val()==""){
          ubp = $(evento.target).closest('.ubicacionpre')
          mun = ubp.find('[id$='+campoubi+'_municipio_id]')
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, mun, "municipios")
        }else{
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "centrospoblados")
        }
        Msip__Motor.habilitarOtrosSiHayMun(evento, 1, campoubi)
      })

    // Habilita otros campos al cambiar lugar
    $(document).on('change',
      '[id^=' + iniid + '][id$=' + campoubi + '_lugar]',
      function (evento) {
        Msip__Motor.habilitarOtrosSiHayMun(evento, 2, campoubi)
      }
    )

  }

}
