# Store Collection

The store collection backs data in the database.  Currently, the only supported database is Mongo. (More coming soon, RethinkDb and Postgres will probably be next).  Because ```store``` sometimes need to wait for data to come back from the server, all query methods on ```store``` return a Promise.  If you are new to promises, be sure to [read more about Opal's promises](http://opalrb.org/docs/promises/) before continuing.

In Volt, you can access ```store``` on the front-end and the back-end.  Data will automatically be synced between the browser and the server.  Any changes to the data in ```store``` will be reflected on any clients using the data (unless a [buffer](#buffers) is in use - see below).

```ruby
store._items.create({name: 'Item 1'})
# => #<Promise(70297824266280): #<Volt::Model id: "9a46..5dd7", name: "Item 1">>

store._items[0]
# => #<Promise(70297821413860): #<Volt::Model id: "9a46..5dd7", name: "Item 1">>
```

Calling ```create``` (or ```append```, or ```<<```) on ```store._items``` will create an ```items``` table in the data store (if it doesn't exist) and insert the model document into it.  A [golbally unique](http://en.wikipedia.org/wiki/Globally_unique_identifier) ```id``` will be generated automatically.

## Promises on store

In order to support asynchronus loading, methods on store ArrayModel's return promises.  If you want to work with the results of a query, you can call .then on it.

```ruby
store._items.first.then do |item|
  # work with item
end
```

[See here](http://opalrb.org/blog/2014/05/07/promises-in-opal/) for more information on promises in ruby/opal.

## Promises in Bindings

Promises can be passed to bindings and the bindings will update with the value once the promise resolves.  This means you can do something like the following:

```html
{{ store._items.first.then {|i| i._name } }}
```

This would grab the first item, then return its name once it resolves.  This also preserves the reactivity, since if the first item changes, it will re-run the binding all together and re-resolve.

## Promise Method Forwarding

To make the above example simpler, Volt extends promises so you can call methods directly on the promise and it will call the method on the resolved value once the promise resolved.  The following are the semantically the same:

```ruby
store._items.first.then {|i| i._name }
store._items.first._name
```

## Promise Sync

If you are working with store on the server only (in tasks for example), you can call ```.sync``` on a Promise to have it synchronusly resolve and return the result.  If the promise is rejected, ```.sync``` will raise the error.

```ruby
# Remember this only works on the server or console

store._items.create({name: 'Item 1'})

# .sync blocks until the items are loaded
store._items.first.sync
# => #<Volt::Model id: "3607..a0b0", name: "Item 1">

store._items.size.sync
# => 1
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

## Store Model State

Because there is a delay when syncing data to the server, store models provide a ```loaded_state``` method that can be used to determine if the model is in the process of loading.

| state       | description                                                  |
|-------------|--------------------------------------------------------------|
| not_loaded  | data is not loaded                                           |
| loading     | model is fetching data from the server                       |
| loaded      | data is loaded and no changes are unsynced                   |
| dirty       | the data was loaded, but it is no longer being kept in sync with the server |



Modified at {{ file.mtime }}
