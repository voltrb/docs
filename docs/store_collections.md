## Store Collection

The store collection backs data in the data store.  Currently the only supported data store is Mongo. (More coming soon, RethinkDb will probably be next)  You can use store very similar to the other collections.

In Volt you can access ```store``` on the front-end and the back-end.  Data will automatically be synced between the front-end and the backend.  Any changes to the data in store will be reflected on any clients using the data (unless a [buffer](#buffers) is in use - see below).

```ruby
    store._items << {_name: 'Item 1'}

    store._items[0]
    # => <Model:70303681865560 {:name=>"Item 1", :_id=>"e6029396916ed3a4fde84605"}>
```

Inserting into ```store._items``` will create a ```_items``` table and insert the model into it.  An pseudo-unique _id will be automatically generated.

Currently one difference between ```store``` and other collections is ```store``` does not store properties directly.  Only ArrayModels are allowed directly on ```store```

```ruby
    store._something = 'yes'
    # => won't be saved at the moment
```

Note: We're planning to add support for direct ```store``` properties.
