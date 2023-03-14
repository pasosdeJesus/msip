# Iniciar un motor que use msip

# Iniciar el motor

Como se explica en {1}
```sh
rails plugin new mimotor --mountable --database=postgresql --skip-keeps \
  --javascript=esbuild
```

Pasa al directorio `mimotor` y edita el archivo `mimotor.gemspec` para 
modificar  las descripciones que dicen TODO y agregar:
```ruby
s.add_dependency "msip"
```

Edita el archivo `Gemfile` y agrega las mismas gemas que requiere una 
[Iniciar un sistema de información usando Msip](iniciar-si-usando-msip)


Crea el archivo `app/models/mimotor/ability.rb` donde se configurará 
control de acceso, inicialmente con:
```ruby
module Mimotor
  class Ability  < Msip::Ability

    BASICAS_PROPIAS = []

    def tablasbasicas
      Msip::Ability::BASICAS_PROPIAS +
        Mimotor::Ability::BASICAS_PROPIAS
    end

    # Establece autorizaciones con CanCanCan
    def initialize_mimotor(usuario = nil)
      initialize_msip(usuario)
      if !usuario || !usuario.rol
        return
      end
      case usuario.rol
      when Ability::ROLADMIN
        # can ...
      end
    end

  end
end
```

Elimina `app/controllers/mimotor/application_controller` pero en la aplicación
de prueba deja `test/dummy/app/controllers/application_controller.rb` 
estándar de aplicaciones que usan msip.

# Verificar aplicación de prueba

Antes de comenzar a crear tablas básicas y otras tablas, es conveniente que 
veas corriendo la aplicación de prueba disponible en `test/dummy` para 
eso sigue las instrucciones de 
[Iniciar un sistema de información usando Msip](iniciar-si-usando-msip)

En esas instrucciones ten en cuenta:

* Cuando crees `test/dummy/app/models/ability.rb` cambia
`class Ability  < Msip::Ability` por `class Ability  < Mimotor::Ability`
* Las semillas de la aplicación deberían incluir las de 
  msip y las de tu nuevo motor, por eso `test/dummy/db/seeds.rb`
  debe ser:

  ```ruby
  # encoding: UTF-8
  conexion = ActiveRecord::Base.connection();
  
  # De motores
  Msip::carga_semillas_sql(conexion, 'msip', :datos)
  motor = ['mimotor', '../..']
  motor.each do |m|
      Msip::carga_semillas_sql(conexion, m, :cambios)
      Msip::carga_semillas_sql(conexion, m, :datos)
  end
  
  # Usuario para primer ingreso msip, msip
  conexion.execute("INSERT INTO usuario 
    (nusuario, email, encrypted_password, password, 
    fechacreacion, created_at, updated_at, rol) 
    VALUES ('msip', 'msip@localhost', 
    '$2a$10$uPICXBx8K/csSb5q3uNsPOwuU1h.9O5Kj9dyQbaCy8gF.5rrPJgG.',
    '', '2014-08-14', '2014-08-14', '2014-08-14', 1);")
  ```
* Las rutas deben montar el motor que estás creando al final
  ```
  mount MiMotor::Engine, at: rutarel, as: 'mimotor'
  ```

* Es mejor configurar la inclusión de todos los ayudadores en
  en `test/dummy/config/application.rb` con la línea:
  ```
  config.action_controller.include_all_helpers = true
  ```

# Migraciones automáticas

Tu motor puede tener migraciones, para aplicarlas en aplicaciones que 
usen el motor tienes al menos estas dos opciones:

1. Con una tarea (un usuario de la aplicación tendría que ejecutar algo como 
   `bin/rails mimotor:install:migrations`)
2. Que se apliquen automáticamente desde la aplicación cuando se ejecute 
   `bin/rails db:migrate`

Para el segundo caso lo que debe hacer, como se explica en {2}, es agregar 
al archivo `lib/mimotor/engine.rb` las líneas:

```ruby
  initializer :append_migrations do |app|
    unless app.root.to_s === root.to_s
      config.paths["db/migrate"].expanded.each do |expanded_path|
        app.config.paths["db/migrate"] << expanded_path
      end
    end
  end
```


# Referencias
* {1} https://guides.rubyonrails.org/engines.html
* {2} http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
* {3} http://dhobsd.pasosdejesus.org/motores_rails.html
