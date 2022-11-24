require "devise"

module Msip
  class Engine < ::Rails::Engine
    isolate_namespace Msip

    config.generators do |g|
      g.test_framework(:mintest, fixture: false)
      # g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets(false)
      g.helper(false)
    end

    # Basado en
    # http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
    initializer :append_migrations do |app|
      unless app.root.to_s == root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    # De http://guides.rubyonrails.org/engines.html
    config.to_prepare do
      #      Dir.glob(Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
      #        require_dependency(c)
      #      end
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require(c)
      end
    end
  end

  mattr_accessor :longitud_nusuario
  mattr_accessor :paginador
  mattr_accessor :paisomision
  mattr_accessor :ruta_anexos
  mattr_accessor :ruta_volcados
  mattr_accessor :titulo
  mattr_accessor :descripcion
  mattr_accessor :codigofuente
  mattr_accessor :urllogo
  mattr_accessor :urlcontribuyentes
  mattr_accessor :urlcreditos
  mattr_accessor :agradecimientoDios

  # Tema
  mattr_accessor :colorom_nav_ini
  mattr_accessor :colorom_nav_fin
  mattr_accessor :colorom_nav_fuente
  mattr_accessor :colorom_fondo_lista
  mattr_accessor :colorom_btn_primario_fondo_ini
  mattr_accessor :colorom_btn_primario_fondo_fin
  mattr_accessor :colorom_btn_primario_fuente
  mattr_accessor :colorom_btn_peligro_fondo_ini
  mattr_accessor :colorom_btn_peligro_fondo_fin
  mattr_accessor :colorom_btn_peligro_fuente
  mattr_accessor :colorom_btn_accion_fondo_ini
  mattr_accessor :colorom_btn_accion_fondo_fin
  mattr_accessor :colorom_btn_accion_fuente
  mattr_accessor :colorom_alerta_exito_fondo
  mattr_accessor :colorom_alerta_exito_fuente
  mattr_accessor :colorom_alerta_problema_fondo
  mattr_accessor :colorom_alerta_problema_fuente
  mattr_accessor :colorom_fondo
  mattr_accessor :colorom_color_fuente
  mattr_accessor :colorom_color_flota_subitem_fondo
  mattr_accessor :colorom_color_flota_subitem_fuente

  # Prosidebar
  mattr_accessor :prosidebar_colapsada

  # Valores iniciales
  self.longitud_nusuario = 15
  self.paginador = :will_paginate
  self.paisomision = 170
  self.ruta_anexos = "#{Rails.root}/archivos/anexos"
  self.ruta_volcados = "#{Rails.root}/archivos/bd"
  self.titulo = "msip"
  self.descripcion = "Motor para Sistemas de Información estilo Pasos de Jesús"
  self.codigofuente = "https://gitlab.com/pasosdeJesus/msip"
  self.urllogo = "https://openclipart.org/detail/141613/a-simple-representation-of-a-electric-3-phase-motor-by-eypros"
  self.urlcontribuyentes = "https://gitlab.com/pasosdeJesus/msip/-/graphs/main"
  self.urlcreditos = "https://gitlab.com/pasosdeJesus/msip/-/blob/main/CREDITOS.md"
  self.agradecimientoDios = "<p>
Sobre todo agradecemos a Dios, a Jesús que nos toca y sana, cuando nadie
más puede.
</p>
<blockquote>
  <p>
  Yendo Jesús a Jerusalén, pasaba entre Samaria y Galilea.
  Y al entrar en una aldea, le salieron al encuentro diez hombres leprosos,
  los cuales se pararon de lejos y alzaron la voz, diciendo:
  ¡Jesús, Maestro, ten misericordia de nosotros!
  <br>
  Cuando él los vio, les dijo: Id, mostraos a los sacerdotes.
  Y aconteció que mientras iban, fueron limpiados.
  <br>
  Entonces uno de ellos, viendo que había sido sanado, volvió, glorificando
  a Dios a gran voz, y se postró rostro en tierra a sus pies, dándole gracias;
  y este era samaritano.
  <br>
  Respondiendo Jesús, dijo: ¿No son diez los que fueron limpiados?
  Y los nueve, ¿dónde están? ¿No hubo quien volviese y diese gloria a
  Dios sino este extranjero?
  Y le dijo: Levántate, vete; tu fe te ha salvado.
  </p>
  <p>
  Lucas 17:11-19. Traducción Reina Valera 1960
  </p>".html_safe

  self.colorom_fondo = "#ffffff"
  self.colorom_color_fuente = "#000000"
  self.colorom_nav_ini = "#95c4ff"
  self.colorom_nav_fin = "#266dd3"
  self.colorom_nav_fuente = "#ffffff"
  self.colorom_fondo_lista = "#95c4ff"
  self.colorom_btn_primario_fondo_ini = "#0088cc"
  self.colorom_btn_primario_fondo_fin = "#0044cc"
  self.colorom_btn_primario_fuente = "#ffffff"
  self.colorom_btn_peligro_fondo_ini = "#ee5f5b"
  self.colorom_btn_peligro_fondo_fin = "#bd362f"
  self.colorom_btn_peligro_fuente = "#ffffff"
  self.colorom_btn_accion_fondo_ini = "#ffffff"
  self.colorom_btn_accion_fondo_fin = "#e6e6e6"
  self.colorom_btn_accion_fuente = "#000000"
  self.colorom_alerta_exito_fondo = "#dff0d8"
  self.colorom_alerta_exito_fuente = "#468847"
  self.colorom_alerta_problema_fondo = "#f8d7da"
  self.colorom_alerta_problema_fuente = "#721c24"
  self.colorom_color_flota_subitem_fondo = "#266dd3"
  self.colorom_color_flota_subitem_fuente = "#ffffff"

  self.prosidebar_colapsada = false

  def self.setup(&block)
    yield self
  end
end
