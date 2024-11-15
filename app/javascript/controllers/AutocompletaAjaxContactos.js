
export default class Msip__AutocompletaAjaxContactos {
  /* No usamos constructor ni this porque en operaElegida sería
   * del objeto AutocompletaAjaxExpreg y no esta clase.
   * Más bien en esta todo static
   */


  // Elije una persona en autocompletación
  static operarElegida (eorig, cadpersona, id, otrosop) {
    Msip__Motor.arreglarPuntoMontaje()
    const cs = id.split(';')
    const idPersona = cs[0]
    if ([...document.querySelector('.orgsocial_persona').
        querySelectorAll('[id$=_attributes_id]')].filter(
          e => e.value==idPersona).length > 0) {
      window.alert("La misma persona ya está en el listado de contactos");
      return
    }
    let d = '&persona_id=' + idPersona
    d += '&ac_orgsocial_persona=true'
    const a = window.puntoMontaje + 'personas/datos'

    window.Rails.ajax({
      type: 'GET',
      url: a,
      data: d,
      success: (resp, estado, xhr) => {
        const divcp = eorig.target.closest(
        '.' + Msip__AutocompletaAjaxContactos.claseEnvoltura)
        if (divcp == null) {
          alert('No se encontró elmento con clase ' + 
            Msip__AutocompletaAjaxContactos.claseEnvoltura)
        }
        divcp.querySelector('[id$=_attributes_id]').value = resp.id
        divcp.querySelector('[id$=_attributes_nombres]').value = resp.nombres
        divcp.querySelector('[id$=_attributes_apellidos]').value = resp.apellidos
        divcp.querySelector('[id$=_attributes_sexo]').value = resp.sexo
        const tdocid = divcp.querySelector('[id$=_attributes_tdocumento_id]')
        if (tdocid != null) {
          let idop = null
          tdocid.childNodes.forEach((o) => {
            if (typeof (o.innerText) === 'string' &&
              o.innerText === resp.tdocumento) {
              idop = o.value
            }
          })
          if (idop != null) {
            tdocid.value = idop
          }
        }
        const numdoc = divcp.querySelector('[id$=_numerodocumento]')
        if (numdoc != null) {
          numdoc.value = resp.numerodocumento
        }
        const anionac = divcp.querySelector('[id$=_anionac]')
        if (anionac != null) {
          anionac.value = resp.anionac
        }
        const mesnac = divcp.querySelector('[id$=_mesnac]')
        if (mesnac != null) {
          mesnac.value = resp.mesnac
        }
        const dianac = divcp.querySelector('[id$=_dianac]')
        if (dianac != null) {
          dianac.value = resp.dianac
        }
        const cargo = divcp.querySelector('[id$=_cargo]')
        if (cargo != null && typeof resp.cargo != 'undefined') {
          cargo.value = resp.cargo
        }
        const correo = divcp.querySelector('[id$=_correo]')
        if (correo != null && typeof resp.correo != 'undefined') {
          correo.value = resp.correo
        }
        eorig.target.setAttribute('data-autocompleta', 'no')
        eorig.target.removeAttribute('list')
        const sel = document.getElementById(
          Msip__AutocompletaAjaxContactos.idDatalist)
        sel.innerHTML = ''
        document.dispatchEvent(new Event('msip:autocompletado-contacto'))
      },
      error: (resp, estado, xhr) => {
        window.alert('Error con ajax ' + resp)
      }
    })
  }

  static iniciar() {
    console.log("Msip__AutocompletaAjaxContactos msip")
    let url = window.puntoMontaje + 'personas.json'
    if (window.AutocompletaAjaxExpreg) {
      var contactos = new window.AutocompletaAjaxExpreg(
          [/^orgsocial_orgsocial_persona_attributes_[0-9]*_persona_attributes_nombres$/],
          url,
          Msip__AutocompletaAjaxContactos.idDatalist,
          Msip__AutocompletaAjaxContactos.operarElegida
          )
        contactos.iniciar()
    }
  }

}

// Queriamos hacer dentro de Msip__AutocompletaAjaxConactos static
// claseEnvoltura = 'campos_persona' pero la versión de bable usada por babel-transpiler, usado por sprockets4 no lo soporta así que:
Msip__AutocompletaAjaxContactos.claseEnvoltura = 'div-tabla-fila'
Msip__AutocompletaAjaxContactos.idDatalist = 'fuente-contactos-orgsocial'
