import { Controller } from "@hotwired/stimulus"

/**
 * Controlador para convertir el botón cancelar a eliminación cuando algunos campos
 * determinadores del formulario están vacíos.
 *
 * 1. Conecte el formulario con este controlador con: `data-controller="msip--cancelar-vacio-es-eliminar"`.
 * 2. Marque uno a uno los campos determinadores con `data-msip--cancelar-vacio-es-eliminar-target='determinador'`.
 * 3. Cambie el botón cancelar para agregarle:
 *    `data-msip--cancelar-vacio-es-eliminar-target` => `boton`,
 *    `data-msip--cancelar-vacio-es-eliminar-id-param` => `@registro.nil? ? '' : @registro.id.to_s`,
 *    `data-msip--cancelar-vacio-es-eliminar-urlparcial-param` => `/casos/`,
 *
 *     Teniendo en cuenta que:
 *       - `id` debe tener id del registro que se edita y que podría borrarse.
 *       - `urlparcial` debe ser ruta a registros que permita borrar con ruta/id.
 */
export default class extends Controller {

  static targets = [
    'boton',
    'determinador'
  ]

  /**
   * Conecta el controlador.
   */
  connect() {
  }

  /**
   * Evalúa si el formulario debe ser eliminado y modifica el botón de cancelar.
   * @param {Event} evento - El evento que dispara la función.
   */
  talvezEliminar(evento) {
    if (!this.hasDeterminadorTarget) {
      return
    }
    var borrar = this.determinadorTargets.length > 0
    this.determinadorTargets.forEach((d) => {
      if (d.value != '') {
        borrar = false
      }
    })
    var purl = window.puntomontaje
    if (purl == '/') {
      purl = ''
    }
    if (borrar) {
      var id = evento.params.id
      var urlparcial = evento.params.urlparcial
      this.botonTarget.setAttribute('data-method', 'delete')
      var url = purl + '/' + urlparcial + '/' + id
      url = url.replace(/\/\/*/g, '/')
      this.botonTarget.setAttribute('href', url)
    }
  }
}
