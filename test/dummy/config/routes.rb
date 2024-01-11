# frozen_string_literal: true

Rails.application.routes.draw do
  # La prioridad se base en el orden de creación:
  #   primero creado -> prioridad más alta
  # Vea como sus rutas se aplian con "rake routes".
  devise_scope :usuario do
    get "sign_out" => "devise/sessions#destroy", as: "sign_out"
    get "salir" => "devise/sessions#destroy",
      as: :terminar_sesion
    post "usuarios/iniciar_sesion", to: "devise/sessions#create"
    get "usuarios/iniciar_sesion",
      to: "devise/sessions#new",
      as: :iniciar_sesion

    # El siguiente para superar mala generación del action en el formulario
    # cuando se autentica mal (genera
    # /puntomontaje/puntomontaje/usuarios/sign_in )
    if Rails.configuration.relative_url_root != "/"
      ruta = File.join(
        Rails.configuration.relative_url_root, "usuarios/sign_in"
      )
      post ruta, to: "devise/sessions#create"
      get  ruta, to: "devise/sessions#new"
    end
  end
  devise_for :usuarios, skip: [:registrations], module: :devise
  as :usuario do
    get "usuarios/edit" => "devise/registrations#edit",
      :as => "editar_registro_usuario"
    put "usuarios/:id" => "devise/registrations#update",
      :as => "registro_usuario"
  end
  resources :usuarios, path_names: { new: "nuevo", edit: "edita" }

  root "msip/hogar#index"
  mount Msip::Engine, at: "/", as: :msip

end
