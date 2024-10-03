# frozen_string_literal: true

module Msip
  module FormatoFechaHelper
    MESES = [
      "",
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre",
    ]

    ABMESES = [
      "",
      "Ene",
      "Feb",
      "Mar",
      "Abr",
      "May",
      "Jun",
      "Jul",
      "Ago",
      "Sep",
      "Oct",
      "Nov",
      "Dic",
    ]
    # Este ayudador emplea Rails.application.config.x.formato_fecha
    # al que llama formato local.
    #
    # Por el momento soporta bien:
    # dd-M-yyyy, dd/M/yyyy, dd-mm-yyyy, dd/mm/yyyy y yyyy-mm-ddd
    #
    # El formato estándar es el usado por PostgreSQL yyyy-mm-dd

    def fecha_local_colombia_estandar(f, menserror = nil)
      # Date.strptime(f, '%d-%M-%Y') no ha funcionado,
      # %b debe ser en ingles
      # rails-i18n I18n.localize con %b produce mes en minuscula
      unless f
        return nil
      end
      if f == ""
        return ""
      end

      nf = nil
      pf = f.split("/")
      if pf.count < 3
        pf = f.split("-")
      end
      if pf.count < 3
        if menserror
          menserror << "  Formato de fecha en locale de colombia desconocido: #{f}"
        else
          Rails.logger.debug { "Formato de fecha en locale de colombia desconocido: #{f}" }
        end
        return nil
        # nf = Date.strptime(f, "%d-%M-%Y").strftime("%Y-%m-%d")
      else
        return nil unless pf[1]

        m = case pf[1].downcase
        when "ene", "ene.", "jan", "jan.", "1", "01"
          1
        when "feb", "feb.", "2", "02"
          2
        when "mar", "mar.", "3", "03"
          3
        when "abr", "abr.", "apr", "apr.", "4", "04"
          4
        when "may", "may.", "5", "05"
          5
        when "jun", "jun.", "6", "06"
          6
        when "jul", "jul.", "7", "07"
          7
        when "ago", "ago.", "aug", "aug.", "8", "08"
          8
        when "sep", "sep.", "9", "09"
          9
        when "oct", "oct.", "10"
          10
        when "nov", "nov.", "11"
          11
        when "dic", "dic.", "dec", "dec.", "12"
          12
        else
          if menserror
            menserror << "  Formato de fecha en locale de Colombia con mes desconocido suponiendo 12."
          end
          12
        end
        a = pf[2].to_i
        if a < 100
          a += 2000
        end
        begin
          nf = Date.new(a, m, pf[0].to_i).strftime("%Y-%m-%d")
        rescue
          if menserror
            menserror << "  Formato de fecha en locale de colombia desconocido: #{f}"
          else
            Rails.logger.debug { "Formato de fecha en locale de colombia desconocido: #{f}" }
          end
        end
      end
      nf
    end
    module_function :fecha_local_colombia_estandar

    # Convierte una fecha de formato local a formato estándar
    def fecha_local_estandar(f)
      unless f
        return nil
      end
      if f == ""
        return ""
      end

      nf = case Rails.application.config.x.formato_fecha
      when "dd/M/yyyy", "dd-M-yyyy"
        fecha_local_colombia_estandar(f)
      when "dd-mm-yyyy"
        Date.strptime(f, "%d-%m-%Y").strftime("%Y-%m-%d")
      when "dd/mm/yyyy"
        Date.strptime(f, "%d/%m/%Y").strftime("%Y-%m-%d")
      else
        Date.strptime(f, "%Y-%m-%d").strftime("%Y-%m-%d")
      end
      nf
    end
    module_function :fecha_local_estandar

    # Convierte una fecha de formato estándar a formato local
    def fecha_estandar_local(f)
      if !f || (f.class != String && f.class != Date &&
          f.class != ActiveSupport::TimeWithZone) ||
          (f.class == String && f == "")
        return nil
      end

      if f.class == String
        fr = Date.strptime(f, "%Y-%m-%d")
      elsif f.class == Date
        fr = f
      elsif f.class == ActiveSupport::TimeWithZone
        fr = f.to_date
      end
      nf = case Rails.application.config.x.formato_fecha
      when "dd/M/yyyy"
        I18n.l(fr, format: "%d/%b/%Y")
      when "dd-M-yyyy"
        I18n.l(fr, format: "%d-%b-%Y")
      when "dd-mm-yyyy"
        fr.strftime("%d-%m-%Y")
      when "dd/mm/yyyy"
        fr.strftime("%d/%m/%Y")
      else
        fr.strftime("%Y-%m-%d")
      end
      nf
    end
    module_function :fecha_estandar_local

    # Adivina locale de fecha y retorna Date
    def reconoce_adivinando_locale(f, menserror = nil)
      if !f || (f.class != String && f.class != Date) ||
          (f.class == String && f == "")
        return nil
      end
      if f.class == Date
        return f
      end

      nf = f # nf se espera yyyy-mm-dd
      if f.include?("/")
        # 'dd/M/yyyy'
        nf = fecha_local_colombia_estandar(f, menserror)
      elsif f.include?("-")
        p = f.split("-")
        if p[0].to_i >= 1 && p[0].to_i <= 31 && p[2].to_i >= 0
          nf = fecha_local_colombia_estandar(f, menserror)
        end
      end
      begin
        r = Date.strptime(nf, "%Y-%m-%d")
      rescue
        r = nil
        if menserror
          menserror << "  Formato de fecha desconocido: #{f}"
        else
          Rails.logger.debug { "Formato de fecha desconocido: #{f}" }
        end
      end

      r
    end
    module_function :reconoce_adivinando_locale

    def inicio_semestre(f)
      if f.month <= 6
        Date.new(f.year, 1, 1)
      else
        Date.new(f.year, 7, 1)
      end
    end
    module_function :inicio_semestre

    def fin_semestre(f)
      if f.month <= 6
        Date.new(f.year, 6, 30)
      else
        Date.new(f.year, 12, 31)
      end
    end
    module_function :fin_semestre

    ##
    # Retorna fecha inicial del semestre anterior
    ##
    def inicio_semestre_ant
      hoy = Time.zone.today
      anio = hoy.year
      if hoy.mon >= 7 && hoy.mon < 12
        ini = anio.to_s + "-" + "01-01"
      elsif hoy.mon == 12
        ini = anio.to_s + "-" + "07-01"
      else
        anio -= 1
        ini = anio.to_s + "-" + "07-01"
      end
      ini
    end
    module_function :inicio_semestre_ant

    ##
    # Retorna fecha final del semestre anterior
    ##
    def fin_semestre_ant
      hoy = Time.zone.today
      anio = hoy.year
      if hoy.mon >= 7 && hoy.mon < 12
        fin = anio.to_s + "-" + "06-30"
      elsif hoy.mon == 12
        fin = anio.to_s + "-" + "12-31"
      else
        anio -= 1
        fin = anio.to_s + "-" + "12-31"
      end
      fin
    end
    module_function :fin_semestre_ant

    def dif_meses_dias(fechaini, fechafin)
      m = 0
      d = 0
      if fechaini && fechafin && fechaini < fechafin
        if fechafin.month < fechaini.month
          m = (fechafin.year - fechaini.year - 1) * 12
          m += 12 - fechaini.month + fechafin.month
        else
          m = (fechafin.year - fechaini.year) * 12
          m += fechafin.month - fechaini.month
        end
        if fechafin.day < fechaini.day
          m -= 1
          d = fechaini.end_of_month.day - fechaini.day + fechafin.day
        else
          d = fechafin.day - fechaini.day
        end
        # Hasta aquí, era preciso, el siguiente tiene en cuenta lo típico
        if (d + 1) == fechafin.end_of_month.day
          m += 1
          d = 0
        end
        if m == 0
          return I18n.t(:dia, count: d)
        elsif d == 0
          return I18n.t(:mes, count: m)
        end

        I18n.t(:mes, count: m) + " y " +
          I18n.t(:dia, count: d)
      else
        ""
      end
    end
    module_function :dif_meses_dias
  end
end
