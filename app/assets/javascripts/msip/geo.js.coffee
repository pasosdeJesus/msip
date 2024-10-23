# Completa campos con información geográfica que se carga con AJAX

# Busca un campo similar a idactual pero remplazando id_tipoactual por 
# id_tipobuscado
@busca_campo_similar = (idactual, tipoactual, tipobuscado) ->
  idb = idactual.replace('id_' + tipoactual, 'id_' + tipobuscado)
  if idb != idactual && $('#' + idb).length > 0
    return idb
  idb = idactual.replace(tipoactual + '_id', tipobuscado + '_id')
  if idb != idactual && $('#' + idb).length > 0
    return idb
  idb = idactual.replace('_' + tipoactual, '_' + tipobuscado)
  if idb != idactual && $('#' + idb).length > 0
    return idb
  return ""

