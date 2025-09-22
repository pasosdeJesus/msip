# frozen_string_literal: true

class NilClass
  # Extensión a la clase NilClass para manejo de decimales localizados.

  # Retorna "0,0" para representar un valor decimal localizado.
  # @return [String] "0,0"
  def a_decimal_localizado
    "0,0"
  end

  # Retorna "0.0" para representar un valor decimal no localizado.
  # @return [String] "0.0"
  def a_decimal_nolocalizado
    "0.0"
  end
end
