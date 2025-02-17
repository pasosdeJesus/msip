# frozen_string_literal: true

class RestAnexos < ActiveRecord::Migration[7.1]
  def up
    if Msip::Anexo.has_attribute?(:archivo)
      remove_column(:msip_anexo, :archivo)
    end
    if Msip::Anexo.has_attribute?(:fecha)
      remove_column(:msip_anexo, :fecha)
    end
    change_column_null(:msip_anexo, :adjunto_file_name, false, "")
    change_column_null(:msip_anexo, :adjunto_content_type, false, "")
    change_column_null(:msip_anexo, :adjunto_file_size, false, 0)
  end

  def down
    change_column_null(:msip_anexo, :adjunto_file_name, true, nil)
    change_column_null(:msip_anexo, :adjunto_content_type, true, nil)
    change_column_null(:msip_anexo, :adjunto_file_size, true, nil)
  end
end
