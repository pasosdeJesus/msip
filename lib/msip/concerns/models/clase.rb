
module Msip
  module Concerns
    module Models
      module Clase
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          Nombresunicos=false  # Por ejemplo hay departamento AMAZONAS en COLOMBIA y en VENEZUELA
          self.table_name = 'msip_clase'
          has_many :persona, foreign_key: "id_clase", validate: true,
            class_name: 'Msip::Persona'
          has_many :ubicacion, foreign_key: "id_clase", validate: true,
            class_name: 'Msip::Ubicacion'

          belongs_to :municipio, foreign_key: "id_municipio", 
            validate: true, class_name: 'Msip::Municipio', optional: false
          has_one :departamento, through: :municipio,
            class_name: 'Msip::Departamento', source: :departamento
          has_one :pais, through: :departamento,
            class_name: 'Msip::Pais', source: :pais

          belongs_to :tclase, foreign_key: "id_tclase", validate: true,
            class_name: 'Msip::Tclase', optional: false

          # A nombre se le quitan espacios de sobra
          def nombre=(val)
            self[:nombre] = val.squish if val
          end

          validates :id_municipio, presence:true
          validates :id_tclase, presence:true, length: { maximum: 10 } 

          validates_uniqueness_of :id_clalocal, 
            scope: :id_municipio,
            message: "debe ser único en el municipio",
            allow_blank: true 

          validates_uniqueness_of :nombre, 
            scope: :id_municipio,
            case_sensitive: false, 
            message: "debe ser único en el municpio"

          scope :filtro_pais, lambda {|p|
            joins(:municipio).joins(:departamento).
              where('msip_departamento.id_pais=?', p)
          }

          @@conf_presenta_nombre_con_origen = false
          mattr_accessor :conf_presenta_nombre_con_origen

          def presenta_nombre_con_origen
            mun = Msip::Municipio.find(self.id_municipio)
            dep= Msip::Departamento.find(mun.id_departamento)
            pais = Msip::Pais.find(dep.id_pais)
            self.nombre + " / " + mun.nombre + "/" + dep.nombre + 
              " / " + pais.nombre
          end

          def presenta_nombre
            if @@conf_presenta_nombre_con_origen
              presenta_nombre_con_origen
            else
              self.nombre
            end
          end

        end

      end
    end
  end
end

