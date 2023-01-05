# frozen_string_literal: true

require_relative "../../test_helper"
require "msip/edad_sexo_helper"

module Msip
  class EdadSexoHelperTest < ActionView::TestCase
    include EdadSexoHelper

    test "edad" do
      assert_equal 47, edad_de_fechanac_fecha(1973, 7, 20, 2021, 7, 19)
      assert_equal 48, edad_de_fechanac_fecha(1973, 7, 20, 2021, 7, 21)
    end

    test "lib/msip" do
      c = Ubicacionpre.connection

      assert Msip.existe_secuencia?(c, "msip_ubicacionpre_id_seq")
      assert Msip.renombra_secuencia(
        c,
        "msip_ubicacionpre_id_seq",
        "msip_ubicacionpre_id_tmp_seq",
      )
      # Por ahora nos toca parar prueba aquí porque aunque
      # se ejecuta el ALTER, el ambiente de pruebas lo hace en
      # una transacción que no permite el renombramiento en realidad
      # debugger
      # assert Msip::existe_secuencia?(c, 'msip_ubicacionpre_id_tmp_seq')
      # assert Msip::renombra_secuencia(c, 'msip_ubicacionpre_id_tmp_seq',
      #                             'msip_ubicacionpre_id_seq')
    end
  end  # class
end    # module
