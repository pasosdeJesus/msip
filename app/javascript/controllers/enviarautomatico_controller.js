import { Controller } from "@hotwired/stimulus"
// Al modificar alguno de los campos de un formulario
// envía automáticamente el formulario.
// Util en filtro de un listado para ir actualizando el listado
// tan pronto se ingresa un valor en un filtro.
import Msip__Motor from "../msip/motor.js"

export default class extends Controller {
  // Conecta con data-controller="msip--enviarautomatico"
  // En los campos que al modificarse deben enviar el formulario agregar
  // data-action='change->msip--enviarautomatico#enviar'
  // En el div o contenedor del formulario y todo lo que se debe
  // repintar agregar `data-msip--enviarautomatico-target='repintar'`
  // En el form agregar `data-msip--enviarautomatico-target='formulario'`

  static targets = [ 
    "repintar",
    "formulario"
  ]

  initialize() {
    console.log('inicializa controlador enviarautomatico')
  }

  connect() {
    console.log('conectado controlador enviarautomatico')
  }

  enviar(e) {
    var purl = window.puntoMontaje;
    if (purl == "/") {
      purl = "";
    }

    if (this.repintarTarget == null) {
      alert("Falta marcar elemento repintar");
      return;
    }
    if (this.formularioTarget == null) {
      alert("Falta marcar elemento formulario");
      return;
    }
    console.log("repintar ahora es", this.repintarTarget)
    console.log("formulario ahora es", this.formularioTarget)
    //Msip__Motor.guardarFormularioYRepintar([this.formulario.id], null, null)

    let a = this.formularioTarget.getAttribute('action');
    const datos = new FormData(this.formularioTarget);
    datos.set('commit', 'enviarautomatico');
    datos.set('_msip_enviarautomatico', '1');
    const paramUrl = new URLSearchParams(datos).toString();
    document.body.style.cursor = 'wait'
    a = `${a}?${paramUrl}`
    fetch(a, {
      method: 'GET',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Content-Type': 'text/html',
        'Accept': 'text/html'
      },
      data: datos, // Si fuera PATCH posiblemente seria datos
    }).then( response  => {
      return response.text()

    }).then( html => {
      document.body.style.cursor = 'default'
      let parser = new DOMParser();
      let parsedHtml = parser.parseFromString(html, 'text/html');
      let selector = `${this.repintarTarget.localName}[data-msip--enviarautomatico-target]` // e.g form[data-msip--enviarautomatico-target]
      const cont = parsedHtml.querySelectorAll(selector)
      if (cont == null || cont.length == 0) {
        alert(`En el HTML recibido no se encontro el selector ${selector}`)
        return
      } else if (cont.length > 1) {
        alert(`En el HTML recibido se encontraron ${cont.length} elementos ` +
          `con selector ${selector}`)
        return
      }
      const elemRepintar = document.querySelectorAll(selector)
      if (elemRepintar == null) {
        alert(`En la página no se encontro el selector ${selector}`)
        return
      } else if (elemRepintar.length > 1) {
        alert(`En la página se encontraron ${cont.length} elementos `+
          `con selector ${selector}`)
        return
      }
      elemRepintar[0].replaceWith(cont[0])
    }).catch( error => {
      document.body.style.cursor = 'default'
      alert(`Error al enviar: ${error.message}`);
    });
  }


}

