# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class PersonaTrelacionTest < ActiveSupport::TestCase
    test "valido" do
      persona1 = Msip::Persona.create(
        nombres: "nombre1",
        apellidos: "apellidos1",
        sexo: "S",
      )

      assert_predicate persona1, :valid?
      persona2 = Msip::Persona.create(
        nombres: "nombre2",
        apellidos: "apellidos2",
        sexo: "S",
      )

      assert_predicate persona2, :valid?
      trelacion = Msip::Trelacion.where(id: "AB").take

      assert_predicate trelacion, :valid?
      pt = Msip::PersonaTrelacion.create(
        personauno: persona1,
        personados: persona2,
        trelacion: trelacion,
      )

      assert_predicate pt, :valid?
      pt.destroy!
      persona1.destroy!
      persona2.destroy!
    end

    test "invalido: falta persona 1" do
      persona2 = Msip::Persona.create(
        nombres: "nombrei12", apellidos: "apellidosi12", sexo: "S",
      )

      assert_predicate persona2, :valid?
      trelacion = Msip::Trelacion.where(id: "AB").take

      assert_predicate trelacion, :valid?
      pt = Msip::PersonaTrelacion.create(
        personados: persona2,
        trelacion: trelacion,
      )

      assert_not pt.valid?
      persona2.destroy!
    end

    test "invalido: falta persona 2" do
      persona1 = Msip::Persona.create(
        nombres: "nombrei21", apellidos: "apellidos1", sexo: "S",
      )

      assert_predicate persona1, :valid?
      trelacion = Msip::Trelacion.where(id: "AB").take

      assert_predicate trelacion, :valid?
      pt = Msip::PersonaTrelacion.create(
        personauno: persona1,
        trelacion: trelacion,
      )

      assert_not pt.valid?
      persona1.destroy!
    end

    test "invalido: falta trelacion" do
      persona1 = Msip::Persona.create(
        nombres: "nombrei31", apellidos: "apellidos1", sexo: "S",
      )

      assert_predicate persona1, :valid?
      persona2 = Msip::Persona.create(
        nombres: "nombrei32", apellidos: "apellidos2", sexo: "S",
      )

      assert_predicate persona2, :valid?
      pt = Msip::PersonaTrelacion.create(
        personauno: persona1,
        personados: persona2,
        trelacion_id: nil,
      )

      assert_not pt.valid?
      pt.destroy!
      persona1.destroy!
      persona2.destroy!
    end

    test "invalido: no única" do
      persona1 = Msip::Persona.create(
        nombres: "nombrei41", apellidos: "apellidos1", sexo: "S",
      )

      assert_predicate persona1, :valid?
      persona2 = Msip::Persona.create(
        nombres: "nombre2", apellidos: "apellidos2", sexo: "S",
      )

      assert_predicate persona2, :valid?
      trelacion = Msip::Trelacion.where(id: "AB").take

      assert_predicate trelacion, :valid?

      pt = Msip::PersonaTrelacion.create(
        personauno: persona1,
        personados: persona2,
        trelacion: trelacion,
      )

      assert_predicate pt, :valid?
      pt2 = Msip::PersonaTrelacion.create(
        personauno: persona1,
        personados: persona2,
        trelacion: trelacion,
      )

      assert_not pt2.valid?
      pt.destroy!
      persona1.destroy!
      persona2.destroy!
    end
  end
end
