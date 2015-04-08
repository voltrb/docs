# Store Collection

The store collection backs data in the data store.  Currently, the only supported data store is Mongo. (More coming soon, RethinkDb will probably be next).  You can use ```store``` very similarly to the other Volt collections.

In Volt, you can access ```store``` on the front-end and the back-end.  Data will automatically be synced between the front-end and the backend.  Any changes to the data in ```store``` will be reflected on any clients using the data (unless a [buffer](#buffers) is in use - see below).

```ruby
    store._items << {name: 'Item 1'}

    store._items[0]
    # => <Volt::Model:70303681865560 {:name=>"Item 1", :_id=>"e6029396916ed3a4fde84605"}>
```

Inserting into ```store._items``` will create an ```items``` collection in mongo and insert the model document into it.  A pseudo-unique ```_id``` will be generated automatically.

Currently, one difference between ```store``` and other collections is that ```store``` does not store properties directly.  Only ArrayModels are allowed directly on the ```store``` collection.

```ruby
    store._something = 'yes'
    # => won't be saved at the moment
```

Note: We're are planning to add support for direct ```store``` properties.

## Store Model State

Because there is a delay when syncing data to the server, store models provide a ```loaded_state``` method that can be used to determine if the model is in the process of loading.


| state       | description                                                  |
|-------------|--------------------------------------------------------------|
| not_loaded  | data is not loaded                                           |
| loading     | model is fetching data from the server                       |
| loaded      | data is loaded and no changes are unsynced                   |
| dirty       | the data was loaded, but it is no longer being kept in sync with the server |

## Reactive Loading

When using store, you might notice that sometimes ArrayModels are empty.  The reason is that store needs to go the the server to fetch the results of any lookups.  If the results of store are being used in a binding (an each binding for example), the binding will update and show the values once the data loads.  However sometimes you need to wait for the data to be loaded.  In this case you can use ```.fetch``` and ```.fetch_first```

```.fetch``` can be called with or without a block.  If it is called with a block, it will yield the values once they have been loaded and return a promise.  If you call it without a block, it just returns a promise.

Example:

```ruby
store._items.fetch do |items|
  # => items == the loaded items
end
```

Or you can call fetch like this:

```ruby
promise = store._items.fetch

promise.then do |items|
  # => items == the loaded items
end
```

[See here](http://opalrb.org/blog/2014/05/07/promises-in-opal/) for more information on promises in ruby/opal.

```.fetch_first``` loads and resolves the first item (using .limit(1))

## Promises in Bindings

Promises can be passed to bindings and the bindings will update with the value once the promise resolves.  This means you can do something like the following:

```html
{{ store._items.fetch_first.then {|v| v._name } }}
```

This would grab the first item, then return its name once it resolves.  This also preserves the reactivity, since if the first item changes, it will re-run the binding all together and re-resolve.

## Promise Sync

Passing in a block is a convience method for calling .then

If you are working with store on the server only (in tasks for example), you can call ```.sync``` on a Promise to have it synchronusly resolve and return the result.  If the promise is rejected, ```.sync``` will raise the error.

```ruby
# Remember this only works on the server or console

# .sync blocks until the items are loaded
items = store._items.fetch.sync

items.size
```

## Querying

Currently store persists to a mongodb database.  We are working on adding a data provider api that will allow support for any data store.  Volt currently supports the following query methods:

### .where

```.where``` passes down its arguments to a mongodb ```.find``` call.

### .limit

```.limit``` lets you restrict how many results you want.

### .skip

```.skip``` says how many items in you want to start fetching.  So store._items.skip(5).limit(10) would grab items 5-15.

### .order

```.order``` passes its arguments to a mongodb ```.sort``` call.  Since ```.sort``` is already a method on ruby's Enum class, we use ```.order``` instead.


