# Conversión automática del Modelo

## Hash -> Model

Por conveniencia, cuando colocamos un hash dentro de un modelo este será convertido automáticamente en otro modelo. Los modelos son similares a los hashes, pero estos tienen características adicionales como persistencia y el lanzamiento de eventos reactivos.

```ruby
user = Volt::Model.new
user._name = 'Ryan'
user._profile = {
  twitter: 'http://www.twitter.com/ryanstout',
  dribbble: 'http://dribbble.com/ryanstout'
}

user._name
# => "Ryan"
user._profile._twitter
# => "http://www.twitter.com/ryanstout"
user._profile.class
# => Volt::Model
```

Puedes obtener un hash de vuelta llamando al metodo `#to_h` en el Modelo.

## Array -> ArrayModel

Los arrays dentro de un modelo se transforman automáticamente en un instancia de ArrayModel. Los ArrayModels tienen las mismas características de un array normal, con la diferencia de que estos pueden estar enlazados con los datos de backend y generar eventos reactivos.

```ruby
model = Volt::Model.new
model._items << {name: 'item 1'}
model._items.class
# => Volt::ArrayModel

model._items[0].class
# => Volt::Model
model._items[0]
```

Para convertir un Volt::Model o un Volt::ArrayModel en una estructura normal de Ruby podemos llamar los metodos .to_h o to_a respectivamente. Para convertirlo a un objeto de JavaScript (y usarlo en código javascript), puedes llamar al método `#to_n`(to native)

```ruby
user = Volt::Model.new
user._name = 'Ryan'
user._profile = {
  twitter: 'http://www.twitter.com/ryanstout',
  dribbble: 'http://dribbble.com/ryanstout'
}

user._profile.to_h
# => {twitter: 'http://www.twitter.com/ryanstout', dribbble: 'http://dribbble.com/ryanstout'}

items = Volt::ArrayModel.new([1,2,3,4])
# => #<Volt::ArrayModel:70226521081980 [1, 2, 3, 4]>

items.to_a
# => [1,2,3,4]
```

Puedes obtener un array normal invocando .to_a en un Volt:ArrayModel.
