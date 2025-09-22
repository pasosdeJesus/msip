import { Controller } from "@hotwired/stimulus"

/**
 * Controlador para la bitácora de cambios en formularios.
 * Al enviar formularios, agrega datos del formulario al campo escondido `bitacora_cambio`.
 */
export default class extends Controller {
  /**
   * Conecta por ejemplo en form con `data-controller="msip--bitacoraap"`.
   * En el botón para enviar agregar `data-action='submit->msip--bitacoraap#enviarFormulario'`.
   */
  static targets = [
  ]

  /**
   * Inicializa el controlador.
   */
  initialize() {
    console.log('inicializa controlador bitacoraap')
  }

  /**
   * Conecta el controlador.
   * Almacena el estado inicial del formulario para calcular cambios posteriormente.
   */
  connect() {
    console.log('conectado controlador bitacoraap')
    let campo = document.querySelector('input.bitacora_cambio')
    if (campo != null && typeof MsipSerializarFormularioEnArreglo == 'function') {
      window.bitacora_estado_inicial_formulario =
        MsipSerializarFormularioEnArreglo(
          campo.closest('form')
        );
    }
  }

  /**
   * Maneja el envío del formulario.
   * Calcula los cambios realizados en el formulario y los asigna al campo `bitacora_cambio`.
   * @param {Event} e - El evento de envío del formulario.
   */
  enviarFormulario(e) {
    let campo = document.querySelector('input.bitacora_cambio')
    if (campo == null) {
      return;
    }
    let cambio = MsipCalcularCambiosParaBitacora();
    campo.value = JSON.stringify(cambio)
  }
}
