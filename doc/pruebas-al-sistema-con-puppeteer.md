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

Por esto para las pruebas al sistema con pupeeteer recomendamos y preferimos una aplicación en modo desarrollo corriendo y usable con un navegador bien desde el computador donde hace
las pruebas o bien uno remoto.

## Ejecución de una sola prueba

Las pruebas típicamente corren en un navegador sin cabeza (del inglés 
_headless_), es decir que el navegador se ejecuta en la CPU y la memoria 
del computador pero desconectado del vídeo, del teclado y del ratón.

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

## Ejecuar una sóla prueba



La primera herramienta (además visual) para depurar las pruebas es ejecutarlas
en un navegador con cabeza, es decir que presente en pantalla lo que hace
y que permita la interacción con el teclado y el ratón (además de lo que
haga la prueba).

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

En tal caso desde el directorio de la aplicación ejecute:
```sh
bin/pruebasjs.sh
```

Sin embargo, si prefiere usar un sistema de ensayo/prueba corriendo en otro
computador (digamos `pruebas.miservidor.org` en puerto `4300`) puede ejecutar 
las diversas pruebas con:

```sh
IPDES=pruebas.miservidor.org PUERTODES=4300 bin/pruebasjs.sh
```

Esto supone que el usuario y la clave de autenticación como administrador
las ha definido en el archivo .env en las variables `USUARIO_ADMIN_PRUEBA` y
`CLAVE_ADMIN_PRUEBA`.


# Depurar

Las pruebas típicamente corren en un navegador sin cabeza (del inglés 
_headless_), es decir que el navegador se ejecuta en la CPU y la memoria 
del computador pero desconectado del vídeo, del teclado y del ratón.

La primera herramienta (además visual) para depurar las pruebas es ejecutarlas
en un navegador con cabeza, es decir que presente en pantalla lo que hace
y que permita la interacción con el teclado y el ratón (además de lo que
haga la prueba).

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

# Referencias

* 2022. Vladimir Támara. Investigando como hacer pruebas del sistema para una aplicación rails con puppeteer. <https://gitlab.com/pasosdeJesus/msip/-/wikis/Investigando-como-hacer-pruebas-del-sistema-para-una-aplicaci%C3%B3n-rails-con-puppeteer>

* 2018-2022. Chrome Developers. Debugging Puppeteer. <https://developer.chrome.com/docs/puppeteer/debugging/#use-debugger-in-nodejs>
