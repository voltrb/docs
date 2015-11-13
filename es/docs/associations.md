# Asociaciones

Volt provee modelos anidados, los cuales se pueden acceder sin una declaración explícita. Aunque, por lo general tendrás que asociar otros modelos usando id's externas. Volt usa la convención de usar undescore ```_id``` para los nombres de los campos. Volt también proveé métodos como ```belongs_to``` , ```has_many``` y ```has_one``` para asociar modelos.

```ruby
class Person < Volt::Model
  has_many :addresses
end

class Address < Volt::Model
  belongs_to :person
  has_one :street
end

class Street < Volt::Model
  belongs_to :address
end
```

## Has Many

Puedes usar ```has_many``` para acceder a todas las instancias de otros modelos que tienen un campo ```_id``` apuntando al modelo actual. Por ejemplo si tenemos una instancia person:

```ruby
person.addresses
# => #<Volt::ArrayModel [#<Address ..>, #<Address ..>, ...]>
```

Podemos llamar al método .addresses de person para encontrar todos los ```addresses``` con el id de person.

Las asociaciones ```has_many``` retornan un cursor.

#### Options

Puedes pasar cualquiera de las siguientes opciones como segundo argumento en has_many (para el modelo Usuario.)

:collection - el nombre de la coleccion en la base de datos, y la clase que debe ser cargada cuando se retornen los modelos

:foreign_key - (por default es el nombre de la clase actual + "_id") si añades ```has_many :posts, foreign_key: :user_id```, entonces
realizara el siguiente query: ```store.posts.where(user_id: self.id)```

:local_key - es el id del modelo, por default es ```self.id```. Si añades ```has_many :posts, local_key: :user_system_id``` este
realizará el siguiente query: ```store.posts.where(user_id: self.user_system_id)```

## Has One

Puedes llamar ```has_one``` en un modelo para crear una asociación con un único modelo. ```has_one``` toma un símbolo para el nombre del otro modelo. Si pasamos ```:street``` en un modelo ```Address```, Volt buscará un modelo ```Street``` que tiene el address_id del id del modelo ```Address```.

Has one puede usar las mismas opciones que has_many

## Belongs to

Puedes usar ```belongs_to``` para enlazar un modelo padre. Por ejemplo, si tenemos una instancia de ```Address```:

```ruby
address.person.then do |person|
  # => person is: #<Person ...>
end
```

Las asociaciones ```belongs_to``` retornan una promesa que se resuelve con el modelo asociado.
