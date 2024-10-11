# Motor para Sistemas de Información estilo Pasos de Jesús - msip

[![Revisado por Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com) Pruebas y seguridad:[![Estado Construcción](https://gitlab.com/pasosdeJesus/msip/badges/main/pipeline.svg)](https://gitlab.com/pasosdeJesus/msip/-/pipelines?page=1&scope=all&ref=main) [![Mantenibilidad](https://api.codeclimate.com/v1/badges/a20b38b425687073070e/maintainability)](https://codeclimate.com/github/pasosdeJesus/msip/maintainability) [![Cobertura de Pruebas](https://api.codeclimate.com/v1/badges/a20b38b425687073070e/test_coverage)](https://codeclimate.com/github/pasosdeJesus/msip/test_coverage) [![Gem Version](https://badge.fury.io/rb/msip.svg)](https://badge.fury.io/rb/msip)


![Logo de msip](https://gitlab.com/pasosdeJesus/msip/-/raw/main/test/dummy/app/assets/images/logo.jpg)

Este es un motor diseñado para ser base actualizada de sistemas de información
seguros o de otros motores para sistemas de información.

Puedes pensarlo como una capa adicional sobre Ruby on Rails que incluye
soluciones estándar, seguras y probadas para más elementos de un sistema
de información a diversos niveles:

- Vistas e Interfaz:
  - Propuesta para administrar modelos con vistas automáticas (no requieren
    código) y controladores semiautomáticos vía un generador.  Similar a
    [ActiveAdmin](https://activeadmin.info/),
    [Administrate](https://github.com/thoughtbot/administrate) y
    [Rails Admin](https://github.com/sferik/rails_admin)
    Usa `Msip::Modelo`, `Msip::ModelosController` y vistas de
    `app/views/msip/modelos/`. La vista `index` incluye
    un filtro definible con `scope` en el modelo.  La vista parcial
    `_form` genera automáticamente un formulario con elementos típicos.
    Consulta
    <https://gitlab.com/pasosdeJesus/msip/-/blob/main/doc/vistas-automaticas.md>
  - Vistas y formularios generados con las herramientas estándar de `rails`
    y `simple_form`. Listados paginados con `will_paginate`.
  - Preparado para construir aplicaciones adaptables (_responsive_) con
    `bootstrap`, `stimulus` y/o `coffescript` y `jquery`.
    Se usa de manera predeterminada `tom-select` para cuadros de selección 
    simple y múltiple y el control HTML estándar para campos de fecha.
  - Incluye biblioteca para operaciones comunes con javascript, por ejemplo para
    facilitar actualización automática mediante AJAX (ver
    `msip_enviarautomatico_formulario` en
    `app/asset/javascript/msip/motor.js.coffee.erb` que enviará
    automáticamente formularios cuando cambien campos con clase
    `enviarautomatico` o se presionen enlaces a anclas con esa clase)
  - Localización con mecanismos estándar de `rails` y de `twitter_cldr`.
    Propuesta para localización de campos tipo fecha(s) (que en español no es
    bien soportado por `rails`) especificando el formato local en
    `config.x.formato_fecha`, así como ayudas para definir campos de fecha
    localizados en ese formato.
  - Maquetación configurable, viene con dos ejemplos uno con menús horizontales
    en la parte superior y otro con menús verticales e icónos al lado izquierdo.
  - Sistema de temas que permite configurar diversos temas de colores para la
    interfaz con uno predeterminado y facilidad para que cada usuario elija el
    suyo.


- Modelos:
  - Concepto y propuesta de tablas básicas (también llamados tesauros
    de la aplicación o parámetros de la aplicación) con
    vistas automáticas y controladores y modelos semiautomáticos vía un
    generador. 
    Validación automática de campos `has_many` cuando se borra un registro
    para reportar si existen  registros dependientes en otras tablas (en lugar
    de fallar)
  
- Componentes ampliables (i.e modelos, controladores, vistas)
  - Modelos y controladores básicos con diversos propósitos y fácilmente
    ampliables o modificables con herencia o con `ActiveSupport::Concern`
    para aplicaciones más complejas. 
  - Componente para ubicaciones geográficas 
    `msip_pais`, `msip_departamento`, `msip_municipio`, `msip_centropoblado` para centros
    poblados), `msip_tcentropoblado` (tipos de centros poblados), `msip_tsitio`
    (tipo de sitio) y `msip_ubicacion`. Con datos de todos los países,
    aunque estados y municipios completos para Colombia, Venezuela y
    Honduras y ciudades completas para Colombia de acuerdo a DIVIPOLA 2022 
    con actualización periódica (vía migraciones de `rails`) de acuerdo a 
    esa fuente oficial.
      - Siluetas en SVG de los mapas de departamentos y municipios de Colombia
      con coordenadas listas para su composición.  Convertidas de OpenStreetMap
      y actualizadas con periodicidad.
  - Componente para personas y relaciones entre personas
    `msip_persona`, `msip_trelacion` (tipo de relación entre 
    personas), `tdocumento` (tipo de documento de identificación personal),
    `msip_persona_trelacion` (relación entre 2 personas).
  - Componente para grupos de personas
    `msip_grupoper`, organizaciones sociales `msip_orgsocial` (así llamamos a 
    un grupo de personas que se ponen de acuerdo para un objetivo o 
    representación conjunta), sus sectores `msip_sectororgsocial` y la 
    relación entre una persona y una organización social con su perfil 
    `msip_orgsocial_persona` y `msip_perfilorgsocial`
  - Componente para anexos con tabla `msip_anexo` y vistas
    incrustables y gema `kt-paperclip`
  - Propuesta de respaldo cifrado y comprimido con `7z` por parte de usuario
    final (del rol que se configure) desde menús de la aplicación.


- Control de Acceso
  - Propuesta inicial para control de acceso con:
  - Autenticación con tabla `usuario` (modelo `::Usuario`), gema `devise`
    y cifrado `bcrypt`
  - Autorización muy configurable con gema `cancancan` que puede valerse
    de roles (inicialmente sólo Administrador y Operador) o grupos
    (implementados en tablas `msip_grupo` --modelo `Msip::Grupo`--,
    y `msip_grupo_usuario`), o en otras tablas o métodos que elija.


- Facilidades para desarrollar y configurar aplicaciones que usen este motor:
  - Variables de ambiente en un archivo `.env` y la gema `dotenv`.  
  - Con variables de configuración de rails en el espacio de 
    nombres `config.x`, 
  - Con variables de configuración  en `config/initializers/msip.rb` (por 
    ejemplo país por omisión en `Msip.paisomision`).
  - La inicialización de este motor (`lib/msip/engine.rb`) incluye 
    automáticamente migraciones de motores en la aplicación final.
  - Tareas `rake` para actualizar indices y sacar copia de respaldo de base
    de datos


- Pruebas:
  - Pruebas con `minitest`

- Pila actualizada
  - Desarrollado en simultaneo con adJ (distribución de
  OpenBSD) y modificado para operar siempre sobre las nuevas versiones
  de adJ que se actualizan cada 6 meses para incluir:
  sistema operativo más reciente, motor de base de datos más reciente,
  Ruby reciente, librerías y gemas más recientes.   Probado de manera
  continua en Linux (vía integración continúa con gitlab-ci).  
  - Busca promover gemas recienten que faciliten el desarrollo del resto
  de la aplicación a nivel de interfaz e internacionalización y proveer
  ayudas para actualizar --por lo menos documentación en el directorio
  [doc](https://gitlab.com/pasosdeJesus/msip/-/tree/main/doc) y guías de 
  actualización en el [wiki](https://gitlab.com/pasosdeJesus/msip/-/wikis).
  - Busca mantener actualizada la información geográfica respecto al DIVIPOLA
    colombiano y OpenStreetMap

## Requisitos

Ver <https://gitlab.com/pasosdeJesus/msip/blob/main/doc/requisitos.md>

## Aplicación mínima incluida en msip

**msip** ya viene con una aplicación mínima (en el directorio `test/dummy` )
que es la usada para hacer pruebas de regresión.  Es una aplicación completa
con diseño web adaptable, autenticación, manejo de clave con condensado 
`bcrypt`, usuarios, grupos, vistas completas para tablas básicas y para
modelos persona y organización social. Incluso antes de intentar
iniciar una aplicación aparte, puede intentar ejecutar esa aplicación mínima,
siguiendo las instrucciones de:
<https://gitlab.com/pasosdeJesus/msip/blob/main/doc/aplicacion-de-prueba.md>

## Iniciar un sistema de información usando msip

Ver 
<https://gitlab.com/pasosdeJesus/msip/blob/main/doc/iniciar-si-usando-msip.md>

## Documentación

Después de tener tu primer ejemplo puedes generar tablas básicas para
tu aplicación, personalizar los modelos, vistas y controladores que `msip`
ofrece. Puedes consultar:
* Guías para varias operaciones usuales: 
  <https://gitlab.com/pasosdeJesus/msip/blob/main/doc/README.md>
* Documentación de las fuentes de msip en:
  <https://rubydoc.info/github/pasosdeJesus/msip/>
* Noticias y actualizaciones:
 <https://gitlab.com/pasosdeJesus/msip/-/wikis/pages>
* Versiones y resumen de cambios de cada una:
 <https://gitlab.com/pasosdeJesus/msip/-/releases>

## Reportar fallas

Si algo no opera como se espera puedes abrir un incidente en
<https://gitlab.com/pasosdeJesus/msip/-/issues>

