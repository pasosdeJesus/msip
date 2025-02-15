import Msip__AutocompletaAjaxContactos from "./AutocompletaAjaxContactos"
window.Msip__AutocompletaAjaxContactos = Msip__AutocompletaAjaxContactos

import Msip__AutocompletaAjaxFamiliares from "./AutocompletaAjaxFamiliares"
window.Msip__AutocompletaAjaxFamiliares = Msip__AutocompletaAjaxFamiliares


import * as bootstrap from 'bootstrap'

export default class Msip__Motor {
  /*
   * Librería de funciones comunes.
   *
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
   *  Msip__Motor.partirFechaLocalizada(fl, formato)
   *
   * Para poderlo usar desde Javascript global con
   * window.Msip__Motor
   * asegure que en app/javascript/application.js ejecuta:
   *
   * import Msip__Motor from './controllers/msip/motor.js'
   * window.Msip__Motor = Msip__Motor
   *
   *
   * Convenciones:
   *
   * Primero constantes
   *
   * Después funciones static ordenadas alfabéticamente dejando 2 espacios
   * en  blanco entre una y otra.
   *
   * Antes de cada función comentario que la documenta
   *
   */

  static MESES = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
  ]


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
  static actualizarCuadrosSeleccionDependientes(idfuente, posfijo_id_fuente, posfijo_etiqueta_fuente, seldestino, opvacia = false) {
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
  static actualizarCuadrosSeleccionDependientesFunEtiqueta(idfuente, posfijo_id_fuente, fun_etiqueta, seldestino, opvacia = false) {
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


  // Verifica que `puntoMontaje` esté definido y termine en /;
  // si no está definido, lo establece como '/'
  static arreglarPuntoMontaje() {
    if (typeof window.puntoMontaje === 'undefined') {
      window.puntoMontaje = '/';
    }
    if (window.puntoMontaje[window.puntoMontaje.length - 1] !== '/') {
      window.puntoMontaje += '/';
    }
    return window.puntoMontaje
  }


  /* Calcula cambios en formulario para agregar a bitácora
   */
  static calcularCambiosParaBitacora() {
    let bitacora = document.querySelector("input.bitacora_cambio");
    if (bitacora == null) {
      return { vacio: false };
    }
    window.bitacora_estado_final_formulario =
      Msip__Motor.serializarFormularioEnArreglo(
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



  // Modifica el enlace de un elemento a `elema` para que 
  // sea `rutagenera` agregandole datos del formulario `idruta` o 
  // el más cercano si idruta es null 
  static completarEnlace(elema, idruta, rutagenera) {
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

    Msip__Motor.arreglarPuntoMontaje();

    // Ajusta `rutagenera` con el punto de montaje si es necesario
    if ((window.puntoMontaje !== '/' || rutagenera[0] !== '/') &&
      !rutagenera.startsWith(window.puntoMontaje)
    ) {
      rutagenera = window.puntoMontaje + rutagenera;
    }

    // Construye la URL con los datos del formulario
    const url = `${rutagenera}?${formData.toString()}`;
    elema.setAttribute('href', url);
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


  // Calcula edad en una fecha de referencia dada la fecha de nacimiento
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

    Msip__Motor.ponerTemaUsuarioAjax();

    document.querySelectorAll("a[rel~=popover], .has-popover").forEach(elem => {
      new bootstrap.Popover(elem);
    });

    document.querySelectorAll("a[rel~=tooltip], .has-tooltip").forEach(elem => {
      new bootstrap.Tooltip(elem);
    });

    const mundep = document.getElementById('mundep');
    if (mundep) {
      mundep.addEventListener('focusin', () => {
        Msip__Motor.arreglarPuntoMontaje();
        this.buscaGen(mundep, null, `${window.puntoMontaje}mundep.json`);
      });
    }

    document.addEventListener('click', event => {
      if (event.target.matches('a.enviarautomatico[href^="#"]')) {
        Msip__Motor.enviarAutomaticoFormulario(document.querySelector('form'), 'POST', 'json', false);
      }
    });

    document.addEventListener('change', event => {
      debugger
      if (event.target.matches('select[data-enviarautomatico], input[data-enviarautomatico]')) {
        debugger
        Msip__Motor.enviarAutomaticoFormulario(event.target.form);
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
    console.log("* Corriendo Msip__Motor.ejecutarAlCargarPagina()")
    // Pone colores de acuerdo al tema
    if (typeof window.formato_fecha === "undefined" || window.formato_fecha === "{}") {
      this.inicializaMotor();
    }
    Msip__Motor.iniciar()
    Msip__Motor.ponerTemaUsuarioAjax()

    Msip__Motor.configurarElementosTomSelect()

    Msip__AutocompletaAjaxContactos.iniciar()
    Msip__AutocompletaAjaxFamiliares.iniciar()

  }


  /** Enviar AJAX
   * @param url Url
   * @param datos Cuerpo
   */
  static enviarAjax(url, datos, metodo='GET', tipo='script',
    alertaerror=true) {
    var t = Date.now()
    var d = -1
    if (window.Msip__Motor.enviarAjaxTestigo) {
      d = (t - window.Msip__Motor.enviarAjaxTestigo)/1000
    }
    window.Msip__Motor.enviarAjaxTestigo = t
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


  // Envía con ajax a la ruta especificada junto con los datos, espera
  // respuesta html de la cual extrae una parte con selector selresp y
  // lo usa para volver a pintar el elemento con selector selelem
  static enviarAjaxDatosRutaYPinta(
    ruta, datos, selresp, selelem, metodo = 'GET', tipo = 'html',
    concsrf = false
  ) {
    const t = Date.now();
    let d = -1;

    if (window.msipEnviaAjaxT) {
      d = (t - window.msipEnviaAjaxT) / 1000;
    }
    window.msipEnviaAjaxT = t;

    if (d === -1 || d > 2) {
      Msip__Motor.arreglarPuntoMontaje();
      const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const rutac = `${window.puntoMontaje}${ruta}.js`;

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


  // Envia con AJAX datos del formulario, junto con el botón submit,
  // # evitando duplicaciones.
  // # @param f      Formulario jquery-sado
  // @param metodo GET, POST, PUT
  // @param tipo   json, script, xml o html (html puede ser interceptado
  // #   por redirect_to con turbolinks y presentado automáticamente en navegador)
  // @param alertaerror Presentar alerta en caso de error (true/false)
  // @param vcommit Valor para commit
  static enviarAutomaticoFormulario(
    f, metodo = 'GET', tipo = 'script', alertaerror = true,
    vcommit = 'Enviar', agenviarautom = true
  ) {
    const t = Date.now();
    let d = -1;
    if (window.msip_enviarautomatico_t) {
      d = (t - window.msip_enviarautomatico_t) / 1000;
    }
    window.msip_enviarautomatico_t = t;
    // NO se permite más de un envío en 2 segundos
    if (d === -1 || d > 2) {
      const a = f.getAttribute('action');
      const datos = new FormData(f);
      datos.set('commit', vcommit);
      if (agenviarautom) {
        datos.set('_msip_enviarautomatico', '1');
      }
      const paramUrl = new URLSearchParams(datos).toString();
      if (!window.dant || window.dant !== d) {
        window.dant = d;
        document.body.style.cursor = 'wait'
        debugger
        window.Rails.ajax({
          type: metodo,
          url: f.getAttribute('action'),
          data: paramUrl,
          dataType: 'html',
          success: (resp, estado, xhr) => {
            document.body.style.cursor = 'default'
            const elements = document.querySelectorAll(".tom-select");
            elements.forEach(function(el){
              if(typeof el.tomselect === 'undefined' &&
                (el.tagName == "INPUT" || el.tagName == "SELECT")) {
                new TomSelect(el, window.configuracionTomSelect);
              }
            });
          },
          error: (req, estado, xhr) => {
            document.body.style.cursor = 'default'
             if(alertaerror && xhr.status !== 0 && xhr.responseText !== ''){
               alert('Error: el servicio respondió: ' + xhr.status + xhr.responseText);
             }
          }
        })
      }
    }
  }


  // Escapar HTML de un texto con algunos reemplazos
  static escaparHtml(cadena) {
    return cadena
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
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


  // Operaciones comunes de inicialización desde varios puntos
  // conenv indica si debe preferir window.RailsConfig.relativeUrlRoot sobre
  // window.RailsConfig.puntoMontaje
  static inicializaMotor(conenv = true) {
    const config = window.RailsConfig || {}; // Accede a la configuración global
    window.puntoMontaje = config.puntoMontaje || '/';
    if (conenv && config.relativeUrlRoot) {
      window.puntoMontaje = config.relativeUrlRoot;
    }
    Msip__Motor.arreglarPuntoMontaje();
    window.msip_sincoord = false;
    window.formato_fecha = config.formatoFecha || "yyyy-mm-dd";
    window.msip_idioma_predet = config.idiomaPredet || "en";
  }


  // Llamada desde application.js tal vez antes de cargar el documento,
  // paquetes javascript y recursos sprockets
  static iniciar() {
    console.log("* Corriendo Msip__Motor.iniciar()")
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
  static intentarEliminarFila(fila, prefijoUrl, seldep) {
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


  // Cambia un campo select con base en valor de otro campo
  // rutajson Ruta del API que respondera JSON (sin punto de montaje)
  // params   Parametros por pasar a consulta AJAX
  // idsel    Id. del select por modificar
  // descerr  Descripcion por presentar en caso de que el JSON no responda
  // cid      Campo en el JSON resultantes de la consulta AJAX que corresponderá
  //          al id de cada elemento del campo de seleccion
  // cnombre  Campo en el JSON resultante de la consula AJAX que corresponderá al
  //          nombre de cada elemento del campo de seleccion (si es presenta_nombre
  //          además pasará parametro presenta_nombre al hacer la consulta para
  //          que el controlador responda con presenta_nombre de Msip::Modelo)
  // f        Función por llamar despues de cambiar el cuadro de seleccion
  // opvacia  Si es verdadero agrega opción vacía al cuadro de selección
  static llenarSelectConAjax(rutajson, params, idsel, descerr, cid = 'id', cnombre = 'nombre', callback = null, opvacia = false) {
    Msip__Motor.arreglarPuntoMontaje();

    const currentTime = Date.now();
    let elapsed = -1;

    if (window.llenarSelectConAjax_t) {
      elapsed = (currentTime - window.llenarSelectConAjax_t) / 1000;
    }
    window.llenarSelectConAjax_t = currentTime;

    const previousRoute = window.llenarSelectConAjax_rv || '';
    const previousParams = window.llenarSelectConAjax_pv || {};

    window.llenarSelectConAjax_rv = rutajson;
    window.llenarSelectConAjax_pv = params;

    // Limitar a 1 solicitud cada 2 segundos con los mismos parámetros
    if (elapsed > 0 && elapsed <= 2 && rutajson === previousRoute && JSON.stringify(params) === JSON.stringify(previousParams)) {
      return;
    }

    fetch(`${window.puntoMontaje}${rutajson}?${new URLSearchParams(params)}`)
      .then(response => response.json())
      .then(data => {
        this.remplazaOpcionesSelect(idsel, data, true, cid, cnombre, opvacia);
        if (callback) callback();
      })
      .catch(error => {
        alert(`Problema ${descerr}. ${JSON.stringify(params)} ${error.message}`);
      });
  }



  // Divide una fecha localizada en día, mes y año
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


  // Pone colores del tema en elementos de la interfaz de manera dinámica
  static ponerTema(tema) {
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


  // Pide al servidor el tema del usuario y lo establece
  static async ponerTemaUsuarioAjax(){
    var ruta = 'temausuario'
    var datos = {}
    var t = Date.now();
    var d = -1;
    Msip__Motor.arreglarPuntoMontaje()
    if (window.msip_ajax_recibe_json_t) {
      if (window.msip_ajax_recibe_json_t[ruta]) {
        d = (t - window.msip_ajax_recibe_json_t[ruta]) / 1000;
      }
    } else {
      window.msip_ajax_recibe_json_t = {};
    }
    window.msip_ajax_recibe_json_t[ruta] = t;

    if (d === -1 || d > 2) {
      var rutac = window.puntoMontaje + ruta + ".json";
      await fetch(rutac)
        .then(function(response) {
          if (!response.ok) {
            console.error('Request failed with status:', response.status);
          }
          return response.json();
        })
        .then(function(data) {
          return Msip__Motor.ponerTema(data);
        })
    }
    return true;
  }


  // Llamada a API
  // (recordar en rails responder con render json: objeto, status:ok,
  //  donde objeto es un objeto --no una cadena o entero)
  //
  // @ruta ruta (sin punto de montaje)
  // @datos Datos por enviar
  // @funproc Funcion para procesar respuesta
  static recibirJsonAjax(ruta, datos, funproc) {
    Msip__Motor.arreglarPuntoMontaje();

    // Evitar cargar de la misma ruta 2 veces en menos de 2 segundos
    const t = Date.now();
    let d = -1;

    if (window.msipAjaxRecibeJsonT) {
      if (window.msipAjaxRecibeJsonT[ruta]) {
        d = (t - window.msipAjaxRecibeJsonT[ruta]) / 1000;
      }
    } else {
      window.msipAjaxRecibeJsonT = {};
    }

    window.msipAjaxRecibeJsonT[ruta] = t;

    if (d === -1 || d > 2) {
      const rutac = `${window.puntoMontaje}${ruta}.json`;

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
          funproc(data);
        })
        .catch(error => {
          alert(error.message);
        });
    }

    return true;
  }



  // Retorna valor flotante con locale de USA a partir de un 
  // flotante con locale de Colombia, por ejemplo si recibe 
  // 1'323.000,2 retorna 1323000,2
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


  // Modifica los campos escondidos con clase `bitacora_cambio`
  // para establecer como valor las modificaciones al formulario
  static registrarCambiosParaBitacora() {
    // Si existen entradas con la clase 'bitacora_cambio', guarda el estado inicial del formulario
    const bitacoraCampos = document.querySelectorAll("input.bitacora_cambio");
    if (bitacoraCampos.length > 0) {
      const form = bitacoraCampos[0].closest("form");
      window.bitacoraEstadoInicialFormulario = Array.from(new FormData(form)).map(([name, value]) => ({ name, value }));
    }

    // Registra el evento 'submit' para formularios que contengan 'bitacora_cambio'
    document.addEventListener("submit", (e) => {
      const form = e.target;
      if (!form.querySelector(".bitacora_cambio")) return;

      // Almacena el estado final del formulario
      window.bitacoraEstadoFinalFormulario = Array.from(new FormData(form)).map(([name, value]) => ({ name, value }));

      // Compara el estado inicial y final para detectar cambios
      const cambio = {};
      const di = Object.fromEntries(window.bitacoraEstadoInicialFormulario.map(v => [v.name, v.value]));
      const df = Object.fromEntries(window.bitacoraEstadoFinalFormulario.map(v => [v.name, v.value]));

      window.bitacoraEstadoFinalFormulario.forEach(v => {
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



}
