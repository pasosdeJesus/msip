require 'test_helper'

module Msip
  class OrgsocialesControllerTest < ActionDispatch::IntegrationTest

    include Rails.application.routes.url_helpers
    include Devise::Test::IntegrationHelpers
    #include Cocoon::ViewHelpers

    setup  do
      if ENV['CONFIG_HOSTS'] != 'www.example.com'
        raise 'CONFIG_HOSTS debe ser www.example.com'
      end
      @current_usuario = ::Usuario.find(1)
      sign_in @current_usuario
      @grupoper = Msip::Grupoper.create!(PRUEBA_GRUPOPER)
      @orgsocial = Msip::Orgsocial.create!(PRUEBA_ORGSOCIAL)
    end

    # Cada prueba que se ejecuta se hace en una transacción
    # que después de la prueba se revierte

    test "debe presentar listado" do
      get msip.orgsociales_path
      assert_response :success
      assert_template :index
    end

    test "debe presentar resumen de existente" do
      get msip.orgsocial_url(@orgsocial.id)
      assert_response :success
      assert_template :show
    end

    test "debe presentar formulario para nueva" do
      get msip.new_orgsocial_path
      assert_response :success
      assert_template :new
    end

    test "debe presentar formulario de edición" do
      get msip.edit_orgsocial_path(@orgsocial)
      assert_response :success
      assert_template :edit
    end

    test "debe crear nueva" do
      # Arreglamos indice
      Msip::Orgsocial.connection.execute <<-SQL
        SELECT setval('public.msip_orgsocial_id_seq', MAX(id)) 
          FROM public.msip_orgsocial;
      SQL
      assert_difference('Orgsocial.count') do
        post msip.orgsociales_path, params: { 
          orgsocial: { 
            id: nil,
            grupoper_attributes: {
              id: nil,
              nombre: 'ZZ'
            }
          }
        }
      end

      assert_redirected_to msip.orgsocial_path(
        assigns(:orgsocial))
    end

    test "debe actualizar existente" do
      patch msip.orgsocial_path(@orgsocial.id),
        params: { 
          orgsocial: { 
            id: @orgsocial.id,
            grupoper_attributes: {
              id: @grupoper.id,
              nombre: 'YY'
            }
          }
        }

      assert_redirected_to msip.orgsocial_path(assigns(:orgsocial))
    end

    test "debe eliminar" do
      assert_difference('Orgsocial.count', -1) do
        delete msip.orgsocial_path(Orgsocial.find(1))
      end

      assert_redirected_to msip.orgsociales_path
    end

  end
end
