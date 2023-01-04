# frozen_string_literal: true

require_relative "../../test_helper"
require "rake"

module Msip
  class TareasTest < ActiveSupport::TestCase
    include Engine.routes.url_helpers
    # include Devise::Test::IntegrationHelpers

    setup do
      Dummy::Application.load_tasks
    end

    test "indices" do
      Rake::Task["msip:indices"].invoke
    end

    # modifica db/datos-basicas.sql
    # test "vuelcabasicas" do
    #  Rake::Task['msip:vuelcabasicas'].invoke
    # end

    # test "actbasicas" do
    #  Rake::Task['msip:actbasicas'].invoke
    # end

    test "vuelca" do
      puts "OJO vuelca:"
      Rake::Task["msip:vuelca"].invoke
      # Rake::Task['msip:restaura'].invoke
    end

    # test "stimulus_motores" do
    #  skip
    #  Rake::Task['msip:stimulus_motores'].invoke(directory: 'test/dummy')
    #  assert Dir.exist?("app/javascript/controllers/msip")
    #  FileUtils.rm_f "app/javascript/controllers/msip"
    # end
  end
end
