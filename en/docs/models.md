# Models

Volt's concept of a model is slightly different from many frameworks where a model is the name for the ORM to the database.  In Volt, a model is a class where you can store data easily.  Models can optionally be created with a "Volt::Persistor", which is responsible for persisting data (to a database, local store, url parameters, etc..)  Models created without a persistor simply store the data in the class's instance.  Lets first see how to use a model.

A model is simply an instance of Volt::Model.  To start, lets create an instance directly.

```ruby
item = Volt::Model.new
item
# <Volt::Model {:id=>"beb492e2997ebd1365d3bf83"}>
```

Volt models are automatically assigned a [GUID](https://en.wikipedia.org/wiki/Globally_unique_identifier) for the id attribute.  Models are similar to hashes in that you can get/set properties on them. There are two ways to handle working with properties on Models.

- underscore accessors
- fields

## Underscore Accessors

First lets look at underscore accessors.  These let you get or set any property without explicitely setting it up ahead of time.

```ruby
item = Volt::Model.new
item._name = 'Ryan'
item._name
# => "Ryan"

item
# => <Volt::Model {:id=>"d8872b283c6dc1a7861e9baa", :name=>"Ryan"}>
```

Notice that we didn't have to setup the field name ahead of time.  Using an underscore before any property name lets you set/get a property on the model.  (Note this is similar to doing ```[:property]``` on a hash.  [See here](/getting_help/why_use_underscore_accessors_instead_of_[property].md) for more info)

Underscore accessors are often used for prototying, before you decide on exactly what fields will be used.

# Fields

Once you know the fields you will want on a model, you can create a model class to set up fields on the class.  A model class inherits from Volt::Model and should be put in app/{component}/models/model_name.rb  (If your new to Volt, use 'main' as the component)  You can generate a new model with the following:

```bash
bundle exec volt generate model Item
```

Once you have a model class you can specify fields on the model explicitly instead of using the underscore accessors.

```ruby
class Post < Volt::Model
  field :title                              # no type restriction
  field :body, String                       # a string
  field :published, Volt::Boolean           # true or false
  field :count_or_details, [String, Fixnum] # can be String or Fixnum
  field :notes, String, allow_nil: true     # a String field that can also be nil
end
```

Fields can optionally take on or more restrictions.  If the assigned value is not of the type (and can not be easily cast to the type (string -> int/float), the model will have a type validation error.  NOTE: Ruby does not have a Boolean class, and opal does not have TrueClass/FalseClass, so to specify a boolean, use ```Volt::Boolean``` as the type restriction.

Once you add fields, they can be read and assigned by calling a method with the property name on the model instance (a ruby getter).  You can set the property with an property name = method:

```ruby
new_post = Post.new(body: 'it was the best of times')

new_post.title = 'A Title'

new_post.title
# => 'A Title'

store._posts << new_post
```

## Collections

Since Volt Models do not have built-in persistance, we can access them through a collection which set up the persistance for you.  Volt comes with many built-in collections; one is called ```page```.  If you call ```page``` in the console (or a controller), you will get access to the page collection.

```ruby
page._name = 'Ryan'
page._name
# => 'Ryan'
```

Collections simply return a root model with the persistance setup for the model. When calling an underscore method, we either get back the attribute value, or ```nil``` if the value isn't defined.

## Nesting

You can also nest models.

```ruby
page._setting = {}
page._setting._color = 'blue'
page._setting._color
# => 'blue'
```

Assigning an empty hash to a property creates another model that gets assigned to the ```setting``` property on ```page```.  The ```setting``` model can then be assigned it's own properties.

If you want to nest without needing to assign a model directly to a property, you can use a  ```!``` (pronounced bang) method.

```ruby
page._setting!._color = 'blue'
page._setting._color
# => 'blue'

page
# => <PageRoot {:id=>"0df58b9f8b6b6f3404ea4d7b", :setting=><Volt::Model {:id=>"5ea3193e429c1f2ecba21bc5", :color=>"blue"}>}>
```

Calling ```._setting!``` creates a model if the property is not assigned and returns the new model.  (This is called "expanding")

## ArrayModels

In Volt models, plural properties return a ```Volt::ArrayModel``` instance.  ArrayModels behave the same way as normal arrays.  You can add/remove items to the array with normal array methods like ```#<<```, ```push```, ```append```, ```delete```, ```delete_at```, etc.

```ruby
page._items
# #<Volt::ArrayModel []>

page._items << {name: 'Item 1'}

page._items
# #<Volt::ArrayModel [<Volt::Model {:id=>"997e8a28c9675452ebcd5fa7", :name=>"Item 1"}>]>

page._items.size
# => 1

page._items[0]
# => <Volt::Model {:id=>"997e8a28c9675452ebcd5fa7", :name=>"Item 1"}>
```
