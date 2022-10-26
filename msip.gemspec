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

  s.files = Dir['[A-Z]*'] +
    Dir['app/assets/**/*'] +
    Dir['app/controllers/**/*rb'] +
    Dir['app/helpers/**/*rb'] +
    Dir['app/javascript/**/*'] +
    Dir['app/mailers/**/*rb'] +
    Dir['app/models/**/*rb'] +
    Dir['app/views/**/*rb'] +
    Dir['bin/*'] +
    Dir['config/**/*rb'] +
    Dir['config/**/*yml'] +
    Dir['db/**/*rb'] +
    Dir['db/**/*sql'] +
    Dir['desarrollo/**/*'] +
    Dir['doc/**/*md'] +
    Dir['lib/**/*rb'] +
    Dir['lib/**/*rake'] 

  s.test_files = Dir["test/**/*.rb"] + 
    Dir["test/**/*plantilla"] + 
    Dir["test/dummy/*"] + 
    Dir["test/dummy/app/assets/config/*"] + 
    Dir["test/dummy/app/assets/images/*"] + 
    Dir["test/dummy/app/assets/javascripts/*"] + 
    Dir["test/dummy/app/assets/stylesheets/*"] + 
    Dir["test/dummy/app/javascript/*"] + 
    Dir["test/dummy/app/javascript/controllers/*"] + 
    Dir["test/dummy/app/views/**/*rb"] + 
    Dir["test/dummy/bin/*"] + 
    Dir["test/dummy/config/**/*"] + 
    Dir["test/dummy/db/*"] + 
    Dir["test/dummy/public/*"] + 
    Dir["test/dummy/public/msip/*html"] + 
    Dir["test/dummy/public/msip/*ico"] + 
    Dir["test/dummy/test/**/*rb"] 

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
