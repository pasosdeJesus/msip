
import { Controller } from "@hotwired/stimulus"
// Controles de geografía pais, departamento, municipio, centro poblado
// dependientes

import Msip__Motor from "../msip/motor"

export default class extends Controller {
  // Conecta un área que incluye campos pais/dep/mun con 
  //   data-controller="msip--geodep"
  // En el campo para el país agrega
  //   data-action='change->msip--geodep#cambiar_pais'
  // En el campo para el departamento agrega
  //   data-action='change->msip--geodep#cambiar_departamento y
  //   data-msip--geodep-target='departamento'
  // En el campo para el municipio agrega
  //   data-action='change->msip--geodep#cambiar_municipio y
  //   data-msip--geodep-target='municipio'
  // En el campo para el centro poblado agrega
  //   data-action='change->msip--geodep#cambiar_centropoblado y
  //   data-msip--geodep-target='centropoblado'

  static targets = [ 
    "departamento", 
    "municipio", 
    "centropoblado", 
    "lugar",
    "sitio",
    "tsitio",
    "latitud",
    "longitud",
  ]

  initialize() {
    console.log('inicializa controlador geodep')
  }

  connect() {
    console.log('conectado controlador geodep')
  }

  habilitarCamposExtra() {
    if (this.hasLugarTarget) {
      this.lugarTarget.disabled = false
    }
    if (this.hasSitioTarget) {
      this.sitioTarget.disabled = false
    }
    if (this.hasTsitioTarget) {
      this.tsitioTarget.disabled = false
    }
    if (this.hasLatitudTarget) {
      this.latitudTarget.disabled = false
    }
    if (this.hasLongitudTarget) {
      this.longitudTarget.disabled = false
    }
  }

  cambiar_pais(e) {
    var purl = Msip__Motor.arreglarPuntoMontaje()

    console.log("departamento ahora es", this.departamentoTarget.value)
    let url = purl + '/admin/departamentos.json?pais_id=' + e.target.value
    window.Rails.ajax({
      type: 'GET',
      url: url,
      data: null,
      success: (resp, estado, xhr) => {
        if (this.hasDepartamentoTarget) {
          Msip__Motor.remplazarOpcionesSelect(this.departamentoTarget.id,
            resp, true, 'id', 'nombre', true)
          if (this.hasMunicipioTarget) {
            Msip__Motor.remplazarOpcionesSelect(this.municipioTarget.id,
              [], true, 'id', 'nombre', true)
            if (this.hasCentropobladoTarget) {
              Msip__Motor.remplazarOpcionesSelect(this.centropobladoTarget.id,
                [], true, 'id', 'nombre', true)
            }
            this.habilitarCamposExtra()
          }
        }
      },
      error: (req, estado, xhr) => {
        window.alert('No pudo consultar departamentos')
      }
    })
  }

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
        if (this.hasMunicipioTarget) {
          Msip__Motor.remplazarOpcionesSelect(this.municipioTarget.id,
            resp, true, 'id', 'nombre', true)
          if (this.hasCentropobladoTarget) {
            Msip__Motor.remplazarOpcionesSelect(this.centropobladoTarget.id,
              [], true, 'id', 'nombre', true)
          }
          this.habilitarCamposExtra()
        }
      },
      error: (req, estado, xhr) => {
        window.alert('No pudo consultar municipios')
      }
    })
  }

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
        if (this.hasCentropobladoTarget) {
          Msip__Motor.remplazarOpcionesSelect(this.centropobladoTarget.id,
            resp, true, 'id', 'nombre', true)
        }
        this.habilitarCamposExtra()
      },
      error: (req, estado, xhr) => {
        window.alert('No pudo consultar centrospoblados')
      }
    })
  }

  cambiar_centropoblado(e) {
  }
 


}
