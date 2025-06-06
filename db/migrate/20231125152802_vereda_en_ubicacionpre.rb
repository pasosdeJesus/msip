# frozen_string_literal: true

class VeredaEnUbicacionpre < ActiveRecord::Migration[7.0]
  def change
    add_column(:msip_ubicacionpre, :vereda_id, :integer)
    add_foreign_key(:msip_ubicacionpre, :msip_vereda, column: :vereda_id)
    add_index(:msip_ubicacionpre, :vereda_id)
  end
end
