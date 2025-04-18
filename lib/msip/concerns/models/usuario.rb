# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Usuario
        extend ActiveSupport::Concern
        include Msip::Modelo
        include Msip::Localizacion

        included do
          self.table_name = "usuario"
          scope :habilitados, ->(campoord = "nusuario") {
            where(fechadeshabilitacion: nil).order(campoord.to_sym)
          }
          @current_usuario = -1
          attr_accessor :current_usuario

          # Otros modulos de devise disponibles:
          # :recoverable :registerable, :confirmable, :timeoutable and :omniauthable
          devise :database_authenticatable,
            :rememberable,
            :trackable,
            :lockable

          campofecha_localizado :fechacreacion
          campofecha_localizado :fechadeshabilitacion
          campofecha_localizado :created_at

          belongs_to :tema, class_name: "Msip::Tema", validate: true, optional: true
          has_and_belongs_to_many :grupo,
            class_name: "Msip::Grupo",
            foreign_key: "usuario_id",
            association_foreign_key: "grupo_id",
            join_table: "msip_grupo_usuario",
            validate: true

          # http://stackoverflow.com/questions/1200568/using-rails-how-can-i-set-my-primary-key-to-not-be-an-integer-typed-column
          self.primary_key = :id

          def email_required?
            false
          end
          validates_uniqueness_of :nusuario, case_sensitive: false
          validates_format_of :nusuario,
            with: /\A[a-zA-Z_0-9]+[-.a-zA-Z_0-9]*\z/

          validates_presence_of :nusuario
          # La longitud de nusuario se configura en Msip.longitud_nusuario
          # De manera predeterminada es 15 (qe no basta para correos)
          validates_length_of :nusuario, maximum: Msip.longitud_nusuario

          # validates_length_of :nombre, maximum: 50, unless: 'nombre.nil?'
          validates_length_of :password, maximum: 64
          validates_length_of :descripcion, maximum: 50

          validates_presence_of :idioma
          validates_length_of :idioma, maximum: 6

          validates_presence_of :rol

          validates_uniqueness_of :email, case_sensitive: false
          validates_presence_of :email
          validates_length_of :email, maximum: 255

          validates_presence_of :sign_in_count

          validates_presence_of :fechacreacion
          validate :fechacreacion_posible?
          def fechacreacion_posible?
            if !fechacreacion || fechacreacion < Date.new(2001, 1, 1)
              errors.add(:fechacreacion, "Debe ser reciente (posterior a 2001)")
            end
          end

          validate :fechadeshabilitacion_posible?
          def fechadeshabilitacion_posible?
            if fechadeshabilitacion.present? && fechadeshabilitacion < fechacreacion
              errors.add(:fechadeshabilitacion, "Debe ser posterior a la de creación")
            end
          end

          validates_presence_of :encrypted_password, on: :create
          validates_confirmation_of :encrypted_password, on: :create

          def confirmation_token=(value)
            if value == ""
              value = nil
            end
            super
          end

          def presenta_nombre
            r = nusuario
            if nombre
              r += " - " + nombre
            end
            r
          end

          def self.presenta_base(registro, atr)
            case atr.to_s
            when "actualizacion"
              registro.updated_at
            when "condensado_de_clave"
              registro.encrypted_password
            when "creacion"
              registro.created_at
            when "correo"
              registro.email
            when "rol"
              a = ::Ability::ROLES.select { |v| v[1] == registro.rol }
              if a == []
                "Rol #{registro.rol} desconocido"
              else
                a.first[0]
              end
            else
              registro.presenta_gen(atr)
            end
          end

          def presenta(atr)
            Msip::Usuario.presenta_base(self, atr)
          end

          scope :filtro_nusuario, lambda { |u|
            where(nusuario: u)
          }

          scope :filtro_nombre, lambda { |n|
            where(
              "unaccent(nombre) ILIKE '%' || unaccent(?) || '%'",
              n,
            )
          }

          scope :filtro_descripcion, lambda { |d|
            where(
              "unaccent(descripcion) ILIKE '%' ||
                    unaccent(?) || '%'",
              d,
            )
          }

          scope :filtro_rol, lambda { |r|
            where(rol: r)
          }

          scope :filtro_idioma, lambda { |i|
            where(idioma: i)
          }

          scope :filtro_email, lambda { |e|
            where(
              "unaccent(email) ILIKE '%' ||
                    unaccent(?) || '%'",
              e,
            )
          }

          attr_accessor :habilitado

          def habilitado
            fechadeshabilitacion.nil? ? "Si" : "No"
          end

          scope :filtro_habilitado, lambda { |o|
            if o.upcase.strip == "SI"
              where(fechadeshabilitacion: nil)
            elsif o.upcase.strip == "NO"
              where.not(fechadeshabilitacion: nil)
            end
          }
        end

        class_methods do
        end
      end
    end
  end
end
