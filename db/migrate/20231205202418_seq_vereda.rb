class SeqVereda < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      SELECT pg_catalog.setval('msip_vereda_id_seq', 
        GREATEST(1000000, MAX(id)+1), true) FROM msip_vereda;
    SQL
  end
  def down
  end
end
