
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

  static MESES = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic']



  static arreglarPuntoMontaje() {
    var purl = window.puntomontaje
    if (purl == "/") {
      purl = ""
    }
    return purl
  }

  // Si el elemento es campos de selección le configura tom-select
  static configurarElementoTomSelect(el) {
    if (typeof el.tomselect == 'undefined' && 
      (el.tagName == "INPUT" || el.tagName == "SELECT") &&
      window.TomSelect) {
      new window.TomSelect(el, window.configuracionTomSelect)
    }
  }


  // Busca elementos input y select con la clase tom-select
  // y si les falta los inicializa como campos de selección
  // con TomSelect
  static configurarElementosTomSelect() {
    document.querySelectorAll('.tom-select').forEach((el) => {
      Msip__Motor.configurarElementoTomSelect(el)
    })
  }

  // Pone colores del tema en elementos de la interfaz de manera dinámica
  static ponerTema(root, tema) {
    console.log("entro a msip_ pone_tema")
    document.querySelectorAll('.table-striped>tbody>tr:nth-child(odd)').forEach((element) => {
      element.style.backgroundColor = tema.fondo_lista;
    });
    document.querySelector('.navbar').style.backgroundImage = `linear-gradient(${tema.nav_ini}, ${tema.nav_fin})`;
    document.querySelectorAll('.navbar-default .navbar-nav>li>a').forEach((element) => {
      element.style.color = tema.nav_fuente;
    });
    document.querySelector('.navbar .navbar-brand').style.color = tema.nav_fuente;
    document.querySelectorAll('.navbar-light .navbar-nav .nav-link').forEach((element) => {
      element.style.color = tema.nav_fuente;
    });
    document.querySelector('.navbar-light .navbar-brand').style.color = tema.nav_fuente;
    let edm = document.querySelector('.dropdown-menu')
    if (edm) {
      edm.style.backgroundColor = tema.nav_fin;
    }
    document.querySelectorAll('.dropdown-item').forEach((element) => {
      element.style.color = tema.nav_fuente;
      element.addEventListener('mouseover', () => {
        element.style.color = tema.color_flota_subitem_fuente;
        element.style.backgroundColor = tema.color_flota_subitem_fondo;
      });

      element.addEventListener('mouseout', () => {
        element.style.color = tema.nav_fuente;
        element.style.backgroundColor = tema.nav_fin;
      });
    });
    document.querySelectorAll('.alert-success').forEach((element) => {
      element.style.color = tema.alerta_exito_fuente;
      element.style.backgroundColor = tema.alerta_exito_fondo;
    });
    document.querySelectorAll('.alert-danger').forEach((element) => {
      element.style.color = tema.alerta_problema_fuente;
      element.style.backgroundColor = tema.alerta_problema_fondo;
    });
    document.querySelectorAll('.btn').forEach((element) => {
      element.style.backgroundImage = `linear-gradient(to bottom, ${tema.btn_accion_fondo_ini}, ${tema.btn_accion_fondo_fin})`;
      element.style.color = tema.btn_accion_fuente;
    });
    document.querySelectorAll('.btn-primary').forEach((element) => {
      element.style.backgroundImage = `linear-gradient(to bottom, ${tema.btn_primario_fondo_ini}, ${tema.btn_primario_fondo_fin})`;
      element.style.color = tema.btn_primario_fuente;
    });
    document.querySelectorAll('.btn-danger').forEach((element) => {
      element.style.backgroundImage = `linear-gradient(to bottom, ${tema.btn_peligro_fondo_ini}, ${tema.btn_peligro_fondo_fin})`;
      element.style.color = tema.btn_peligro_fuente;
    });
    document.body.style.backgroundColor = tema.fondo;
    document.querySelectorAll('.card').forEach((element) => {
      element.style.backgroundColor = tema.fondo;
    });
    document.querySelectorAll('.msip-sf-bs-input:not(.form-check-input)').forEach((element) => {
      element.style.backgroundColor = tema.fondo;
      element.style.color = tema.color_fuente;
    });
    document.querySelectorAll('.page-link').forEach((element) => {
      element.style.backgroundColor = tema.fondo;
    });
    document.body.style.color = tema.color_fuente;
    document.querySelectorAll('table').forEach((element) => {
      element.style.color = tema.color_fuente;
    });
  }

  static async ponerTemaUsuarioAjax(){
    var root = window
    var ruta = 'temausuario'
    var datos = {}
    var t = Date.now();
    var d = -1;
    if (root.msip_ajax_recibe_json_t) {
      if (root.msip_ajax_recibe_json_t[ruta]) {
        d = (t - root.msip_ajax_recibe_json_t[ruta]) / 1000;
      }
    } else {
      root.msip_ajax_recibe_json_t = {};
    }
    root.msip_ajax_recibe_json_t[ruta] = t;

    if (d === -1 || d > 2) {
      var rutac = root.puntomontaje + ruta + ".json";
      await fetch(rutac)
        .then(function(response) {
          if (!response.ok) {
            console.error('Request failed with status:', response.status);
          }
          return response.json();
        })
        .then(function(data) {
          return Msip__Motor.ponerTema(root, data);
        })
    }
    return true;
  }

  // Si el elemento es campos de selección tal vez antes con tom-select
  // pero con opciones modificadas dinamicamente, refresca
  static refrescarElementoTomSelect(el) {
    if (typeof el.tomselect == 'undefined' &&
      (el.tagName == "INPUT" || el.tagName == "SELECT") &&
      window.TomSelect) {
      new window.TomSelect(el, window.configuracionTomSelect)
    }
    if (el.tomselect) {
      el.tomselect.clear()
      el.tomselect.clearOptions()
      el.tomselect.sync()
      el.tomselect.refreshOptions()
    }
  }

  // Se ejecuta cada vez que se carga una página que no está en cache
  // y tipicamente después de que se ha cargado la página y los recursos.
  static ejecutarAlCargarDocumentoYRecursos() {
    console.log("* Corriendo Msip__Motor::ejecutarAlCargarDocumentoYRecursos()")
    Msip__Motor.configurarElementosTomSelect()
  }


  // Llamar cada vez que se cargue una página detectada con turbo:load
  // Tal vez en cache por lo que podría no haberse ejecutado iniciar 
  // nuevamente.
  // Podría ser llamada varias veces consecutivas por lo que debe detectarlo
  // para no ejecutar dos veces lo que no conviene.
  static ejecutarAlCargarPagina() {
    console.log("* Corriendo Msip::ejecutarAlCargarPagina()")
    // Pone colores de acuerdo al tema
    Msip__Motor.ponerTemaUsuarioAjax()

    Msip__Motor.configurarElementosTomSelect()
  }

  // Llamada desde application.js tal vez antes de cargar el documento,
  // paquetes javascript y recursos sprockets
  static iniciar() {
    console.log("* Corriendo Msip::iniciar()")
  }

  static partirFechaLocalizada(fechaLocalizada, formato) {
    let anio = 1900
    let dia = 15
    let mes = 6
    if (formato == 'dd/M/yyyy' || formato == 'dd-M-yyyy') {
      anio = +fechaLocalizada.slice(7,11)
      dia = +fechaLocalizada.slice(0,2)
      let nmes = fechaLocalizada.slice(3,6)
      if (typeof nmes != 'undefined' && 
        Msip__Motor.MESES.includes(nmes.toLowerCase())) {
        mes = Msip__Motor.MESES.indexOf(nmes.toLowerCase()) + 1
      } else {
        mes = 6
      }
    } else {
      if (typeof fechaLocalizada == 'string') {
        anio = +fechaLocalizada.slice(0,4)
        mes = +fechaLocalizada.slice(5,7)
        dia = +fechaLocalizada.slice(8,10)
      } else {
        anio = 1900
        mes = 1
        dia = 1
      }
    }
    return [anio, mes, dia]
  }

  static prepararEventosComunes() {

  }

  static enviarAutomaticoFormulario(f, metodo = 'GET', tipo = 'script', alertaerror = true, vcommit = 'Enviar', agenviarautom = true) {
    const root = window;
    const t = Date.now();
    let d = -1;
    if (root.msip_enviarautomatico_t) {
      d = (t - root.msip_enviarautomatico_t) / 1000;
    }
    root.msip_enviarautomatico_t = t;
    // NO se permite más de un envío en 2 segundos
    if (d === -1 || d > 2) {
      const a = f.getAttribute('action');
      const formData = new FormData(f);
      formData.append('commit', vcommit);
      if (agenviarautom) {
        formData.append('_msip_enviarautomatico', '1');
      }
      const dat = new
        URLSearchParams(formData).toString();
      if (!root.dant ||
        root.dant !== d) {
        root.dant = d;
        const xhr = new XMLHttpRequest();
        xhr.open(metodo,a);
        xhr.setRequestHeader('Content-Type',
          'application/x-www-form-urlencoded');
        xhr.setRequestHeader('X-CSRF-Token',
          document.querySelector('meta[name="csrf-token"]').getAttribute('content'));
        xhr.onreadystatechange= function(){
          if(xhr.readyState===4){
            if(xhr.status === 200){
              const elements = document.querySelectorAll(".tom-select");
              elements.forEach(function(el){
                if(typeof el.tomselect === 'undefined' &&
                  (el.tagName == "INPUT" || el.tagName == "SELECT")) {
                    new TomSelect(el, window.configuracionTomSelect);
                }
              });
            }
            else
              if(alertaerror && xhr.status !== 0 && xhr.responseText !== ''){
                alert('Error: el servicio respondió: ' + xhr.status + xhr.responseText);
              }
          }
        };
        xhr.send(dat);
      }
    }
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
      const opt = document.createElement("option")
      opt.value = ""
      opt.text = ""
      elemento.add(opt)
    }
    let index = 0
    let encontrado = false
    for(const v of nuevasop) {
      const opt = document.createElement("option")
      opt.value = v[cid] 
      if (opt.value == sel) {
        encontrado = true
      }
      opt.text = v[cetiqueta]
      elemento.add(opt)
      index++
      /*if (id != '' && sel != null && 
        (('' + id) == ('' + sel)  || sel.indexOf('' + id) >= 0)) {
        nh = nh + ' selected'
      } */
    }

    if (!encontrado) {
      sel = ""
      elemento.value = ""
    }

    if (usatomselect) {
      if (typeof elemento.tomselect != 'undefined') {
        elemento.tomselect.clear() 
        elemento.tomselect.clearOptions()
        elemento.tomselect.sync()
        elemento.tomselect.refreshOptions()
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
