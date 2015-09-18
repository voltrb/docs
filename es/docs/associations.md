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

## Has One

Puedes llamar ```has_one``` en un modelo para crear una asociación con un único modelo. ```has_one``` toma un símbolo para el nombre del otro modelo. Si pasamos ```:street``` en un modelo ```Address```, Volt buscará un modelo ```Street``` que tiene el address_id del id del modelo ```Address```.

## Belongs to

Puedes usar ```belongs_to``` para enlazar un modelo padre. Por ejemplo, si tenemos una instancia de ```Address```:

```ruby
address.person.then do |person|
  # => person is: #<Person ...>
end
```

Las asociaciones ```belongs_to``` retornan una promesa que se resuelve con el modelo asociado.
