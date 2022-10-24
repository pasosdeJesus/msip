$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "msip/version"

Gem::Specification.new do |s|
  s.name        = "msip"
  s.version     = Msip::VERSION
  s.authors     = ["Vladimir Támara Patiño"]
  s.email       = ["vtamara@pasosdeJesus.org"]
  s.homepage    = "http://gitlab.com/pasosdeJesus/msip.git"
  s.summary     = "Motor para Sistemas de Información estilo Pasos de Jesús"
  s.description = "Motor para construir su propio sistema de información."
  s.license     = "ISC"

  s.files = Dir['{app,config,db,lib}/**/*.rb'] + Dir['bin/*']
  s.files += Dir['[A-Z]*']

  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency "rails"
  s.add_runtime_dependency "rails-i18n"
  s.add_runtime_dependency "coffee-rails"
  s.add_runtime_dependency "sassc-rails"
  s.add_runtime_dependency "devise"
  s.add_runtime_dependency "devise-i18n"
  s.add_runtime_dependency "kt-paperclip"
  s.add_runtime_dependency "cancancan"
  s.add_runtime_dependency "simple_form"
  s.add_runtime_dependency "twitter_cldr"

  s.add_runtime_dependency "minitest"

  s.add_development_dependency "capybara"

end
