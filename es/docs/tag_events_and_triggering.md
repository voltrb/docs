# Eventos Tag y Triggering

Cuando usas tags en volt, tu controlador puede activar eventos que pueden ser manejados cuando alguien hace uso de este tag.

Ejemplo:

```html
<:upload e-uploaded="was_uploaded" />
```

En el ejemplo anterior, podemos tener un botón de 'upload' que llama al código en el binding de evento 'e-uploaded' (cuando el controlador active el evento 'uploaded').

Ejemplo de triggering:

```ruby
module Main
  class UploadController < Volt::ModelController
    def upload
      # ... handle the upload ..

      # Trigger the uploaded event.
      trigger('uploaded')
  end
end
```

Los eventos de tag se activarán de abajo hacia arriba en el dom, por lo que podríamos seguir muchos mas arriba si así lo quisieramos (en cualquier parent tag):

```html
<div e-uploaded="was_uploaded">
  <p>
    Upload 1:
    <:upload />
  </p>
  <p>
    Upload 2:
    <:upload />
  </p>
</div>
```

En el ejemplo anterior, ```was_uploaded``` será llamado en el caso de que cualquiera de los dos 'upload tags' activen un evento 'uploaded'

## Pasando argumentos

También puedes pasar argumentos cuando activas un evento.

```ruby
module Main
  class UploadController < Volt::ModelController
    def upload
      # ... handle the upload ..

      # Trigger the uploaded event.
      trigger('uploaded', file_name)
  end
end
```

En el caso anterior, podemos pasar el nombre del archivo 'file_name' como argumento en el evento. En el controlador (en la vista donde usamos el tag) nuestro evento con el método ```was_uploaded``` se verá de la siguiente manera:

```ruby
module Main
  class MyDocumentsController < Volt::ModelController
    def was_uploaded(file_name)
      # ... do something with the file ...
    end
  end
end
```

Cualquier argumento que pasemos luego del nombre del evento se pasará al método de e- binding que creamos.

## Obteniendo el controlador

Si el método llamado por el event binding tiene un argumento extra (comparado con el numero de argumentos con el que fue activado), el event binding lo pasará en objeto ```JSEvent```.  (Mira [EventBindings](event_bindings.md) para obtener mas información) Con ```JSEvent``` puedes obtener el controlador que activó ese evento (si no era un evento dom) llamando al método ```event.controller```.

## Methodizing

Lo siguiente es un detalle mas técnico, pero es util tenerlo en cuenta.

Los string pasados a los e- bindings se convierten en un Proc o en un método ruby (dependiendo en lo que pasamos como argumento). Si el string que pasamos contiene un paréntesis al final, este asume que quieres pasar el resultado de haber llamado a un método dentro del string

```<:upload e-uploaded="was_uploaded('done')" />```

Lo anterior se convertirá en un Proc que se llamará cuando el evento 'uploaded' se haya activado. Si la última parte del string no tiene un paréntesis, asume que estas pasando la referencia a un método y este se convertirá en un método (cambiando el string a un método intérnamente con el siguiente método ```method(:last_part_str)```)

Por ejemplo, lo siguiente:

```<:upload e-uploaded="upload_handler.was_uploaded" />```

el evento de binding e-uploaded recibirá lo siguiente:

```ruby
upload_handler.method(:was_uploaded)
```
