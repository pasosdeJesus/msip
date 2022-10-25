class ArreglaGrupoUsuario < ActiveRecord::Migration[7.0]
  def change
    rename_column :msip_grupo_usuario, :sip_grupo_id, :grupo_id
  end
end
