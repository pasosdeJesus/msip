# frozen_string_literal: true

class AjustaRegexPSd < ActiveRecord::Migration[7.0]
  def up
    p = Msip::Tdocumento.find_by(sigla: "P")
    p.formatoregex = "[A-Z]*[0-9]*"
    p.save!
    sd = Msip::Tdocumento.find_by(sigla: "SD")
    sd.formatoregex = "[0-9]*[A-Z]*"
    sd.save!
  end

  def down
    sd = Msip::Tdocumento.find_by(sigla: "SD")
    sd.formatoregex = "[0-9]*"
    sd.save!
    p = Msip::Tdocumento.find_by(sigla: "P")
    p.formatoregex = "[0-9]*"
    p.save!
  end
end
