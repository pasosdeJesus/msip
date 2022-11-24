class SipAMsip < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper

  Funciones = [
    "edad_de_fechanac_fecharef",
  ]

  Tablas_con_idseq = [
    "anexo",
    "bitacora",
    "clase",
    "departamento",
    "estadosol",
    "etiqueta",
    "fuenteprensa",
    "grupo",
    "grupoper",
    "municipio",
    "oficina",
    "orgsocial",
    "pais",
    "perfilorgsocial",
    "persona",
    "sectororgsocial",
    "solicitud",
    "tema",
    "tdocumento",
    "tipoorg",
    "trivalente",
    "tsitio",
    "ubicacion",
    "ubicacionpre",
    "vereda",

    # Amplian  con id propio y id_seq
    "clase_histvigencia",
    "departamento_histvigencia",
    "municipio_histvigencia",
    "pais_histvigencia",

    # Combinan pero tienen id_seq
    "orgsocial_persona",
    "persona_trelacion",
  ]

  Tablas_con_idnoseq = [
    "tclase",
    "trelacion",
  ]

  Tablas_sin_id = [
    "etiqueta_municipio",
    "grupo_usuario",
    "orgsocial_sectororgsocial",
    "solicitud_usuarionotificar",
    "tclase",
  ]

  # Vistas materializadas
  VistasMat = [
    "mundep",
  ]

  # Vistas no materializadas
  Vistas = [
    "divipola",
    "mundep_sinorden",
  ]

  def up
    Funciones.each do |f|
      if existe_función_pg?("sip_#{f}")
        renombrar_función_pg("sip_#{f}", "msip_#{f}")
      end
    end

    Tablas_con_idseq.each do |t|
      next unless table_exists?("sip_#{t}")

      if existe_restricción_pg?("#{t}_pkey")
        # En sip hay anexo_pkey pero no sip_anexo_pkey que hace fallar
        # rename_table. Toca arreglar.
        renombrar_restricción_pg("sip_#{t}", "#{t}_pkey", "sip_#{t}_pkey")
      end
      rename_table("sip_#{t}", "msip_#{t}")
      # Por confirmar que no se requiere rename_sequence "sip_#{t}_id_seq", "msip_#{t}_id_seq"
    end

    Tablas_con_idnoseq.each do |t|
      if table_exists?("sip_#{t}")
        rename_table("sip_#{t}", "msip_#{t}")
      end
    end

    Tablas_sin_id.each do |t|
      next unless table_exists?("sip_#{t}")

      rename_table("sip_#{t}", "msip_#{t}")
      if existe_restricción_pg?("sip_#{t}_pkey")
        renombrar_restricción_pg("msip_#{t}", "sip_#{t}_pkey",
          "msip_#{t}_pkey")
      end
    end

    if data_source_exists?("divipola_sip")
      # Arreglamos nombre primero
      renombrar_vista_pg("divipola_sip", "sip_divipola")
    end

    Vistas.each do |t|
      if data_source_exists?("sip_#{t}")
        renombrar_vista_pg("sip_#{t}", "msip_#{t}")
      end
    end

    VistasMat.each do |t|
      if data_source_exists?("sip_#{t}")
        renombrar_vistamat_pg("sip_#{t}", "msip_#{t}")
      end
    end
  end # up

  def down
    VistasMat.reverse.each do |t|
      if data_source_exists?("msip_#{t}")
        renombrar_vistamat_pg("msip_#{t}", "sip_#{t}")
      end
    end

    Vistas.reverse.each do |t|
      if data_source_exists?("msip_#{t}")
        renombrar_vista_pg("msip_#{t}", "sip_#{t}")
      end
    end

    Tablas_sin_id.reverse.each do |t|
      if table_exists?("msip_#{t}")
        rename_table("msip_#{t}", "sip_#{t}")
      end
    end

    Tablas_con_idnoseq.reverse.each do |t|
      if table_exists?("msip_#{t}")
        rename_table("msip_#{t}", "sip_#{t}")
      end
    end

    Tablas_con_idseq.reverse.each do |t|
      if table_exists?("msip_#{t}")
        rename_table("msip_#{t}", "sip_#{t}")
      end
    end

    Funciones.reverse.each do |f|
      if existe_función_pg?("msip_#{f}")
        renombrar_función_pg("msip_#{f}", "sip_#{f}")
      end
    end
  end # down
end
