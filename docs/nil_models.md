## Nil Models

As a convience, calling something like ```page._info``` returns what's called a NilModel (assuming it isn't already initialized).  NilModels are place holders for future possible Models.  NilModels allow us to bind deeply nested values without initializing any intermediate values.

```ruby
page._info
# => <Model:70260787225140 nil>

page._info._name
# => <Model:70260795424200 nil>

page._info._name = 'Ryan'
# => <Model:70161625994820 {:info=><Model:70161633901800 {:name=>"Ryan"}>}>
```

One gotchya with NilModels is that they are a truthy value (since only nil and false are falsy in ruby).  To make things easier, calling ```.nil?``` on a NilModel will return true.

One common place we use a truthy check is in setting up default values with || (logical or)  Volt provides a convenient method that does the same thing `#or`, but works with NilModels.

Instead of

```ruby
    a || b
```

Simply use:

```ruby
    a.or(b)
```

`#and` works the same way as &&.  #and and #or let you easily deal with default values involving NilModels.

-- TODO: Document .true? / .false?
