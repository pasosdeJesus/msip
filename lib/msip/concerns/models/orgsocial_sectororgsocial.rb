
module Msip
  module Concerns
    module Models
      module OrgsocialSectororgsocial
        extend ActiveSupport::Concern

        included do
          self.table_name = 'msip_orgsocial_sectororgsocial'

          belongs_to :orgsocial, class_name: 'Msip::Orgsocial', 
            foreign_key: 'orgsocial_id', optional: false
          belongs_to :sectororgsocial, class_name: 'Msip::Sectororgsocial',
            foreign_key: 'sectororgsocial_id', optional: false

        end # included

      end
    end
  end
end
