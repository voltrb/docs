# Por que usar underscore para los accesors y no [:property] ?

Una pregunta muy común es porque volt usa underscore para los accesors. Uno de los mótivos tiene que ver con los requerimientos para guardar/obtener propiedades de un modelo sin tener que definir previamente los nombres de estos.

## Prevenir Ofuscación de Errores

Aunque es posible permitir que cualquier método sea creado en un modelo:

```ruby
item = Volt::Model.new
item.name = 'Ryan'
```

Existe el problema de que Volt necesita que una propiedad no asignada siempre retorne nil. Esto hace mas fácil el enlazar una propiedad sin tener que crearala antes, y el enlaze puede manejar el valor nil como lo necesite (por ejemplo un ```valor``` enlazado con un campo de texto puede asumir que nil significa un string vacío). El problema con el siguiente ejemplo es que si llamamos a un método que no existe este siempre retornará nil en lugar de ```NoMethodError```

```ruby
item = Volt::Model.new
item.savr! # => nil
# ^ meant to type .save!
```

## Manteniendo el código simple/Evitar el uso de self

Acceder a las propiedades de un modelo es algo común. Mientras algunos frameworks JavaScript usan métodos como ```.set```/```.get```, existe la queja de que es demasiado código solo para acceder a los valores de unas propiedades. En volt queremos mantener el código lo mas simple posible. Ruby nos permite hacer lo siguiente:

```ruby
item = Volt::Model.new
item[:name] # => nil
```

Mientras esto funciona bien dentro del código de un controlador, en Volt , al usar un ModelController, tendrás que definir el modelo del controlador con la instancia de un modelo. En ese caso, tienes que hacer lo siguiente en los bindings (debido a la forma en la que funciona ruby)

```html
<input value="{{ self[:name] }}" />
```

A pesar de que esto funciona, sentimos que no se lee muy fácilmente y puede ser fuente de confusiones.

Aunque no es común agregar un underscore a las variables en Ruby, no es difícil acostumbrarse al mismo y te ahorrará tiempo de lectura/escritura. Si no estás convencido, siempre puedes usar los [campos de modelos](/docs/models.md)
