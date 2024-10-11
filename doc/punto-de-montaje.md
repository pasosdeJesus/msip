# Personalización del punto de montaje

Es posible configurar `rack` para que tu aplicación quede en un punto de montaje diferente a `/`, por ejemplo `/miorg/miap`.  Sin embargo rails no podrá determinar la situación por lo que las pruebas tipicamente deberás hacerlas suponiendo que el punto de montaje es `/`.

Hasta rails 6.0 recomendabamos hacer esto con un `scope` en `config/routes.rb` pero desde rails 7 ya no es posible sino que debe usarse `rack`--ver como hacer el cambio y el contexto en [https://gitlab.com/pasosdeJesus/msip/-/wikis/2024_01%20Actualizaci%C3%B3n%20a%20msip%202.2.0.beta4]

Suponiendo que en tu archivo `.env` tienes la variable `RUTA_RELATIVA` don la ruta:

1. En `config/application.rb` agrega o manten un línea como la siguiente

       ```rb
       config.relative_url_root = ENV.fetch('RUTA_RELATIVA', '/msip')
       ```
   
   Asegura que no se inicializa `config.relative_url_root` en ningún otro archivo (e.g si antes 
   usabas para eso `config/initializers/punto_montaje.rb` quitalo de ahí), la siguiente orden no
   debería dar resultados:

   ```sh
   grep config.relative_url_root config/initializers
   ```

2. Modifica el archivo `config.ru`  para que sea rack el que analice el punto de montaje (para esto internamente usará la variable de encabezado HTTP `SCRIPT_NAME`):

    require_relative "config/environment"
    rutarel = Rails.application.config.relative_url_root || '/'
    if rutarel[0] != '/'
      rutarel = "/#{rutarel}"
    end
    map Rails.application.config.relative_url_root || '/' do
      run Rails.application
      Rails.application.load_server
    end 

3. Al final de tu archivo `config/routes.rb` agrega `msip` y otros motores que agreguen rutas a tu aplicación:
<pre>
mount Msip::Engine, at: '/', as: 'msip'
</pre>

4. Crea el directorio `public/miorg/miap` y mueva alli el contenido de `public`. En sitios de desarrollo los recursos sprockets se compilarán en `public/miorg/miap/assets` pero en  modo de desarrollo se requieren en `public/assets` por lo que puedes crear un enlace: `cd public; ln -sf public/miorg/miap/assets .`   También debes declarar ese directorio como la ruta de los recursos sprockets creando un archivo  ```config/initializers/punto_montaje.rb``` con:
<pre>
MiAp::Application.config.assets.prefix = '/miorg/miap/assets'
</pre>
Siendo `MiAp` el mismo nombre de aplicación que hayas usado en `config/application.rb`.
  
5. Los sistemas en producción que usan nginx y unicorn 6.1.0 operan bien. Sin embargo al momento de este escrito unicorn no ha publicado una nueva versión que soporte rack 3 (y tiene listo el soporte en repositorio con fuentes pero no ha publicado nueva versión), por eso la solución más simple es usar rack 2 (dejando en el `Gemfile` la línea `gem "rack", "~> 2"` mientras `unicorn` publica nueva versión, de no hacerlo se verá en bitácoras el error app error: `undefined method '=~' for ["_x_session=Y; path=/; secure; httponly; SameSite=Lax"]:Array (NoMethodError)`

6. En sitios de producción es mejor que emplees tu servidor web para servir los recursos sprockets. Una configuración de nginx cuando unicorn corre en el puerto 2051 y su aplicación está en `/var/www/htdocs/miap/` incluirá:

          ...
          http {
            ...
            upstream unicorn_miap {
              server 127.0.0.1:2051 fail_timeout=0;
            }
            ...
            server {
              ...
              location /miorg/miap {
                try_files $uri @unicorn_miap;
              }
              location @unicorn_myapp {
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_pass http://unicorn_miap;
                proxy_pass http://unicorn_miap;
                error_page 500 502 503 504 /500.html;
                keepalive_timeout 10;
              }
              location ~ ^/miorg/miap/(assets|images)/ {
                 gzip_static on;
                 expires max;
                 add_header Cache-Control public;
                 root /var/www/htdocs/miap/public/;
              }
         ...
    


7. En la aplicación si debes referirte a una ruta y no puedes utilizar auxiliares, usa como prefijo de la ruta `Rails.configuration.relative_url_root`

8. En javascript ese punto de montaje quedará disponible en `window.puntomontaje` (por si requieres hacer llamados AJAX  o usar URLs de la aplicación).

Aunque en versiones de Rails anteriores a la 5 se usaba la variable de ambiente `RAILS_RELATIVE_URL_ROOT` para especificar el punto de montaje, hemos notado que desde Rails 5 no es necesario usarla y puede resultar conflictivo con el método descrito.  
