## Buffers

In volt all models automatically save any changes back to their persistor.  For example, if we change a name property on a model in ```store```, it will automatically sync to the database and any other clients.  Unlike other frameworks, there is no need to call save, models sync as soon as properties are changed.

```ruby
store._items.first.then do |item|
    item._name = 'New Item Name'
    # ...syncs back to db
end
```

As another example, if we change an ```index``` property on params, the url is updated as soon as index is changed:

```ruby
params._index = 20
# ...url is updated
```

Because the store collection is automatically synced to the backend, any change to a model's property will result in all other clients seeing the change immediately.  Often this is not the desired behavior.  To facilitate building [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) apps, Volt provides the concept of a "buffer".  A buffer can be created from one model and will not save data back to the model it was created from (the backing model) until ```.save!``` is called on the buffer. This lets you create a form thats not saved until a submit button is pressed.

```ruby
store._items << {name: 'Item 1'}

store._items[0].then do |item1|
  item1_buffer = item1.buffer

  item1_buffer._name = 'Updated Item 1'
  item1_buffer._name
  # => 'Updated Item 1'

  item1._name
  # => 'Item 1'

  item1_buffer.save!

  item1_buffer._name
  # => 'Updated Item 1'

  item1._name
  # => 'Updated Item 1'
end
```

```#save!``` on buffer also returns a [promise](http://opalrb.org/blog/2014/05/07/promises-in-opal/) that will resolve when the data has been saved back to the server.

```ruby
item1_buffer.save!.then do
  puts "Item 1 saved"
end.fail do |err|
  puts "Unable to save because #{err}"
end
```

Calling .buffer on an existing model will return a buffer for that model instance.  If you call .buffer on a Volt::ArrayModel, you will get a buffer for a new item in that collection.  Calling .save! will then add the item to that sub-collection as if you had done ```<<``` or ```create``` to push the item into the collection.

Modified at {{ file.mtime }}
