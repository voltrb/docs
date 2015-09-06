## Logging

Volt nos provee un helper para almacenar nuestros loggings. Podemos llamar al método ```Volt.logger```, el cual nos retornará una instancia del logger de Ruby. Mira [aquí](http://www.ruby-doc.org/stdlib-2.1.3/libdoc/logger/rdoc/Logger.html) para obtener mas información.

Un ejemplo:

```ruby
Volt.logger.info("Some info...")
```

Puedes cambiar el logger de la siguiente forma:

```ruby
Volt.logger = Logger.new
```

## Configuración del App

Como en muchos frameworks, Volt puede cambiar los settings por default basado en el flag de environment. Puedes cambiar el environment de volt por medio de la variable ```VOLT_ENV```.

Todos los archivos en la carpeta ```config``` de la aplicación son cargados cuando se inicia la aplicación. Este comportamiento es similar al de la carpeta ```initializers``` de Rails.

Volt se inicializa con las configuraciones mas útiles. Puedes configurar cosas como tu base de datos o el nombre de tu aplicación, por ejemplo, dentro del archivo ```config/app.rb```. Actualmente volt cuenta con las siguientes opciones de configuracion:

| nombre    | default                        | descripcion                                                                    |
|-----------|--------------------------------|--------------------------------------------------------------------------------|
| app_name  | el nombre de la carpeta actual | Este es usado internamente para logging, por ejemplo.                          |
| db_driver | 'mongo'                        | Por el momento mongo es el unico driver compatible, se añadirán mas muy pronto |
| db_name   | "#{app\_name}\_#{Volt.env}     | El nombre de la base de datos mongo.                                           |
| db_host   | 'localhost'                    | El hostname de la base de datos mongo.                                         |
| db_port   | 27017                          | El puerto de la base de datos mongo.                                           |
| compress_deflate | false                   | Si el valor es true. este correrá la opción deflate en el servidor del app. Aunque es mejor que un servidor web como nginx se encarge de esto |
