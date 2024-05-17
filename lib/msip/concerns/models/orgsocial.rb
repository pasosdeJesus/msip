# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Orgsocial
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          self.table_name = "msip_orgsocial"

          attr_accessor :bustipoorg_id

          belongs_to :grupoper, class_name: "Msip::Grupoper", validate: true, optional: false
          accepts_nested_attributes_for :grupoper, reject_if: :all_blank

          belongs_to :pais, class_name: "Msip::Pais", validate: true, optional: true

          belongs_to :tipoorg, class_name: "Msip::Tipoorg", optional: false

          has_many :orgsocial_persona,
            class_name: "Msip::OrgsocialPersona",
            dependent: :destroy,
            foreign_key: "orgsocial_id"
          accepts_nested_attributes_for :orgsocial_persona,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :persona,
            through: :orgsocial_persona,
            class_name: "Msip::Persona"
          accepts_nested_attributes_for :persona, 
            reject_if: :all_blank

          has_and_belongs_to_many :sectororgsocial,
            class_name: "Msip::Sectororgsocial",
            foreign_key: "orgsocial_id",
            validate: true,
            association_foreign_key: "sectororgsocial_id",
            join_table: "msip_orgsocial_sectororgsocial"

          campofecha_localizado :fechadeshabilitacion
          campofecha_localizado :created_at
          campofecha_localizado :updated_at

          validates :telefono, length: { maximum: 500 }
          validates :fax, length: { maximum: 500 }
          validates :direccion, length: { maximum: 500 }
          validates :web, length: { maximum: 500 }

          scope :habilitados, -> () {
            where(fechadeshabilitacion: nil)
          }

          attr_accessor :habilitado

          def habilitado
            fechadeshabilitacion.nil? ? "Si" : "No"
          end

          def presenta_msip(atr)
            case atr.to_s
            when "{:orgsocial_persona=>[]}"
              if orgsocial_persona
                orgsocial_persona.inject("") do |memo, s|
                  (memo == "" ? "" : memo + "; ") +
                    (if s.persona
                       s.persona.nombres + " " + s.persona.apellidos
                     else
                       ""
                     end)
                end
              else
                ""
              end
            when "anotaciones"
              self["grupoper_id"] ? grupoper.anotaciones : ""
            when "grupoper"
              self["grupoper_id"] ? grupoper.nombre : ""
            when "nombre"
              self["grupoper_id"] ? grupoper.nombre : ""
            when "pais"
              pais_id ? Msip::Pais.find(pais_id).nombre : ""
            when "pais_id"
              self[atr] ? Msip::Pais.find(self[atr]).nombre : ""
            when "sectores", Msip::Orgsocial
              .human_attribute_name(:sectoresorgsocial).downcase.gsub(" ", "_")
              if sectororgsocial
                sectororgsocial.inject("") do |memo, s|
                  (memo == "" ? "" : memo + "; ") + s.nombre
                end
              else
                ""
              end
            else
              presenta_gen(atr)
            end
          end

          def presenta(atr)
            presenta_msip(atr)
          end

          def presenta_nombre
            self["grupoper_id"] ?  grupoper.nombre : ""
          end

          scope :filtro_grupoper_id, lambda { |n|
            joins(:grupoper).where(
              "unaccent(msip_grupoper.nombre) ILIKE "\
              "'%' || unaccent(?) || '%'", n.to_s
            )
          }

          scope :filtro_habilitado, lambda { |o|
            if o.upcase.strip == "SI"
              where(fechadeshabilitacion: nil)
            elsif o.upcase.strip == "NO"
              where.not(fechadeshabilitacion: nil)
            end
          }

          scope :filtro_created_atini, lambda { |f|
            where("date(msip_orgsocial.created_at) >= ?", f)
          }

          scope :filtro_created_atfin, lambda { |f|
            where("date(msip_orgsocial.created_at) <= ?", f)
          }

          scope :filtro_sectororgsocial_ids, lambda { |s|
            joins('JOIN msip_orgsocial_sectororgsocial ON
                  msip_orgsocial_sectororgsocial.orgsocial_id=msip_orgsocial.id').where(
                    "msip_orgsocial_sectororgsocial.sectororgsocial_id=?", s
                  )
          }
        end # included
      end
    end
  end
end
