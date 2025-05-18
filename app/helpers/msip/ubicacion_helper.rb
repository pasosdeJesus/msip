# frozen_string_literal: true

module Msip
  module UbicacionHelper
    def formato_ubicacion_partes(pais_id, departamento_id, municipio_id,
      centropoblado_id, con_centropoblado, con_pais)
      r = ""
      if pais_id.nil? || Msip::Pais.where(id: pais_id).count != 1
        return r
      end

      if con_pais
        r = Msip::Pais.find(pais_id).nombre
      end
      if departamento_id.nil? ||
          Msip::Departamento.where(
            pais_id: pais_id,
            id: departamento_id,
          ).count != 1
        return r
      end

      if con_pais
        r += " / "
      end
      r += Msip::Departamento.find_by(id: departamento_id).nombre
      if municipio_id.nil? ||
          Msip::Municipio.where(
            departamento_id: departamento_id,
            id: municipio_id,
          ).count != 1
        return r
      end

      r += " / " + Msip::Municipio.find_by(id: municipio_id).nombre
      if !con_centropoblado || centropoblado_id.nil? ||
          Msip::Centropoblado.where(
            municipio_id: municipio_id,
            id: centropoblado_id,
          ).count != 1
        return r
      end

      r += " / " + Msip::Centropoblado.find_by(id: centropoblado_id).nombre
      r
    end
    module_function :formato_ubicacion_partes

    def formato_ubicacion(u, con_centropoblado = true, con_pais = true)
      if u.nil?
        return ""
      end

      formato_ubicacion_partes(
        (u ? u.pais_id : nil),
        (u ? u.departamento_id : nil),
        (u ? u.municipio_id : nil),
        (u ? u.centropoblado_id : nil),
        con_centropoblado,
        con_pais,
      )
    end
    module_function :formato_ubicacion
  end
end
