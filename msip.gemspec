# frozen_string_literal: true

require_relative "lib/msip/version"

Gem::Specification.new do |s|
  s.name        = "msip"
  s.version     = Msip::VERSION
  s.authors     = ["Vladimir Támara Patiño"]
  s.email       = ["vtamara@pasosdeJesus.org"]
  s.homepage    = "http://gitlab.com/pasosdeJesus/msip.git"
  s.summary     = "Motor para Sistemas de Información estilo Pasos de Jesús"
  s.description = "Motor para Rails que le facilita construir su sistema de información."
  s.license     = "ISC"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = s.homepage

  s.required_ruby_version = ">= 3"

  # s.files = Dir.chdir(__dir__) do %x(git ls-files -z).split("\x0").reject do |f| (f == __FILE__) || f.match(%r{\A(?:(?:spec|features)/|\.(?:git|travis|circleci)|appveyor)}) end end

  # Dejamos gemas representativas, el listado completo en Gemfile
  s.add_dependency("cancancan", "~> 3")
  s.add_dependency("devise", "~> 4")
  s.add_dependency("devise-i18n", "~> 1")
  s.add_dependency("kt-paperclip", "~> 7")
  s.add_dependency("pg", "~> 1")
  s.add_dependency("rails", "~> 8.0")
  s.add_dependency("rails-i18n", "~> 8")
  s.add_dependency("simple_form", "~> 5")
  s.add_dependency("stimulus-rails", "~> 1")
  s.add_dependency("twitter_cldr", "~> 6")
  s.add_dependency("will_paginate", "~> 4")

  s.add_development_dependency("minitest", "~> 5")
end
