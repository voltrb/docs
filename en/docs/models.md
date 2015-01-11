# Models

Volt's concept of a model is slightly different from the many frameworks where a model is the name for the ORM to the database.  In Volt, a model is a class where you can store data easily.  Models can be created with a "Volt::Persistor", which is responsible for storing the data in the model somewhere.  Models created without a persistor simply store the data in the class's instance.  Lets first see how to use a model.

Volt comes with many built-in models; one is called ```page```.  If you call ```#page``` on a controller, you will get access to the model.

```ruby
page._name = 'Ryan'
page._name
# => 'Ryan'
```

Models act like a hash that you can access with getters and setters that start with an underscore.  If an attribute is accessed that hasn't yet been assigned, you will get back a "nil model".  Prefixing with an underscore makes sure that we don't accidentally try to call a method that doesn't exist.  Instead, we get back a nil model instead of raising an exception. Fields behave similarly to a hash, but with different access and assignment syntax.

Models also let you nest data without having to manually create the intermediate models:

```ruby
page._settings._color = 'blue'
page._settings._color
# => @'blue'

page._settings
# => @#<Volt::Model:_settings {:color=>"blue"}>
```

Nested data is automatically setup when assigned.  In this case, ```page._settings``` is a model that is part of the page model.  This allows nested models to be bound in a binding without the need to setup the model before use.

In Volt models, plural properties return a ```Volt::ArrayModel``` instance.  ArrayModels behave the same way as normal arrays.  You can add/remove items to the array with normal array methods like ```#<<```, ```push```, ```append```, ```delete```, ```delete_at```, etc.

```ruby
page._items
# #<Volt::ArrayModel:70303686333720 []>

page._items << {name: 'Item 1'}

page._items
# #<Volt::ArrayModel:70303686333720 [<Volt::Model:70303682055800 {:name=>"Item 1"}>]>

page._items.size
# => 1

page._items[0]
# => <Volt::Model:70303682055800 {:name=>"Item 1"}>
```
