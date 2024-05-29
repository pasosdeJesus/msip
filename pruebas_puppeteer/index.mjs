import fs from "fs";
import dotenv from "dotenv";
import puppeteer from "puppeteer-core";
import {
  PuppeteerRunnerOwningBrowserExtension,
  Runner
} from "@puppeteer/replay";


// Adaptando de createPuppeteerRunnerOwningBrowserExtension de @puppeteer/replay

export async function preparar(timeout = 5000, rutainicial = '/msip') {
  let maq = "http://127.0.0.1:33001";
  if (typeof process.env.IPDES != "undefined" && 
    typeof process.env.PUERTODES != "undefined") {
    maq = "http://" + process.env.IPDES + ":" + process.env.PUERTODES;
  }
  //console.log("maq=", maq);
  let sincabeza = 'new';
  if (typeof process.env.CONCABEZA != "undefined") {
    sincabeza = false;
  }
  //console.log("sincabeza=", sincabeza);
  let browser = null;
  if (typeof process.env.CI == "string") {
    console.log("Esta función no opera en gitlab");
    exit(1);
  } else {
    if (fs.existsSync("/usr/local/bin/chrome")) {
      console.log("Corriendo en OpenBSD")
      browser = await puppeteer.launch({
        executablePath: '/usr/local/bin/chrome',
        defaultViewport: { width: 1240, height: 800},
        headless: sincabeza 
      });
    } else if (fs.existsSync("/usr/bin/chromium-browser")) {
      browser = await puppeteer.launch({
        executablePath: '/usr/bin/chromium-browser',
        defaultViewport: { width: 1240, height: 800},
        headless: sincabeza,
        devtools: true
      });
    } else if (fs.existsSync("/bin/chromium-browser")) {
      browser = await puppeteer.launch({
        executablePath: '/bin/chromium-browser',
        defaultViewport: { width: 1240, height: 800},
        headless: sincabeza,
        devtools: true
      });
    } else {
      throw "No se encontró navegador";
    }
  }
  //console.log("browser=", browser);

  const page = await browser.newPage();

  page.setDefaultTimeout(timeout);
  {
    const targetPage = page;
    await targetPage.setViewport({
      width: 1292,
      height: 636
    })
  }
  {
    const targetPage = page;
    const promises = [];
    promises.push(targetPage.waitForNavigation());
    await targetPage.goto(maq + rutainicial);
    await Promise.all(promises);
  }
  
  //console.log("page=", page);

  const runner = new Runner(new PuppeteerRunnerOwningBrowserExtension(browser, page));
  //console.log("maq=", maq);
  //console.log("runner=", runner);
  return [maq, runner];

}

//    const runner = await createRunner(extension);
//    await runner.runStep({
//        type: 'navigate',
//        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2',
//        assertedEvents: [
//            {
//                type: 'navigation',
//                url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2',
//                title: 'msip 2.2.0.beta6'
//            }
//        ]
//    });


export async function terminar(runner) {
  await runner.runAfterAllSteps()
}

export async function autenticar(runner, timeout, usuario, clave) {

    await runner.runBeforeAllSteps();

    await runner.runStep({
        type: 'setViewport',
        width: 1206,
        height: 569,
        deviceScaleFactor: 1,
        isMobile: false,
        hasTouch: false,
        isLandscape: false
    });
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Iniciar Sesión'
            ],
            [
                'li:nth-of-type(3) > a'
            ],
            [
                'xpath///*[@id="navbarSupportedContent"]/ul[2]/li[3]/a'
            ],
            [
                'pierce/li:nth-of-type(3) > a'
            ],
            [
                'text/Iniciar Sesión'
            ]
        ],
        offsetY: 16,
        offsetX: 68.03125
    });
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Usuario'
            ],
            [
                '#usuario_nusuario'
            ],
            [
                'xpath///*[@id="usuario_nusuario"]'
            ],
            [
                'pierce/#usuario_nusuario'
            ]
        ],
        offsetY: 29.609375,
        offsetX: 252
    });
    await runner.runStep({
        type: 'change',
        value: 'msip',
        selectors: [
            [
                'aria/Usuario'
            ],
            [
                '#usuario_nusuario'
            ],
            [
                'xpath///*[@id="usuario_nusuario"]'
            ],
            [
                'pierce/#usuario_nusuario'
            ]
        ],
        target: 'main'
    });
    await runner.runStep({
        type: 'keyDown',
        target: 'main',
        key: 'Tab'
    });
    await runner.runStep({
        type: 'keyUp',
        key: 'Tab',
        target: 'main'
    });
    await runner.runStep({
        type: 'change',
        value: 'msip',
        selectors: [
            [
                'aria/Clave'
            ],
            [
                '#usuario_password'
            ],
            [
                'xpath///*[@id="usuario_password"]'
            ],
            [
                'pierce/#usuario_password'
            ]
        ],
        target: 'main'
    });
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Iniciar Sesión[role="button"]'
            ],
            [
                'div.form-actions > input'
            ],
            [
                'xpath///*[@id="new_usuario"]/div[2]/input'
            ],
            [
                'pierce/div.form-actions > input'
            ]
        ],
        offsetY: 18.609375,
        offsetX: 63,
        assertedEvents: [
            {
                type: 'navigation',
                url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/',
                title: ''
            }
        ]
    });

    await runner.runAfterAllSteps();
}


export async function prepararYAutenticarDeAmbiente(timeout = 5000, 
  funcionPreparar, rutaAmbiente = '../../.env') {
  dotenv.config({ path: rutaAmbiente });
  const rutaRelativa = typeof process != "undefined" &&
    typeof process.env.RUTA_RELATIVA != "undefined" ?
    process.env.RUTA_RELATIVA : '/msip';
  const usuarioAdminPrueba = typeof process != "undefined" &&
    typeof process.env.USUARIO_ADMIN_PRUEBA != "undefined" ?
    process.env.USUARIO_ADMIN_PRUEBA : 'msip';
  const claveAdminPrueba = typeof process != "undefined" &&
    typeof process.env.CLAVE_ADMIN_PRUEBA != "undefined" ?
    process.env.CLAVE_ADMIN_PRUEBA : 'msip';

  let urlini, runner;
  //Si se ejecuta el siguiente falla: console.log("rutaRelativa=", rutaRelativa)
  [urlini, runner] = await funcionPreparar(timeout, rutaRelativa);
  //console.log("urlini=", urlini)
 
  //console.log("usuarioAdminPrueba=", usuarioAdminPrueba)
  await autenticar(runner, usuarioAdminPrueba, claveAdminPrueba);
  return [urlini, runner];
}
 


