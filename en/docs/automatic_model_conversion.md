## Automatic Model Conversion

### Hash -> Model

For convenience, when placing a hash inside of another model, it is automatically converted into a model.  Models are similar to hashes, but provide support for things like persistence and triggering reactive events.

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

You can get a Ruby hash back out by calling `#to_h` on a Model.

### Array -> ArrayModel

Arrays inside of models are automatically converted to an instance of ArrayModel.  ArrayModels behave the same as a normal Array except that they can handle things like being bound to backend data and triggering reactive events.

```ruby
    model = Volt::Model.new
    model._items << {name: 'item 1'}
    model._items.class
    # => Volt::ArrayModel

    model._items[0].class
    # => Volt::Model
    model._items[0]
```


To convert a Volt::Model or a Volt::ArrayModel back to a normal hash, call .to_h or .to_a respectively.
To convert them to a JavaScript Object (for passing to some JavaScript code), call `#to_n` (to native).

```ruby
    user = Volt::Model.new
    user._name = 'Ryan'
    user._profile = {
      _twitter: 'http://www.twitter.com/ryanstout',
      _dribbble: 'http://dribbble.com/ryanstout'
    }

    user._profile.to_h
    # => {twitter: 'http://www.twitter.com/ryanstout', dribbble: 'http://dribbble.com/ryanstout'}

    items = Volt::ArrayModel.new([1,2,3,4])
    # => #<Volt::ArrayModel:70226521081980 [1, 2, 3, 4]>

    items.to_a
    # => [1,2,3,4]
```

You can get a normal array again by calling .to_a on a Volt::ArrayModel.
