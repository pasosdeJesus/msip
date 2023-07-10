import { Controller } from "@hotwired/stimulus"
// Ayudas Todas-Algunas-Ninguna para un cuadro de selección. 

export default class extends Controller {
  // Conecta con data-controller="msip--filtro-tan"
  // En el campo con botones de radio agregar
  // data-action='change->msip--filtro-tan#cambia_boton_todos'
  // data-msip--filtro-tan-target='boton-todos'
  // data-action='change->msip--filtro-tan#cambia_boton_ninguno'
  // data-msip--filtro-tan-target='boton-ninguno'
  // data-msip--filtro-tan-target='boton-algunos'

  // En el campo de selección por ayudar a controlar
  // data-msip--filtro-tan-target='cuadro-de-seleccion'

  static targets = [ 
    "todos", 
    "algunos",
    "ninguno",
    "seleccion" 
  ]

  initialize() {
    console.log('inicializa controlador filto-tan')
  }

  connect() {
    console.log('conectado controlador filto-tan')
  }

  cambiarATodos(e) {
    console.log(this.seleccionTarget.id)
    csSeleccionarTodasSinSpan(this.seleccionTarget.id)
  }

  cambiarANinguno(e) {
    console.log(this.seleccionTarget.id)
    csDeseleccionarTodas(this.seleccionTarget.id)
  }

  revisarCambioAlgunas(e) {
    debugger
  }

}
