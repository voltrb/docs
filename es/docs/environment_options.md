# Opciones de Environment

Adicionalmente a las opciones dentro de config/app.rb, algunas opciones específicas
pueden ser configuradas con variables de instancia.

| Name                   | Description                             |
|------------------------|-----------------------------------------|
| VOLT_ENV               | Cambia el valor de Volt.env, el cual es usado para controlar varias partes de la aplicación. |
| RACK_ENV               | También es usado para cambiar el valor de Volt.env |
| NO_MESSAGE_BUS         | Deshabilita el bus de mensajes. esto previene que las actualizaciones se propaguen entre las instancias de Volt, pero puede ser útil para debugging |
| NO_FORKING             | El "Servidor de Forking" es usado en desarrollo en MRI para permitir el reload automático de codigo. (Crea un proceso hijo para conecciones, el cual se elimina y posteriormente se crea uno nuevo cuando hay cambios en el código) |
| WEBSOCKET_PING_TIME    | Sirve para enviar un ping a la conección de websocket cada cierta cantidad de segundos. |
| NO_WEBSOCKET_PING      | Hacer ping al websocket esta habilitado solo en heroku (cuando el DYNO env esta present), para prevenir que Heroku mate las conecciones inactivas, esta variable puede forzar a que no se realize el ping al websocket |
| SKIP_BUNDLER_REQUIRE   | Deshabilita la carga automática de archivos del Gemfile. Esta característica todavía es experimental. |
| POLL_FS                | En algunas situaciones, Volt puede fallar al momento de chequear que archivos han sido cambiados para hacer auto-reloading. En esta situación puedes usar POLL_FS=true para que recolecte información directamente del sistema de archivos. Un uso común de esta variable es cuando necesitas compartir archivos a través de una red |
| DB_NAME                | Lo mismo que Volt.config.db_name             |
| DB_HOST                | Lo mismo que Volt.config.db_host             |
| DB_PORT                | Lo mismo que Volt.config.db_port             |
| DB_DRIVER              | Lo mismo que Volt.config.db_driver           |
| DB_URI                 | Lo mismo que Volt.config.db_uri              |

