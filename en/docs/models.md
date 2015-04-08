# Models

Volt's concept of a model is slightly different from the many frameworks where a model is the name for the ORM to the database.  In Volt, a model is a class where you can store data easily.  Models can be created with a "Volt::Persistor", which is responsible for storing the data in the model somewhere.  Models created without a persistor simply store the data in the class's instance.  Lets first see how to use a model.

Volt comes with many built-in models; one is called ```page```.  If you call ```#page``` on a controller, you will get access to the model.

```ruby
page._name = 'Ryan'
page._name
# => 'Ryan'
```

Models act like a hash and have attributes that you can access with getters and setters that start with an underscore. When calling an underscore method, we either get back the attribute value, or ```nil``` if the value isn't defined.  Prefixing with an underscore makes sure that when calling normal methods, we still get a ```NoMethodError``` if we accidentally misspell a normal method name. Fields behave similarly to a hash, but with different access and assignment syntax.

You can also deeply nest models.  If you want to deeply nest, you can either assign an empty hash at the parent levels, or use the ```!``` on the end of the lookup to auto generate an empty model. (We call this expanding)

```ruby
page._setting!._color = 'blue'
page._setting._color
# => 'blue'

page._setting
# => #<Volt::Model:70100138058800 path:[:setting] state:loaded {:color=>"blue"}>
```

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
