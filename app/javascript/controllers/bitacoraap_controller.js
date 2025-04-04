import { Controller } from "@hotwired/stimulus"
// Al enviar formularios agrega datos del formulario al
// campo escondido bitacora_cambio.

export default class extends Controller {
  // Conecta por ejemplo en form con data-controller="msip--bitacoraap"
  // En el botón para enviar agregar
  // data-action='submit->msip--bitacoraap#enviarFormulario'

  static targets = [ 
  ]


  initialize() {
    console.log('inicializa controlador bitacoraap')
  }


  connect() {
    console.log('conectado controlador bitacoraap')
    let campo = document.querySelector('input.bitacora_cambio')
    if (campo != null && typeof Msip__Motor.serializarFormularioEnArreglo == 'function') {
      window.bitacora_estado_inicial_formulario =
        Msip__Motor.serializarFormularioEnArreglo( 
          campo.closest('form') 
        );
    }
  }


  enviarFormulario(e) {
    let campo = document.querySelector('input.bitacora_cambio')
    if (campo == null) {
      return;
    }
    let cambio = Msip__Motor.calcularCambiosParaBitacora();
    campo.value = JSON.stringify(cambio)
  }


}
