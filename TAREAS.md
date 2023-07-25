Versión 2.2.0.beta3

* El sistema asignará un número de documento automáticamente a personas
  que no tengan número de documento a las que se les elija el tipo SIN
  DOCUMENTO.
* Ahora las personas pueden tener etiquetas asociadas, pueden editarse
  desde nueva sección Etiquetas del formulario de persona.
* Es posible especificar familiares de una persona desde la nueva sección
  Familiares del formulario de Persona.

Versión 2.2.0.beta4

* División política de Colombia actualizada acorde al DIVIPOLA del DANE
  de Julio de 2023.  Ver
  <https://gitlab.com/pasosdeJesus/msip/-/wikis/2023_07-Resumen-ejecutivo-de-la-actualizaci%C3%B3n-a-DIVIPOLA-2023-07>



* Agregar `etnia_id` en `msip_persona` (requiere quitarla de victima en
  `sivel2_gen` y sus motores y aplicaciones descendientes)


IDEAS
-----

A 10.Mar.2020 del `Gemfile` de este y `sivel2_gen` las gemas que tienen 
menos de 100.000 dependencias:

  https://github.com/gorn/rspreadsheet/network/dependents 27
  https://github.com/sandrods/odf-report/network/dependents 96
  https://github.com/xml4r/libxml-ruby/network/dependents 2.184
  https://github.com/prawnpdf/prawn-table/network/dependents 2.700
  https://github.com/twitter/twitter-cldr-rb/network/dependents 3.141
  https://github.com/prawnpdf/prawn/network/dependents 7.374
  https://github.com/tigrish/devise-i18n/network/dependents 7.800
  https://github.com/nathanvda/cocoon/network/dependents 10.603
  https://github.com/svenfuchs/rails-i18n/network/dependents 20.895
  https://github.com/sporkrb/spork/network/dependents 25.400
  https://github.com/CanCanCommunity/cancancan/network/dependents 25.914
  https://github.com/titusfortner/webdrivers/network/dependents 32.793
  https://github.com/mperham/connection_pool/network/dependents 46.722
  https://github.com/SeleniumHQ/selenium/network/dependents 47.255
  https://github.com/sass/sassc-rails/network/dependents 47.960
  https://github.com/vmg/redcarpet/network/dependents 65.194
  https://github.com/fazibear/colorize/network/dependents 66.748
  https://github.com/rails/webpacker/network/dependents muestra 70.935 proyectos en github que dependen de webpacker
  https://github.com/thoughtbot/paperclip/network/dependents 77.725
  https://github.com/colszowka/simplecov/network/dependents 84.781

Así que puede haber problemas de soporte especialmente en:
1. Método de generar hojas de cálculo, documentos y PDFs.
2. Internacionalización


Alternativas para hoja de cálculo:
  https://github.com/caxlsx/caxlsx_rails/network/dependents 37
  https://github.com/roo-rb/roo/network/dependents 5.803

Alternativas para documentos:
  https://github.com/senny/sablon#writing-templates 44


