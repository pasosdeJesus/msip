import { Controller } from "@hotwired/stimulus"
// Al enviar formularios agrega datos del formulario al
// campo escondido bitacora_cambio.

export default class extends Controller {
  // Conecta por ejemplo en form con data-controller="msip--bitacoraap"
  // En el botón para enviar agregar
  // data-msip--bitacoraap-action='submit->msip--bitacoraap#enviarFormulario'

  static targets = [ 
  ]


  /*!
   * Serializa valores de un formulario en un arreglo
   * Idea de serializeArray de jQuery, implemantación basada en
   * https://vanillajstoolkit.com/helpers/serializearray/
   * FormData debería dejar esto obsoleto
   **/
  static serializarFormularioEnArreglo(formulario) {
    var arr = [];
    Array.prototype.slice.call(formulario.elements).forEach(function (campo) {
      if (!campo.name || campo.disabled || 
        ['file', 'reset', 'submit', 'button'].indexOf(campo.type) > -1) {
        return;
      }
      if (campo.type === 'select-multiple') {
        Array.prototype.slice.call(campo.options).forEach(function (opcion) {
          if (!opcion.selected) return;
          arr.push({
            name: campo.name,
            value: opcion.value
          });
        });
        return;
      }
      if (['checkbox', 'radio'].indexOf(campo.type) >-1 && !campo.checked) {
        return;
      }
      arr.push({
        name: campo.name,
        value: campo.value
      });
    });
    return arr;
  }


  static calcularCambiosParaBitacora() {
    let bitacora = document.querySelector('input.bitacora_cambio')
    if (bitacora == null) {
      return { vacio: false };
    }

    if (typeof window.bitacora_estado_inicial_formulario != 'object') {
      window.bitacora_estado_inicial_formulario = 
        this.constructor.SerializarFormularioEnArreglo( bitacora.closest('form') );
      return { vacio: false };
    }
    window.bitacora_estado_final_formulario = 
      this.constructor.SerializarFormularioEnArreglo( bitacora.closest('form') );
    cambio = {}
    di = {} 
    window.bitacora_estado_inicial_formulario.forEach( 
      (v) => di[v.name] = v.value 
    )
    df = {} 
    window.bitacora_estado_final_formulario.forEach((v) => {
      df[v.name]=v.value
      if (typeof di[v.name] == 'undefined') {
        cambio[v.name] = [null, v.value]
      }
    });
    for (const i in di) {
      if (typeof df[i] == 'undefined') {
        cambio[i] = [di[i], null]
      } else if (df[i] != di[i] && i.search(/\[bitacora_cambio\]/) < 0) {
        cambio[i] = [di[i], df[i]]
      }
    }
    return cambio
  }


  initialize() {
    console.log('inicializa controlador bitacoraap')
  }


  connect() {
    console.log('conectado controlador bitacoraap')
    let campo = document.querySelector('input.bitacora_cambio')
    if (campo != null) {
      window.bitacora_estado_inicial_formulario =
        this.constructor.serializarFormularioEnArreglo( 
          campo.closest('form') 
        );
    }
  }


  enviarFormulario(e) {
    let campo = document.querySelector('input.bitacora_cambio')
    if (campo == null) {
      return;
    }
    let cambio = this.constructor.calcularCambiosParaBitacora();
    campo.value = JSON.stringify(cambio)
  }


}
