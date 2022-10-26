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
  s.description = "Motor para Rails que le facilita construir su sistema de información."
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

  # Dejamos gemas representativas, el listado completo en Gemfile
  s.add_runtime_dependency "cancancan", '~> 3'
  s.add_runtime_dependency "devise", '~> 4'
  s.add_runtime_dependency "devise-i18n", '~> 1'
  s.add_runtime_dependency "kt-paperclip", '~> 7'
  s.add_runtime_dependency "pg", '~> 1'
  s.add_runtime_dependency "rails", '~> 7.0'
  s.add_runtime_dependency "rails-i18n", '~> 7'
  s.add_runtime_dependency "sassc-rails", '~> 2'
  s.add_runtime_dependency "simple_form", '~> 5'
  s.add_runtime_dependency "sprockets-rails", '~> 3'
  s.add_runtime_dependency "stimulus-rails", '~> 1'
  s.add_runtime_dependency "twitter_cldr", '~> 6'
  s.add_runtime_dependency "will_paginate", '~> 3'

  s.add_development_dependency "minitest", '~> 5'
  s.add_development_dependency "cuprite", '~> 0'

end
