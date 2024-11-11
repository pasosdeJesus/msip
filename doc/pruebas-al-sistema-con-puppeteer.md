# Pruebas al sistema o fin a fin con puppeteer en aplicaciones basadas en msip y rails

Las pruebas del sistema con mintest/capybara/ferrum han sido descartadas por los desarrolladores principales de rails (ver <https://world.hey.com/dhh/system-tests-have-failed-d90af718>) 

Por los problemas mencionados en el artículo citado, hace unos años veniamos experimentando pruebas al sistema o fin a fin con puppeteer y consideramos que siguen valiendo la pena respecto a mantenerlas por cuanto las fallas no han sido tan complejas de manejar (aún ante cambios en navegador y puppeteer) y porque la mayoría de la descripción de una prueba puede hacerse en un lenguaje cada vez más simple y menos fluctuante.

Como ilustramos en <https://github.com/rails/rails/issues/49688> desde rails 7.1 el ambiente de prueba usado por minitest es bastante diferente al de desarrollo y al de producción por ejemplo en:

| Aspecto | Pruebas | Desarrollo | Producción |
|---|---|---|---|
| Variable de .env con base de datos | `BD_PRUEBA` | `BD_DES` | `BD_PRO` |
| CONFIG_HOSTS | Debe ser `www.example.com` | Configurable |  Configurable |
| Uso de racc | No | Si | Si |
| Punto de montaje | / | Configurable en `RUTA_RELATIVA` | Configurable en `RUTA_RELATIVA` |

Aunque las pruebas típicamente corren en un navegador sin cabeza (del inglés 
_headless_), es decir que el navegador se ejecuta en la CPU y la memoria 
del computador pero desconectado del vídeo, del teclado y del ratón, por lo menos 
en adJ 7.5 que incluye chromium 122.06261.111 no opera el modo headless
(ver <https://gitlab.com/pasosdeJesus/adJ/-/issues/15>),
por lo que con adJ es necesario correr las pruebas en un navegador que corra 
localmente, aunque el sistema que se prueba pueda correr en un servidor remoto.

## Ejecutar todas las pruebas 

Para lanzar una aplicación de prueba localmente en el puerto `$PUERTOPRU` (definido en `.env`) 
y ejecutar las pruebas localmente:
```sh
bin/pruebasjs.sh
```

Sin embargo, si prefiere usar un sistema de ensayo/prueba corriendo en otro
computador (digamos `pruebas.miservidor.org` en puerto `4300`) puede ejecutar 
las diversas pruebas con:

```sh
IPDES=pruebas.miservidor.org PUERTOPRU=4300 bin/pruebasjs.sh
```

Esto supone que el usuario y la clave de autenticación como administrador
las ha definido en el archivo .env en las variables `USUARIO_ADMIN_PRUEBA` y
`CLAVE_ADMIN_PRUEBA`.


## Ejecución de una sola prueba

Suponiendo que correrá las pruebas desde su computador personal pero empleará un
sistema de desarrollo corriendo en un servidor remoto, digamos  `desarrollo.miservidor.org` en el puerto `4300` en su computador clone las fuentes de msip y 

```sh
cd tests/dummy/tests/puppeteer
yarn
```

Despues ejecute una sólo prueba en modo sin cabeza con:
``` 
RUTA_RELATIVA=/msip_2_2 IPDES=pruebas.miservidor.org PUERTODES=4300 node msip-001-Iniciar-sesión.mjs
```


Es posible correr la aplicación en en el mismo computador donde corre las
pruebas puppeteer --siempre y cuando haya configurado el ambiente Ruby 
on Rails, PostgreSQL y la base de datos para que opere la aplicación.

## Depurar una prueba

Para esto ejecute de la misma manera explicada en la sección anterior pero
agregando la variable de ambiente `CONCABEZA=1` por ejemplo:

```sh
CONCABEZA=1 IPDES=pruebas.miservidor.org PUERTODES=4300 bin/pruebasjs
```

Para depurar sólo una prueba exporte las variables de ambiente, cargue 
el archivo `.env` y use `node` para cargar la prueba
(`msip-003-tb-departamentos.mjs` en el siguiente ejemplo):

``` 
RUTA_RELATIVA=/msip_2_2 CONCABEZA=1 IPDES=pruebas.miservidor.org PUERTODES=4300 \
 node test/puppeteer/msip-003-tb-departamentos.mjs
```

Para detener la ejecución y usar un depurador visual como se explica en
Chrome Developers 2022, agregue `debugger` en la parte de la prueba donde 
desea detenerla y ejecute con `--inspect-brk`
  
``` 
RUTA_RELATIVA=/msip_2_2 CONCABEZA=1 IPDES=pruebas.miservidor.org PUERTODES=4300 \
 node --inspect-brk test/puppeteer/msip-003-tb-departamentos.mjs
```

Después en su navegador abra <chrome://inspect/#devices> donde
verá el archivo que está corriendo con un enlace `Inspect` que
debe presionar.  Al hacerlo se abrirá una consola de DevTools conectada
a la ejecución de la prueba. Continúe en este la ejecución y notará que
se detiene en la instrucción debugger y podrá usar esta herramienta
como típicamente se usa para revisar el estado o poner puntos de ruptura.


## Crear una prueba

Abra en el navegador la aplicación, pase la autenticación,
abra el inspector (DevTools) elija Grabadora y comience a grabar
una tarea típica. En general como parte de la misma tarea elimina la información
que agregue.


Una vez concluya la tarea típica detenga la grabación y exportela en formato @puppeteer/replay.

Edite el archivo generado y elimine del comienzo:
```
import url from 'url';
import { createRunner } from '@puppeteer/replay';

export async function run(extension) {
    const runner = await createRunner(extension);

    await runner.runBeforeAllSteps();

    await runner.runStep({
        type: 'setViewport',
        width: 1263,
        height: 529,
        deviceScaleFactor: 1,
        isMobile: false,
        hasTouch: false,
        isLandscape: false
    });
    await runner.runStep({
        type: 'navigate',
        url: 'http://servidor.org:4300/msip_2_2/admin/estadossol',
        assertedEvents: [
            {
                type: 'navigation',
                url: 'http://servidor.org:4300/msip_2_2/admin/estadossol',
                title: 'msip 2.2.0.beta6'
            }
        ]
    });

```
y agregue al comienzo:
```
import {
  preparar,
  prepararYAutenticarDeAmbiente,
  terminar
} from "@pasosdeJesus/pruebas_puppeteer"

(async () => {

  const tiempoini = performance.now()

  let timeout = 15000
  let urlini, runner, browser, page
  [urlini, runner, browser, page] = await prepararYAutenticarDeAmbiente(timeout, preparar)
```

Al final de la prueba cambie
```
    await runner.runAfterAllSteps();
}

if (process && import.meta.url === url.pathToFileURL(process.argv[1]).href) {
    run()
}
```
Por
``` 
  await terminar(runner)

  const tiempofin = performance.now();
  console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`);
})().catch(err => {
  console.error(err);
  process.exit(1);
});
```

Si la prueba tiene dialogos de confirmación por ejemplo para eliminar, agregue un evento antes como se ejemplifica a continuación:

```
  
  page.on('dialog', async dialog => {
    console.log(dialog.message())
    await dialog.accept(); //o dismiss()
  })

  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Eliminar'
      ],
      [
        'a.btn-danger'
      ],
      [
        'xpath///*[@id="div_contenido"]/div[4]/a[3]'
      ],
      [
        'pierce/a.btn-danger'
      ],
      [
        'text/Eliminar'
      ]
    ],
    offsetY: 30,
    offsetX: 40.75,
  });
```


# Referencias

* 2022. Vladimir Támara. Investigando como hacer pruebas del sistema para una aplicación rails con puppeteer. <https://gitlab.com/pasosdeJesus/msip/-/wikis/Investigando-como-hacer-pruebas-del-sistema-para-una-aplicaci%C3%B3n-rails-con-puppeteer>

* 2018-2022. Chrome Developers. Debugging Puppeteer. <https://developer.chrome.com/docs/puppeteer/debugging/#use-debugger-in-nodejs>
