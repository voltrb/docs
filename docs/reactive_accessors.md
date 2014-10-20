## Reactive Accessors

The default ModelController proxies any missing methods to its model.  Sometimes you need to store additional data reactively in the controller outside of the model.  (Though often you may want to consider doing another control/controller).  In this case, you can add a ```reactive_accessor```.  These behave just like ```attr_accessor``` except the values assigned and returned are tracked for any Computations.

```ruby
  class Contacts < Volt::ModelController
    reactive_accessor :query
  end
```

Now from the view we can bind to query while also changing in and out the model.  You can also use ```reactive_reader``` and ```reactive_writer```. When query is accessed it tracks that it was accessed and will any Computations when it changes.
