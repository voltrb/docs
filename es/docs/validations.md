# Validaciones

Dentro de una clase modelo podemos configurar validaciones. Las validaciones nos permiten restringir los tipos de datos que pueden ser guardados en un modelo. Las validaciones se usan generalmente para la colección ```store``` , pero también pueden ser usadas en otros lugares.

Por el momento, contamos con las siguiente validaciones (mas validaciones muy pronto):

- length
- present
- email
- format
- numericality
- phone number
- unique
- type

Mira [aquí](https://github.com/voltrb/volt/tree/master/lib/volt/models/validators) para mayor información sobre los validators.

```ruby
class Info < Volt::Model
  validate :name, length: 5
  validate :state, presence: true
end
```

Cuando usamos el método ```save!``` en un buffer este llama a las validaciones, lo siguiente puede ocurrir:

1. Se corren las validaciones del cliente, si estas fallan, la promesa del método ```save!``` será rechazada con el objeto error.
2. Los datos se enviarán al servidor, donde las validaciones de cliente y servidor se correrán en el servidor; se retornará el error obtenido y la promesa será rechazada en el front-end (con el objeto error). Correr de nuevo las validaciones nos ayudará a cerciorarnos de que ningún dato pueda ser guardado si es que no ha pasado las validaciones.
3. Si todas las validaciones pasan, los datos serán guardados en la base y la promesa se resolverá en el cliente
4. Los datos serán sincronizados al resto de clientes.

## Validaciones Customizadas

Puedes crear una validación propia pasando un bloque al método validate

```ruby
validate do
  if _name.present?
    {}
  else
    { name: ['must be present'] }
  end
end
```

El bloque debe retornar un hash con los errores. Cada llave del hash debe estar relacionado con un array de mensajes error para ese campo.  Puedes retornar multiples errores y estos serán agregados.

## Validaciones con Condicionales

Puedes verte en la necesidad de usar un validator ya existente solo en ciertas situaciones. Por ejemplo, puedes tener la publicación de un blog con una fecha de publicación ```publish_date``` la cual debe ser seteada, pero solo en el caso de que se haya publicado el post.  Puedes usar cualquier validator dentro del bloque del método ```validations``` (en plural).

```ruby
class Post < Volt::Model
  field :title, String
  field :published, Boolean
  field :publish_date

  validate :title, length: 5

  validations do
    if published
      validate :publish_date, presence: true
    end
  end
end
```

También puedes especificar que la validación solo se realize cuando se crea o se actualiza:

```ruby
class Post < Volt::Model
  field :published, Boolean
  field :publish_date

  validations(:update) do
    if _published
      validate :publish_date, presence: true
    end
  end
end
```

Por último, ```validations``` puede pasar :create o :update basado en el estado.

```ruby
class Post < Volt::Model
  ...

  validations do |action|
    if action == :update && _published
      validate :publish_date, presence: true
    end
  end
end
```
