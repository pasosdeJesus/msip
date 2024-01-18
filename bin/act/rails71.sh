#!/bin/sh

grep "rails.*>=* *7.1" Gemfile > /dev/null 2>&1
if (test -f Gemfile -a "$?" != "0") then {
  cp Gemfile Gemfile.ant
  ed Gemfile <<EOF
/gem *.rails. *, *.>= 7.0.*
d
i
  gem "rack", "~> 2"

  gem "rails", ">= 7.1", "<7.2"
.
w
q
EOF
  echo "Cambiado Gemfile"
  bundle
  bundle update
  bundle
} fi;


grep "fontawesome-free.: .^5.1" package.json > /dev/null 2>&1
if (test "$?" = "0") then {
  cp package.json package.json.ant
  cat package.json.ant |\
    sed -e "s/fontawesome-free\": \"^5.1[0-9.]*/fontawesome-free\": \"^6.4.2/g" |\
    sed -e "s/stimulus\": \"^3.0.1/stimulus\": \"^3.2.2/g" |\
    sed -e "s/turbo-rails\": \"^7.1.0/turbo-rails\": \"^7.3.0/g" |\
    sed -e "s/popperjs\/core\": \"^2.9.1/popperjs\/core\": \"^2.11.8/g" |\
    sed -e "s/@rails\/ujs\": \"^7.0.1/@rails\/ujs\": \"^7.1.1/g" |\
    sed -e "s/bootstrap\": \"^5.1.0/bootstrap\": \"^5.3.2/g" |\
    sed -e "s/bootstrap-datepicker\": \"^1.9.0/bootstrap-datepicker\": \"^1.10.0/g" |\
    sed -e "s/esbuild\": \"^0.14.[0-9]*/esbuild\": \"^0.19.4/g" |\
    sed -e "s/esbuild-des.config.js/esbuild-des.config.mjs/g" |\
    sed -e "s/jquery\": \"^3.6.0/jquery\": \"^3.7.1/g"  > package.json
  echo "Cambiado package.json"
  yarn
} fi;


  grep "rails/all" config/application.rb > /dev/null 2>&1
  if (test "$?" = "0") then {
    cp config/application.rb config/application.rb.ant
    ed config/application.rb <<EOF
/require.*rails.all
d
i
require "rails"
# Elige los marcos de trabajo que necesitas:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

.
w
q
EOF
    ed config/application.rb <<EOF
/config.load_defaults 7.0
d
i
config.load_defaults Rails::VERSION::STRING.to_f

config.autoload_lib(ignore: %w(assets tasks))

.
w
q
EOF
  echo "Cambiado config/application.rb"
  ruby -c config/application.rb
} fi;


grep "active_storage" config/environments/development.rb > /dev/null 2>&1
if (test "$?" = "0") then {
  cp ~/comp/rails/msip/test/dummy/config/environments/* config/environments
  echo "Cambiados config/environments/*"
  ruby -c config/environments/*.rb
} fi;

if (test -f .env) then {
  . ./.env
  if (test "$RUTA_RELATIVA" != "/") then {

    if (test ! -d public/assets) then {
      grep "RUTA_RELATIVA" config.ru > /dev/null 2>&1
      if (test "$?" != "0" -a -f config.ru) then {
        cp ~/comp/rails/msip/test/dummy/config.ru config.ru
        echo "Cambiado config.ru"
        ruby -c config.ru
      } fi;

      grep "^  scope rutarel do" config/routes.rb > /dev/null 2>&1 
      if (test "$?" = "0") then {
        cp config/routes.rb config/routes.rb.ant
        echo "Quitando scope de config/routes.rb"
        cat config/routes.rb.ant |\
          sed -e "s/rutarel=.*//g" |\
          sed -e "s/^  scope rutarel do//g" |\
          sed -e "s/^  end//" |\
          sed -e "s/: rutarel,/: \"\/\",/g" > config/routes.rb
        ruby -c config/routes.rb
      } fi;
  
      if (test -f esbuild-des.config.js) then {
        git mv esbuild-des.config.js esbuild-des.config.mjs
        cp ~/comp/rails/msip/test/dummy/esbuild-des.config.mjs .
        echo "Cambiado esbuild-des.config.mjs"
        node -c esbuild-des.config.mjs
      } fi;
  
      echo "Creando public/assets"
      (cd public; doas ln -sf $RUTA_RELATIVA/assets .)
      ls -l public/assets/
      g add public/assets
    } fi;
  } fi;
