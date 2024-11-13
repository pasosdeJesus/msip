class RenombraVerlocal < ActiveRecord::Migration[7.2]
  def change
    rename_column :msip_vereda, :verlocal_id, :verlocal_cod
  end
end
