require_relative '../../test_helper'

module Msip
  class OrgsocialSectororgsocialTest < ActiveSupport::TestCase

    test "valido" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER)
      orgsocial = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL)
      assert orgsocial.valid?

      sectororgsocial = Msip::Sectororgsocial.create(PRUEBA_SECTORORGSOCIAL)
      assert sectororgsocial.valid?

      pt = Msip::OrgsocialSectororgsocial.create(
        orgsocial_id: orgsocial.id,
        sectororgsocial_id: sectororgsocial.id
      )
      assert pt.valid?
      # pt.destroy!  No opera porque msip_orgsocial_sectororgsocial no tiene
      # llave primaria
      orgsocial.sectororgsocial_ids = []
      orgsocial.save!
      sectororgsocial.destroy!
      orgsocial.destroy!
      grupoper.destroy!
    end

    test "invalido: falta orgsocial" do
      sectororgsocial = Msip::Sectororgsocial.create(PRUEBA_SECTORORGSOCIAL)
      assert sectororgsocial.valid?

      pt = Msip::OrgsocialSectororgsocial.create(
        orgsocial_id: nil,
        sectororgsocial_id: sectororgsocial.id
      )
      assert_not pt.valid?
      pt.destroy!
      sectororgsocial.destroy!
    end

    test "invalido: falta sectororgsocial" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER)
      orgsocial = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL)
      assert orgsocial.valid?

      pt = Msip::OrgsocialSectororgsocial.create(
        orgsocial_id: orgsocial.id,
        sectororgsocial_id: nil
      )
      assert_not pt.valid?
      pt.destroy!
      orgsocial.destroy!
      grupoper.destroy!
    end

    test "invalido: no única" do
      skip # Por hacer operar en mmsip
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER)
      orgsocial = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL)
      assert orgsocial.valid?

      sectororgsocial = Msip::Sectororgsocial.create(PRUEBA_SECTORORGSOCIAL)
      assert sectororgsocial.valid?

      pt = Msip::OrgsocialSectororgsocial.create(
        orgsocial_id: orgsocial.id,
        sectororgsocial_id: sectororgsocial.id
      )
      assert pt.valid?

      pt2 = Msip::OrgsocialSectororgsocial.create(
        orgsocial_id: orgsocial.id,
        sectororgsocial_id: sectororgsocial.id
      )
      assert_not pt2.valid?
    end


  end
end
