# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Archivo adjuntando a algún otro elemento. El archivo se almacena en el
      # directorio del servidor definido en la variable de ambiente
      # `MSIP_RUTA_ANEXOS`
      module Anexo
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo

          self.table_name = "msip_anexo"
          has_attached_file :adjunto,
            path: Msip.ruta_anexos.to_s + "/:id_:filename"
          validates_attachment_content_type :adjunto,
            content_type: ["text/plain", /.*/]
          validates_attachment_presence :adjunto

          validates :descripcion,
            presence: true,
            allow_blank: false,
            length: { maximum: 1500 }
          # validates :archivo, length: { maximum: 255 }
          validates :adjunto_file_name, length: { maximum: 255 }
          validates :adjunto_content_type, length: { maximum: 255 }
        end
      end
    end
  end
end
