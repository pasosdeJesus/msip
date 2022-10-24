# Personalización de diseño visual, logo y favicon

Un diseño (layout) por omisión para todas las páginas se ubica en ```app/views/layouts/msip/application.html.erb``` y una página portada por omisión en `app/views/msip/hogar/index.html.erb` , incluyen soporte para:
* Encabezado fijo, pie de página y espacio para el contenido
* Una imagen de portada que debe ubicar en `app/assets/images/logo.jpg`
* favicons de diversos tamaños. Podrá generalos desde http://faviconit.com/ a partir de una imagen al menos de 310x310.  Ubiquelos en el directorio ```app/assets/images``` con los nombres dados por esa página.
* Un titulo que se recomienda especificar en config/initializers/msip.rb y aparecerá como título de la página y al lado izquierdo de la barra de navegación
* Diseño adaptable (responsive) basado en bootstrap, que reubica menus como desplegables en dispositivos móbiles y escala imagen de portada
* Un menú que se puede especificar en el contenido con nombre ```menu```
* Una guía-rastro (breadcrumb) especificable en el contenido con nombre ```breadcrumb```
* Espacio para las notificaciones (flash)
* Contenido principal de la página

Desde su aplicación lo usa en ```app/views/layouts/application.html.erb``` que debe tener los contenidos organizados así:

```
<% content_for :titulo do %>
    <%= Msip.titulo %>
<% end %>

<% content_for :menu do %>
  <%= menu_group do %>
    <% if !current_usuario.nil? %>
      <%= menu_item "Carne1", "/" %>
    <% end %>
  <% end %>
  <%= menu_group :pull => :right do %>
    <%= menu_item "Documentacion", "https://gitlab.com/pasosdeJesus/msip/wiki" %>
    <% if current_usuario %>
      <%= menu_item "Clave", msip.editar_registro_usuario_path %>
      <%= menu_item "Usuarios", msip.usuarios_path %>
      <%= menu_item "Tablas Básicas", msip.tablasbasicas_path %>
      <%= menu_item "Salir #{current_usuario.nusuario}", msip.sign_out_path %>
    <% else %>
      <%= menu_item "Acerca de", msip.acercade_path %>
      <%= menu_item "Iniciar Sesión", msip.new_usuario_session_path %> 
    <% end %>
  <% end %>
<% end %>

<% content_for :piedepagina do %>
  <p><span class='derechos'><a href="http://www.pasosdejesus.org/dominio_publico_colombia.html">Dominio Público de acuerdo a Legislación Colombiana</a><br/>
    Desarrollado por <a href="http://www.pasosdeJesus.org" target="_blank">Pasos de Jesús</a>. 2016. 
  </span></p>
<% end %>

<%= render template: "layouts/msip/application" %>
```


Los colores pueden personalizarse con los temas o creando por ejemplo un archivo  ```app/assets/stylesheets/personaliza.css``` con un contenido como el siguiente:

* Personalización del color de la barra de navegación, degrade de blanco a acre, aunque color acre en navegadores que no lo soportan:
```css
.navbar {
        background-image: linear-gradient(rgb(255, 255, 255), rgb(135, 43, 0));
        color: #872b00;
}
```

# Elementos del diseño visual para sistemas de información web

Recomendamos https://gitlab.com/pasosdeJesus/msip/blob/main/doc/elementos_dise%C3%B1o_visual.md
