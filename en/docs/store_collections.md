# Store Collection

The store collection backs data in the data store.  Currently, the only supported data store is Mongo. (More coming soon, RethinkDb will probably be next).  You can use ```store``` very similarly to the other Volt collections.

In Volt, you can access ```store``` on the front-end and the back-end.  Data will automatically be synced between the front-end and the backend.  Any changes to the data in ```store``` will be reflected on any clients using the data (unless a [buffer](#buffers) is in use - see below).

```ruby
    store._items << {_name: 'Item 1'}

    store._items[0]
    # => <Volt::Model:70303681865560 {:name=>"Item 1", :_id=>"e6029396916ed3a4fde84605"}>
```

Inserting into ```store._items``` will create an ```_items``` table and insert the model into it.  A pseudo-unique ```_id``` will be generated automatically.

Currently, one difference between ```store``` and other collections is that ```store``` does not store properties directly.  Only ArrayModels are allowed directly on the ```store``` collection.

```ruby
    store._something = 'yes'
    # => won't be saved at the moment
```

Note: We're are planning to add support for direct ```store``` properties.

## Store Model State

Because there is a delay when syncing data to the server, store models provide a ```state``` method that can be used to determine if the model is loaded or synced.


| state       | description                                                  |
|-------------|--------------------------------------------------------------|
| not_loaded  | data is not loaded                                           |
| loading     | model is fetching data from the server                       |
| loaded      | data is loaded and no changes are unsynced                   |
| dirty       | data has been changed, but is not synced back to the server yet |
| inactive    | model is not listening for updates.                          |

The ```inactive``` state can happen because there are no current event listeners or bindings listening on the model.
