# frozen_string_literal: true

module Msip
  class ApplicationController < ActionController::Base
    protect_from_forgery

    # sin autorizacion porque es utilidad para otros controladores

    before_action do
      resource = controller_name.singularize.to_sym
      method = "#{resource}_params"
      params[resource] &&= send(method) if respond_to?(method, true)
    end

    before_action :configure_permitted_parameters,
      if: :devise_controller?

    # Aplicación final debe hacer algo como:
    # protect_from_forgery with: :exception

    # learn.tg propone una autenticación con un token firmado
    # con la billetera y verificado al lado del servidor y tras
    # eso almacenado en base de datos en BilleteraUsuario(usuario_id,
    # billetera, token).
    #
    # En lugar de usar devise para ese caso puede activarse
    # la ubicación del usuario con config.autentica_token_cripto_billetera
    def current_ability
      if !current_usuario && request.format.json? &&
          Rails.configuration.x.autentica_token_cripto_billetera
        if params[:walletAddress] && params[:token]
          b = BilleteraUsuario.where(billetera: params[:walletAddress])
          if b.count == 0
            puts "No BilleteraUsuario for #{params[:walletAddress]}"
          else
            ub = b.take
            if ub.token != params[:token]
              puts "Different tokens #{ub.token} and #{params[:token]}"
            else
              @current_usuario = ub.usuario
            end
          end
        end
      end
      @current_ability ||= ::Ability.new(current_usuario)
    end

    # Evitar WEBrick: RequestURITooLarge según
    # https://stackoverflow.com/questions/8333158/webrick-requesturitoolarge-should-i-update-or-use-a-different-server
    if defined?(WEBrick)
      WEBrick::HTTPRequest.const_set("MAX_URI_LENGTH", 124000)
    end

    protected

    def configure_permitted_parameters
      if (Gem.loaded_specs["devise"].version <=> Gem::Version.new("4.0.0")) < 0
        devise_parameter_sanitizer.for(:sign_up) << :nusuario
        devise_parameter_sanitizer.for(:account_update) <<
          [:nombre, :email, :descripcion, :tema_id]
      else
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nusuario])
        devise_parameter_sanitizer.permit(:account_update, keys:
                                        [:nombre, :email, :descripcion, :tema_id])
      end
    end
  end
end
