# frozen_string_literal: true

module Msip
  # Vista: Municipios con departamento
  # Ideas de https://www.sitepoint.com/speed-up-with-materialized-views-on-postgresql-and-rails/
  class Mundep < ActiveRecord::Base
    self.table_name = "msip_mundep"

    def readonly?
      true
    end

    def self.refresca
      if ActiveRecord::Base.connection.data_source_exists?("msip_mundep")
        ActiveRecord::Base.connection.execute(
          "REFRESH MATERIALIZED VIEW msip_mundep",
        )
      end
    end
  end
end
