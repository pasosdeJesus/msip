
# @pasosdeJesus/pruebas_puppeter

Este paquete consta de funciones auxiliares para facilitar hacer pruebas con 
puppeteer en motores y aplicaciones que usan msip

## Uso

Cree un directorio donde alojará las pruebas, por ejemplo si `test/dummy`
es directorio de la aplicación:

    cd test/dummy
    mkdir -p test/puppeteer
    cd test/puppeteer
    yarn init

    yarn add dotenv https://gitpkg.now.sh/pasosdeJesus/msip/pruebas_puppeteer?main

Después ponga sus pruebas para @puppeteer/replay modificadas
en ese directorio.  Ver el detalle de como usar y crear pruebas en
https://gitlab.com/pasosdeJesus/msip/-/blob/main/doc/pruebas-al-sistema-con-puppeteer.md

