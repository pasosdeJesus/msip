# frozen_string_literal: true

# Ideas de https://www.sitepoint.com/speed-up-with-materialized-views-on-postgresql-and-rails/
module Msip
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
