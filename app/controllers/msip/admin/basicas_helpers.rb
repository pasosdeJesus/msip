# frozen_string_literal: true

module Msip
  module Admin
    # Ayudadores para controladores de tablas básicas en el espacio de nombres Admin.
    module BasicasHelpers
      include ActionView::Helpers::TextHelper
      include Msip::ModeloHelper

      # Prepara para rutas de tablas basicas en espacio de nombres
      # /admin para la ruta si se requiere
      # @param o [Object] Objeto de la tabla básica.
      # @param plural [Boolean] Si el nombre debe ser plural.
      # @return [String] Nombre del objeto para rutas admin.
      def nombreobj_admin(o, plural = false)
        nsing = nombreobj(o)
        nom = plural ? nsing.pluralize : nsing
        if !defined?(request) || request.fullpath.include?("/admin/#{nsing}") ||
            request.fullpath.include?("/admin/#{nsing.pluralize}")
          return "admin_" + nom
        end

        nom
      end

      # Ruta para administrar tabla basica o
      # @param o [Object] Objeto de la tabla básica.
      # @return [String] Ruta para administrar la tabla básica.
      def admin_basicas_path(o)
        n = nombreobj_admin(o, true) + "_path"
        send(n.to_sym)
      end

      # Url para administrar tabla basica o
      # @param o [Object] Objeto de la tabla básica.
      # @return [String] URL para administrar la tabla básica.
      def admin_basicas_url(o)
        n = nombreobj_admin(o, true) + "_url"
        send(n.to_sym)
      end

      # Ruta para examinar un registro de tabla basica o
      # @param o [Object] Objeto de la tabla básica.
      # @return [String] Ruta para examinar un registro de la tabla básica.
      def admin_basica_path(o)
        n = nombreobj_admin(o, !o.id) + "_path"
        send(n.to_sym, o)
      end

      # URL para examinar un registro de tabla basica o
      # @param o [Object] Objeto de la tabla básica.
      # @param format [Symbol] Formato de la URL.
      # @return [String] URL para examinar un registro de la tabla básica.
      def admin_basica_url(o, format)
        n = nombreobj_admin(o, !o.id) + "_url"
        send(n.to_sym, o, format)
      end

      # Ruta para crear un registro de la tabla básica
      # @param o [Object] Objeto de la tabla básica.
      # @return [String] Ruta para crear un registro de la tabla básica.
      def new_admin_basica_path(o)
        n = "new_" + nombreobj_admin(o) + "_path"
        send(n.to_sym)
      end

      # Ruta para editar un registro de la tabla básica o
      # @param o [Object] Objeto de la tabla básica.
      # @return [String] Ruta para editar un registro de la tabla básica.
      def edit_admin_basica_path(o)
        n = "edit_" + nombreobj_admin(o) + "_path"
        send(n.to_sym, o)
      end
    end
  end
end
