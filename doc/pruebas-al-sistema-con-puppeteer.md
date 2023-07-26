
# Correr pruebas del sistema con puppeteer en aplicaciones basadas en msip

Las pruebas al sistema con pupeeteer requieren una aplicación de prueba o de
ensayo corriendo y usable con un navegador desde el computador donde hace
las pruebas.

Es posible correr la aplicación en en el mismo computador donde corre las
pruebas puppeteer --siempre y cuando haya configurado el ambiente Ruby 
on Rails, PostgreSQL y la base de datos para que opere la aplicación.

En tal caso ejecute:
bin/pruebasjs


Pero si prefiere usar un sistema de ensayo/prueba corriendo en otro
computador puede ejecutar las diversas pruebas con:

```sh
IPDES=pruebas.miservidor.org PUERTODES=4300 bin/pruebasjs
```

Esto supone que el usuario y la clave de autenticación como administrador
se ha definido en el archivo .env en las variables `USUARIO_ADMIN_PRUEBA` y
`CLAVE_ADMIN_PRUEBA`.


# Depurar

Las pruebas típicamente corren en un navegador sin cabeza, es decir que 
corre en el computador pero desconectado del vídeo, el teclado y el 
ratón es decir sólo en memoria.

La herramienta más visual para depurar las pruebas es ejecutarlas
en un navegador con cabeza, es decir que presente en pantalla lo que hace
y que permita interacción con teclado y ratón (además de lo que
emule la prueba).

Para esto ejecute de la misma manera explicada en la sección anterior pero
agregando la variable de ambiente CONCABEZA=1 por ejemplo:

```sh
CONCABEZA=1 IPDES=pruebas.miservidor.org PUERTODES=4300 bin/pruebasjs
```


# Referencias

* 2022. Vladimir Támara. Investigando como hacer pruebas del sistema para una aplicación rails con puppeteer. <https://gitlab.com/pasosdeJesus/msip/-/wikis/Investigando-como-hacer-pruebas-del-sistema-para-una-aplicaci%C3%B3n-rails-con-puppeteer>

