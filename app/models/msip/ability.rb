# frozen_string_literal: true

module Msip
  class Ability
    include CanCan::Ability

    ROLADMIN  = 1
    # ROLINV    = 2
    ROLDIR    = 3
    # ROLCOOR   = 4
    ROLOPERADOR = ROLANALI = 5
    # ROLSIST   = 6

    ROLES = [
      ["Administrador", ROLADMIN], # 1
      ["", 0], # 2
      ["Directivo", ROLDIR], # 3
      ["", 0], # 4
      ["Operador", ROLOPERADOR], # 5
      ["", 0], # 6
    ]

    ROLES_CA = [
      "Crear copias de respaldo cifradas. " \
        "Administrar usuarios. " \
        "Administrar tablas básicas. ",
      "", # 2
      "", # 3
      "", # 4
      "", # 5
      "", # 6
      "", # 7
    ]

    BASICAS_PROPIAS = [
      ["Msip", "centropoblado"],
      ["Msip", "departamento"],
      ["Msip", "estadosol"],
      ["Msip", "etiqueta"],
      ["Msip", "fuenteprensa"],
      ["Msip", "grupo"],
      ["Msip", "municipio"],
      ["Msip", "oficina"],
      ["Msip", "pais"],
      ["Msip", "perfilorgsocial"],
      ["Msip", "sectororgsocial"],
      ["Msip", "tcentropoblado"],
      ["Msip", "tema"],
      ["Msip", "tdocumento"],
      ["Msip", "tipoorg"],
      ["Msip", "trelacion"],
      ["Msip", "trivalente"],
      ["Msip", "tsitio"],
      ["Msip", "vereda"],
    ]

    INISEC_TB = {
      msip_centropoblado: 1000000,
      msip_departamento: 10000,
      msip_municipio: 100000,
      msip_pais: 1000,
    }

    # Retorna diccionario con inicialización para secuencia de ids de
    # algunas tablas básicas que comienzan en valores mayor a 100.
    # Las tablas básicas que no esten indexadas comienzan secuencia
    # de ids en 100
    def inisec_tb
      INISEC_TB
    end

    # Retorna arreglo de tablas básicas
    # No conviene usar variables de clas @@tablasbasicas
    # Cuando varios motores heredan e inicializan, pues al
    # cargar en modo eager puede evaluarse de último una clase
    # que no se espera.
    def tablasbasicas
      BASICAS_PROPIAS
    end

    BASICAS_ID_NOAUTO = [
      ["Msip", "tcentropoblado"],
      ["Msip", "trelacion"],
    ]

    # Tablas básicas cuyo id no es autoincremental
    def basicas_id_noauto
      BASICAS_ID_NOAUTO
    end

    NOBASICAS_INDSEQID = [
      ["Msip", "anexo"],
      ["Msip", "centropoblado_histvigencia"],
      ["Msip", "departamento_histvigencia"],
      ["Msip", "municipio_histvigencia"],
      ["Msip", "pais_histvigencia"],
      ["Msip", "grupoper"],
      ["Msip", "persona"],
      ["Msip", "persona_trelacion"],
      ["Msip", "ubicacion"],
      ["", "usuario"],
    ]

    # Tablas no básicas pero que tienen índice *_seq_id
    def nobasicas_indice_seq_con_id
      NOBASICAS_INDSEQID
    end

    BASICAS_PRIO = [
      ["Msip", "tcentropoblado"],
      ["Msip", "pais"],
      ["Msip", "departamento"],
      ["Msip", "municipio"],
      ["Msip", "centropoblado"],
      ["Msip", "oficina"],
    ]

    # Tablas básicas que deben volcarse primero --por ser requeridas
    # por otras básicas
    def tablasbasicas_prio
      BASICAS_PRIO
    end

    # Recibe una tabla básica como pareja [Modulo, clase] y retorna
    # clase completa Modulo::Clase
    def self.tb_clase(t)
      k = if t[0] != ""
        t[0] + "::" + t[1].camelize
      else
        t[1].camelize
      end
      k.constantize
    end

    # Recibe una tabla básica como pareja [Modulo, clase] y retorna
    # nombre de tabla modulo_clase
    def self.tb_modelo(t)
      if t[0] != ""
        t[0].underscore.gsub(%r{/}, "_") + "_" + t[1]
      else
        t[1]
      end
    end

    # Se definen habilidades con cancancan
    # Util en motores y aplicaciones de prueba
    # En aplicaciones es mejor escribir completo el modelo de autorización
    # para facilitar su análisis y evitar cambios inesperados al actualizar
    # motores
    # @param usuario Usuario que hace petición
    def initialize_msip(usuario = nil)
      # El primer argumento para can es la acción a la que se da permiso,
      # el segundo es el recurso sobre el que puede realizar la acción,
      # el tercero opcional es un diccionario de condiciones para filtrar
      # más (e.g :publicado => true).
      #
      # El primer argumento puede ser :manage para indicar toda acción,
      # o grupos de acciones como :read (incluye :show e :index),
      # :create, :update y :destroy.
      #
      # Si como segundo argumento usa :all se aplica a todo recurso,
      # o puede ser una clase.
      #
      # Detalles en el wiki de cancan:
      #   https://github.com/ryanb/cancan/wiki/Defining-Abilities

      # Sin autenticación puede consultarse DIVIPOLA
      can(:read, [
        Msip::Pais, Msip::Departamento, Msip::Municipio, Msip::Centropoblado, Msip::Vereda,
      ])
      if !usuario || usuario.fechadeshabilitacion
        return
      end

      can(:contar, Msip::Ubicacion)
      can(:buscar, Msip::Ubicacion)
      can(:lista, Msip::Ubicacion)
      can(:descarga_anexo, Msip::Anexo)
      can(:mostrar_portada, Msip::Anexo)
      can(:abre_anexo, Msip::Anexo)
      can(:nuevo, Msip::Ubicacion)
      can(:read, Msip::Ubicacionpre)

      if usuario&.rol

        can(:read, [Msip::Persona])
        case usuario.rol
        when Ability::ROLANALI
          can([:new, :create, :read, :update], Msip::Grupoper)
          can([:new, :create, :read, :update], Msip::Orgsocial)
          can([:new, :create, :read, :update], Msip::Persona)
          can([:new, :create, :read, :update], Msip::Solicitud)
          can(:read, Msip::Ubicacion)
          can(:new, Msip::Ubicacion)
          can([:update, :create, :destroy], Msip::Ubicacion)
          can([:new, :index, :create, :show], ::Usuario, rol: 5)
          can([:show, :destroy], ::Usuario, nusuario: usuario.nusuario)
        when Ability::ROLADMIN
          can(:manage, Msip::Bitacora)
          can(:manage, Msip::Grupoper)
          can(:manage, Msip::Orgsocial)
          can(:manage, Msip::Persona)
          can(:manage, Msip::Respaldo7z)
          can(:manage, Msip::Solicitud)
          can(:manage, Msip::Tema)
          can(:manage, Msip::Ubicacion)
          can(:manage, Msip::Ubicacionpre)
          can(:manage, ::Usuario)
          can(:manage, :tablasbasicas)
          tablasbasicas.each do |t|
            c = Ability.tb_clase(t)
            can(:manage, c)
          end
        end
      end
    end
  end
end
