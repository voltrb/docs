## Nil Models

As a convenience, calling something like ```page._info``` returns what's called a ```NilModel``` (assuming it isn't already initialized).  NilModels are placeholders for possible future Models.  NilModels allow us to bind deeply-nested values without having to initialize intermediate values.

```ruby
page._info
# => <Volt::Model:70260787225140 nil>

page._info._name
# => <Volt::Model:70260795424200 nil>

page._info._name = 'Ryan'
# => <Volt::Model:70161625994820 {:info => <Volt::Model:70161633901800 {:name => "Ryan"}>}>
```

One gotcha with NilModels is that they are a truthy value (since only nil and false are falsy in Ruby).  To make things easier, calling ```.nil?``` on a NilModel will return true.

One common place we use a truthy check is in setting up default values with ```||``` (logical or).  Volt provides a convenient method that does the same thing ```#or```, but that works with NilModels.

Instead of:

```ruby
    a || b
```

simply use:

```ruby
    a.or(b)
```

Additionally, ```#and``` works the same way as ```&&```.  ```#and``` and ```#or``` let you easily deal with default values involving NilModels.

-- TODO: Document .true? / .false?
