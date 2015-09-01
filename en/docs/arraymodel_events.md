## ArrayModel Events

ArrayModels trigger events when their data is updated.  Currently, models emit two events: ```added``` and ```removed```.  For example:

```ruby
page._items.on('added') { puts 'item added' }
page._items << 1
# => item added

page._items.on('removed') { puts 'item removed' }
page._items.delete_at(0)
# => item removed
```

This is used internally on each bindings, but can be used in your own code.

NOTE: ArrayModel events are sort of an unofficial feature right now.  No guarentees on them working in all cases.
