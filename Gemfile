# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# No usamos gemspec porque la aplicacón de prueba de un motor rails
# no lo soporta.

ruby ">= 3.4"

gem "bcrypt"

gem "bootsnap"

gem "cancancan"

gem "cssbundling-rails"

gem "devise"

gem "devise-i18n"

gem "jbuilder"

gem "jsbundling-rails"

gem "kt-paperclip",             # Anexos
  git: "https://github.com/kreeti/kt-paperclip.git"
# git: 'https://github.com/vtamara/paperclip.git', branch: 'fix-ruby3'
# path: '../tmp/paperclip'

gem "nokogiri"

gem "pg" # PostgreSQL

gem "propshaft"

gem "puma" # Lanza en modo desarrollo

gem "rails", "~> 8.0"
# git: 'https://github.com/rails/rails.git', branch: '6-1-stable'

gem "rails-i18n"      # Localización e Internacionalización

gem "rorvswild"

gem "simple_form"     # Formularios

gem "stimulus-rails"            # Controladores en javascript

gem "turbo-rails"

gem "twitter_cldr"   # Localiación e internacionalización

gem "tzinfo"                    # Zonas horarias

gem "will_paginate"             # Pagina listados

group :development, :test do
  gem "brakeman"

  gem "bundler-audit"

  gem "code-scanning-rubocop"

  gem "colorize"

  gem "debug"

  gem "dotenv-rails"

  gem "rails-erd"

  gem "rubocop-minitest"

  gem "rubocop-rails"

  gem "rubocop-shopify"

  gem "yard"
end

group :development do
  gem "web-console"
end

group :test do
  gem "minitest"

  gem "minitest-reporters"

  gem "rails-controller-testing"

  gem "simplecov"
end
