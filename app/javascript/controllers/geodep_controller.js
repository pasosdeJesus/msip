import { Controller } from "@hotwired/stimulus"
// Controles de geografía pais, departamento, municipio, centro poblado
// dependientes

import Msip__Motor from "../msip/motor"

/**
 * Controlador para la gestión de campos de geografía (país, departamento, municipio, centro poblado) dependientes.
 *
 * Conecta un área que incluye campos pais/dep/mun con `data-controller="msip--geodep"`.
 *
 * En el campo para el país agrega `data-action='change->msip--geodep#cambiar_pais'`.
 * En el campo para el departamento agrega `data-action='change->msip--geodep#cambiar_departamento` y `data-msip--geodep-target='departamento'`.
 * En el campo para el municipio agrega `data-action='change->msip--geodep#cambiar_municipio` y `data-msip--geodep-target='municipio'`.
 * En el campo para el centro poblado agrega `data-action='change->msip--geodep#cambiar_centropoblado` y `data-msip--geodep-target='centropoblado'`.
 */
export default class extends Controller {

  static targets = [
    "departamento",
    "municipio",
    "centropoblado",
  ]

  /**
   * Inicializa el controlador.
   */
  initialize() {
    console.log('inicializa controlador geodep')
  }

  /**
   * Conecta el controlador.
   */
  connect() {
    console.log('conectado controlador geodep')
  }

  /**
   * Maneja el cambio en la selección del país.
   * Carga los departamentos correspondientes al país seleccionado.
   * @param {Event} e - El evento de cambio.
   */
  cambiar_pais(e) {
    var purl = Msip__Motor.arreglarPuntoMontaje()

    console.log("departamento ahora es", this.departamentoTarget.value)
    let url = purl + '/admin/departamentos.json?pais_id=' + e.target.value
    window.Rails.ajax({
      type: 'GET',
      url: url,
      data: null,
      success: (resp, estado, xhr) => {
        Msip__Motor.remplazarOpcionesSelect(this.departamentoTarget.id,
          resp, true, 'id', 'nombre', true)
        Msip__Motor.remplazarOpcionesSelect(this.municipioTarget.id,
          [], true, 'id', 'nombre', true)
        Msip__Motor.remplazarOpcionesSelect(this.centropobladoTarget.id,
          [], true, 'id', 'nombre', true)
      },
      error: (req, estado, xhr) => {
        window.alert('No pudo consultar departamentos')
      }
    })
  }

  /**
   * Maneja el cambio en la selección del departamento.
   * Carga los municipios correspondientes al departamento seleccionado.
   * @param {Event} e - El evento de cambio.
   */
  cambiar_departamento(e) {
    var purl = Msip__Motor.arreglarPuntoMontaje()

    console.log("municipio ahora es", this.municipioTarget.value)
    let url = purl + '/admin/municipios.json?departamento_id=' + 
      e.target.value
    window.Rails.ajax({
      type: 'GET',
      url: url,
      data: null,
      success: (resp, estado, xhr) => {
        Msip__Motor.remplazarOpcionesSelect(this.municipioTarget.id,
          resp, true, 'id', 'nombre', true)
        Msip__Motor.remplazarOpcionesSelect(this.centropobladoTarget.id,
          [], true, 'id', 'nombre', true)
      },
      error: (req, estado, xhr) => {
        window.alert('No pudo consultar municipios')
      }
    })
  }

  /**
   * Maneja el cambio en la selección del municipio.
   * Carga los centros poblados correspondientes al municipio seleccionado.
   * @param {Event} e - El evento de cambio.
   */
  cambiar_municipio(e) {
    var purl = Msip__Motor.arreglarPuntoMontaje()

    console.log("centro poblado ahora es", this.centropobladoTarget.value)
    let url = purl + '/admin/centrospoblados.json?municipio_id=' + 
      e.target.value
    window.Rails.ajax({
      type: 'GET',
      url: url,
      data: null,
      success: (resp, estado, xhr) => {
        Msip__Motor.remplazarOpcionesSelect(this.centropobladoTarget.id,
          resp, true, 'id', 'nombre', true)
      },
      error: (req, estado, xhr) => {
        window.alert('No pudo consultar centrospoblados')
      }
    })
  }

  /**
   * Maneja el cambio en la selección del centro poblado.
   * @param {Event} e - El evento de cambio.
   */
  cambiar_centropoblado(e) {
  }
}
