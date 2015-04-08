## ArrayModel Events

Models trigger events when their data is updated.  Currently, models emit two events: ```added``` and ```removed```.  For example:

```ruby
    model = Volt::Model.new

    model._items.on('added') { puts 'item added' }
    model._items << 1
    # => item added

    model._items.on('removed') { puts 'item removed' }
    model._items.delete_at(0)
    # => item removed
```

This is used internally on each bindings, but can be used in your own code.
