
// Cambia id de los campoubi relacionados con el control de ubicacionpre
// expandible en 2 filas, que tengan id 0.
function msip_ubicacionpre_expandible_cambia_ids(campoubi, cocoonid) {
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


function msip_ubicacionpre_expandible_maneja_evento_busca_lugar(e) {
  root = window
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
  msip_ubicacionpre_expandible_busca_lugar($(this), ubi)
}


function msip_ubicacionpre_expandible_busca_lugar(s, ubi) {
  root = window
  msip_arregla_puntomontaje(root)
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
    var n = new AutocompletaAjaxCampotexto(campo, root.puntomontaje + 
      "ubicacionespre_lugar.json" + '?pais=' + ubi[0] + 
      '&dep=' + ubi[1] + '&mun=' + ubi[2] + '&clas=' + ubi[3] + '&', 
      'fuente-lugar', function (event, nomop, idop, otrosop) { 
        msip_ubicacionpre_expandible_autocompleta_lugar(otrosop['centropoblado_id'],
          otrosop['tsitio_id'], otrosop['lugar'], 
          otrosop['sitio'], otrosop['latitud'], otrosop['longitud'], 
          ubipre, window)
        event.stopPropagation()
        event.preventDefault()
      }.bind(n)
    )
    n.iniciar()
  }
  return
}

function msip_ubicacionpre_expandible_autocompleta_lugar(centropoblado_id, tsit, lug, sit, lat, lon, ubipre, root){
  msip_arregla_puntomontaje(root)
  ubipre.parent().find('[id$=_centropoblado_id]').val(centropoblado_id).trigger('chosen:updated')
  ubipre.find('[id$=_lugar]').val(lug)
  ubipre.find('[id$=_sitio]').val(sit)
  if (lat != 0 && lat != null){
  ubipre.find('[id$=_latitud]').val(lat)
  }
  if (lon != 0 && lon != null){
  ubipre.find('[id$=_longitud]').val(lon)
  }
  if (tsit != null){
    ubipre.find('[id$=_tsitio_id]').val(tsit).trigger('chosen:updated')
  }
  $(document).trigger("msip:autocompletada-ubicacionpre")
  return
}


function deshabilita_otros_sinohaymun(e, campoubi){
  ubp = $(e.target).closest('.ubicacionpre')
  lugar = ubp.find('[id$='+campoubi+'_lugar]')
  sitio = ubp.find('[id$='+campoubi+'_sitio]')
  tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
  latitud = ubp.find('[id$='+campoubi+'_latitud]')
  longitud = ubp.find('[id$='+campoubi+'_longitud]')
  lugar.val("")
  lugar.attr('disabled', true).trigger('chosen:updated')
  sitio.val(null)
  sitio.attr('disabled', true).trigger('chosen:updated')
  tsitio.val(3)
  tsitio.attr('disabled', true).trigger('chosen:updated')
  latitud.val("")
  latitud.attr('disabled', true).trigger('chosen:updated')
  longitud.val("")
  longitud.attr('disabled', true).trigger('chosen:updated')
}

function habilita_otros_sihaymun(e, tipo, campoubi){
  ubp = $(e.target).closest('.ubicacionpre')
  lugar = ubp.find('[id$='+campoubi+'_lugar]')
  sitio = ubp.find('[id$='+campoubi+'_sitio]')
  tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
  latitud = ubp.find('[id$='+campoubi+'_latitud]')
  longitud = ubp.find('[id$='+campoubi+'_longitud]')
  if(tipo == 1){
    lugar.attr('disabled', false).trigger('chosen:updated')
    tsitio.attr('disabled', false).trigger('chosen:updated')
  }
  if(tipo == 2){
    sitio.attr('disabled', false).trigger('chosen:updated')
    latitud.attr('disabled', false).trigger('chosen:updated')
    longitud.attr('disabled', false).trigger('chosen:updated')
  }
}


function msip_ubicacionpre_fija_coordenadas(e, campoubi, elemento, ubi_plural){
  ubp = $(e.target).closest('.ubicacionpre')
  latitud = ubp.find('[id$='+campoubi+'_latitud]')
  longitud = ubp.find('[id$='+campoubi+'_longitud]')

  id = Number.parseInt($(elemento).val(), 10) // evita eventual XSS
  root = window
  $.getJSON(root.puntomontaje + "admin/" + ubi_plural +".json", function(o){
    ubi = o.filter(function(item){
      return item.id == id
    })
    if(ubi[0]){
      if(ubi[0].latitud){
        latitud.val(ubi[0].latitud).trigger('chosen:updated')
        longitud.val(ubi[0].longitud).trigger('chosen:updated')
      }
    }else{
      latitud.val(null).trigger('chosen:updated')
      longitud.val(null).trigger('chosen:updated')
    }
  });
}


// iniid Inicio de identificacion por ejemplo 'caso_migracion_attributes'
// campoubi Identificación particular del que se registra por ejemplo 'salida'
//    (teniendo en cuenta que haya campos para el mismo, por ejemplo
//    uno terminado en salida_lugar).
// root Raiz
// fcamdep Función opcional por llamar cuando cambie el departamento
// fcammun Función opcional por llamar cuando cambie el municipio
function msip_ubicacionpre_expandible_registra(iniid, campoubi, root, 
  fcamdep = null, fcammun = null) {
  msip_arregla_puntomontaje(root)

  // Buscador en campo lugar
  $(document).on('focusin', 
    'input[id^=' + iniid + '][id$=_' + campoubi + '_lugar]', 
    msip_ubicacionpre_expandible_maneja_evento_busca_lugar
  )

  // Cambia coordenadas al cambiar pais
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + campoubi + '_pais_id]', function (evento) {
      msip_ubicacionpre_fija_coordenadas(evento, campoubi, $(this), "paises")
      deshabilita_otros_sinohaymun(evento, campoubi)
    }
  )

  // Cambia coordenadas y deshabilita otros campos al cambiar departamento
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + campoubi + '_departamento_id]', 
    function (evento) {
      if($(this).val() == "") {
        ubp = $(evento.target).closest('.ubicacionpre')
        let epais = ubp.find('[id$='+campoubi+'_pais_id]')
        msip_ubicacionpre_fija_coordenadas(evento, campoubi, epais, "paises")
      } else {
        msip_ubicacionpre_fija_coordenadas(evento, campoubi, $(this), "departamentos")
      }
      deshabilita_otros_sinohaymun(evento, campoubi)
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
        msip_ubicacionpre_fija_coordenadas(evento, campoubi, dep, "departamentos")
        deshabilita_otros_sinohaymun(evento, campoubi)
      }else{
        msip_ubicacionpre_fija_coordenadas(evento, campoubi, $(this), "municipios")
        habilita_otros_sihaymun(evento, 1, campoubi)
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
        msip_ubicacionpre_fija_coordenadas(evento, campoubi, mun, "municipios")
      }else{
        msip_ubicacionpre_fija_coordenadas(evento, campoubi, $(this), "centrospoblados")
      }
      habilita_otros_sihaymun(evento, 1, campoubi)
    })

  // Habilita otros campos al cambiar lugar
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + campoubi + '_lugar]', 
    function (evento) {
      habilita_otros_sihaymun(evento, 2, campoubi)
    }
  )

}

