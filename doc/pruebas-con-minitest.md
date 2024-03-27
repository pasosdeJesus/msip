# Pruebas con minitest

Se han implementado algunas pruebas con minitest a modelos, controladores, 
vistas, rutas y de integración.

* Sigue los mismos pasos para la creación de una aplicación de pruebas 
con **msip**, hasta la creación de la base de datos.  
Ver <https://gitlab.com/pasosdeJesus/msip/-/blob/main/doc/aplicacion-de-prueba.md?ref_type=heads>
* Crea una base de datos para pruebas:
  ``` sh
  cd test/dummy
  RAILS_ENV=test bin/rails db:drop db:setup db:migrate msip:indices
  ```
* Ejecuta las pruebas desde el directorio del motor con:
  ```sh
  cd ../..
  bin/rails test
  ```
* Si necesitas depurar pruebas,  en la prueba donde quieres iniciar la 
  depuración usa `debugger`.  
* Para ejecutar las pruebas de un solo archivo, por ejemplo las de 
  `test/models/usuario_test.rb` usa:
  ```
  bin/rails test test/models/usuario_test.rb
  ```
* Y para ejecutar una sola de las pruebas de un archivo usa el nombre del 
  archivo y el nombre de la prueba, por ejemplo:
  ```
  bin/rails test test/models/usuario_test.rb valido
  ```
* Al hacer una nueva prueba recuerda mantener el estado de la base de datos.
  Al iniciar la prueba queda como tras ejecutar:
  `RAILS_ENV=test bin/rails db:drop db:setup db:migrate msip:indices`
  Y cuando la prueba concluya debe quedar igual. 
  Es decir elimina los objetos que crees en la base de datos.

