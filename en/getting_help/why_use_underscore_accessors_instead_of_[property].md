# Why use underscore accessors instead of [:property]

A common question about Volt is why we use underscore accessors.  There are a few reasons that have more to do with the requirements for setting/getting properties on a model without predefining the names of the properties.

## 1. Preventing Error Swallowing

While it would be possible to simply allow any method to be set on a model:

```ruby
item = Volt::Model.new
item.name = 'Ryan'
```

The problem is in Volt we need a property that hasn't been assigned to return nil.  This makes it easy to bind a property without setting it up, and the binding can handle the nil as it sees fit.  (for example a bound ```value``` on a text field might assume nil means an empty string)  The problem with the above is if we were to call a method that didn't exist, it will always return nil instead of returning a ```NoMethodError```

```ruby
item = Volt::Model.new
item.savr! # => nil
# ^ meant to type .save!
```

## 2. Keeping it short/Avoiding self

Accessing model properties is a really common thing.  While some JS frameworks use something like ```.set```/```.get```, this is a very commmon complaint about those frameworks that it is a lot of extra typing just to access a property.  In Volt we want to keep it short.  Ruby would allow us to do something like:

```ruby
item = Volt::Model.new
item[:name] # => nil
```

While that works really well in controller code, in Volt when using a ModelController, you will often want to set the controller's model to a model instance.  In that case, you have to do the following in your bindings (due to the way ruby works):

```html
<input value="{{ self[:name] }}" />
```

While this works, we feel that it doesn't read as easy and is something that can be a source of confusion.

While the _property syntax is not common in ruby, its easy to get used to. Once you do it saves a lot of typing/reading.  If the above hasn't convinced you its the best solution, keep in mind you can always just use [fields](/docs/models.md).
