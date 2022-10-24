require_relative '../../test_helper'

module Msip
  class OrgsocialPersonaTest < ActiveSupport::TestCase

    test "valido" do
      grupoper = Msip::Grupoper.create PRUEBA_GRUPOPER
      assert grupoper.valid?
      grupoper.save!
      orgsocial = Msip::Orgsocial.new PRUEBA_ORGSOCIAL
      orgsocial.grupoper = grupoper
      assert orgsocial.valid?
      orgsocial.save!

      persona = Msip::Persona.create PRUEBA_PERSONA
      assert persona.valid?
      persona.save!
 
      perfilorgsocial = Msip::Perfilorgsocial.create PRUEBA_PERFILORGSOCIAL
      assert perfilorgsocial.valid?
      perfilorgsocial.save!

      orgsocial_persona= Msip::OrgsocialPersona.new
      orgsocial_persona.orgsocial = orgsocial
      orgsocial_persona.persona = persona
      orgsocial_persona.perfilorgsocial = perfilorgsocial
      assert orgsocial_persona.valid?
      orgsocial_persona.save!
     
      orgsocial_persona.destroy
      perfilorgsocial.destroy
      persona.destroy
      orgsocial.destroy
      grupoper.destroy
    end

    test "no valido" do
      orgsocial_persona= Msip::OrgsocialPersona.new 
      assert_not orgsocial_persona.valid?
      orgsocial_persona.destroy
    end


  end
end
