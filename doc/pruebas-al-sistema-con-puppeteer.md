# Correr pruebas del sistema con puppeteer en aplicaciones basadas en msip

Las pruebas al sistema con pupeeteer requieren una aplicación de prueba o de
ensayo corriendo y usable con un navegador desde el computador donde hace
las pruebas.

Es posible correr la aplicación en en el mismo computador donde corre las
pruebas puppeteer --siempre y cuando haya configurado el ambiente Ruby 
on Rails, PostgreSQL y la base de datos para que opere la aplicación.

En tal caso desde el directorio de la aplicación ejecute:
```sh
bin/pruebasjs
```

Sin embargo, si prefiere usar un sistema de ensayo/prueba corriendo en otro
computador (digamos `pruebas.miservidor.org` en puerto `4300`) puede ejecutar 
las diversas pruebas con:

```sh
IPDES=pruebas.miservidor.org PUERTODES=4300 bin/pruebasjs
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
(. ./.env; CONCABEZA=1; IPDES=pruebas.miservidor.org; PUERTODES=4300; \
 node test/puppeteer/msip-003-tb-departamentos.mjs )
```

Para detener la ejecución y usar un depurador visual como se explica en
Chrome Developers 2022, agregue `debugger` en la parte de la prueba donde 
desea detenerla y ejecute con `--inspect-brk`

``` 
(. ./.env; CONCABEZA=1; IPDES=pruebas.miservidor.org; PUERTODES=4300; \
 node --inspect-brk test/puppeteer/msip-003-tb-departamentos.mjs )
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
