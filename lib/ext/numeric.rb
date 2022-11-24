# frozen_string_literal: true

class Numeric
  delegate :a_decimal_localizado, to: :to_s
end
