# frozen_string_literal: true

module Msip
  module InternetHelper
    # Obtiene datos de una URL con mediante HTTP y método GET haciendo
    # redirecciones (limitadas) de requerirse
    # @param uri Del cual traer datos
    # @param prob Colchón para problemas (debería llegar vacío y si hay
    #   problemas lo llena)
    # @param limite Máximo de redirecciones
    # @return nil si hay error o los datos obtenidos
    # https://ruby-doc.org/stdlib-2.7.0/libdoc/net/http/rdoc/Net/HTTP.html
    def obtener(uri, prob, limite = 10)
      if limite == 0
        prob = "demasidas redirecciones HTTP"
        return
      end
      resp = Net::HTTP.get(URI(uri))
      case resp
      when Net::HTTPSuccess then
        resp
      when Net::HTTPRedirection then
        localizacion = resp["localizacion"]
        warn("redirected to #{localizacion}")
        traer(localizacion, prob, limite - 1)
      else
        if resp.respond_to?(:value)
          resp.value
        else
          resp
        end
      end
    end
    module_function :obtener
  end
end
