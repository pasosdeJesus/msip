class AjustaRegexPSd < ActiveRecord::Migration[7.0]
  def up
    p = Msip::Tdocumento.where(sigla: 'P').take
    if p
      p.formatoregex = '[A-Z]*[0-9]*'
      p.save!
    end
    sd = Msip::Tdocumento.where(sigla: 'SD').take
    if sd
      sd.formatoregex = '[0-9]*[A-Z]*'
      sd.save!
    end
  end
  
  def down
    sd = Msip::Tdocumento.where(sigla: 'SD').take
    if sd
      sd.formatoregex = '[0-9]*'
      sd.save!
    end
    p = Msip::Tdocumento.where(sigla: 'P').take
    if p
      p.formatoregex = '[0-9]*'
      p.save!
    end
  end
end
