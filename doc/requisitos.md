# Requisitos

* Recomendamos emplear la distribución adJ 7.2 del sistema operativo OpenBSD,
  que ya incluye configurada la pila de software que presentamos a 
  continuación.
  Puedes consultar sobre el uso de Ruby on Rails en adJ en
  <http://pasosdejesus.github.io/usuario_adJ/conf-programas.html#ruby>
* Ruby versión >= 3.1.2
* Ruby on Rails >= 7.0.4 (la instalas con `gem install rails`)
* PostgreSQL >= 14.5 con extensión `unaccent` disponible y posibilidad
  de crearle un usuario con permisos para crear bases de datos
* `node.js` >= 16.7.1 y `coffescript` instalado globalmente 
  (i.e.  `doas npm install -g coffee-script`)
* Una cuenta en el sistema operativo para desarrollo, esta cuenta 
  debe tener permiso de usar al menos 1024M en RAM y para abrir al menos 
  2048 archivos.  
  Para asegurarlo, en adJ como superusuario pon un valor alto al 
  máximo de archivos que el kernel puede abrir
  simularlestaneamente en la variable de configuración `kern.maxfiles`, por
  ejemplo 20000 en `/etc/sysctl.conf`, y en la clase de la cuenta de desarrollo
  (en `/etc/login.conf`) que al menos diga
  `:datasize-cur=1024M:` y  `:openfiles-cur=2048:`
* `yarn` instalado globalmente
  ```
  doas npm install -g yarn
  ```
* Gema `dotenv` instalada globalmente i.e `doas gem install dotenv`
* Gema `foreman` instalada globalmente i.e `doas gem install foreman`
* Gema `rails` instalada globalmente i.e `doas gem install rails`
* Recomendado usar `bundler` para mantener gemas en un
  directorio de la forma `/var/www/bundler-miusuario`, ejecutando:
  ```
  doas mkdir /var/www/bundler-miusuaro
  doas chown $USER:www /var/www/bundler-miusuaro
  bundle config path /var/www/bundler-miusuario/
  ```
  o asegurando que el archivo ~/.bundle/config contiene:
  ```
  ---
  BUNDLE_PATH: "/var/www/bundler-miusuario/"
  ```
* Recomendamos emplear zsh, tmux y neovim con los archivos de configuración
  e instrucciones disponibles en
  <https://github.com/pasosdeJesus/adJ/tree/master/arboldd/usr/local/share/adJ/archconf>



