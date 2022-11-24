module Msip
  module TemasHelper
    def tema_usuario(current_usuario)
      t = if !current_usuario || !current_usuario.tema_id
        if Msip::Tema.where(id: 1).count == 1
          Msip::Tema.find(1)
        else
          Msip::Tema.new(
            nav_ini: Msip.colorom_nav_ini,
            nav_fin: Msip.colorom_nav_fin,
            nav_fuente: Msip.colorom_nav_fuente,
            fondo_lista: Msip.colorom_fondo_lista,
            btn_primario_fondo_ini: Msip.colorom_btn_primario_fondo_ini,
            btn_primario_fondo_fin: Msip.colorom_btn_primario_fondo_fin,
            btn_primario_fuente: Msip.colorom_btn_primario_fuente,
            btn_peligro_fondo_ini: Msip.colorom_btn_peligro_fondo_ini,
            btn_peligro_fondo_fin: Msip.colorom_btn_peligro_fondo_fin,
            btn_peligro_fuente: Msip.colorom_btn_peligro_fuente,
            btn_accion_fondo_ini: Msip.colorom_btn_accion_fondo_ini,
            btn_accion_fondo_fin: Msip.colorom_btn_accion_fondo_fin,
            btn_accion_fuente: Msip.colorom_btn_accion_fuente,
            alerta_exito_fondo: Msip.colorom_alerta_exito_fondo,
            alerta_exito_fuente: Msip.colorom_alerta_exito_fuente,
            alerta_problema_fondo: Msip.colorom_alerta_problema_fondo,
            alerta_problema_fuente: Msip.colorom_alerta_problema_fuente,
            fondo: Msip.colorom_fondo,
            color_fuente: Msip.colorom_color_fuente,
            color_flota_subitem_fondo: Msip.colorom_color_flota_subitem_fondo,
            color_flota_subitem_fuente: Msip.colorom_color_flota_subitem_fuente,
          )
        end
      else
        current_usuario.tema
      end
      t
    end
    module_function :tema_usuario
  end
end
