# Personalización de rutas, controladores y vistas

El controlador de la aplicación completa ```app/controllers/application_controller.rb``` no se necesita en motores, en aplicaciones basta que sea:
```
# encoding: UTF-8
require 'msip/application_controller'
class ApplicationController < Msip::ApplicationController
  protect_from_forgery with: :exception
end
```

## Diseño general de la interfaz / layout

Uno genérico se define en ```app/views/layout/msip/application.html.erb``` que es adaptable y para completar contenidos mediante ```content_for```.  Sus características son:
- Tiene un título definible en :titulo
- Tiene una barra de menus en la parte superior, que puede definirse en :menu
- Un contenedor en el centro con el contenido principal con el contenido principal
- Un pie de página definible en :piedepagina

Para usarlo en aplicaciones basta en ```app/views/layouts/application.html.erb``` definir los contenidos, por ejemplo:
```
<% content_for :titulo do %>
    <%= Msip.titulo %>
<% end %>

<% content_for :menu do %>
  <%= menu_group :pull => :right do %>
    <%= menu_item "Documentacion", "http://gitlab.com/pasosdeJesus/msip.git" %>
    <%= menu_item "Acerca de", msip.acercade_path %>
    <%= menu_item "Iniciar Sesión", msip.new_usuario_session_path %>
  <% end %>
<% end %>

<% content_for :piedepagina do %>
  <p><span class='derechos'>Dominio Público de acuerdo a Legislación Colombiana<br/>
    Desarrollado por <a href="http://www.pasosdeJesus.org" target="_blank">Pasos de Jesús</a>. 2015.
  </span></p>
<% end %>

<%= render template: "layouts/msip/application" %>
```

Si un motor descendiente lo modificará se recomienda en ```app/views/layout/Mimotor/application.html.erb```, ver por ejemplo https://gitlab.com/pasosdeJesus/sal7711_gen/blob/master/app/views/layouts/sal7711_gen/application.html.erb


## Controlador hogar

La página principal, el listado de tablas básicas y el acceso a "Acerca de" se definen en el controlador ```app/controllers/msip/hogar_controller.rb``` y sus vistas ```app/views/msip/hogar```.  

La vista de la página principal ```app/views/msip/hogar/index.html.erb``` sólo presenta la imagen que
esté disponible en ```public/images/logo.jpg``` y el mensaje que se deje en la vista parcial ```app/views/msip/hogar/_local.html.erb```.  Se recomienda incluir en repositorio git de aplicaciones ```app/views/msip/hogar/_local.html.erb.plantilla``` que se espera copiar y modificar en instalaciones locales como  ```app/views/msip/hogar/_local.html.erb```

Se recomienda definir ```app/views/msip/hogar/acercade.html.erb```

Para modificar el controlador en otro motor Mimotor se recomienda en ```app/controllers/Mimotor/hogar_controller.rb``` que herede de Msip::HogarController, que modifique lo necesario y que sea referenciado desde ```config/routes.rb``` del motor.

