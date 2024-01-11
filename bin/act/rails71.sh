#!/bin/sh

grep "fontawesome-free.: .^5.11.2" package.json > /dev/null 2>&1
if (test "$?" = "0") then {
  cp package.json package.json.ant
  cat package.json.ant |\
    sed -e "s/fontawesome-free\": \"^5.11.2/fontawesome-free\": \"^6.4.2/g" |\
    sed -e "s/stimulus\": \"^3.0.1/stimulus\": \"^3.2.2/g" |\
    sed -e "s/turbo-rails\": \"^7.1.0/turbo-rails\": \"^7.3.0/g" |\
    sed -e "s/popperjs\/core\": \"^2.9.1/popperjs\/core\": \"^2.11.8/g" |\
    sed -e "s/@rails\/ujs\": \"^7.0.1/@rails\/ujs\": \"^7.1.1/g" |\
    sed -e "s/bootstrap\": \"^5.1.0/bootstrap\": \"^5.3.2/g" |\
    sed -e "s/bootstrap-datepicker\": \"^1.9.0/bootstrap-datepicker\": \"^1.10.0/g" |\
    sed -e "s/esbuild\": \"^0.14.1/esbuild\": \"^0.19.4/g" |\
    sed -e "s/jquery\": \"^3.6.0/jquery\": \"^3.7.1/g"  > package.json
  echo "Cambiado package.json"
} fi;


  grep "rails/all" config/application.rb > /dev/null 2>&1
  if (test "$?" = "0") then {
    cp config/application.rb config/application.rb.ant
    ed config/application.rb <<EOF
/require "rails/all
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
} fi;


grep "active_storage" config/environments/development.rb > /dev/null 2>&1
if (test "$?" = "0") then {
  cp ~/comp/rails/msip/test/dummy/config/environments/* config/environments
  echo "Cambiados config/environments/*"
} fi;

grep "RUTA_RELATIVA" config.ru > /dev/null 2>&1
if (test "$?" != "0" -a -f config.ru) then {
  cp ~/comp/rails/msip/test/dummy/config.ru config.ru
  echo "Cambiado config.ru"
} fi;

if (test -f esbuild-des.config.js) then {
  git mv esbuild-des.config.js esbuild-des.config.mjs
  cp ~/comp/rails/msip/test/dummy/esbuild-des.config.mjs .
  echo "Cambiado esbuild-des.config.mjs"
} fi;
