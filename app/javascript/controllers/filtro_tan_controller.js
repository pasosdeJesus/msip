import { Controller } from "@hotwired/stimulus"

/**
 * Ayudas Todas-Algunas-Ninguna para un cuadro de selección.
 *
 * Conecta con `data-controller="msip--filtro-tan"`.
 *
 * En el campo con botones de radio agregar:
 * - `data-action='change->msip--filtro-tan#cambia_boton_todos'`
 * - `data-msip--filtro-tan-target='boton-todos'`
 * - `data-action='change->msip--filtro-tan#cambia_boton_ninguno'`
 * - `data-msip--filtro-tan-target='boton-ninguno'`
 * - `data-msip--filtro-tan-target='boton-algunos'`
 *
 * En el campo de selección por ayudar a controlar:
 * - `data-msip--filtro-tan-target='cuadro-de-seleccion'`
 */
export default class extends Controller {

  static targets = [
    "todos",
    "algunos",
    "ninguno",
    "seleccion"
  ]

  /**
   * Inicializa el controlador.
   */
  initialize() {
    console.log('inicializa controlador filto-tan')
  }

  /**
   * Conecta el controlador.
   */
  connect() {
    console.log('conectado controlador filto-tan')
  }

  /**
   * Cambia la selección a "Todos".
   * @param {Event} e - El evento que dispara la función.
   */
  cambiarATodos(e) {
    console.log(this.seleccionTarget.id)
    csSeleccionarTodasSinSpan(this.seleccionTarget.id)
  }

  /**
   * Cambia la selección a "Ninguno".
   * @param {Event} e - El evento que dispara la función.
   */
  cambiarANinguno(e) {
    console.log(this.seleccionTarget.id)
    csDeseleccionarTodas(this.seleccionTarget.id)
  }

  /**
   * Revisa cambios en la selección "Algunas".
   * @param {Event} e - El evento que dispara la función.
   */
  revisarCambioAlgunas(e) {
    debugger
  }
}
