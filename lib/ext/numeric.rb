# frozen_string_literal: true

class Numeric
  # Extensión a la clase Numeric para manejo de decimales localizados.

  # Delega la llamada a `a_decimal_localizado` al método `to_s`.
  # @return [String] Representación localizada del número.
  delegate :a_decimal_localizado, to: :to_s
end
