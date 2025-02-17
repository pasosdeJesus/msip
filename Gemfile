# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# No usamos gemspec porque la aplicacón de prueba de un motor rails
# no lo soporta.

ruby ">= 3.3.3"

gem "bootsnap", ">= 1.4.4", require: false

gem "cancancan", "~> 3.4" # Control de acceso

gem "devise" # Autenticación

gem "devise-i18n"               # Localización e Internacionalización

gem "jbuilder", ">= 2.7"        # Json

gem "jsbundling-rails"

gem "kt-paperclip",             # Anexos
  git: "https://github.com/kreeti/kt-paperclip.git"
# git: 'https://github.com/vtamara/paperclip.git', branch: 'fix-ruby3'
# path: '../tmp/paperclip'

gem "nokogiri", ">=1.11.1"

gem "pg" # PostgreSQL

gem "puma" # Lanza en modo desarrollo

gem "rails", ">= 7.2", "< 7.3"
# git: 'https://github.com/rails/rails.git', branch: '6-1-stable'

gem "rails-i18n", "~> 7.0"      # Localización e Internacionalización

gem "sassc-rails", "~> 2.1"     # Conversión a CSS

gem "simple_form", "~> 5.1"     # Formularios

gem "sprockets-rails"

gem "stimulus-rails"            # Controladores en javascript

gem "turbo-rails", "~> 1.0"

gem "twitter_cldr", "~> 6.11"   # Localiación e internacionalización

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
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "connection_pool"

  gem "minitest", "~> 5.16"

  gem "minitest-reporters"

  gem "rails-controller-testing"

  gem "simplecov"

  gem "spork" # Un proceso para cada prueba -- acelera
end
