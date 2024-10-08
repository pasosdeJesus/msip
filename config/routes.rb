# frozen_string_literal: true

Msip::Engine.routes.draw do
  get "/acercade" => "hogar#acercade", as: "acercade"
  get "/anexos/descarga_anexo/:id",
    to: "anexos#descarga_anexo",
    as: "descarga_anexo"
  get "/anexos/abre_anexo/:id",
    to: "anexos#abre_anexo",
    as: "abre_anexo"
  get "/anexos/mostrar_portada/:id",
    to: "anexos#mostrar_portada",
    as: "mostrar_portada"
  get "/controldeacceso" => "hogar#ayuda_controldeacceso",
    as: "ayuda_controldeacceso"
  get "/espacio" => "hogar#espacio", as: "espacio"

  resources :etiqueta_persona, only: [], param: :index do
    member do
      delete '(:id)', to: "etiquetas_persona#destroy", as: "eliminar"
      post '/' => "etiquetas_persona#create", as: "crear"
    end
  end

  get "/gruposper" => "gruposper#index"
  get "/gruposper/remplazar" => "gruposper#remplazar"
  get "/hogar" => "hogar#index"
  get "/mundep" => "admin/municipios#mundep"
  get "/personas" => "personas#index"
  get "/personas/datos" => "personas#datos"
  get "/personas/remplazar" => "personas#remplazar"

  resources :persona_trelacion, only: [], param: :index do
    member do
      delete '(:id)', to: "persona_trelaciones#destroy", as: "eliminar"
      post '/' => "persona_trelaciones#create", as: "crear"
    end
  end

  get "/personas/identificacionsd" => "personas#identificacionsd",
    as: :personas_identificacionsd

  get "/personas/remplazarfamiliar" => "personas#remplazarfamiliar",
    as: :personas_remplazarfamiliar

  post '/persona_trelaciones/actualizar' => 'persona_trelaciones#update',
    as: :actualizar_familiar

  get "/personas/validar_conjunto" => "personas#validar_conjunto",
    as: :personas_validar_conjunto

  post '/personas/unificar' => 'personas#unificar',
    as: :personas_unificar
  get '/personas/unificar' => 'personas#unificar',
    as: :personas_unificar_get


  get "/respaldo7z" => "respaldo7z#new", as: "respaldo7z"
  post "/respaldo7z" => "respaldo7z#create"
  get "/tablasbasicas" => "hogar#tablasbasicas"
  get "/temausuario" => "admin/temas#temausuario"


  get "/tipocentropoblado" => "admin/centrospoblados#tipo_centropoblado"
  get "/ubicaciones/nuevo" => "ubicaciones#nuevo", as: :nueva_ubicacion
  get "/ubicacionespre_mundep" => "admin/ubicacionespre#mundep"

  resources :bitacoras, path_names: { new: "nueva", edit: "edita" }

  resources :orgsocial_persona, only: [], param: :index do
    member do
      delete '(:id)', to: "orgsocial_personas#destroy", as: "eliminar"
      post '/' => "orgsocial_personas#create", as: "crear"
    end
  end

  resources :orgsociales, path_names: { new: "nueva", edit: "edita" }

  resources :personas, path_names: { new: "nueva", edit: "edita" }

  resources :solicitudes, path_names: { new: "nueva", edit: "edita" }


  #resources :ubicacionespre, path_names: { new: "nueva", edit: "edita" }

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
    get "/trelaciones/validar_conjunto" => "trelaciones#validar_conjunto",
      as: :trelaciones_validar_conjunto

    get "/ubicacionespre/validar_conjunto" => "ubicacionespre#validar_conjunto",
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
