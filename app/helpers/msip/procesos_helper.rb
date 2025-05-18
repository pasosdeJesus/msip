# frozen_string_literal: true

module Msip
  module ProcesosHelper
    # Retorna lista de procesos que corren en OpenBSD/adJ
    # Cada entrada es un registro con campos:
    #   pid: # de proceso
    #   user: usuario que lo ejecutó
    #   ppid: # de proceso papá
    #   pgid: # de grupo de proceso
    #   sess: apuntador de sesión
    #   jobc: cuenta del control de trabajos
    #   stat: estado
    #   time: tiempo acumulado de CPU
    #   tt: abreviatura de la terminal que controla el proceso
    #   command: orden y argumentos
    def procesos_OpenBSD
      rproc = []
      p = %x(ps axwwj)
      l = p.split("\n")
      l[1..-1].each do |p|
        pp = p.split(" ")
        rproc.push({
          user: pp[0],
          pid: pp[1].to_i,
          ppid: pp[2].to_i,
          pgid: pp[3].to_i,
          sess: pp[4].to_i,
          jobc: pp[5].to_i,
          stat: pp[6],
          tt: pp[7],
          time: pp[8],
          command: pp[9..-1].join(" "),
        })
      end
      rproc
    end
    module_function :procesos_OpenBSD

    # Espacio en bytes usado por la ruta dada
    def discousado_OpenBSD(ruta)
      p = %x(du -s #{Shellwords.escape(ruta)})
      l = p.split(" ")
      l[0].to_i * 512 # bytes
    end
    module_function :discousado_OpenBSD

    # Espacio en la partición que contiene la ruta dada
    # @return [puntodemontaje, usado, libre] en bytes
    def espacioparticion_OpenBSD(ruta)
      p = %x(df #{Shellwords.escape(ruta)})
      l = p.split("\n")
      c = l[1].split(" ")
      [c[5], c[2].to_i * 512, c[3].to_i * 512]
    end
    module_function :espacioparticion_OpenBSD

    # Retorna una representación para humanos en sistema internacional
    # de unidades (ver https://es.wikipedia.org/wiki/Megabyte) de una
    # cantidad en bytes
    def tamhumano(bytes)
      if bytes < 10000
        return bytes.to_s
      end

      if bytes < 1000 * 1000
        k = bytes / 1000
        return k.to_s + "kB"
      end
      if bytes < 1000 * 1000 * 1000
        m = bytes / (1000 * 1000)
        return m.to_s + "MB"
      end
      if bytes < 1000 * 1000 * 1000 * 1000
        g = bytes / (1000 * 1000 * 1000)
        return g.to_s + "GB"
      end
      if bytes < 1000 * 1000 * 1000 * 1000 * 1000
        t = bytes / (1000 * 1000 * 1000 * 1000)
        return t.to_s + "TB"
      end
      p = bytes / (1000 * 1000 * 1000 * 1000 * 1000)
      p.to_s + "PB"
    end
    module_function :tamhumano
  end
end
