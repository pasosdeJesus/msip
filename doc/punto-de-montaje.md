# Personalización del punto de montaje

Es posible configurar `rack` para que tu aplicación quede en un punto de montaje diferente a `/`, por ejemplo `/miorg/miap`.  Sin embargo rails no podrá determinar la situación por lo que las pruebas tipicamente deberás hacerlas suponiendo que el punto de montaje es `/`.

Hasta rails 6.0 recomendabamos hacer esto con un `scope` en `config/routes.rb` pero desde rails 7 ya no es posible sino que debe usarse `rack`--ver como hacer el cambio y el contexto en [https://gitlab.com/pasosdeJesus/msip/-/wikis/2024_01%20Actualizaci%C3%B3n%20a%20msip%202.2.0.beta4]

Si tienes la ruta en una variable `RUTA_RELATIVA` por ejemplo en tu archivo `.env` puedes hacer el cambio así:

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

      Tal asignación no es necesaria en otros archivos de 
      inicialización como `config/initializers/punto_montaje.rb` pero 
      es indispensable en `config/application.rb`

   4. En sitios de desarrollo los recursos sprockets se compilarán en `public/mipunto/demontaje/assets` pero en  modo de desarrollo se requieren en `public/assets` por lo que puede crear un enlace: `cd public; ln -sf public/mipunto/demontaje/assets .`  
   
   5. Los sistemas en producción que usan nginx y unicorn 6.1.0 operan bien. Sin embargo al momento de este escrito unicorn no ha publicado una nueva versión que soporte rack 3 (y tiene listo el soporte en repositorio con fuentes pero no ha publicado nueva versión), por eso la solución más simple es usar rack 2 (dejando en el `Gemfile` la línea `gem "rack", "~> 2"` mientras `unicorn` publica nueva versión, de no hacerlo se verá en bitácoras el error app error: `undefined method '=~' for ["_x_session=Y; path=/; secure; httponly; SameSite=Lax"]:Array (NoMethodError)`


   6. En sitios de producción es mejor que emplee su servidor web para servir los recursos sprockets una configuración de nginx cuando unicorn corre en el puerto 2051 y su aplicación está en `/var/www/htdocs/miap/` incluirá:

          ...
          http {
            ...
            upstream unicorn_miap {
              server 127.0.0.1:2051 fail_timeout=0;
            }
            ...
            server {
              ...
              location /mipunto/demontaje {
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
              location ~ ^/mipunto/demontaje/(assets|images)/ {
                 gzip_static on;
                 expires max;
                 add_header Cache-Control public;
                 root /var/www/htdocs/miap/public/;
              }
         ...
    

1.1 Poner sus rutas entre:

<pre>
scope 'miorg/miap' do
</pre>
...
<pre>
end
</pre>
No incluya entre estos el montaje de las rutas de `msip` y otros motores
1.2. Después de cerrar esa sección ```scope```, incluya puntos de montaje de motores como msip asi:
<pre>
mount Msip::Engine, at: '/miorg/miap', as: 'msip'
</pre>
2. Cree el directorio ```public/miorg/miap``` y mueva alli el contenido de ```public```
3. Indique el punto de montaje en config/application.rb:
<pre>
config.relative_url_root = "/miorg/miap"
</pre>
4. Indique también el punto de montaje en un archivo ```config/initializers/punto_montaje.rb``` con algo como:
<pre>
MiAp::Application.config.relative_url_root = '/miorg/miap'
MiAp::Application.config.assets.prefix = '/miorg/miap/assets'
</pre>
Siendo `MiAp` el mismo nombre de aplicación que haya configurado en `config/application.rb`

5. En la aplicación si requiere referirse a una ruta y no puede utilizar auxiliares, ponga como prefijo de la ruta el contenido de ```Rails.configuration.relative_url_root```

6. En javascript ese punto de montaje quedará disponible en `window.puntomontaje` (por si requiere hacer llamados AJAX  o usar URLs de la aplicación).

Aunque en versiones de Rails anteriores a la 5 se usaba la variable de ambiente `RAILS_RELATIVE_URL_ROOT` para especificar el punto de montaje, hemos notado que con Rails 5 no es necesario usarla y puede resultar conflictivo con el método anterior.  
