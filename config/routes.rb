# frozen_string_literal: true

Msip::Engine.routes.draw do

  get "/acercade", to: "hogar#acercade", as: "acercade"

  get "/anexos/descarga_anexo/:id",
    to: "anexos#descarga_anexo",
    as: "descarga_anexo"
  get "/anexos/abre_anexo/:id",
    to: "anexos#abre_anexo",
    as: "abre_anexo"
  get "/anexos/mostrar_portada/:id",
    to: "anexos#mostrar_portada",
    as: "mostrar_portada"

  get "/bitacoras",
    to: "bitacoras#index",
    as: "bitacoras"
  get "/bitacora/:id",
    to: "bitacoras#show",
    as: "bitacora"
  #resources :bitacoras, only: [:index, :show]

  get "/controldeacceso", to: "hogar#ayuda_controldeacceso",
    as: "ayuda_controldeacceso"

  get "/espacio", to: "hogar#espacio", as: "espacio"

  resources :etiqueta_persona, only: [], param: :index do
    member do
      delete "(:id)", to: "etiquetas_persona#destroy", as: "eliminar"
      post "/", to: "etiquetas_persona#create", as: "crear"
    end
  end

  get "/gruposper", to: "gruposper#index"
  get "/gruposper/remplazar", to: "gruposper#remplazar"

  get "/hogar", to: "hogar#index"

  get "/mundep", to: "admin/municipios#mundep"

  resources :orgsocial_persona, only: [], param: :index do
    member do
      delete "(:id)", to: "orgsocial_personas#destroy", as: "eliminar"
      post "/", to: "orgsocial_personas#create", as: "crear"
    end
  end

  resources :orgsociales, path_names: { new: "nueva", edit: "edita" }

  resources :persona_trelacion, only: [], param: :index do
    member do
      delete "(:id)", to: "persona_trelaciones#destroy", as: "eliminar"
      post "/", to: "persona_trelaciones#create", as: "crear"
    end
  end
  post "/persona_trelaciones/actualizar", to: "persona_trelaciones#update",
    as: :actualizar_familiar


  get "/personas", to: "personas#index"
  get "/personas/datos", to: "personas#datos"
  get "/personas/remplazar", to: "personas#remplazar"
  get "/personas/identificacionsd", to: "personas#identificacionsd",
    as: :personas_identificacionsd
  get "/personas/remplazarfamiliar", to: "personas#remplazarfamiliar",
    as: :personas_remplazarfamiliar
  get "/personas/validar_conjunto", to: "personas#validar_conjunto",
    as: :personas_validar_conjunto
  post "/personas/unificar", to: "personas#unificar",
    as: :personas_unificar
  get "/personas/unificar", to: "personas#unificar",
    as: :personas_unificar_get

  resources :personas, path_names: { new: "nueva", edit: "edita" }

  get "/respaldo7z", to: "respaldo7z#new", as: "respaldo7z"
  post "/respaldo7z", to: "respaldo7z#create"

  resources :solicitudes, path_names: { new: "nueva", edit: "edita" }

  get "/tablasbasicas", to: "hogar#tablasbasicas"

  get "/temausuario", to: "admin/temas#temausuario"

  get "/tipocentropoblado", to: "admin/centrospoblados#tipo_centropoblado"

  get "/ubicaciones/nuevo", to: "ubicaciones#nuevo", as: :nueva_ubicacion

  get "/ubicacionespre_mundep", to: "admin/ubicacionespre#mundep"

  # resources :ubicacionespre, path_names: { new: "nueva", edit: "edita" }

  # En su aplicación al emplear ayudadores de rutas utilice prefijo
  # "msip." si viene de msip o "main_app." si es de las rutas de la aplicación.
  # Y en config/routes.rb utilice:
  #
  #  devise_scope :usuario do
  #    get 'sign_out' => 'devise/sessions#destroy'
  #
  #    # El siguiente para superar mala generación del action en el formulario
  #    # cuando se autentica mal (genera
  #    # /puntomontaje/puntomontaje/usuarios/sign_in )
  #    if (Rails.configuration.relative_url_root != '/')
  #      ruta = File.join(Rails.configuration.relative_url_root, 'usuarios/sign_in')
  #      post ruta, to: 'devise/sessions#create'
  #      get  ruta, to: 'devise/sessions#new'
  #    end
  #  end
  #  devise_for :usuarios, :skip => [:registrations], module: :devise
  #    as :usuario do
  #          get 'usuarios/edit' => 'devise/registrations#edit',
  #            :as => 'editar_registro_usuario'
  #          put 'usuarios/:id' => 'devise/registrations#update',
  #            :as => 'registro_usuario'
  #  end
  #  resources :usuarios, path_names: { new: 'nuevo', edit: 'edita' }

  namespace :admin do
    get "/trelaciones/validar_conjunto", 
      to: "trelaciones#validar_conjunto",
      as: :trelaciones_validar_conjunto

    get "/ubicacionespre/validar_conjunto", 
      to: "ubicacionespre#validar_conjunto",
      as: :ubicacionespre_validar_conjunto

    ab = Ability.new
    ab.tablasbasicas.each do |t|
      next unless t[0] == "Msip"

      c = t[1].pluralize
      resources c.to_sym,
        path_names: { new: "nueva", edit: "edita" }
      get "#{t[1]}/copiar/:id" => "#{c}#copiar",
        as: "copiar_#{t[1]}".to_sym
    end
  end

  root "hogar#index"
end
