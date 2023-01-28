# Diseño visual con prosidebar

Para que su aplicación emplee el diseño visual con prosidebar incluido
en msip:

* En `app/views/layouts/application.html.erb` cambie
  * `layouts/msip/application` por `layouts/msip/application-prosidebar`
  * `opcion_menu` por `opcion_menu_prosidebar`
  * `despliega_abajo` por `despliega_abajo_prosidebar`
* En `app/javascript/application.js` cada vez que se cargue una página
  asegúrese de ejecutar:  `window.inicializaProsidebar()`

