# frozen_string_literal: true

module Msip
  module EdadSexoHelper
    # Opciones de sexo están en Msip::Persona::SEXO_OPCIONES

    # Retorna edad de una persona en cierta fecha
    # @param anionac año de nacimiento
    # @param mesnac mes de nacimiento
    # @param dianac dia de nacimiento
    # @ return -1 si no puede calcularse por falta de años
    def edad_de_fechanac_fecha(anionac, mesnac, dianac,
      anio, mes, dia)
      if anionac.nil? || anionac == ""
        return -1
      end
      if anio.nil? || anio == ""
        return -1
      end
      if anio < anionac
        return -1
      end

      na = anio - anionac
      if mesnac && mesnac > 0 && mes && mes > 0 && mesnac >= mes
        if mesnac > mes || (dianac && dianac > 0 && dia && dia > 0 &&
            dianac > dia)
          na -= 1
        end
      end

      na
    end
    module_function :edad_de_fechanac_fecha

    # @param modelorango es nombre de modelo con rangos e.g
    #   'Sivel2Gen::Rangoead' o 'Cor1440Gen::Rangoedadac'
    # @return id en tabla del rango o si no se puede calcular
    #   retorna ID del registro SIN INFORMACIÓN (o -1 si no hay
    #   SIN INFORMACIÓN)
    def buscar_rango_edad(edad, modelorango)
      if !modelorango || !defined?(modelorango.constantize) ||
          !defined?(!modelorango.constantize.habilitados)
        puts "No se pudo usar modelorango"
        return -1
      end
      t = modelorango.constantize.habilitados
      idsin = t.where("unaccent(nombre) ILIKE unaccent('SIN INFORMACIÓN')")
      idsin = if idsin.count == 1
        idsin.take.id
      else
        -1
      end
      c = t.where("(limiteinferior IS NULL) OR (limiteinferior  <= ?)", edad)
        .where("(limitesuperior IS NULL) OR (? <= limitesuperior)", edad)
      ret = idsin
      if c.count == 0
        puts "No se encontró edad #{edad} en tabla #{modelorango}"
      elsif c.count > 1
        puts "Traslape de #{c.count} rangos en edad #{edad}"
      else # c.count == 1
        ret = c.take.id
      end
      ret
    end
    module_function :buscar_rango_edad
  end
end
