
export default class Msip__AutocompletaAjaxFamiliares {
  /* No usamos constructor ni this porque en operaElegida sería
   * del objeto AutocompletaAjaxExpreg y no esta clase.
   * Más bien en esta todo static
   */


  // Elije una persona en autocompletación
  static operarElegida (eorig, cadpersona, id, otrosop) {
    Msip__Motor.arreglarPuntoMontaje()
    const cs = id.split(';')
    const idPersona = cs[0]
    const divcpf = eorig.target.closest('.' + 
      window.Msip__AutocompletaAjaxFamiliares.claseEnvoltura)
    divcpf.querySelector(
      '.persona_persona_trelacion1_personados_id > input').value = idPersona
    divcpf.querySelector(
      '.persona_persona_trelacion1_personados_nombres > input').value = ""
    divcpf.querySelector(
      '.persona_persona_trelacion1_personados_apellidos > input').value = ""
    divcpf.querySelector('input[value=Actualizar]').click()
  }

  static iniciar() {
    console.log("Msip__AutocompletaAjaxFamiliares")
    let url = window.puntoMontaje + 'personas.json'
    if (window.AutocompletaAjaxExpreg) {
      var asistentes = new window.AutocompletaAjaxExpreg(
          [ /^persona_persona_trelacion1_attributes_[0-9]*_personados_attributes_nombres$/ ],
          url,
          window.Msip__AutocompletaAjaxFamiliares.idDatalist,
          window.Msip__AutocompletaAjaxFamiliares.operarElegida
          )
        asistentes.iniciar()
    }
  }

}

// Sobrellevamos imposibilidad de hacer static claseEnvoltura y
// static idDatalist dentro de la clase Msip__AutocompletaAjaxFamiliares asi:
Msip__AutocompletaAjaxFamiliares.claseEnvoltura = 'nested-fields'
Msip__AutocompletaAjaxFamiliares.idDatalist = 'fuente-familiares'
