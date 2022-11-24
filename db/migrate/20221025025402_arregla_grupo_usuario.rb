class ArreglaGrupoUsuario < ActiveRecord::Migration[7.0]
  def up
    if column_exists?(:msip_grupo_usuario, :sip_grupo_id)
      rename_column(:msip_grupo_usuario, :sip_grupo_id, :grupo_id)
    elsif column_exists?(:msip_grupo_usuario, :msip_grupo_id)
      rename_column(:msip_grupo_usuario, :msip_grupo_id, :grupo_id)
    end
  end

  def down
    rename_column(:msip_grupo_usuario, :grupo_id, :msip_grupo_id)
  end
end
