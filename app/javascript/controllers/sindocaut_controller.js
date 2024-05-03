import { Controller } from "@hotwired/stimulus"
// Llena automaticamente número de documento del tipo de doc. SIN DOCUMENTO
// con un número que corresponde a la identificación de la persona
// en el sistema o uno que empieza igual y termina en letras en caso de que
// ya se esté usando el mismo

export default class extends Controller {
  // Conecta con data-controller="msip--sindocaut"
  // En el campo para el tipo de documento agregar
  // data-action='change->msip--sindocaut#cambia_tdocumento
  // En el campo con la id de la persona agregar
  // data-msip--sindocaut-target='id'
  // Y en el campo con el número de documento agregar
  // data-msip--sindocaut-target='numerodocumento'

  static targets = [ 
    "numerodocumento", 
    "id" 
  ]

  initialize() {
    console.log('inicializa controlador sindocaut')
  }

  connect() {
    console.log('conectado controlador sindocaut')
  }

  cambia_tdocumento(e) {
    var purl = window.puntomontaje;
    if (purl == "/") {
      purl = "";
    }

    console.log("numerodocumento ahora es", this.numerodocumentoTarget.value)
    if (e.target.value == '11' && 
      this.numerodocumentoTarget.value == '') { // SIN DOCUMENTO
      // Obtiene último indice pensando en formularios anidados
      // como familiar dentro de persona
      let bindice = this.idTarget.id.match(
        new RegExp("attributes_([0-9]+)_persona", "g")
      );
      if (bindice == null) {
        bindice = ["attributes_0_persona"];
      }
      let indice = bindice.at(-1).substr(11, bindice.at(-1).length-19)
      window.Rails.ajax({
        type: 'GET',
        url: purl + '/personas/identificacionsd?persona_id=' + 
          this.idTarget.value + '&indice=' + indice,
        data: null,
        success: (resp, estado, xhr) => {
          this.numerodocumentoTarget.value = resp;
        },
        error: (req, estado, xhr) => {
          window.alert('No pudo consultar identificación.')
        }
      })
    }
    window.Rails.ajax({
      type: 'GET',
      url: purl + '/admin/tdocumentos/' + e.target.value + '.json',
      data: null,
      success: (resp, estado, xhr) => {
        this.numerodocumentoTarget.setAttribute('data-bs-toggle', 'tooltip')
        this.numerodocumentoTarget.setAttribute('data-bs-original-title', 
          resp.ayuda)
        this.numerodocumentoTarget.setAttribute('title', resp.ayuda)
      },
      error: (req, estado, xhr) => {
        window.alert('No pudo consultar tipo de documento ' + e.target.value)
      }
    })
  }



}
