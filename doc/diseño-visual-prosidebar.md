# Diseño visual con prosidebar e iconos de remixicon

Para que tu aplicación basada en msip emplee una maquetación y diseño 
visual basado en 
[prosidebar](https://github.com/azouaoui-med/pro-sidebar-template/blob/master/README.md) 
con iconos que elijas de remixicon.com.


Elige y prepara los iconos:

1. Elige los iconos que quieras ver en <https://remixicon.com/> 
   y en la misma página agregalos a una colección
2. Crea el directorio `vendor/assets/remixicon/`
3. Descarga la colección como fuente y descomprimela en el directorio
   `vendor/assets/remixicon/`
4. Renombra `remixicon.css` por `remixicon.scss`
5. Asegura que se copian recursos de remixicon agregando en
   `app/assets/config/manifest.json` las líneas
   ```
    //= link_directory ../../../vendor/assets/remixicon .eot
    //= link_directory ../../../vendor/assets/remixicon .svg
    //= link_directory ../../../vendor/assets/remixicon .ttf
    //= link_directory ../../../vendor/assets/remixicon .woff
    //= link_directory ../../../vendor/assets/remixicon .woff2
    ```

Copia lo necesario de prosidebar e integra:

1. Copia las hojas de estilo de
  <https://github.com/azouaoui-med/pro-sidebar-template/tree/master/src/styles>
   en `vendor/assets/stylesheets/prosidebar`
2. Copia javascript de prosidebar en `vendor/javascript/prosidebar`
3. Ejecuta `yarn add css-pro-layout`
5. Cambia `app/javascript/application.js` para agregar junto con 
   otras inicializaciones:
   ```
   import inicializaProsidebar from '../../vendor/javascript/prosidebar/index.js'
   window.inicializaProsidebar = inicializaProsidebar
   ```
   y dentro de el escuchador del evento `turbo:load` agregar:
   ```
   window.inicializaProsidebar()
   ```
6. En `app/views/layouts/application.html.erb` cambia
  * `layouts/msip/application` por `layouts/msip/application-prosidebar`
  * `grupo_menus` por `grupo_menus_prosidebar`
  * `opcion_menu` por `opcion_menu_prosidebar`
  * `despliega_abajo` por `despliega_abajo_prosidebar` y añadele el 
    icono por presentar (de los que están en `assets/remixicon`) y nil. 
    Por ejemplo:

    ```
    <%= despliega_abajo_prosidebar "Proyectos", 'ri-briefcase-4-fill', nil do %>
    ```
7. Crea `app/assets/stylesheets/prosidebar.scss` con
  ```
  @import '../../../vendor/assets/remixicon/remixicon';
  @import '../../../vendor/assets/stylesheets/prosidebar/styles';

  ```


