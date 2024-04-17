
export default class Msip__Motor {
  /* 
   * Librería de funciones comunes.
   * Aunque no es un controlador lo dejamos dentro del directorio
   * controllers para aprovechar método de msip para compartir controladores
   * Stimulus de motores.
   *
   * Como su nombre no termina en _controller no será incluido en 
   * controllers/index.js
   *
   * Desde controladores stimulus importelo con
   *
   *  import Msip__Motor from "../msip/motor"
   *
   * Use funciones por ejemplo con
   *
   *  Msip__Motor.partiFechaLocalizada(fl, formato)
   *
   * Para poderlo usar desde Javascript global con 
   * window.Msip__Motor 
   * asegure que en app/javascript/application.js ejecuta:
   *
   * import Msip__Motor from './controllers/msip/motor.js'
   * window.Msip__Motor = Msip__Motor
   *
   */

  static MESES = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];



  static arreglarPuntoMontaje() {
    var purl = window.puntomontaje
    if (purl == "/") {
      purl = "";
    }
    return purl;
  }

  static partirFechaLocalizada(fechaLocalizada, formato) {
    let anio = 1900;
    let dia = 15;
    let mes = 6;
    if (formato == 'dd/M/yyyy' || formato == 'dd-M-yyyy') {
      anio = +fechaLocalizada.slice(7,11)
      dia = +fechaLocalizada.slice(0,2)
      let nmes = fechaLocalizada.slice(3,6)
      if (typeof nmes != 'undefined' && 
        Msip__Motor.MESES.includes(nmes.toLowerCase())) {
        mes = Msip__Motor.MESES.indexOf(nmes.toLowerCase()) + 1;
      } else {
        mes = 6;
      }
    } else {
      if (typeof fechaLocalizada == 'string') {
        anio = +fechaLocalizada.slice(0,4);
        mes = +fechaLocalizada.slice(5,7);
        dia = +fechaLocalizada.slice(8,10);
      } else {
        anio = 1900;
        mes = 1;
        dia = 1;
      }
    }
    return [anio, mes, dia]
  }

  static prepararEventosComunes() {

  }

  /* Remplaza las opciones de un cuadro de seleccion por unas nuevas
   * @idsel es identificación del select
   * @nuevasop Arreglo de hashes con nuevas opciones, cada una tiene propiedades
   *   para la id (por omision id) y la etiqueta (por omisión nombre).
   * @usatomselect Es verdadero si y solo si el cuadro de selección usa tom-select
   * @cid campo con id en cada elemento de @nuevasop por omision id
   * @cetiqueta campo con etiqueta en cada elemento de @nuevasop por omision nombre
   * @opvacia Incluye opción vacia entre las posibles
   */
  static remplazarOpcionesSelect(
    idElemento, nuevasop, usatomselect = false, cid = 'id',
    cetiqueta = 'nombre', opvacia = false
  ) {
    let elemento = document.getElementById(idElemento)
    let sel = elemento.value
    for (; elemento.length > 0; elemento.remove(0)) {
    }
    if (opvacia) {
      const opt = document.createElement("option");
      opt.value = "";
      opt.text = "";
      elemento.add(opt);
    }
    let index = 0
    let encontrado = false
    for(const v of nuevasop) {
      const opt = document.createElement("option");
      opt.value = v[cid] 
      if (opt.value == sel) {
        encontrado = true;
      }
      opt.text = v[cetiqueta];
      elemento.add(opt);
      index++;
      /*if (id != '' && sel != null && 
        (('' + id) == ('' + sel)  || sel.indexOf('' + id) >= 0)) {
        nh = nh + ' selected'
      } */
    }

    if (!encontrado) {
      sel = "";
      elemento.value = ""
    }

    if (usatomselect) {
      if (typeof elemento.tomselect != 'undefined') {
        elemento.tomselect.clear(); 
        elemento.tomselect.clearOptions();
        elemento.tomselect.sync();
        elemento.tomselect.refreshOptions();
      }  else {
        let et = new TomSelect('#' + idElemento, {
          create: true,
          sortField: {
            field: "text",
            direction: "asc"
          }
        })
      }
    } 
    elemento.value = sel
  }

}
