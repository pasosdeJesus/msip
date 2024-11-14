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


  // Verifica que `puntoMontaje` esté definido y termine en /; 
  // si no está definido, lo establece como '/'
  static arreglarPuntoMontaje(root) {
    if (typeof root.puntoMontaje === 'undefined') {
      root.puntoMontaje = '/';
    }
    if (root.puntoMontaje[root.puntoMontaje.length - 1] !== '/') {
      root.puntoMontaje += '/';
    }
    return root.puntoMontaje
  }

  // Si el elemento el es campo de selección le configura tom-select
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

  
  // Llamada a API 
  // (recordar en rails responder con render json: objeto, status:ok, 
  //  donde objeto es un objeto --no una cadena o entero)
  //
  // @root Donde almacenar objetos globales i.e window
  // @ruta ruta (sin punto de montaje)
  // @datos Datos por enviar
  // @funproc Funcion para procesar respuesta
  static ajaxRecibeJson(root, ruta, datos, funproc) {
    Msip__Motor.arreglarPuntoMontaje(root);

    // Evitar cargar de la misma ruta 2 veces en menos de 2 segundos
    const t = Date.now();
    let d = -1;

    if (root.msipAjaxRecibeJsonT) {
      if (root.msipAjaxRecibeJsonT[ruta]) {
        d = (t - root.msipAjaxRecibeJsonT[ruta]) / 1000;
      }
    } else {
      root.msipAjaxRecibeJsonT = {};
    }

    root.msipAjaxRecibeJsonT[ruta] = t;

    if (d === -1 || d > 2) {
      const rutac = `${root.puntoMontaje}${ruta}.json`;

      fetch(rutac, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(datos)
      })
        .then(response => {
          if (!response.ok) {
            throw new Error(`Error - ${response.statusText}`);
          }
          return response.json();
        })
        .then(data => {
          funproc(root, data);
        })
        .catch(error => {
          alert(error.message);
        });
    }

    return true;
  }


  // Envía con ajax a la ruta especificada junto con los datos, espera
  // respuesta html de la cual extrae una parte con selector selresp y
  // lo usa para volver a pintar el elemento con selector selelem
  static enviaAjaxDatosRutaYPinta(ruta, datos, selresp, selelem, metodo = 'GET', tipo = 'html', concsrf = false) {
    const root = window;
    const t = Date.now();
    let d = -1;

    if (root.msipEnviaAjaxT) {
      d = (t - root.msipEnviaAjaxT) / 1000;
    }
    root.msipEnviaAjaxT = t;

    if (d === -1 || d > 2) {
      Msip__Motor.arreglarPuntoMontaje(root);
      const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const rutac = `${root.puntoMontaje}${ruta}.js`;

      const xhr = new XMLHttpRequest();
      xhr.open(metodo, rutac, true);
      xhr.responseType = tipo;

      if (concsrf) {
        xhr.setRequestHeader('X-CSRF-Token', token);
      }

      xhr.onload = function() {
        if (xhr.status >= 200 && xhr.status < 300) {
          const parser = new DOMParser();
          const responseDoc = parser.parseFromString(xhr.response, 'text/html');
          const t = responseDoc.querySelector(selresp);

          if (selresp && selelem) {
            const targetElem = document.querySelector(selelem);
            if (selresp === selelem) {
              targetElem.replaceWith(t);
            } else {
              targetElem.innerHTML = t.innerHTML;
            }
          }
        } else {
          alert(`Error con ajax a ${rutac}: ${xhr.statusText}`);
        }
      };

      xhr.onerror = function() {
        alert(`Error con ajax a ${rutac}: ${xhr.statusText}`);
      };

      xhr.send(datos);
    }
  }



  // Pone colores del tema en elementos de la interfaz de manera dinámica
  static ponerTema(root, tema) {
    console.log("entro a msip_ pone_tema")
    document.querySelectorAll('.table-striped>tbody>tr:nth-child(odd)').forEach((element) => {
      element.style.backgroundColor = tema.fondo_lista;
    });
    if  (document.querySelector('.navbar')) {
      document.querySelector('.navbar').style.backgroundImage = `linear-gradient(${tema.nav_ini}, ${tema.nav_fin})`;
      document.querySelectorAll('.navbar-default .navbar-nav>li>a').forEach((element) => {
        element.style.color = tema.nav_fuente;
      });
      document.querySelector('.navbar .navbar-brand').style.color = tema.nav_fuente;
      document.querySelectorAll('.navbar-light .navbar-nav .nav-link').forEach((element) => {
        element.style.color = tema.nav_fuente;
      });
      document.querySelector('.navbar-light .navbar-brand').style.color = tema.nav_fuente;
    }
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
    Msip__Motor.arreglarPuntoMontaje(root)
    if (root.msip_ajax_recibe_json_t) {
      if (root.msip_ajax_recibe_json_t[ruta]) {
        d = (t - root.msip_ajax_recibe_json_t[ruta]) / 1000;
      }
    } else {
      root.msip_ajax_recibe_json_t = {};
    }
    root.msip_ajax_recibe_json_t[ruta] = t;

    if (d === -1 || d > 2) {
      var rutac = root.puntoMontaje + ruta + ".json";
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
  //
  // conenv indica si para el punto de montaje debe preferir 
  // window.RailsConfig.relativeUrlRoot sobre window.RailsConfig.puntoMontaje
  static ejecutarAlCargarDocumentoYRecursos(conenv = true) {
    console.log("* Corriendo Msip__Motor::ejecutarAlCargarDocumentoYRecursos()")
    Msip__Motor.configurarElementosTomSelect()
    if (typeof window.formato_fecha === 'undefined') {
      this.inicializaMotor(conenv);
    }

    document.querySelectorAll('[data-toggle="tooltip"]').forEach(elem => {
      new bootstrap.Tooltip(elem); // Inicializa tooltips
    });

    document.addEventListener('cocoon:after-insert', () => {
      document.querySelectorAll('[data-toggle="tooltip"]').forEach(elem => {
        new bootstrap.Tooltip(elem);
      });
    });

    this.ponerTemaUsuarioAjax();

    document.querySelectorAll("a[rel~=popover], .has-popover").forEach(elem => {
      new bootstrap.Popover(elem);
    });

    document.querySelectorAll("a[rel~=tooltip], .has-tooltip").forEach(elem => {
      new bootstrap.Tooltip(elem);
    });

    const mundep = document.getElementById('mundep');
    if (mundep) {
      mundep.addEventListener('focusin', () => {
        Msip__Motor.arreglarPuntoMontaje(window);
        this.buscaGen(mundep, null, `${window.puntoMontaje}mundep.json`);
      });
    }

    document.addEventListener('click', event => {
      if (event.target.matches('a.enviarautomatico[href^="#"]')) {
        MsipEnviaAutomaticoFormulario(document.querySelector('form'), 'POST', 'json', false);
      }
    });

    document.addEventListener('change', event => {
      if (event.target.matches('select[data-enviarautomatico], input[data-enviarautomatico]')) {
        MsipEnviaAutomaticoFormulario(event.target.form);
      }
    });

    function iniciaRotador() {
      document.documentElement.style.cursor = "progress";
    }

    function detieneRotador() {
      document.documentElement.style.cursor = "auto";
    }

    document.addEventListener('turbo:click', event => {
      if (event.target.getAttribute('href').charAt(0) === '#') {
        event.preventDefault();
      }
    });

    document.addEventListener("page:fetch", iniciaRotador);
    document.addEventListener("page:receive", detieneRotador);

  }


  // Llamar cada vez que se cargue una página detectada con turbo:load
  // Tal vez en cache por lo que podría no haberse ejecutado iniciar 
  // nuevamente.
  // Podría ser llamada varias veces consecutivas por lo que debe detectarlo
  // para no ejecutar dos veces lo que no conviene.
  static ejecutarAlCargarPagina() {
    console.log("* Corriendo Msip::ejecutarAlCargarPagina()")
    // Pone colores de acuerdo al tema
    if (typeof window.formato_fecha === "undefined" || window.formato_fecha === "{}") {
      this.inicializaMotor();
    }
    Msip__Motor.iniciar()
    this.ponerTemaUsuarioAjax()

    Msip__Motor.configurarElementosTomSelect()

    Msip__AutocompletaAjaxContactos.iniciar()
    Msip__AutocompletaAjaxFamiliares.iniciar()

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



  // Envia con AJAX datos del formulario, junto con el botón submit,
  // # evitando duplicaciones.
  // # @param f      Formulario jquery-sado
  // @param metodo GET, POST, PUT
  // @param tipo   json, script, xml o html (html puede ser interceptado
  // #   por redirect_to con turbolinks y presentado automáticamente en navegador)
  // @param alertaerror Presentar alerta en caso de error (true/false)
  // @param vcommit Valor para commit
  static enviarAutomaticoFormulario(f, metodo = 'GET', tipo = 'script', alertaerror = true, vcommit = 'Enviar', agenviarautom = true) {
    const t = Date.now();
    let d = -1;
    if (window.msip_enviarautomatico_t) {
      d = (t - window.msip_enviarautomatico_t) / 1000;
    }
    window.msip_enviarautomatico_t = t;
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
      if (!window.dant ||
        window.dant !== d) {
        window.dant = d;
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



  // Remplaza las opciones de un cuadro de seleccion por unas nuevas
  // @idsel es identificación del select
  // @nuevasop Arreglo de hashes con nuevas opciones, cada una tiene propiedades
  //   para la id (por omision id) y la etiqueta (por omisión nombre).
  // @usatomselect Es verdadero si y solo si el cuadro de selección usa tom-select
  // @cid campo con id en cada elemento de @nuevasop por omision id
  // @cetiqueta campo con etiqueta en cada elemento de @nuevasop por omision nombre
  // @opvacia Incluye opción vacia entre las posibles
  static remplazaOpcionesSelect(idsel, nuevasop, usatomselect = false, cid = 'id', cetiqueta = 'nombre', opvacia = false) {
    console.log("Entrando a msipRemplazaOpcionesSelect");

    const selectElement = document.getElementById(idsel);
    if (!selectElement) {
      alert('msipRemplazaOpcionesSelect: No se encontró ${idsel}');
      return;
    }

    const sel = selectElement.value;
    let opcionesHTML = '';

    // Si se requiere una opción vacía, se agrega al inicio
    if (opvacia) {
      opcionesHTML += "<option value=''></option>";
    }

    // Agrega las nuevas opciones
    nuevasop.forEach((v) => {
      const id = v[cid];
      const etiqueta = v[cetiqueta];

      // Genera el HTML de la opción
      let optionHTML = '<option value="${id}"';
      if (id !== '' && sel && (String(id) === String(sel) || sel.includes(String(id)))) {
        optionHTML += ' selected';
      }
      optionHTML += '>${etiqueta}</option>';
      opcionesHTML += optionHTML;
    });

    // Inserta las nuevas opciones en el select
    selectElement.innerHTML = opcionesHTML;

    // Si se usa Tom Select, refresca el elemento
    if (usatomselect && selectElement.tomSelect) {
      Msip__Motor.refrescarElementoTomSelect(selectElement);
    }
  }


  // Actualiza opciones de cuadros de selección que dependen de datos de un 
  // formulario anidado
  //
  // @params idfuente id en html del formulario anidado
  // @params posfijo_id_fuente posfijo para identificaciones de campos con 
  //  valores para opciones
  // @params posfijo_etiqueta_fuente posfijo para identificaciones de campos 
  //  con etiquetas para opciones
  // @params seldestino lista de selectores que identifica cuadros de selección
  // dependientes de la fuente y que serán modificados
  static actualizaCuadrosSeleccionDependientes(idfuente, posfijo_id_fuente, posfijo_etiqueta_fuente, seldestino, opvacia = false) {
    console.log("Actualizando cuadros de selección dependientes...");

    const nuevasop = [];
    // Selecciona los elementos visibles con clase "nested-fields" dentro del elemento fuente
    const lobj = document.querySelectorAll(`#${idfuente} .nested-fields:not([style*="display: none;"])`);

    lobj.forEach((v) => {
      // Encuentra el valor del 'id' y la 'etiqueta' en cada campo visible
      const idInput = v.querySelector(`input[id$=${posfijo_id_fuente}]`);
      const etiquetaInput = v.querySelector(`input[id$=${posfijo_etiqueta_fuente}]`);

      if (idInput && etiquetaInput) {
        const id = idInput.value;
        const etiqueta = etiquetaInput.value;
        nuevasop.push({ id: id, etiqueta: etiqueta });
      }
    });

    // Recorre cada selector en 'seldestino' y actualiza las opciones del select
    seldestino.forEach((sel) => {
      const selectElements = document.querySelectorAll(sel);

      selectElements.forEach((selectElement) => {
        const ts = selectElement.hasOwnProperty('tomSelect');
        this.remplazaOpcionesSelect(selectElement.id, nuevasop, ts, 'id', 'etiqueta', opvacia);
      });
    });
  }


  // Actualiza opciones de cuadros de selección que dependen de datos de un 
  // formulario anidado. Etiquetas de opciones se calculan con función.
  //
  // @params idfuente id en html del formulario anidado
  // @params posfijo_id_fuente posfijo para identificaciones de campos con 
  //  valores para opciones
  // @params fun_etiqueta función que retorna etiqueta que corresponde a una
  //   opción
  // @params seldestino lista de selectores que identifica cuadros de selección
  //   dependientes de la fuente y que serán modificados
  static actualizaCuadrosSeleccionDependientesFunEtiqueta(idfuente, posfijo_id_fuente, fun_etiqueta, seldestino, opvacia = false) {
    console.log("Actualizando cuadros de selección dependientes con función de etiqueta...");

    const nuevasop = [];
    // Selecciona los elementos visibles con clase "nested-fields" dentro del elemento fuente
    const lobj = document.querySelectorAll(`#${idfuente} .nested-fields:not([style*="display: none;"])`);

    lobj.forEach((v) => {
      // Obtiene el valor de 'id' y la etiqueta usando la función fun_etiqueta
      const idInput = v.querySelector(`input[id$=${posfijo_id_fuente}]`);
      if (idInput) {
        const id = idInput.value;
        const etiqueta = fun_etiqueta(v);
        nuevasop.push({ id: id, etiqueta: etiqueta });
      }
    });

    // Recorre cada selector en 'seldestino' y actualiza las opciones del select
    seldestino.forEach((sel) => {
      const selectElements = document.querySelectorAll(sel);

      selectElements.forEach((selectElement) => {
        const ts = selectElement.hasOwnProperty('tomSelect');
        this.msipRemplazaOpcionesSelect(selectElement.id, nuevasop, ts, 'id', 'etiqueta', opvacia);
      });
    });
  }


  // Intenta eliminar una fila añadida con coocon
  //
  // @fila fila por eliminar de una tabla dinámica manejada por cocoon
  // @prefijo_url Preijo del URL al cual enviar requerimientos AJAX para eliminar
  //   se le concatenará la identificación i.e prefijo_url/id/ (se espera json)
  //   y se le agregaría antes el punto de montaje
  // @seldep Lista de selectores a los cuadros de selección que dependen 
  //   de la fila por eliminar (si existen esta función no eliminará la fila 
  //   sino alertará).
  static intentaEliminarFila(fila, prefijoUrl, seldep) {
    console.log("Intentando eliminar fila...");
    // Evitar ejecuciones repetidas en un intervalo corto de tiempo
    const t = Date.now();
    let d = -1;
    if (window.ajax_t) {
      d = (t - window.ajax_t) / 1000;
    }
    window.ajax_t = t;

    if (d === -1 || d > 2) {
      // Encontrar el ID de registro por eliminar
      const bid = fila.querySelector('input[id$="_id"]');
      if (!bid) {
        return false;
      }
      const ide = parseInt(bid.value, 10);

      // Verificar dependencias antes de eliminar
      if (seldep != null) {
        let num = 0;
        seldep.forEach((sel) => {
          const selectedOptions = document.querySelectorAll(`${sel} option:checked`);
          selectedOptions.forEach((option) => {
            if (parseInt(option.value, 10) === ide) {
              num += 1;
            }
          });
        });

        if (num > 0) {
          alert(`Hay elementos que dependen de este (${num}). Elimínelos antes.`);
          return false;
        }
      }

      // Preparar URL para el requerimiento AJAX
      let purl = prefijoUrl;
      if (!prefijoUrl.startsWith(window.puntoMontaje)) {
        purl = window.puntoMontaje + prefijoUrl;
      }

      // Realizar la solicitud AJAX para eliminar
      fetch(`${purl}${ide}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      })
        .then((response) => {
          if (response.ok) {
            fila.remove();
          } else {
            return response.text().then((text) => {
              if (response.status !== 0 && text !== '') {
                alert(`Error: el servicio respondió con: ${response.status}\n${text}`);
              }
            });
          }
        })
        .catch((error) => {
          console.error('Error al intentar eliminar la fila:', error);
        });
    }
    return true;
  }

  static escapaHtml(cadena) {
    return cadena
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
  }


  // Cambia un campo select con base en valor de otro campo
  // $elem    Elemento jquery del otro campo (opciones de select dependen)
  // idsel    Id. del select por modificar
  // rutajson Ruta del API que respondera JSON (sin punto de montaje)
  // nomparam Parametro para el API JSON que irá con el valor de $elem
  // descerr  Descripcion por presentar en caso de que el JSON no responda
  // root     Donde se almacenan objetos globales
  // paramfiltro Enviar parámetro de la forma { filtro: { nomparam: val} } 
  // cid      Campo en el JSON resultantes de la consulta AJAX que corresponderá 
  //          al id de cada elemento del campo de seleccion
  // cnombre  Campo en el JSON resultante de la consula AJAX que corresponderá al 
  //          nombre de cada elemento del campo de seleccion (si es presenta_nombre 
  //          además pasará parametro presenta_nombre al hacer la consulta para 
  //          que el controlador responda con presenta_nombre de Msip::Modelo)
  // f        Función por llamar despues de cambiar el cuadro de seleccion
  static llenaSelectConAJAX(elem, idsel, rutajson, nomparam, descerr, root = window, paramfiltro = false, cid = 'id', cnombre = 'nombre', callback = null) {
    Msip__Motor.arreglarPuntoMontaje(root);
    
    const currentTime = Date.now();
    let elapsed = -1;
    
    if (root.LlenaSelectConAJAX_t) {
      elapsed = (currentTime - root.llenaSelectConAJAX_t) / 1000;
    }
    root.llenaSelectConAJAX_t = currentTime;

    if (elapsed > 0 && elapsed <= 2) return; // Limitar a 1 solicitud cada 2 segundos
    
    const val = elem.value;
    let param = { [nomparam]: val };

    if (cnombre === 'presenta_nombre') {
      param['presenta_nombre'] = 1;
    }
    if (paramfiltro) {
      param = { filtro: param };
    }

    fetch(`${root.puntoMontaje}${rutajson}?${new URLSearchParams(param)}`)
      .then(response => response.json())
      .then(data => {
        this.remplazaOpcionesSelect(idsel, data, true, cid, cnombre);
        if (callback) callback(root);
      })
      .catch(error => {
        alert(`Problema ${descerr}. ${JSON.stringify(param)} ${error.message}`);
      });
  }


  // Cambia un campo select con base en valor de otro campo
  // rutajson Ruta del API que respondera JSON (sin punto de montaje)
  // params   Parametros por pasar a consulta AJAX
  // idsel    Id. del select por modificar
  // descerr  Descripcion por presentar en caso de que el JSON no responda
  // root     Donde se almacenan objetos globales
  // cid      Campo en el JSON resultantes de la consulta AJAX que corresponderá 
  //          al id de cada elemento del campo de seleccion
  // cnombre  Campo en el JSON resultante de la consula AJAX que corresponderá al 
  //          nombre de cada elemento del campo de seleccion (si es presenta_nombre 
  //          además pasará parametro presenta_nombre al hacer la consulta para 
  //          que el controlador responda con presenta_nombre de Msip::Modelo)
  // f        Función por llamar despues de cambiar el cuadro de seleccion
  // opvacia  Si es verdadero agrega opción vacía al cuadro de selección
  static llenaSelectConAJAX2(rutajson, params, idsel, descerr, root = window, cid = 'id', cnombre = 'nombre', callback = null, opvacia = false) {
    Msip__Motor.arreglarPuntoMontaje(root);
    
    const currentTime = Date.now();
    let elapsed = -1;
    
    if (root.llenaSelectConAJAX2_t) {
      elapsed = (currentTime - root.llenaSelectConAJAX2_t) / 1000;
    }
    root.llenaSelectConAJAX2_t = currentTime;

    const previousRoute = root.llenaSelectConAJAX2_rv || '';
    const previousParams = root.llenaSelectConAJAX2_pv || {};

    root.llenaSelectConAJAX2_rv = rutajson;
    root.llenaSelectConAJAX2_pv = params;

    // Limitar a 1 solicitud cada 2 segundos con los mismos parámetros
    if (elapsed > 0 && elapsed <= 2 && rutajson === previousRoute && JSON.stringify(params) === JSON.stringify(previousParams)) {
      return;
    }

    fetch(`${root.puntoMontaje}${rutajson}?${new URLSearchParams(params)}`)
      .then(response => response.json())
      .then(data => {
        this.remplazaOpcionesSelect(idsel, data, true, cid, cnombre, opvacia);
        if (callback) callback(root);
      })
      .catch(error => {
        alert(`Problema ${descerr}. ${JSON.stringify(params)} ${error.message}`);
      });
  }


  // Ejecuta función con respuesta que recibe mendiante AJAX
  // rutajson Ruta del API que respondera JSON (sin punto de montaje, ni .json)
  // params   Parametros por pasar a consulta AJAX
  // f        Función por llamar
  // descerr  Descripcion por presentar en caso de que el JSON no responda
  // root     Donde se almacenan objetos globales
  static funcionTrasAjax(rutajson, params, callback, descerr, root = window) {
    Msip__Motor.arreglarPuntoMontaje(root);

    const currentTime = Date.now();
    let elapsed = -1;

    if (root.msipFuncionTrasAjax_t) {
      elapsed = (currentTime - root.msipFuncionTrasAjax_t) / 1000;
    }
    root.msipFuncionTrasAjax_t = currentTime;

    // Limitar a 1 solicitud cada 2 segundos
    if (elapsed > 0 && elapsed <= 2) return;

    fetch(`${root.puntoMontaje}${rutajson}.json?${new URLSearchParams(params)}`)
      .then(response => response.json())
      .then(data => {
        callback(root, data);
      })
      .catch(error => {
        alert(`Problema ${descerr}. ${JSON.stringify(params)} ${error.message}`);
      });
  }

  //# Ejecuta función que recibe un parametro además de root y la respuesta que
  //# recibe mendiante AJAX
  //# rutajson Ruta del API que respondera JSON (sin punto de montaje, ni .json)
  //# params   Parametros por pasar a consulta AJAX
  //# f        Función por llamar
  //# p1       Parametro por pasara a la funcion f
  //# descerr  Descripcion por presentar en caso de que el JSON no responda
  //# root     Donde se almacenan objetos globales
  static funcion1pTrasAjax(rutajson, params, callback, p1, descerr, root = window) {
    Msip__Motor.arreglarPuntoMontaje(root);

    const currentTime = Date.now();
    let elapsed = -1;

    if (root.msipFuncion1pTrasAjax_t) {
      elapsed = (currentTime - root.msipFuncion1pTrasAjax_t) / 1000;
    }
    root.msipFuncion1pTrasAjax_t = currentTime;

    // Limitar a 1 solicitud cada 1 segundo
    if (elapsed > 0 && elapsed <= 1) return;

    fetch(`${root.puntoMontaje}${rutajson}.json?${new URLSearchParams(params)}`)
      .then(response => response.json())
      .then(data => {
        callback(root, data, p1);
      })
      .catch(error => {
        alert(`Problema ${descerr}. ${JSON.stringify(params)} ${error.message}`);
      });
  }

  static completaEnlace(elema, idruta, rutagenera) {
    let form;

    // Selecciona el formulario según `idruta`
    if (idruta == null) {
      form = elema.closest('form');
    } else {
      form = document.querySelector(`form[action$='${idruta}']`);
    }

    if (!form) return;

    // Serializar datos del formulario
    const formData = new URLSearchParams(new FormData(form));
    formData.append('commit', 'Enviar');

    const root = window;
    Msip__Motor.arreglarPuntoMontaje(root);

    // Ajusta `rutagenera` con el punto de montaje si es necesario
    if (
      (root.puntoMontaje !== '/' || rutagenera[0] !== '/') &&
      !rutagenera.startsWith(root.puntoMontaje)
    ) {
      rutagenera = root.puntoMontaje + rutagenera;
    }

    // Construye la URL con los datos del formulario
    const url = `${rutagenera}?${formData.toString()}`;
    elema.setAttribute('href', url);
  }

  static registraCambiosParaBitacora(root) {
    // Si existen entradas con la clase 'bitacora_cambio', guarda el estado inicial del formulario
    const bitacoraCampos = document.querySelectorAll("input.bitacora_cambio");
    if (bitacoraCampos.length > 0) {
      const form = bitacoraCampos[0].closest("form");
      root.bitacoraEstadoInicialFormulario = Array.from(new FormData(form)).map(([name, value]) => ({ name, value }));
    }

    // Registra el evento 'submit' para formularios que contengan 'bitacora_cambio'
    document.addEventListener("submit", (e) => {
      const form = e.target;
      if (!form.querySelector(".bitacora_cambio")) return;

      // Almacena el estado final del formulario
      root.bitacoraEstadoFinalFormulario = Array.from(new FormData(form)).map(([name, value]) => ({ name, value }));

      // Compara el estado inicial y final para detectar cambios
      const cambio = {};
      const di = Object.fromEntries(root.bitacoraEstadoInicialFormulario.map(v => [v.name, v.value]));
      const df = Object.fromEntries(root.bitacoraEstadoFinalFormulario.map(v => [v.name, v.value]));

      root.bitacoraEstadoFinalFormulario.forEach(v => {
        if (!(v.name in di)) {
          cambio[v.name] = [null, v.value];
        }
      });

      for (const [i, e] of Object.entries(di)) {
        if (!(i in df)) {
          cambio[i] = [e, null];
        } else if (df[i] !== e && !i.includes("[bitacora_cambio]")) {
          cambio[i] = [e, df[i]];
        }
      }

      // Asigna el JSON de los cambios detectados a los campos correspondientes
      bitacoraCampos.forEach(input => {
        input.value = JSON.stringify(cambio);
      });
    });
  }

  static reconocerDecimalLocaleEsCO(n) {
    if (n === "") return 0;
    
    let r = "";
    
    for (let i = 0; i < n.length; i++) {
      if (n[i] === ",") {
        r += ".";
      } else if (n[i] >= "0" && n[i] <= "9") {
        r += n[i];
      }
    }
    return parseFloat(r);
  } 


  // conenv indica si debe preferir window.RailsConfig.relativeUrlRoot sobre
  // window.RailsConfig.puntoMontaje
  static inicializaMotor(conenv = true) {
    const config = window.RailsConfig || {}; // Accede a la configuración global
    window.puntoMontaje = config.puntoMontaje || '/';
    if (conenv && config.relativeUrlRoot) {
      window.puntoMontaje = config.relativeUrlRoot;
    }
    Msip__Motor.arreglarPuntoMontaje(window);
    window.msip_sincoord = false;
    window.formato_fecha = config.formatoFecha || "yyyy-mm-dd";
    window.msip_idioma_predet = config.idiomaPredet || "en";
  }

  static edadDeFechaNacFechaRef(
    anionac, mesnac, dianac, anioref, mesref, diaref
  ) {
    if (typeof anionac === 'undefined' || anionac === '') {
      return -1;
    }
    if (typeof anioref === 'undefined' || anioref === '') {
      return -1;
    }

    let edad = anioref - anionac;

    if (
      typeof mesnac !== 'undefined' && mesnac !== '' && mesnac > 0 &&
      typeof mesref !== 'undefined' && mesref !== '' && mesref > 0 &&
      mesnac >= mesref
    ) {
      if (
        mesnac > mesref ||
        (typeof dianac !== 'undefined' && dianac !== '' && dianac > 0 &&
         typeof diaref !== 'undefined' && diaref !== '' && diaref > 0 &&
         dianac > diaref)
      ) {
        edad--;
      }
    }

    return edad;
  }

  static initializeStringEndsWith() {
    if (typeof String.prototype.endsWith !== 'function') {
      String.prototype.endsWith = function(suffix) {
        return this.indexOf(suffix, this.length - suffix.length) !== -1;
      };
    }
  }



  // Cambia id de los campoubi relacionados con el control de ubicacionpre
  // expandible en 2 filas, que tengan id 0.
  static cambiarIdUbicacionpreExpandible(campoubi, cocoonid) {
    control = $('#ubicacionpre-' + campoubi + '-0').parent()
    control.find('#ubicacionpre-' + campoubi + '-0').attr('id', 
      'ubicacionpre-' + campoubi + '-'+ cocoonid)
    control.find('#resto-' + campoubi + '-0').attr('id', 
      'resto-' + campoubi + '-'+ cocoonid)
    control.find('#restocp-' + campoubi + '-0').attr('id', 
      'restocp-' + campoubi + '-'+ cocoonid)
    b = control.find('button[data-bs-target$=' + campoubi + '-0]')
    console.log(b.attr('data-bs-target'))
    b.attr('data-bs-target', 
      '#resto-' + campoubi + '-' + cocoonid + ',#restocp-' + campoubi + '-' + 
      cocoonid)
  }


  static manejarEventoBuscarLugarUbicacionpreExpandible(e) {
    root = window
    ubicacionpre = $(this).closest('.ubicacionpre')
    if (ubicacionpre.length != 1) {
      alert('No se encontró ubicacionpre para ' + 
        $(this).attr('id'))
    }

    epais = ubicacionpre.find('[id$=pais_id]')
    pais = +epais.val()
    dep = +ubicacionpre.find('[id$=departamento_id]').val()
    mun = +ubicacionpre.find('[id$=municipio_id]').val()
    clas = +ubicacionpre.find('[id$=centropoblado_id]').val()
    ubi = [pais, dep, mun, clas]
    msip_ubicacionpre_expandible_busca_lugar($(this), ubi)
  }


  static buscarLugarUbicacionpreExpandible(s, ubi) {
    root = window
    Msip__Motor.arreglarPuntoMontaje(root)
    cnom = s.attr('id')
    v = $("#" + cnom).data('autocompleta')
    if (v != 1 && v != "no"){
      $("#" + cnom).data('autocompleta', 1)
      // Buscamos un div con clase div_ubicacionpre dentro del cual
      // están tanto el campo ubicacionpre_id como el campo
      // ubicacionpre_texto 
      ubipre = s.closest('.div_ubicacionpre')
      if (typeof ubipre == 'undefined'){
        alert('No se ubico .div_ubicacionpre')
        return
      }
      if ($(ubipre).find("[id$='ubicacionpre_id']").length != 1) {
        alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_id')
        return
      }
      if ($(ubipre).find("[id$='_lugar']").length != 1) {
        alert('Dentro de .div_ubicacionpre no se ubicó _lugar')
        return
      }
      var campo = document.querySelector("#" + cnom)
      // Cada vez que llegue quitar eventlistener si ya fue inicializado
      var n = new AutocompletaAjaxCampotexto(campo, root.puntoMontaje + 
        "ubicacionespre_lugar.json" + '?pais=' + ubi[0] + 
        '&dep=' + ubi[1] + '&mun=' + ubi[2] + '&clas=' + ubi[3] + '&', 
        'fuente-lugar', function (event, nomop, idop, otrosop) { 
          Msip__Motor.autocompletarLugarUbicacionpreExpandible(otrosop['centropoblado_id'],
            otrosop['tsitio_id'], otrosop['lugar'], 
            otrosop['sitio'], otrosop['latitud'], otrosop['longitud'], 
            ubipre, window)
          event.stopPropagation()
          event.preventDefault()
        }.bind(n)
      )
      n.iniciar()
    }
    return
  }

  static autocompletarLugarUbicacionpreExpandible(centropoblado_id, tsit, lug, sit, lat, lon, ubipre, root){
    Msip__Motor.arreglarPuntoMontaje(root)
    ubipre.parent().find('[id$=_centropoblado_id]').val(centropoblado_id)
    ubipre.find('[id$=_lugar]').val(lug)
    ubipre.find('[id$=_sitio]').val(sit)
    if (lat != 0 && lat != null){
      ubipre.find('[id$=_latitud]').val(lat)
    }
    if (lon != 0 && lon != null){
      ubipre.find('[id$=_longitud]').val(lon)
    }
    if (tsit != null){
      ubipre.find('[id$=_tsitio_id]').val(tsit)
    }
    $(document).trigger("msip:autocompletada-ubicacionpre")
    return
  }


  static deshabilitarOtrosSinoHayMun(e, campoubi){
    ubp = $(e.target).closest('.ubicacionpre')
    lugar = ubp.find('[id$='+campoubi+'_lugar]')
    sitio = ubp.find('[id$='+campoubi+'_sitio]')
    tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
    latitud = ubp.find('[id$='+campoubi+'_latitud]')
    longitud = ubp.find('[id$='+campoubi+'_longitud]')
    lugar.val("")
    lugar.attr('disabled', true)
    sitio.val(null)
    sitio.attr('disabled', true)
    tsitio.val(3)
    tsitio.attr('disabled', true)
    latitud.val("")
    latitud.attr('disabled', true)
    longitud.val("")
    longitud.attr('disabled', true)
  }

  static habilitarOtrosSiHayMun(e, tipo, campoubi){
    ubp = $(e.target).closest('.ubicacionpre')
    lugar = ubp.find('[id$='+campoubi+'_lugar]')
    sitio = ubp.find('[id$='+campoubi+'_sitio]')
    tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
    latitud = ubp.find('[id$='+campoubi+'_latitud]')
    longitud = ubp.find('[id$='+campoubi+'_longitud]')
    if(tipo == 1){
      lugar.attr('disabled', false)
      tsitio.attr('disabled', false)
    }
    if(tipo == 2){
      sitio.attr('disabled', false)
      latitud.attr('disabled', false)
      longitud.attr('disabled', false)
    }
  }


  static fijarCoordenadasUbicacionpreFija(e, campoubi, elemento, ubi_plural){
    ubp = $(e.target).closest('.ubicacionpre')
    latitud = ubp.find('[id$='+campoubi+'_latitud]')
    longitud = ubp.find('[id$='+campoubi+'_longitud]')

    id = Number.parseInt($(elemento).val(), 10) // evita eventual XSS
    root = window
    $.getJSON(root.puntoMontaje + "admin/" + ubi_plural +".json", function(o){
      ubi = o.filter(function(item){
        return item.id == id
      })
      if(ubi[0]){
        if(ubi[0].latitud){
          latitud.val(ubi[0].latitud)
          longitud.val(ubi[0].longitud)
        }
      }else{
        latitud.val(null)
        longitud.val(null)
      }
    });
  }


  // iniid Inicio de identificacion por ejemplo 'caso_migracion_attributes'
  // campoubi Identificación particular del que se registra por ejemplo 'salida'
  //    (teniendo en cuenta que haya campos para el mismo, por ejemplo
  //    uno terminado en salida_lugar).
  // root Raiz
  // fcamdep Función opcional por llamar cuando cambie el departamento
  // fcammun Función opcional por llamar cuando cambie el municipio
  static registrarUbicacionpreExpandible(iniid, campoubi, root, 
    fcamdep = null, fcammun = null) {
    Msip__Motor.arreglarPuntoMontaje(root)

    // Buscador en campo lugar
    $(document).on('focusin', 
      'input[id^=' + iniid + '][id$=_' + campoubi + '_lugar]', 
      Msip__Motor.manejarEventoBuscarLugarUbicacionpreExpandible
    )

    // Cambia coordenadas al cambiar pais
    $(document).on('change', 
      '[id^=' + iniid + '][id$=' + campoubi + '_pais_id]', function (evento) {
        Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "paises")
        Msip__Motor.deshabilitarOtrosSinoHayMun(evento, campoubi)
      }
    )

    // Cambia coordenadas y deshabilita otros campos al cambiar departamento
    $(document).on('change', 
      '[id^=' + iniid + '][id$=' + campoubi + '_departamento_id]', 
      function (evento) {
        if($(this).val() == "") {
          ubp = $(evento.target).closest('.ubicacionpre')
          let epais = ubp.find('[id$='+campoubi+'_pais_id]')
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, epais, "paises")
        } else {
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "departamentos")
        }
        Msip__Motor.deshabilitarOtrosSinoHayMun(evento, campoubi)
        if (fcamdep) {
          fcamdep()
        }
      })

    // Cambia coordenadas y habilita otros campos al cambiar municipio
    $(document).on('change', 
      '[id^=' + iniid + '][id$=' + campoubi + '_municipio_id]', 
      function (evento) {
        if($(this).val() == '') {
          ubp = $(evento.target).closest('.ubicacionpre')
          dep = ubp.find('[id$='+campoubi+'_departamento_id]')
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, dep, "departamentos")
          Msip__Motor.deshabilitarOtrosSinoHayMun(evento, campoubi)
        }else{
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "municipios")
          Msip__Motor.habilitarOtrosSiHayMun(evento, 1, campoubi)
        }
        if (fcammun) {
          fcammun()
        }
      })

    // Cambia coordenadas y habilita otros campos al cambiar centro poblado
    $(document).on('change', 
      '[id^=' + iniid + '][id$=' + campoubi + '_centropoblado_id]', 
      function (evento) {
        if($(this).val()==""){
          ubp = $(evento.target).closest('.ubicacionpre')
          mun = ubp.find('[id$='+campoubi+'_municipio_id]')
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, mun, "municipios")
        }else{
          Msip__Motor.fijarCoordenadasUbicacionpreFija(evento, campoubi, $(this), "centrospoblados")
        }
        Msip__Motor.habilitarOtrosSiHayMun(evento, 1, campoubi)
      })

    // Habilita otros campos al cambiar lugar
    $(document).on('change', 
      '[id^=' + iniid + '][id$=' + campoubi + '_lugar]', 
      function (evento) {
        Msip__Motor.habilitarOtrosSiHayMun(evento, 2, campoubi)
      }
    )

  }

  /* Serializa valores de un formulario en un arreglo
   * Idea de serializeArray de jQuery, implemantación basada en
   * https://vanillajstoolkit.com/helpers/serializearray/
   * FormData debería dejar esto obsoleto
   **/
  static serializarFormularioEnArreglo(formulario) {
    var arr = [];
    Array.prototype.slice.call(formulario.elements).forEach(function (campo) {
      if (!campo.name || campo.disabled || 
        ['file', 'reset', 'submit', 'button'].indexOf(campo.type) > -1) return;
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
      if (['checkbox', 'radio'].indexOf(campo.type) >-1 && !campo.checked) return;
      arr.push({
        name: campo.name,
        value: campo.value
      });
    });
    return arr;
  };



  /* Convierte arreglo (como el producido por Msip__Motor.serializarFormularioEnArreglo)
   * en una cadena apta para enviar consulta.
   * Con base en jQuery.param
   * https://github.com/jquery/jquery-dist/blob/main/src/serialize.js
   */
  static convertirArregloAParam(a) {
    if ( a == null || !Array.isArray( a ) ) {
      return "";
    }

    s = [];
    for(var i = 0; i < a.length; i++) {
      s[ s.length ] = encodeURIComponent( a[i].name ) + "=" +
        encodeURIComponent( a[i].value == null ? "" : a[i].value );

    }

    // Retorna serialización resultante
    return s.join( "&" );
  };


  /** Enviar AJAX
   * @param url Url
   * @param datos Cuerpo
   */
  static enviarAjax(url, datos, metodo='GET', tipo='script', 
    alertaerror=true) {
    var root =  window
    var t = Date.now()
    var d = -1
    if (root.Msip__Motor.enviarAjaxTestigo) {
      d = (t - root.Msip__Motor.enviarAjaxTestigo)/1000
    }
    root.Msip__Motor.enviarAjaxTestigo = t
    if (d == -1 || d > 2) {
      var enc = {}
      if (document.querySelector('meta[name="csrf-token"]') != null) {
        enc['X-CSRF-Token'] = document.
          querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
      if (tipo == 'script') {
        // https://stackoverflow.com/questions/44803944/can-i-run-a-js-script-from-another-using-fetch
        const promesaScript = new Promise((resolve, reject) => {
          const script = document.createElement('script');
          document.body.appendChild(script);
          script.onload = resolve;
          script.onerror = reject;
          script.async = true;
          script.src = url;
        });

        promesaScript
          .then(resultado => {
            console.log('Éxito:', resultado);
          })
          .catch(error => {
            console.error('Error:', error);
            if (alertaerror) {
              alert('Error: el servicio respondió: ' + error)
            }
          });

      } else {
        if (tipo == 'json') {
          enc['Content-Type'] = 'application/json'
        } else if (tipo == 'texto') {
          enc['Content-Type'] = 'text/plain'
        } else if (tipo == 'html') {
          enc['Content-Type'] = 'text/html'
        } else {
          alert('Tipo desconocido: ' + tipo)
          return;
        }

        fetch(url, {
          method: metodo,
          mode: 'cors', // no-cors, *cors, same-origin
          cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
          credentials: 'same-origin', // include, *same-origin, omit
          headers: enc,
          redirect: 'follow', // manual, *follow, error
          referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
          body: datos
        })
          .then(respuesta => respuesta.json())
          .then(resultado => {
            console.log('Éxito:', resultado);
          })
          .catch(error => {
            console.error('Error:', error);
            if (alertaerror) {
              alert('Error: el servicio respondió: ' + error)
            }
          });
      }
    }
    return
  }


  /** Envia datos de un formulario empleando AJAX
   * @param f Formulario
   */
  static enviarFormularioAjax(f, metodo='GET', tipo='script', 
    alertaerror=true, vcommit='Enviar', agenviarautom = true) {

    var a = f.getAttribute('action')
    const datosFormulario = new FormData(f);
    datosFormulario.append('commit', vcommit)
    if (agenviarautom) {
      datosFormulario.push('_msip_enviarautomatico', 1)
    }
    Msip__Motor.enviarAjax(a, datosFormulario, metodo, tipo, alertaerror)
  }

  static calcularCambiosParaBitacora() {
    let bitacora = document.querySelector("input.bitacora_cambio");
    if (bitacora == null) {
      return { vacio: false };
    }
    window.bitacora_estado_final_formulario = Msip__Motor.serializarFormularioEnArreglo(
      bitacora.closest("form")
    );
    if (typeof window.bitacora_estado_inicial_formulario != "object") {
      return { vacio: false };
    }
    let cambio = {};
    let di = {};
    window.bitacora_estado_inicial_formulario.forEach(
      (v) => di[v.name] = v.value
    );
    let df = {};
    window.bitacora_estado_final_formulario.forEach((v) => {
      df[v.name] = v.value;
      if (typeof di[v.name] == "undefined") {
        cambio[v.name] = [null, v.value];
      }
    });
    for (const i in di) {
      if (typeof df[i] == "undefined") {
        cambio[i] = [di[i], null];
      } else if (df[i] != di[i] && i.search(/\[bitacora_cambio\]/) < 0) {
        cambio[i] = [di[i], df[i]];
      }
    }
    return cambio;
  }


  /*
   * Con AJAX actualiza formulario, espera recibir formulario guardado
   * para repintar áreas identificadas con listaIdsRepintar y llamar
   * la retrollamada.
   *
   * Se espera que en rails la función update, maneje PATCH y request.xhr?
   * para no ir a hacer redirect_to con lo proveniente de un XHR 
   * (ver ejemplo en lib/sip/concerns/controllers/modelos_controller.rb)
   *
   * @param listaIdsRepintar Lista de ids de elementos por repintar
   *   Si hay uno llamado errores no vacio después de pintar detiene
   *   con mensaje de error.
   * @param retrollamada_exito Función por llamar en caso de éxito
   * @parama argumentos_exito Por pasar a la función retrollamada_exito (se 
   * sugiere que sea un registro).
   * @param retrollamada_falla Función por llamar en caso de falla
   * @parama argumentos_falla Por pasar a la función retrollamada_falla (se 
   *  sugiere que sea un registro).
   */
  static guardarFormularioYRepintar(listaIdsRepintar, retrollamada_exito, 
    argumentos_exito, retrollamada_falla = null, argumentos_falla = null) {
    if (document.body.style.cursor == 'wait') {
      alert('Hay un procedimiento en curso, por favor espere a que termine')
      return
    }
    document.body.style.cursor = 'wait'
    let formulario = document.querySelector('form')
    if (formulario == null) {
      document.body.style.cursor = 'default'
      alert('** Msip__Motor.guardarFormularioYRepintar: No se encontró formulario')
      if (retrollamada_falla != null) {
        retrollamada_falla(argumentos_falla)
      }
      return
    }
    let datos = new FormData(formulario);
    datos.set('commit', 'Enviar')
    datos.set('siguiente', 'editar')
    datos.set('_msip_enviarautomatico_y_repinta', 'editar')
    let paramUrl = new URLSearchParams(datos).toString()
    document.getElementById('errores').innerText=''
    window.Rails.ajax({
      type: 'PATCH',
      url: formulario.getAttribute('action'),
      data: datos,
      dataType: 'html',
      success: (resp, estado, xhr) => {
        document.body.style.cursor = 'default'
        let hayErrores = false
        listaIdsRepintar.forEach((idfrag) => {
          let f = document.getElementById(idfrag)
          let nf = resp.getElementById(idfrag)
          if (nf) {
            f.innerHTML = nf.innerHTML
            if (idfrag === 'errores' && nf.innerHTML.trim() !== '') {
              hayErrores = true
            }
          }
        })
        if (hayErrores) {
          document.body.style.cursor = 'default'
          alert('Revise los errores de validación, resuelvalos y vuelva a intentar')
          if (retrollamada_falla != null) {
            retrollamada_falla(argumentos_falla)
          }
          return
        }
        retrollamada_exito(argumentos_exito)
      },
      error: (req, estado, xhr) => {
        document.body.style.cursor = 'default'
        window.alert('No se pudo guardar formulario.')
        if (retrollamada_falla != null) {
          retrollamada_falla(argumentos_falla);
        }
        return
      }
    })
  }




}
