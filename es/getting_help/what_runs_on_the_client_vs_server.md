# Que corre en el cliente vs el servidor?

La duda que surge con los frameworks que corren en el servidor y en el cliente es saber que código corre en donde. Para explicarlo de una forma mas clara vamos a dividir una aplicación de volt normal por sus componentes (modelo, vista, controlador) y explicaremos en que parte corren que cada uno de estos.

## Controladores y Vistas

En volt, los controladores, modelos y vistas son accesibles desde el cliente y el servidor. Aunque la mayor parte del tiempo, los controladores y las vistas usualmente corren solo en el cliente. En el futuro correrán una sola vez en el servidor (al cargarse por primera vez), para permitir cargas mas rápidas.

## Modelos

Los modelos corren en el servidor y en el cliente. Cuando un modelo cambia, sus validaciones/permisos se corren primero en el cliente para comprobar si el cambio es permitido. Si es correcto, el cambio se manda al servidor donde el modelo es cargado de nuevo y cambiado en el servidor. Si el cambio pasa las validaciones/permisos en el servidor, el modelo es cargado y sincronizado para todos los clientes. Esto significa que el código necesariamente tiene que correr en ambos lados.

## Tasks

Los tasks son un caso interesante. Están diseñados principalmente para permitir que el cliente pueda llamar código en el servidor. Gracias al sincronizado de modelos de volt, puedes escribir tu aplicación de tal manera que corra solo en el cliente. Correr código en el lado del cliente permite recargas mucho mas rápidas y compartición de datos entre acciones. De todas maneras, hay veces en las que necesitamos llamar código del servidor desde el cliente:

- Seguridad: Parte de los datos necesita ser procesado sin mandarlos al cliente
- Ancho de Banda: Necesitas procesar una gran cantidad de datos para retornar un resultado pequeño
- Gemas no compatibles con Opal: Algunas gemas no son soportadas por Opal, se pueden acceder a estas fácilmente por medio de Tasks.

Tasks proveen una interfaz asíncrona para todos los métodos dentro de una instancia task. Se pueden acceder a todos los métodos públicos de task a través de...

## Corriendo código solo en el cliente o el servidor

Puedes comprobar que el código este corriendo en el servidor o en el cliente por medio de ```Volt.server?``` y ```Volt.client?```. Algunas veces querrás que tu código nunca se compile al cliente, en este caso opal provee una manera de no compilar código en Opal. Puedes usar lo siguiente:

```ruby
if RUBY_PLATFORM != 'opal'
  ...
end
```

Lo bueno de esto es que removerá el codigo completamente y no lo enviará al cliente. Hay que tomar en cuenta que esto no funcionara con ```require``` ya que opal necesita requerir archivos en tiempo de compilacion.

### Seguridad

Una pregunta muy común es que debo hacer para que mi aplicación sea mas segura. Los lugares por los que debemos preocuparnos de la seguridad son:
1) permisos en modelos
2) tasks

### Permisos de Modelo

Los permisos de modelo determinan como van a cambiar los datos. Estos corren en el servidor y luego en el cliente  cuando los datos son cambiados o leidos.  A diferencia de los frameworks de backend, los datos pueden cambiar desde la parte del cliente sin que necesites construir un API. Añadir [permisos de Modelo](docs/permissions.md) es una manera muy simple de añadir seguridad que se ajuste a tu lógica de negocio.  Revisa la sección de [permisos](docs/permissions.md) para mayor informacion. El modelo de usuarios viene con permisos incluidos.

### Tasks

Los tasks son similares a los controladores de frameworks de backend, con la excepción de que trabajan a nivel de métodos ruby en vez de usar http. Cualquier método público en un Task puede ser llamado desde el cliente usando métodos a nivel de clase. Los argumentos serán pasados al backend, para luego ser enviados al cliente. Los argumentos enviados a los Tasks deben ser validados, ya que pueden contener cualquier dato que puede ser serializado a JSON (y objetos de tipo Time). Los modelos seguirán validando permisos aun si son usados dentro de un Task.

### Como mantenerse seguros

1) Asegurate de que los permisos de tu modelo se encuentran en su lugar y que concuerdan con la manera en la que lees y manipulas los datos
2) Valida cualquier dato que recibas como argumento cuando uses Tasks. Por ejemplo si haces requests a un API desde un task no pases todo el url desde el cliente.  Esto permitiría ingresar cualquier url. Si pases el url completo asegurate que el dominio/etx... sean iguales a los del url que quieres acceder.
