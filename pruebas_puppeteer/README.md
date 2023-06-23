
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

    yarn add dotenv puppeteer-core https://gitpkg.now.sh/pasosdeJesus/msip/pruebas_puppeteer?main

Después ponga sus pruebas con puppeteer en ese directorio (por ejemplo las 
puede crear con la Grabadora de versiones recientes de Chrome), tipicamente
con extensión .mjs y después modifique el comienzo de cada prueba para 
quitarle la autenticación con máquina, puerto, usuario y clave fijas por 
lo siguiente que empleará variables de ambiente:

    import * as fs from "fs";
    import puppeteer from "puppeteer-core"
    import {
      changeSelectElement,
      changeElementValue,
      prepararYAutenticarDeAmbiente,
      querySelectorsAll,
      querySelectorAll,
      scrollIntoViewIfNeeded,
      typeIntoElement,
      waitForConnected,
      waitForElement,
      waitForInViewport,
      waitForSelector,
      waitForSelectors,
      waitForFunction,
    } from "@pasosdeJesus/pruebas_puppeteer";
    
    
    (async () => {
    
      let timeout = 5000;
      let urlini, browser, page;
      [urlini, browser, page] = await prepararYAutenticarDeAmbiente(timeout);

      // Dejar aquí las pruebas producidas por Grabadora para puppeteer
    
      await browser.close();
    
    })().catch(err => {
      console.error(err);
      process.exit(1);
    });


Las variables de ambiente que emplea son:

* IPDES  Con IP o nombre de la máquina
* PUERTODES Con puerto por emplear
* USUARIO_ADMIN_PRUEBA  Usuario administrador de prueba
* CLAVE_ADMIN_PRUEBA Clave del usuario administrador de prueba

Se recomienda agregarlas en `../../.env`  (si las define en otro
archivo puede especificarlo cambiando:

      [urlini, browser, page] = await prepararYAutenticarDeAmbiente(
        timeout, '../.env'
      );

Por omisión se ejecutar la prueba en un navegador sin cabeza (headless) con:

    node prueba.mjs

Si prefiere ejecutarla
    CONCABEZA=1 node prueba.mjs
